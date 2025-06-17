import unittest
from nested_value import get_nested_value 

class TestGetNestedValue(unittest.TestCase):
    def test_valid_path(self):
        obj = {"a": {"b": {"c": "d"}}}
        self.assertEqual(get_nested_value(obj, "a/b/c"), "d")

    def test_another_valid_path(self):
        obj = {"x": {"y": {"z": "a"}}}
        self.assertEqual(get_nested_value(obj, "x/y/z"), "a")

    def test_missing_key(self):
        obj = {"a": {"b": {}}}
        with self.assertRaises(KeyError):
            get_nested_value(obj, "a/b/c")

    def test_non_dict_in_path(self):
        obj = {"a": {"b": "not_a_dict"}}
        with self.assertRaises(KeyError):
            get_nested_value(obj, "a/b/c")

    def test_empty_path(self):
        obj = {"a": {"b": {"c": "d"}}}
        with self.assertRaises(KeyError):
            get_nested_value(obj, "")

if __name__ == "__main__":
    unittest.main()

