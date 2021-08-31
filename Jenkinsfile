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
    stage ('Docker-hub login') {
        steps {
           'step' docker.withRegistry('https://registry.hub.docker.com', 'test') {
            }
        }
    }
    stage ('Image push') {
        steps {
            sh 'docker push eub456/test:lates'
            sh 'docker push eub456/test:${env.BUILD_NUMBER}'
        }
    }
  }
}
