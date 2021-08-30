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
        stage {
            checkout scm
        }
    }

    stage('Dcoker image build') {
        steps {
            app = docker.build("eub456/test")
        }
    }
  }
}