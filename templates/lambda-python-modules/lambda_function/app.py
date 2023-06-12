import json
from my_script import sum_two_arrays
from my_other_script import convert_to_numpy_array

print("Loading function")

def lambda_handler(event, context):
    """
    Lambda function that returns the sum of two arrays.

    Args:
        event (dict): A dictionary containing the following keys:
            - first_list (List): A list.
            - second_list (List): Another list.
        context (object): Lambda function runtime information.

    Returns:
        np.array: The array resulting of the sum of two lists.

    Raises:
        Exception: If an error occurs during the execution of the function.
    """
    try:
        first_list = event["first_list"]
        second_list = event["second_list"]

        first_array = convert_to_numpy_array(first_list)
        second_array = convert_to_numpy_array(second_list)

        results = sum_two_arrays(first_array, second_array)
        print(results)

        return json.dumps({"success": "success"})

    except Exception as e:
        raise e
