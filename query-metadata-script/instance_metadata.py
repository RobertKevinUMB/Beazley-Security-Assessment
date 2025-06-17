import boto3
import json

def get_all_instance_metadata(instance_id):
    ec2 = boto3.client('ec2')
    response = ec2.describe_instances(InstanceIds=[instance_id])
    reservations = response.get('Reservations', [])
    if not reservations or not reservations[0]['Instances']:
        return f"Instance {instance_id} not found."
    instance = reservations[0]['Instances'][0]
    return instance

if __name__ == "__main__":
    instance_id = input("Enter EC2 instance ID: ")
    metadata = get_all_instance_metadata(instance_id)
    print(json.dumps(metadata, indent=2, default=str))

