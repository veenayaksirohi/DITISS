pipeline {
    agent any
    stages {
        stage('SCM') {
            steps {
                sh 'echo "pull the latest changes from git repo"'
            }
        }

        stage('Build') {
            steps {
                sh 'echo "building the source code"'
            }
        }

        stage('Test') {
            steps {
                sh 'echo "testing the code"'
            }
        }

        stage('code quality') {
            steps {
                sh 'echo "checking code quality"'
            }
        }

        stage('notification') {
            steps {
                sh 'echo "notifying all the team members about the progress"'
            }
        }
    }
}