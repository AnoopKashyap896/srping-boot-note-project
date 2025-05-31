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
        // stage('Snyk Security Scan') {
        // steps {
        //          bat '"C:\\Users\\anoop\\AppData\\Roaming\\npm\\snyk.cmd" auth %SNYK_TOKEN%'
        //          bat '"C:\\Users\\anoop\\AppData\\Roaming\\npm\\snyk.cmd" test --file=pom.xml --package-manager=maven'
        //     }
        // }
        stage('Snyk Authentication') {
            steps {
                bat 'snyk auth %SNYK_TOKEN%'
            }
        }
        stage('Snyk Security Scan') {
            steps {
                bat 'snyk test --file=pom.xml --package-manager=maven'
            }
        }
        // stage('Snyk Security Scan') {
        // steps {
        //         bat '"C:\\Users\\anoop\\AppData\\Roaming\\npm\\snyk.cmd" test --file=pom.xml --package-manager=maven --auth=%SNYK_TOKEN%'
        //       }
        // }
        stage('Build JAR') {
            steps {
                bat 'mvnw.cmd clean package -DskipTests'
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
