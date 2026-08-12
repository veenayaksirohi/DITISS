pipeline {
    agent any

    environment {
        // define the docker user name
        DOCKER_USER_NAME="amitksunbeam"

        // docker hub access token
        DOCKER_HUB_ACCESS_TOKEN=""

        // docker image name
        DOCKER_IMAGE_NAME="httpd-website"

        // docker service name
        DOCKER_SERVICE_NAME="httpd-website"
    }

    stages {
        stage('SCM') {
            steps {
                // get the latest changes from github repository
                git 'https://github.com/pythoncpp/ditiss-website-demo.git'
            }
        }

        stage('build docker image') {
            steps {
                sh 'docker image build -t ${DOCKER_USER_NAME}/${DOCKER_IMAGE_NAME} .'
            }
        }

        stage('docker login') {
            steps {
                sh 'echo ${DOCKER_HUB_ACCESS_TOKEN} | docker login -u ${DOCKER_USER_NAME} --password-stdin'
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