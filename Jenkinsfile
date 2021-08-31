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
            agent any
            steps {
                script {
                    checkout scm
                    docker.withRegistry('https://registry.hub.docker.com', 'test') {
                        def customImage = docker.build("eub456/test:${env.BUILD_ID}")
                    }
                    customImage.push()
                }
            }
        }
    }
}
