pipeline {
    agent any
    stages {
        stage('Git Progress') {
            steps {
                git  branch: 'main', credentialsId: 'eub456', url: 'https://github.com/eub456/webtest.git'
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
            steps {
                junit '**/build/test-results/test/*.xml'
            }
        }
        stage ('Push image') {
            steps {
                script {
                    checkout scm
                    docker.withRegistry('https://registry.hub.docker.com', 'test') {
                        def customImage = docker.build("eub456/test:${env.BUILD_ID}")
                        customImage.push()
                    }
                }
            }
        }
        stage('Deploy')
            steps {
                sshagent (credentials: ['test-web']) {
                    sh 'scp -o UserKnownHostFile=/dev/null -o StrictHostKeyChecking=no -r build/libs/demo-0.0.1-SNAPSHOT.jar ubuntu@3.34.94.137:/home/ubuntu/deploy'
                }
            }
    }
}
