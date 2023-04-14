import json
from data_diff import connect_to_table

print("Loading function")

def lambda_handler(event, context):
    """Sample lambda function

    Args:
        event (json): Event
        context (json): Context

    Raises:
        e: Exception

    Returns:
        dict: Hello World
    """
    try:
        # Connection to database
        SNOWFLAKE_CONN_INFO = {
            "driver": "snowflake",
            "user": "snowflake",
            "account": "snowflake.us-east-1",
            "database": "snowflake",
            "warehouse": "snowflake_WH",
            "role": "snowflake_ROLE",
            "schema": "snowflake",
            "password": "password"
        }


        snowflake_table = connect_to_table(SNOWFLAKE_CONN_INFO, "CUSTOMERS")

        return json.dumps({"Hello": "World"})

    except Exception as e:
        print(e)
        raise e
