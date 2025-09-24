pipeline {
    agent any

    environment {
        APP_NAME = "train-ticket-reservation-system"
        DOCKER_IMAGE = "train-ticket-reservation-system:latest"
    }

    stages {
        stage('Build') {
            steps {
                echo "Building application..."
                // Example: Build with Maven/Gradle/npm depending on project
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                echo "Running tests..."
                // Run unit tests
                sh 'mvn test'
            }
        }

        stage('Docker Build') {
            steps {
                echo "Building Docker image..."
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying application container..."
                // Stop old container if running
                sh """
                   docker stop ${APP_NAME} || true
                   docker rm ${APP_NAME} || true
                   docker run -d --name ${APP_NAME} -p 8080:8080 ${DOCKER_IMAGE}
                """
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs."
        }
    }
}
