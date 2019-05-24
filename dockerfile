FROM openjdk
WORKDIR /home/app
COPY target/*.jar /home/app/*.jar
EXPOSE 8080
CMD ["java", "-jar", "*.jar"]
