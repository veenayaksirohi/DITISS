pipeline {
    agent any

    stages {
        stage('SCM') {
            steps {
                // get the latest changes from github repository
                // sh 'git clone https://github.com/pythoncpp/ditiss-website-demo.git'
                git 'https://github.com/pythoncpp/ditiss-website-demo.git'
            }
        }
    }
}