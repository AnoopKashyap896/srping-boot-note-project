pipeline {
    agent any

    environment {
        // Global environment variables
        PROJECT_NAME = 'MyApp'
        SONARQUBE_SERVER = 'SonarQube-Server'
        SNYK_TOKEN = credentials('db0be2a3-2b59-4c6b-ba14-c0abf1f3cc2e')
        MAVEN_OPTS = '-Dmaven.test.failure.ignore=true'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Cloning source code from Git"
                git url: 'https://github.com/AnoopKashyap896/srping-boot-note-project.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                echo "Building the project with Maven"
                sh 'mvn clean compile'
            }
        }

        stage('Unit Test') {
            steps {
                echo "Running unit tests"
                sh 'mvn test'
                junit '**/target/surefire-reports/*.xml'
            }
        }

        stage('Code Quality - SonarQube') {
            steps {
                withSonarQubeEnv("${SONARQUBE_SERVER}") {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Security Scan - Snyk') {
            steps {
                echo "Running Snyk security scan"
                sh 'snyk test --all-projects'
            }
        }

        stage('Package') {
            steps {
                echo "Packaging application"
                sh 'mvn package'
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            }
        }

        stage('Deploy (Optional)') {
            when {
                expression { return params.DEPLOY_ENV != null }
            }
            steps {
                echo "Deploying to ${params.DEPLOY_ENV} environment"
                // Example deploy script
                sh './scripts/deploy.sh'
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
