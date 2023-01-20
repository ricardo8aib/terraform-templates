import json
import pandas as pd

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
        data = {
            "col1": [1, 2],
            "col2": [3, 4],
        }

        df = pd.DataFrame(data=data)

        print(f"The DataFrame has {len(df)} rows")

        return json.dumps({"Hello": "World"})

    except Exception as e:
        print(e)
        raise e
