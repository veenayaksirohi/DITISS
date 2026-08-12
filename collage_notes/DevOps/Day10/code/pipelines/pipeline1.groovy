// pipeline block
pipeline {

    // select any available agent for execution
    agent any

    // pipeline specific environment settings
    environment {
        // environment variables will be defined here
        MY_ENV_VAR="test"
    }

    // sequence of stages
    stages {

        // stage configuration
        stage('stage1') {
            
            // steps to execute
            steps {

                // execute a shell command
                sh 'echo "this is the first stage"'
            }
        }
    }
}