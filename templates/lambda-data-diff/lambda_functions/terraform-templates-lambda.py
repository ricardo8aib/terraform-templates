import json
from data_diff import connect_to_table, diff_tables

print("Loading function")

def lambda_handler(event, context):
    """Sample lambda function

    Args:
        event (json): Event
        context (json): Context

    Raises:
        e: Exception

    Returns:
        dict: data_diff imported
    """
    try:
        # Connection to database

        return json.dumps({"data_diff": "imported"})

    except Exception as e:
        print(e)
        raise e
