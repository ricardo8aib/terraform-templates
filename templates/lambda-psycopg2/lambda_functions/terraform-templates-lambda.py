import json
import psycopg2

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
        base_connection = psycopg2.connect(
            dbname="db_name",
            user="db_user",
            password="password",
            host="host",
            port=5432,
        )
        print("YOU ARE CONNECTED!!!", base_connection)

        return json.dump({"Hello": "World"})

    except Exception as e:
        print(e)
        raise e
