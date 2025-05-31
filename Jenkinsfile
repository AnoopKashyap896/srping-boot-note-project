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

        stage('Build JAR') {
            steps {
                bat 'mvnw.cmd clean package -DskipTests'
            }
        }

//         stage('Deploy to Docker') {
//     steps {
//         script {
//             def imageName = "anoop896/spring-boot-notes"
//             def imageTag = "latest"

//             withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
//                 bat """
//                 echo %DOCKER_PASS% > docker-pass.txt
//                 docker login -u %DOCKER_USER% --password-stdin < docker-pass.txt
//                 del docker-pass.txt
//                 docker build -t ${imageName}:${imageTag} .
//                 docker push ${imageName}:${imageTag}
//                 """
//             }
//         }
//     }
// }
        stage('Build Docker Image') {
            steps {
                bat 'docker build -t anoop896/spring-boot-notes:latest .'
            }
        }

        stage('Security Scan') {
            steps {
                script {
                    bat 'mkdir trivy-report'

                    // Run Trivy scan and generate HTML report
                    bat """
                    trivy image --severity HIGH,CRITICAL ^
                        --format html -o trivy-report\\trivy-report.html ^
                        --exit-code 0 --no-progress anoop896/spring-boot-notes:latest || exit 0
                    """
                }

                publishHTML([
                    reportDir: 'trivy-report',
                    reportFiles: 'trivy-report.html',
                    reportName: 'Trivy Vulnerability Report',
                    keepAll: true,
                    alwaysLinkToLastBuild: true,
                    allowMissing: true
                ])
            }
        }



        stage('Release to Production') {
            steps {
                echo 'Simulated release to production (e.g., using Octopus Deploy or AWS CodeDeploy)'
            }
        }

        stage('Monitoring and Alerting') {
            steps {
                echo 'Simulated integration with Datadog/New Relic for monitoring and alerts'
            }
        }
    }

    post {
        success {
            echo 'Build, Docker deploy, and simulation of release/monitoring stages completed.'
        }
        failure {
            echo 'Pipeline failed during one of the stages.'
        }
    }
}
