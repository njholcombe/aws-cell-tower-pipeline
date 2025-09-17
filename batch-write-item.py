import json
import sys

INPUT_FILE = "jobconfig_items.json"   # from your scan
OUTPUT_FILE = "jobconfig_batch.json"  # ready for batch-write

try:
    with open(INPUT_FILE) as f:
        items = json.load(f)
except FileNotFoundError:
    print(f"ERROR: {INPUT_FILE} not found.")
    sys.exit(1)

if not isinstance(items, list) or not items:
    print("No valid items found in input JSON.")
    sys.exit(1)

# DynamoDB batch-write request format
batch = {"MD_JOB_CONFIG": []}

for i, item in enumerate(items, start=1):
    job_id = item.get("job_id")
    sk = item.get("sk")
    config_value = item.get("config_value")

    if not job_id or not sk:
        print(f"❌ Skipping item {i}: missing job_id or sk")
        continue

    # build PutRequest
    put_req = {
        "PutRequest": {
            "Item": {
                "job_id": job_id,  # already in DynamoDB JSON format
                "sk": sk           # already in DynamoDB JSON format
            }
        }
    }

    if config_value:
        put_req["PutRequest"]["Item"]["config_value"] = config_value

    batch["MD_JOB_CONFIG"].append(put_req)

print(f"✅ Prepared {len(batch['MD_JOB_CONFIG'])} items")

with open(OUTPUT_FILE, "w") as f:
    json.dump(batch, f, indent=2)

print(f"✅ Wrote output to {OUTPUT_FILE}")

