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

        stage('Deploy') {
            steps {
                dir('labs') {
                    sh "sudo cp target/labs-0.0.1-SNAPSHOT.war /opt/apache-tomcat-10.1.23/webapps"
                }
            }
        }

        stage("Build docker image") {
            steps{
                script{
                    sh "docker build -t javalabs/devops ."
                }
            }
        }
    }
}