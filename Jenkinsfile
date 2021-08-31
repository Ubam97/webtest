pipeline {
  agent any
  stages {
    stage('Git Progress') {
      steps {
        git branch: 'main', credentialsId: 'eub456', url: 'https://github.com/eub456/webtest.git'
      }
    }
  stage('Gradle Build & Image buil') {
      steps {
        sh 'chmod +x ./gradlew'
        sh './gradlew clean build'
        sh 'docker build -t eub456/test .'
        }
    }
  stage('Push docker image') {
    steps {
        withDockerRegistry([ credentialsId: "test", url: "https://registry.hub.docker.com" ]) {
           'step' docker.image.push()
        }
    }
  }
  }
}