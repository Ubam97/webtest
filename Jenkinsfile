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
    node { 
        stage('Clone repository') {
         checkout scm 
         }
    stage('Build image') {
        app = docker.build("jenkins-docker-pipeline/my-image") 
    }
    }
  }
}