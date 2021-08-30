pipeline {
  agent {
    node {
      label 'master'
    }
  }
  stages {
    stage('Git Progress') {
      steps {
        git credentialsId: 'git', 
        url: 'https://github.com/eub456/webtest.git'
      }
    }
  stage('Gradle Build') {
      steps {
        sh 'gradle clean build -x test -b build-server.gradle'
      }
    }
  }
}