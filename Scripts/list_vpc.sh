#!/bin/bash

#REGIONS=$@



if [ $# -gt 0 ]
then
    aws --version 2> /dev/null
    if [ $? -eq 0 ]
    then
        
        for REGION in "$*"
        do
            echo "----------------------------"
            echo "Getting VPCs for $REGION"
            aws ec2 describe-vpcs --region $REGION | jq ".Vpcs[].VpcId" -r
            
        done
    else
        
        echo " AWS Command not founnd, Please install AWS CLI"
        
    fi
else
    echo "You have passed Zero arguments, please add your region"
fi