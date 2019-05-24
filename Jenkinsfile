pipeline {
    agent any
    //tools {
    //   maven "Maven 3.6.1"
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
        }
        stage('Test by Docker container') {
            steps {
                sh """ if [ ! "\$(docker ps -q -f name=maven)" ];then if [ "\$(docker ps -aq -f status=exited -f name=test_jar)" ];then docker rm maven -f fi docker build -t pipeline . docker run --name maven -d -p 8090:8080 pipeline java -jar *.jar fi"""
            }
        }
        stage('deploy to nexus') {
            steps {
                nexusArtifactUploader(
                        nexusVersion: 'nexus2',
                        protocol: 'http',
                        nexusUrl: 'localhost:8081/nexus',
                        groupId: 'pingable',
                        version: '1.0.${BUILD_NUMBER}-release',
                        repository: 'pipeline',
                        credentialsId: 'cc58507e-b74b-4d26-ba88-88e204ce9b20',
                        artifacts: [
                                [artifactId: 'rd',
                                 classifier: '',
                                 file      : 'target/rd-1.0.${BUILD_NUMBER}-release.jar',
                                 type      : 'jar'
                                ]
                        ]
                )
            }
        }
    }
}