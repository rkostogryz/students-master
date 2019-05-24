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
                sh "docker build -t maven:${BUILD_NUMBER} ."
                sh "docker run --name pipeline -d -ti -p 8090:8080 maven:${BUILD_NUMBER} java -jar *.jar"
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