import boto3, json, sys
from datetime import datetime

ddb = boto3.resource("dynamodb")
table = ddb.Table("MD_JOBS")

def main():
    with open("open_cellid_md_jobs.json") as f:
        item = json.load(f)
    item["created_at"] = datetime.utcnow().isoformat()
    table.put_item(Item=item)
    print(f"Inserted job {item['job_id']} into MD_JOBS")

if __name__ == "__main__":
    main()
