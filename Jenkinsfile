pipeline {
    agent any
    stages {
        stage('Git Progress') {
            steps {
                checkout scm
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
        //stage('OWASP Dependency-Check') {
            //steps {
                //dependencyCheck additionalArguments: '-s "./" -f "XML" -o "./" //--prettyPrint', odcInstallation: 'dependency'
                //dependencyCheckPublisher pattern: 'dependency-check-report.xml'
                //dependencyCheck additionalArguments: '-s "./" -f "HTML" -o "./" //--prettyPrint', odcInstallation: 'dependency'
            //}
        //}
        stage('SonarQube analysis') {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'sonar') {
                        sh "./gradlew sonarqube \
                        -Dsonar.projectKey=sonar-test \
                        -Dsonar.host.url=http://3.36.98.83:9000/ \
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
        stage('ArgoCD Deploy') {
            steps {
                script {
                    sshagent (credentials: ['argoCD']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@15.164.214.244 argocd repo add https://github.com/eub456/webtest.git"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@15.164.214.244 argocd app create test2 --repo https://github.com/eub456/webtest.git --sync-policy automated --path templates --dest-server https://kubernetes.default.svc --dest-namespace default"
                    }
                }
            }
        }
        stage('Arachni scanner') {
            steps {
                script {
                    sshagent (credentials: ['argoCD']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@15.164.214.244 /home/ec2-user/arachni-1.5.1-0.5.12/bin/arachni http://a7e10107c1fc74ffda91e87078a1cd83-370874758.ap-northeast-2.elb.amazonaws.com --report-save-path=arachni.afr"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@15.164.214.244 /home/ec2-user/arachni-1.5.1-0.5.12/bin/arachni_reporter arachni.afr --reporter=json:outfile=arachni.json.zip"
                    }
                }
            }
        }
    }
}