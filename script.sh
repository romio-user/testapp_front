#!/usr/bin/env bash
#####CREATE TASK#####
sed -i "s#REPOSITORY_URI#$REPOSITORY_URI#g" front_task_definition.json
sed -i "s#IMAGE_TAG#$IMAGE_TAG#g" front_task_definition.json
sed -i "s#EXECUTION_ROLE_ARN#$EXECUTION_ROLE_ARN#g" front_task_definition.json
sed -i "s#AWS_DEFAULT_REGION#$AWS_DEFAULT_REGION#g" front_task_definition.json
cat front_task_definition.json
aws ecs register-task-definition --cli-input-json file://front_task_definition.json
#####UPDATE SERVICE#####
task_name=`aws ecs describe-task-definition --task-definition front | grep family | awk '{print $2}' | tr "\"" " " | sed 's/,//g' | sed 's/ //g'`
task_revision=`aws ecs describe-task-definition --task-definition front | grep revision | awk '{print $2}'`
task_definition="$task_name:$task_revision"
aws ecs update-service --cluster testapp --service front --task-definition $task_definition  --desired-count 1
