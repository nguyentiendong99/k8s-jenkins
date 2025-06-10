pipeline {
  agent {
    kubernetes {
      label 'spring'
      defaultContainer 'maven'
      yaml """
        apiVersion: v1
        kind: Pod
        spec:
          containers:
            - name: maven
              image: maven:3.8.7-eclipse-temurin-11
              command: ['cat']
              tty: true
            - name: docker-kubectl
              image: docker:24.0.7-cli
              command: ['cat']
              tty: true
              volumeMounts:
                - name: docker-sock
                  mountPath: /var/run/docker.sock
          volumes:
            - name: docker-sock
              hostPath:
                path: /var/run/docker.sock
        """
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
        sh 'mvn clean package -DskipTests'
      }
    }

    stage('Docker Build & Push') {
      steps {
        container('docker-kubectl') {
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
        container('docker-kubectl') {
          sh 'kubectl apply -f deployment.yaml'
        }
      }
    }
  }
}

