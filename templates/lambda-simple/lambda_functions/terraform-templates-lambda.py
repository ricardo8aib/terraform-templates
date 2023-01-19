import json

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
        return json.dumps({"Hello": "World"})

    except Exception as e:
        print(e)
        raise e
