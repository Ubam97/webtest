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

    stage('Clone Repository'){
        steps {
            checkout scm
        }
    }

    stage('Dcoker image build') {
        steps {
            sh 'docker build -t eub456/test'
        }
    }
  }
}