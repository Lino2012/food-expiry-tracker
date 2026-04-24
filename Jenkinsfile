pipeline {
    agent any
    
    tools {
        maven 'Maven-3.8'
        jdk 'JDK-11'
    }
    
    environment {
        SONAR_SCANNER_HOME = tool 'SonarScanner'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo '✅ Code cloned from Git repository'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests'
                echo '✅ Maven build completed successfully'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml'
                }
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        
        stage('Package WAR') {
            steps {
                sh 'mvn package -DskipTests'
                echo '✅ WAR file created'
            }
        }
        
        stage('Archive WAR') {
            steps {
                archiveArtifacts artifacts: 'target/*.war', fingerprint: true
                echo '✅ WAR artifact archived'
            }
        }
        
        stage('Docker Build') {
            steps {
                sh 'docker build -t food-expiry-tracker:latest .'
                echo '✅ Docker image built'
            }
        }
        
        stage('Docker Compose Deploy') {
            steps {
                sh 'docker-compose down || true'
                sh 'docker-compose up -d'
                echo '✅ Application deployed via Docker Compose'
            }
        }
    }
    
    post {
        success {
            echo '🎉 Pipeline executed successfully! Application is running.'
        }
        failure {
            echo '❌ Pipeline failed! Check the logs above.'
        }
        always {
            cleanWs()
        }
    }
}