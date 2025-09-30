import os, gzip, boto3, urllib3, tempfile
from datetime import datetime
from zoneinfo import ZoneInfo

s3 = boto3.client("s3")
ssm = boto3.client("ssm")
http = urllib3.PoolManager()

def handler(event, ctx):

    print("DEBUG event:", event)  # Logging

    
    #If src_details src TYPE is that of a REST query string build the token and the url.
    
    #If tgt_details TGT TYPE is that of an S3(buckets which it will be most of the time.)
    #then obtain the tgt details raw details to create the raw bucket and raw key to use with the multipart upload logic to load to the s3 raw locations.


    job = event["job_details"]
    
    job_id = job["job_id"]
    ingest = datetime.fromisoformat(job["ingest_date"].replace("Z", "+00:00")).date().isoformat()
    execution_id = job["execution_id"]


    bucket = job['raw_tgt_details']['target_location']   # e.g. celldata-raw-w1
    prefix = job['raw_tgt_details']['prefix_path']       # e.g. bronze/opencellid
    
    if not job_id:
        raise ValueError("Missing job_id")
    if not bucket:
        raise ValueError("Missing RAW_BUCKET")
    
    src_file_name = job['file_name']
    ps_param_name = job['job_src_details']['ps_param_name']
    token = ssm.get_parameter(Name=ps_param_name, WithDecryption=True)["Parameter"]["Value"]

    url = f"{job['job_src_details']['connection_info']}{token}&file={src_file_name}"
    key = f"{prefix}/ingest_date={ingest}/execution_id={execution_id}/{src_file_name}"
    
    
    print(f"url is: {url}, key is: {key}") #Logging
    r = http.request("GET", url, preload_content=False)

    # Start multipart upload
    mpu = s3.create_multipart_upload(Bucket=bucket, Key=key)
    upload_id = mpu["UploadId"]
    parts = []
    part_number = 1

    try:
        while True:
            chunk = r.read(5 * 1024 * 1024)  # 5 MB
            if not chunk:
                break
            print(f"chunk read: {len(chunk)} bytes")
            print("Writing bytes")

            result = s3.upload_part(
                Bucket=bucket,
                Key=key,
                PartNumber=part_number,
                UploadId=upload_id,
                Body=chunk,
            )
            parts.append({"ETag": result["ETag"], "PartNumber": part_number})
            part_number += 1

        # Complete the multipart upload
        s3.complete_multipart_upload(
            Bucket=bucket,
            Key=key,
            UploadId=upload_id,
            MultipartUpload={"Parts": parts},
        )

        return {"ok": True, "s3_key": key, "ingest_date": ingest}

    except Exception as e:
        s3.abort_multipart_upload(Bucket=bucket, Key=key, UploadId=upload_id)
        print(f"Upload aborted due to error: {e}")
        raise

    finally:
        r.release_conn()
