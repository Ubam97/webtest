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
  stage ('Docker image build') {
      stesps {
        script {
          sh 'docker build -t eub456/test .'
        }
      }
 s }
  }
}