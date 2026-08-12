pipeline {
    agent any

    // environment {}

    stages {

        stage('stage 1') {
            steps {
                echo "this is first stage"
            }
        }

        stage('stage 2') {
            steps {
                echo "this is second stage"
            }
        }

        stage('stage 3') {
            steps {
                echo "this is third stage"
            }
        }
    }
}