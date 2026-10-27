#!/bin/bash

AMI_ID="ami-0055977a6e828a4f4"
SG_ID="sg-0970de82b6ff68f8b"
Instances=("mongoDB" "Redis" "MySQL" "RabbitMQ" "Catalogue" "User" "Cart" "Shipping" "Payment" "Dispatch" "Frontend"
Zone_ID="Z0241125FKN75ZHAIP5H"
Domain_Name="deepuprassu.cloud"

#Now you can loop it
for instance in ${INSTANCES[@]}
do
     INSTANCE_ID=$(aws ec2 run-instances  --image-id ami-0055977a6e828a4f4 --instance-type t3.micro --security-group-ids sg-0970de82b6ff68f8b --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=MyCLIInstance}]' --query 'Instances[0].InstanceId' --output text)
    if [ $instance != "Frontend"  ]
    then
        aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[*].Instances[*].[PrivateIpAddress]' --output text
    else
        aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[*].Instances[*].[PublicIpAddress]' --output text
    fi
    echo "$instance Ip Address: $Ip"
done