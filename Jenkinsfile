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
        stage('OWASP Dependency-Check') {
            steps {
                dependencyCheck additionalArguments: '-s "./" -f "XML" -o "./" --prettyPrint', odcInstallation: 'dependency'
                dependencyCheckPublisher pattern: 'dependency-check-report.xml'
                dependencyCheck additionalArguments: '-s "./" -f "HTML" -o "./" --prettyPrint', odcInstallation: 'dependency'
            }
        }
        stage('SonarQube analysis') {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'sonar') {
                        sh "./gradlew sonarqube \
                        -Dsonar.projectKey=sonar-test \
                        -Dsonar.host.url=http://13.125.6.147:9000/ \
                        -Dsonar.login=fb7db0007b25c4c98fa8f3e24801f3335b4211c9"
                    }
                }
            }
        }       
        stage('Anchore test') {
            steps {
                script {
                    def imageLine = 'eub456/test:latest'
                    writeFile file: 'eub456/test:latest', text: imageLine
                    anchore name: 'eub456/test:latest', engineCredentialsId: 'anchore', bailOnFail: false
                }
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
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@54.180.114.224 argocd repo add https://github.com/eub456/webtest.git"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@54.180.114.224 argocd app create test2 --repo https://github.com/eub456/webtest.git --sync-policy automated --path templates --dest-server https://kubernetes.default.svc --dest-namespace default"
                    }
                }
            }
        }
        stage('Arachni scanner') {
            steps {
                script {
                    sshagent (credentials: ['argoCD']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@54.180.114.224 /home/ec2-user/arachni-1.5.1-0.5.12/bin/arachni http://abc77ca99adfe4e8eb3b2e571bcd8d1a-533161508.ap-northeast-2.elb.amazonaws.com/ --checks=xss* --report-save-path=test.afr"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@54.180.114.224 /home/ec2-user/arachni-1.5.1-0.5.12/bin/arachni_reporter test.afr --reporter=json:outfile=my_report.json"
                    }
                }
            }
        }
    }
}