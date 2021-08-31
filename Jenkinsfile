pipeline {
  agent any
  stages {
    stage('Git Progress') {
      steps {
        git branch: 'main', credentialsId: 'eub456', url: 'https://github.com/eub456/webtest.git'
      }
    }
    stage('Gradle Junit Test') {
            steps {
                sh "chmod +x gradlew; ./gradlew test"
            }
    }
  stage('Gradle Build ') {
      steps {
        sh 'chmod +x ./gradlew'
        sh './gradlew clean build'
        }
    }
    stage('Publish test results') {
        junit '**/build/test-results/test/*.xml'
    } 
    stage ('Push image') {
        steps {
                checkout scm
                    'docker' docker.withRegistry('https://registry.hub.docker.com', 'test') {

                            customImage = docker.build("eub456/test:${env.BUILD_ID}")

                            customImage.push()
                   }
        }
    }
  }
}
