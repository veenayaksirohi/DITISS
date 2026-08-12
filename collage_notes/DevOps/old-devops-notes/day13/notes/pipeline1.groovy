// beginning of pipeline
pipeline {

    // select any agent available
    agent any

    // define global environment variables
    // environment {}

    // define the stages in the pipeline
    stages {

        // stage1
        stage('stage 1') {

            // define the steps to execute this stage
            steps {
                echo "stage 1"
            }
        }
    }
}