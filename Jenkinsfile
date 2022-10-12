pipeline {
    agent any

    stages {
        stage('git clone frontend') {
            steps {
                git 'https://github.com/AhTheary/DevOps-Client.git'
            }
        }
        stage('build frontend') {
            steps {
                sh 'cd /var/lib/jenkins/workspace/client && npm install && npm run build'
            }
        }
    }
    post {
          success {
            sh " cp -rf /var/lib/jenkins/workspace/client/dist/ /var/www/"
          }
    }
}