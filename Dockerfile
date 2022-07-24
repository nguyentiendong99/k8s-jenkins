FROM openjdk:11
EXPOSE 8080
ADD target/k8s-jenkins.jar k8s-jenkins.jar
ENTRYPOINT ["java","-jar","k8s-jenkins.jar"]