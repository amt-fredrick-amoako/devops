pipeline {
    agent any

    tools{
        jdk 'jdk'
        maven 'maven3'
    }
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/amt-fredrick-amoako/devops.git'
            }
        }
        stage('Compile') {
            steps{
            dir('labs'){
                sh "mvn compile"
            }
            }

        }
        stage('Test') {
            steps {
                dir('labs'){
                    sh "mvn test"
                }
            }
        }
        stage('Build') {
            steps {
                dir('labs'){
                    sh "mvn package"
                }
            }
        }
        stage('Build & Tag Docker Image') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker'){
                        sh "docker build -t fredamoako/devops:latest ."
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script{
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker'){
                        sh "docker push fredamoako/devops:latest"
                    }
                }
            }
        }
        stage('Deploy K8 Clusters'){
            steps{
                sh "kubectl apply -f devops.yml"
            }
        }
    }
}