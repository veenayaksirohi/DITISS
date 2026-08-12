pipeline {
    agent any

    stages {
        stage('SCM') {
            steps {
                // get the latest changes from github repository
                git 'https://github.com/pythoncpp/ditiss-website-demo.git'
            }
        }

        stage('build docker image') {
            steps {
                sh 'docker image build -t amitksunbeam/httpd-website .'
            }
        }

        stage('docker login') {
            steps {
                sh 'echo <docker access token> | docker login -u <dockerhub accountname> --password-stdin'
            }
        }

        stage('push docker image') {
            steps {
                sh 'docker image push <dockerhub accountname>/<imagename>'
            }
        }

        stage('reload the service') {
            steps {
                sh 'docker service update --force --image <dockerhub accountname>/<imagename> httpd-website'
            }
        }
    }
}