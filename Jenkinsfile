pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                git branch: 'main', credentialsId: 'eub456', url: 'https://github.com/eub456/webtest.git'
            }
        }
    }
}