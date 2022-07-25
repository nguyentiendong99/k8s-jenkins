pipeline {
    agent any
    tools{
        maven 'maven'
    }
    stages{
        stage('Build Maven'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/nguyentiendong99/k8s-jenkins']]])
                sh 'mvn clean install'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t dongnguyen1999/k8s-jenkins .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
//                    withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
//                    sh 'docker login -u dongnguyen1999 -p ${dockerhubpwd}'
//                 }
                   sh 'docker login'
                   sh 'docker push dongnguyen/k8s-jenkins'
                }
            }
        }

    }

}