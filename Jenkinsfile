// pipeline {
//     agent any
//     tools{
//         maven 'maven'
//     }
//     stages{
//         stage('Build Maven') {
//             steps{
//                 checkout([$class: 'GitSCM', branches: [[name: '*/SQ_**']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/nguyentiendong99/k8s-jenkins']]])
//                 sh 'mvn clean install'
//             }
//         }
//         stage('Build docker image'){
//             steps{
//                 script{
//                     sh 'docker build -t dongnguyen1999/k8s-jenkins .'
//                 }
//             }
//         }
//         stage('Push image to Hub'){
//             steps{
//                 script{
//                    withCredentials([string(credentialsId: 'dockerpwd', variable: 'dockerpwd')]) {
//                    sh 'docker login -u dongnguyen1999 -p ${dockerpwd}'
//
//                 }
//                    sh 'docker push dongnguyen1999/k8s-jenkins'
//                 }
//             }
//         }
//         stage('Deploy to k8s'){
//             steps{
//                 script{
//                     kubernetesDeploy (configs: 'deployservice.yaml',kubeconfigId: 'kubeconfig')
//                 }
//             }
//         }
//     }
// }


pipeline {
    agent any
    environment {
        IMAGE = 'dongnguyen1999/spring-boot-app:v1'
        CREDENTIALS_ID = 'dockerhub-credentials'
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/nguyentiendong99/k8s-jenkins'
            }
        }
        stage('Build & Package') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t $IMAGE .'
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                      echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                      docker push $IMAGE
                    '''
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
