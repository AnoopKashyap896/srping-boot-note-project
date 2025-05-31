pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Install Dependencies') {
      steps {
        bat 'npm install'
      }
    }
    stage('Install Snyk CLI') {
      steps {
        bat 'npm install -g snyk'
      }
    }
    stage('Snyk Scan') {
      steps {
        withCredentials([string(credentialsId: 'snyk-api-token', variable: 'SNYK_TOKEN')]) {
          bat 'snyk auth %SNYK_TOKEN%'
          bat 'snyk test'
        }
      }
    }
    stage('Build') {
      steps {
        echo 'Build steps here...'
      }
    }
    stage('SonarQube Analysis') {
      steps {
        echo 'SonarQube steps here...'
      }
    }
  }
}
