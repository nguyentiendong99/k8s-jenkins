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
                   withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhub')]) {
                   sh 'docker login -u dongnguyen1999 -p ${dockerhub}'
                }
                   sh 'docker push dongnguyen1999/k8s-jenkins'
                }
            }
        }
        stage('Deploy to k8s'){
            steps{
                script{
                    kubernetesDeploy (configs: 'deployservice.yaml',kubeconfigId: 'kube-config')
                }
            }
        }
    }
}