pipeline {
    agent any

    tools {
        jdk 'jdk'
        maven 'maven3'
    }

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/amt-fredrick-amoako/devops.git'
            }
        }
        stage('Compile') {
            steps {
                dir('labs') {
                    sh "mvn compile"
                }
            }
        }
        stage('OWASP Dependency Check') {
            steps {
                dependencyCheck additionalArguments: '--scan labs', odcInstallation: 'dependency_check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        stage('Sonarqube') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh '''
                        $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=devops \
                        -Dsonar.java.binaries=. \
                        -Dsonar.projectKey=devops
                    '''
                }
            }
        }
        stage('Test') {
            steps {
                dir('labs') {
                    sh "mvn test"
                }
            }
        }
        stage('Build') {
            steps {
                dir('labs') {
                    sh "mvn package"
                }
            }
        }
        stage('Build & Tag Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh "docker build -t fredamoako/devops:latest ."
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh "docker push fredamoako/devops:latest"
                    }
                }
            }
        }
        stage('Deploy K8 Clusters') {
            steps {
                sh "kubectl apply -f devops.yml"
            }
        }
    }
}