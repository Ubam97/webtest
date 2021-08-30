pipeline {
  agent any

  stages {
    stage('Git Progress') {
      steps {
        git credentialsId: '5db03fd5-6b54-45c6-', 
        url: 'https://github.com/smartjy/(PROJECT_NAME).git'
      }
    }
  stage('Gradle Build') {
      steps {
        sh 'gradle clean build -x test -b build-server.gradle'
      }
    }
  }
}