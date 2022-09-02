// pipeline {
//     agent any
//     tools{
//         maven 'maven'
//     }
//     stages{
//         stage('Build Maven') {
//             steps{
//                 checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/nguyentiendong99/k8s-jenkins']]])
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
    agent {
        docker {
            image 'maven'
            args '-v ~/.m2:/root/.m2'
        }
    }
    stages {
        stage ('Quality gate status check') {
            steps {
                script {
                    withSonarQubeEnv('sonarserver') {
                        sh 'mvn sonar:sonar'
                    }
                    timeout(time: 1, unit: 'HOURS') {
                        def qg = waitForQualityGate() 
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                    sh "mvn clean install"
                }
            }
        }
    }
}