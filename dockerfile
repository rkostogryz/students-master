FROM openjdk
WORKDIR /home/app
COPY target/rd-1.0.${BUILD_NUMBER}-release.jar /home/app/rd-1.0.${BUILD_NUMBER}-release.jar
EXPOSE 8080
CMD ["java", "-jar", "rd-1.0.${BUILD_NUMBER}-release.jar"]