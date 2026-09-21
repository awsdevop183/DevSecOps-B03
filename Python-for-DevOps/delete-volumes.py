import boto3

volumes = boto3.client('ec2')

response = volumes.describe_volumes()

for volume in response["Volumes"]:
    # print(volume['VolumeId'])
    # print(volume['State'])
    if volume['State']=="available":
        volume_id=volume['VolumeId']
        volumes.delete_volume(VolumeId=volume_id)
        print(f"Successfully deleted unattached volume {volume_id}")
