pipeline {
    agent any

    tools{
        jdk 'jdk'
        maven 'maven-3'
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
                    sh "mvn clean compile"
                }
            }
        }

        stage('Build') {
            steps {
                dir('labs') {
                    sh "mvn clean package"
                }
            }
        }

        stage("Build docker image") {
            steps{
                script{
                    sh "docker build -t javalabs/devops ."
                    sh "docker run --name devopslabs --rm -p 8083:8083 -d javalabs/devops"
                }
            }
        }
    }
}