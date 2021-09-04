#!/bin/bash

if [ ! -z "$SLEEP_TIME" ]
then
    sleep $SLEEP_TIME
fi


aws-azure-login --profile=production --no-prompt
aws-azure-login --profile=staging --no-prompt

aws eks --region eu-west-1 update-kubeconfig --name staging-01 --profile staging

systemctl --user start aws.timer
systemctl --user start aws_prod.timer
