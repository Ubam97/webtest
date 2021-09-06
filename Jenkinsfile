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
                sh 'chmod +x ./gradlew'
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
        stage('Push image') {
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
        stage('argoCD Deploy') {
            steps {
                script {
                    sshagent (credentials: ['argoCD']) {
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@3.34.127.63 argocd repo add https://github.com/eub456/webtest.git"
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@3.34.127.63 argocd app create test --repo https://github.com/eub456/webtest.git --sync-policy automated --path templates --dest-server https://kubernetes.default.svc --dest-namespace default"
                    }
                }
            }
        }
    }
}
