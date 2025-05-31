pipeline {
    agent any
    environment {
        SONARQUBE = credentials('56119190-bc90-4178-99b9-f9828d79c837') // Replace with your SonarQube token ID
        SNYK_TOKEN = credentials('18a62d38-9a06-41ca-a962-1e34055e1a96') // Replace with your Snyk API token ID
    }
   stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/AnoopKashyap896/srping-boot-note-project.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh './mvnw clean install -DskipTests'
            }
        }
        stage('Run Tests') {
            steps {
                sh './mvnw test'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh './mvnw sonar:sonar'
                }
            }
        }
        stage('Snyk Security Scan') {
            steps {
                sh "snyk auth $SNYK_TOKEN"
                sh 'snyk test'
            }
        }
        stage('Build JAR') {
            steps {
                sh './mvnw clean package -DskipTests'
            }
        }
        stage('Deploy to Heroku') {
            steps {
                echo 'Build and deployment successful!'
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
}
