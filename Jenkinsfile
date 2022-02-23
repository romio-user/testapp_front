pipeline {
    agent any

    environment {
        IMAGE_REPO_NAME="testapp_front"
        IMAGE_TAG="v_${env.BUILD_ID}"
        REPOSITORY_URI = "${env.AWS_ACCOUNT_ID}.dkr.ecr.${env.AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
        registryCredential = "test_ecs_user"
    }


    stages {

        stage('Git') {
            steps {
                git branch: 'main', url:'https://github.com/romio-user/testapp_front'
            }
        }

        stage('Install&Test') {
            steps {
                sh 'npm install'
                sh 'npm test'
            }
        }

        stage('Building image') {
            steps{
                script {
                    dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                }
            }
        }

        stage('Pushing to ECR') {
            steps{
                script {
                    docker.withRegistry("https://" + REPOSITORY_URI, "ecr:${env.AWS_DEFAULT_REGION}:" + registryCredential) {
                    dockerImage.push()
                        }
                }
            }
        }
        stage('Cleaning up') {
            steps{
                sh "docker rmi ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}"
            }
        }

        stage('Deploy') {
            steps{
                withAWS(credentials: registryCredential, region: "${evn.AWS_DEFAULT_REGION}") {
                    script {
			sh './script.sh'
                    }  
                } 
            }
        }      
    }
}


