FROM openjdk:11
EXPOSE 8085
ADD target/k8s-jenkins.jar k8s-jenkins.jar
ENTRYPOINT ["java","-jar","k8s-jenkins.jar"]