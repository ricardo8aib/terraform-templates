import json

print("Loading function")


def lambda_handler(event, context):
    """
    Entry point for the AWS Lambda function.

    Args:
        event (dict): The event object representing the API Gateway proxy event.
                      It contains information about the request and its context.
        context (object): The context object containing information about the runtime environment.

    Returns:
        dict: A dictionary containing the HTTP response status code and body.

    Raises:
        Exception: If an error occurs during the execution of the function.

    Example:
        >>> event = {
        ...     "queryStringParameters": {
        ...         "name": "John"
        ...     }
        ... }
        >>> context = {}
        >>> lambda_handler(event, context)
        {'statusCode': 200, 'body': '{"Hello": "from John!"}'}
    """
    try:
        str_params = event.get("queryStringParameters", None)
        name = str_params.get("name", "templates") if str_params else "templates"

        return {
            "statusCode": 200,
            "body": json.dumps(
                {"Hello": f"from {name}!"}
            )
        }

    except Exception as e:
        raise e
