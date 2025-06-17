import json

def get_nested_value(obj, key_path):
    keys = key_path.split('/')
    current = obj
    for key in keys:
        if not isinstance(current, dict):
            raise KeyError(f"Key path '{'/'.join(keys)}' does not exist (stopped at '{key}')")
        if key not in current:
            raise KeyError(f"Key '{key}' not found in object at this level")
        current = current[key]
    return current

if __name__ == "__main__":
    try:
        obj_input = input("Enter your JSON object: ")
        obj = json.loads(obj_input)
        key_path = input("Enter the slash-separated key path (e.g., a/b/c): ")
        value = get_nested_value(obj, key_path)
        print(f"Value at '{key_path}': {value}")
    except json.JSONDecodeError:
        print("Error: Invalid JSON object.")
    except KeyError as e:
        print(f"Error: {e}")
    except Exception as e:
        print(f"Unexpected error: {e}")

