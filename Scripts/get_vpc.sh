read -p "Enter your region: " REGION

 aws ec2 describe-instances --region $REGION | jq ".Reservations[].Instances[].InstanceId" -r