pipeline {
    agent any
    environment {
        // docker image name
        DOCKER_IMAGE_NAME="amitksunbeam/python-test-app"

        // docker user name
        DOCKER_USER_NAME="amitksunbeam"

        // docker user auth token
        DOCKER_AUTH_TOKEN=credentials('DOCKER_AUTH_TOKEN')
    }

    stages {
        // stage('scm') {
        //     steps {
        //         echo "already taken care by Jenkins"
        //     }
        // }

        // install the required packages
        stage('prepare env') {
            steps {
                // execute a shell command
                sh 'pip3 install --break-system-package -r requirements.txt '
            }
        }

        // test the application
        stage('test') {
            steps {
                sh 'pytest test_app.py'
            }
        }

        // build the docker image 
        stage('build docker image') {
            steps {
                sh 'docker image build -t ${DOCKER_IMAGE_NAME} .'
            }
        }

        // login to docker hub
        stage('docker login') {
            steps {
                sh 'echo ${DOCKER_AUTH_TOKEN} | docker login -u ${DOCKER_USER_NAME} --password-stdin'
            }
        }

        // push the docker image to docker hub
        stage('push docker image') {
            steps {
                sh 'docker image push ${DOCKER_IMAGE_NAME}'
            }
        }

        // restart the service
        stage('restart service') {
            steps {
                sh 'docker service update --force --image ${DOCKER_IMAGE_NAME} python-app' 
            }
        }
    }
}