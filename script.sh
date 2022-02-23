#!/usr/bin/env bash
aws ecs register-task-definition --cli-input-json file://front_task_definition.json
