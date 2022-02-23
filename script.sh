#!/usr/bin/env bash
#aws ecs register-task-definition --cli-input-json file://front_task_definition.json
sed -i "s#REPOSITORY_URI#$REPOSITORY_URI#g" front_task_definition.json
sed -i "s#IMAGE_TAG#$IMAGE_TAG#g" front_task_definition.json
sed -i "s#EXECUTION_ROLE_ARN#$EXECUTION_ROLE_ARN#g" front_task_definition.json
sed -i "s#AWS_DEFAULT_REGION#$AWS_DEFAULT_REGION#g" front_task_definition.json
cat front_task_definition.json
