pipeline {
    agent any

    stages {
        stage('git progress') {
            steps {
                git branch: 'main', credentialsId: 'eub456', url: 'https://github.com/eub456/webtest.git'
            }
        }
    }

    tools {
        'gradle'
    }

    stage ('Build') {    
       steps {
             bat "./gradlew.bat build" }
    }
}