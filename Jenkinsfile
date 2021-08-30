
 node {
     stage('Clone repository') {
         checkout scm
     }

     stage('Build image') {
         app = docker.build("eub456/test")
     }

     stage('Test image'){
        app.inside {
            sh 'echo "Tests passed"'
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

     stage('Push image') {
            docker.withRegistry('https://registry.hub.docker.com', 'test') {
                app.push("${env.BUILD_NUMBER}")
                app.push("latest")
            }
        }
 }