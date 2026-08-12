pipeline {
    agent any

    environment {
        // define the docker user name
        DOCKER_USER_NAME="amitksunbeam"

        // docker image name
        DOCKER_IMAGE_NAME="python-app"

        // docker service name
        DOCKER_SERVICE_NAME="python-app"
    }

    stages {
        stage('SCM') {
            steps {
                // get the latest changes from github repository
                git 'https://github.com/pythoncpp/ditiss-flask-demo.git'
            }
        }

        stage('build docker image') {
            steps {
                sh 'docker image build -t ${DOCKER_USER_NAME}/${DOCKER_IMAGE_NAME} .'
            }
        }

        stage('docker login') {
            steps {
                // read the docker access token from the Jenkins crdentials
                withCredentials([string(credentialsId: 'DOCKER_ACCESS_TOKEN', variable: 'DOCKER_ACCESS_TOKEN')]) {
                    sh 'echo ${DOCKER_ACCESS_TOKEN} | docker login -u ${DOCKER_USER_NAME} --password-stdin'
                }
            }
        }

        stage('push docker image') {
            steps {
                sh 'docker image push ${DOCKER_USER_NAME}/${DOCKER_IMAGE_NAME}'
            }
        }

        stage('reload the service') {
            steps {
                sh 'docker service update --force --image ${DOCKER_USER_NAME}/${DOCKER_IMAGE_NAME} ${DOCKER_SERVICE_NAME}'
            }
        }
    }
}