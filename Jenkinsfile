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
            'steps1'    docker.withRegistry('https://registry.hub.docker.com', 'test') {
                }
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
        }
    }
  }
}