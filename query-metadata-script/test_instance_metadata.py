import unittest
from unittest.mock import patch, MagicMock
from instance_metadata import get_all_instance_metadata

class TestGetInstanceMetadata(unittest.TestCase):
    @patch('boto3.client')
    def test_instance_found(self, mock_boto_client):
        # Mock the EC2 client and its describe_instances response
        mock_ec2 = MagicMock()
        mock_ec2.describe_instances.return_value = {
            'Reservations': [{
                'Instances': [{
                    'InstanceId': 'i-1234567890abcdef0',
                    'InstanceType': 't3.micro',
                    'PublicIpAddress': '54.210.1.1'
                }]
            }]
        }
        mock_boto_client.return_value = mock_ec2

        result = get_all_instance_metadata('i-1234567890abcdef0')
        self.assertEqual(result['InstanceId'], 'i-1234567890abcdef0')
        self.assertEqual(result['InstanceType'], 't3.micro')
        self.assertEqual(result['PublicIpAddress'], '54.210.1.1')

    @patch('boto3.client')
    def test_instance_not_found(self, mock_boto_client):
        mock_ec2 = MagicMock()
        mock_ec2.describe_instances.return_value = {'Reservations': []}
        mock_boto_client.return_value = mock_ec2

        result = get_all_instance_metadata('i-doesnotexist')
        self.assertEqual(result, "Instance i-doesnotexist not found.")

if __name__ == '__main__':
    unittest.main()

