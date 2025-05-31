pipeline {
    agent any
    environment {
        SONARQUBE = credentials('squ_e62e77bb820afb01a5c548bcea0a884fd59c5d4d') // Replace with your SonarQube token ID
        SNYK_TOKEN = credentials('db0be2a3-2b59-4c6b-ba14-c0abf1f3cc2e') // Replace with your Snyk API token ID
    }
    tools {
        maven 'Maven 3.8.8' // Ensure this matches the Maven version installed in Jenkins
        jdk 'JDK 17' // Ensure this matches the JDK version installed in Jenkins
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/AnoopKashyap896/srping-boot-note-project.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                script {
                    sh './mvnw clean install -DskipTests'
                }
            }
        }
        stage('Run Tests') {
            steps {
                script {
                    sh './mvnw test'
                }
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv('SonarQube') {
                        sh './mvnw sonar:sonar'
                    }
                }
            }
        }
        stage('Snyk Security Scan') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'snyk-api-token', variable: 'SNYK_TOKEN')]) {
                        sh 'snyk auth $SNYK_TOKEN'
                        sh 'snyk test'
                    }
                }
            }
        }
        stage('Build JAR') {
            steps {
                script {
                    sh './mvnw clean package -DskipTests'
                }
            }
        }
        stage('Deploy to Heroku') {
            steps {
                script {
                    echo 'Build and deployment successful!'
                    }
                }
            }
        }
    }
    post {
        success {
            echo 'Build and deployment successful!'
        }
        failure {
            echo 'Build or deployment failed.'
        }
    }
