import os, boto3, datetime, urllib.request

s3 = boto3.client("s3")
ssm = boto3.client("ssm")

def handler(event, context):
    token = ssm.get_parameter(Name=os.environ["PARAM_NAME"], WithDecryption=True)["Parameter"]["Value"]
    date = datetime.datetime.utcnow().date().isoformat()
    key = f"bronze/opencellid/ingest_date={date}/cell_towers.csv.gz"
    url = f"https://opencellid.org/ocid/downloads?token={token}&file=cell_towers.csv.gz"

    with urllib.request.urlopen(url) as resp:
        s3.upload_fileobj(
            resp, os.environ["RAW_BUCKET"], key,
            ExtraArgs={"ServerSideEncryption":"AES256","ContentType":"application/gzip"}
        )
    return {"ok": True, "s3": f"s3://{os.environ['RAW_BUCKET']}/{key}"}
