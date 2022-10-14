pipeline {
    environment {
        registry = "theay003/devops"
        registryCredential = 'dockerhub_id'
        dockerImage = ''
    }

    agent any

    stages {

        stage('git clone frontend') {
            steps {
                git 'https://github.com/AhTheary/DevOps-Client.git'

            }
        }

        stage('Build') {
            steps {
                sh 'cd /var/lib/jenkins/workspace/client && npm install '
            }
        }

        stage('Building image') {
            steps{
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }

        stage('Deploy Image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('docker stop container') {
        steps {
            sh 'docker ps -f name=mywebContainer -q | xargs --no-run-if-empty docker container stop'
            sh 'docker container ls -a -fname=mywebContainer -q | xargs -r docker container rm'
        }
    }

        stage('Docker Run') {
            steps{
                script {
                    dockerImage.run("-p 3000:3000 --rm --name mywebContainer")
                }
            }
        }
    }
}
// pipeline {
//     agent any

//     stages {
//         stage('git clone frontend') {
//             steps {
//                 git 'https://github.com/AhTheary/DevOps-Client.git'
//             }
//         }
//         stage('build frontend') {
//             steps {
//                 sh 'cd /var/lib/jenkins/workspace/client && npm install && npm run build'
//             }
//         }
//     }
//     post {
//           success {
//             sh " cp -rf /var/lib/jenkins/workspace/client/dist/ /var/www/"
//           }
//     }
// }
