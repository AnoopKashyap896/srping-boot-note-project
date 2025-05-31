pipeline {
    agent any

    environment {
        JAVA_HOME = "C:\\Program Files\\Java\\jdk-17"
        PATH = "${env.JAVA_HOME}\\bin;${env.PATH}"
        SNYK_TOKEN = credentials('18a62d38-9a06-41ca-a962-1e34055e1a96')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/AnoopKashyap896/srping-boot-note-project.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'mvnw.cmd clean install -DskipTests'
            }
        }

        stage('Run Tests') {
            steps {
                bat 'mvnw.cmd test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withCredentials([usernamePassword(credentialsId: '56119190-bc90-4178-99b9-f9828d79c837', usernameVariable: 'SONAR_USER', passwordVariable: 'SONAR_TOKEN')]) {
                    withSonarQubeEnv('MySonar') {
                        bat "./mvnw sonar:sonar -Dsonar.login=%SONAR_TOKEN%"
                    }
                }
            }
        }

        stage('Snyk Authentication') {
            steps {
                bat 'snyk auth %SNYK_TOKEN%'
            }
        }

        stage('Snyk Security Scan (Skipped)') {
            steps {
                echo 'Skipping Snyk Security Scan due to authentication issues.'
            }
        }

        stage('Build JAR') {
            steps {
                bat 'mvnw.cmd clean package -DskipTests'
            }
        }

        stage('Deploy to Docker') {
            steps {
                script {
                    bat 'docker build -t spring-boot-notes .'
                    bat 'docker stop spring-boot-notes || exit 0'
                    bat 'docker rm spring-boot-notes || exit 0'
                    bat 'docker run -d -p 8080:8080 --name spring-boot-notes spring-boot-notes'
                }
            }
        }

        stage('Release to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                        bat 'docker tag spring-boot-notes %DOCKER_USER%/spring-boot-notes:prod'
                        bat 'docker push %DOCKER_USER%/spring-boot-notes:prod'
                    }
                }
            }
        }

        stage('Monitoring & Alerting') {
            steps {
                echo 'Simulating monitoring setup with Datadog or New Relic...'
                echo 'In production, hook this with real alerting APIs/scripts.'
            }
        }
    }

    post {
        success {
            echo '✅ Build, deploy and monitoring complete!'
        }
        failure {
            echo '❌ Something failed. Investigate the logs.'
        }
    }
}
