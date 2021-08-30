pipeline {
  agent any

  stages {
    stage('Git Progress') {
      steps {
        git branch: 'main', credentialsId: 'eub456', url: 'https://github.com/eub456/webtest.git'
      }
    }
  stage('Gradle Build') {
      steps {
        sh 'chmod +x ./gradlew'
        sh './gradlew clean build'
            }
        }
    }

    stage('Clone repository') {
             checkout scm
    }
}
