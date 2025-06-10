pipeline {
  agent {
    kubernetes {
      label 'spring'
      defaultContainer 'maven'
    }
  }

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

    stage('Build') {
      steps {
        container('maven') {
          sh 'mvn clean package -DskipTests'
        }
      }
    }

    stage('Docker Build & Push') {
      steps {
        container('docker') {
          withCredentials([usernamePassword(credentialsId: "${CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            sh """
              docker build -t $IMAGE .
              echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
              docker push $IMAGE
            """
          }
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        container('kubectl') {
          sh 'kubectl apply -f deployment.yaml'
        }
      }
    }
  }
}
