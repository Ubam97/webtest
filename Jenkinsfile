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
                        def customImage = docker.build("eub456/test")
                        customImage.push("latest")
                        customImage.push("${env.BUILD_ID}")
                    }
                }
            }
        }
        stage('ArgoCD Deploy') {
            steps {
                script {
                    sshagent (credentials: ['argoCD']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@13.209.3.46 argocd repo add https://github.com/eub456/webtest.git"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@13.209.3.46 argocd app create test --repo https://github.com/eub456/webtest.git --sync-policy automated --path templates --dest-server https://kubernetes.default.svc --dest-namespace default"
                    }
                }
            }
        }
    }
}
