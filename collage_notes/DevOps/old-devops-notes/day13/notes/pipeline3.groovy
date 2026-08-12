pipeline {
    agent any
    // environment {}

    stages {

        stage('scm') {
            steps {
                echo "pulling the code from GitHub Repository"
            }
        }

        stage('build') {
            steps {
                echo "building the code"
            }
        }

        stage('test') {
            steps {
                echo "testing the application"
            }
        }

        stage('quality check') {
            steps {
                echo "checking the quality"
            }
        }

        stage('artifacts') {
            steps {
                echo "generating artifacts"
            }
        }

        stage('provision infrastructure') {
            steps {
                echo "provisioning infrastructure using terraform"
            }
        }

        stage('configure infra') {
            steps {
                echo "configuring the infra using ansible"
            }
        }

        stage('deploy') {
            steps {
                echo "deploying the application"
            }
        }
    }
}