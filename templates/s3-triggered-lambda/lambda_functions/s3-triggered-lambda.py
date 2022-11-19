import json
import urllib.parse
import boto3

print("Loading function")

s3 = boto3.client("s3")


def lambda_handler(event, context):
    """Sample lambda function

    Get a Json lines file (.jsonl) added to an S3 bucket and print the content
    of the first element.

    Args:
        event (json): Event
        context (json): Context

    Raises:
        e: Exception

    Returns:
        dict: ContentType
    """

    # Get the object from the event and show its content type
    bucket = event["Records"][0]["s3"]["bucket"]["name"]
    key = urllib.parse.unquote_plus(event["Records"][0]["s3"]["object"]["key"], encoding="utf-8")
    try:
        response = s3.get_object(Bucket=bucket, Key=key)

        # The following lines get every object contained in a JSON Lines file (.jsonl)
        data = response["Body"].iter_lines()
        data = [json.loads(line) for line in data]

        print(data[0])

        return response["ContentType"]

    except Exception as e:
        print(e)
        print(f"""
                Error getting object {key} from bucket {bucket}.
                Make sure they exist and your bucket is in the same region as this function.
              """)
        raise e
