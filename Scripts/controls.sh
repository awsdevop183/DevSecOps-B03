#!/bin/bash

set -o pipefail

REGIONS=(us-east-1 ap-south-11 us-east-2)

for REGION in ${REGIONS[@]}
do
    echo "Getting VPCs for region $REGION......"
    VPC_LIST=$(aws ec2 describe-vpcs --region $REGION | jq ".Vpcs[].VpcId" -r)
    
    if [ $? -eq 0 ]
    then
        for VPC in ${VPC_LIST[@]}
        do
            echo "VPC ID is: $VPC"
        done
    else
        echo "Invalid Region $REGION"
        continue
    fi
    
done
