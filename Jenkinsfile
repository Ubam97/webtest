pipeline {
    agent any

    stages {
        stage('git progress') {
            steps {
                git branch: 'main', credentialsId: 'eub456', url: 'https://github.com/eub456/webtest.git'
            }
        }
    }

    stage {
        stage('Build gradle'){
            steps {
                 sh 'gradle clean build -x test'
            }
        }
    }
}