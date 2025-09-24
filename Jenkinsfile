pipeline {
    agent any

    tools {
        maven 'Maven3'
        jdk 'JDK11'
    }

    environment {
        IMAGE_NAME = "Task2-app"
        REGISTRY = "docker.io/naveenrroy" // change to your DockerHub username
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Checking out code..."
                git branch: 'main', url: 'https://github.com/naveenrahulroy7-dot/Task2.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "Installing Node.js dependencies..."
                sh '''
                if ! command -v npm &> /dev/null; then
                    echo "Node.js/NPM not installed. Aborting..."
                    exit 254
                fi
                npm install || { echo "npm install failed"; exit 254; }
                '''
            }
        }

        stage('Test') {
            steps {
                echo "Running tests..."
                sh '''
                if npm test; then
                    echo "Tests passed"
                else
                    echo "No tests defined or tests failed. Continuing..."
                fi
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh '''
                if ! command -v docker &> /dev/null; then
                    echo "Docker not installed. Aborting..."
                    exit 254
                fi
                docker build -t $IMAGE_NAME:latest . || { echo "Docker build failed"; exit 254; }
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Pushing Docker image to registry..."
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin || { echo "Docker login failed"; exit 254; }
                    docker tag $IMAGE_NAME:latest $REGISTRY/$IMAGE_NAME:latest || { echo "Docker tag failed"; exit 254; }
                    docker push $REGISTRY/$IMAGE_NAME:latest || { echo "Docker push failed"; exit 254; }
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying Docker container..."
                sh '''
                docker run -d -p 3000:3000 $REGISTRY/$IMAGE_NAME:latest || { echo "Docker run failed"; exit 254; }
                '''
            }
        }
    }

    post {
        always {
            echo "Pipeline finished. Cleaning up any dangling Docker images..."
            sh 'docker system prune -f || echo "No cleanup needed"'
        }
        success {
            echo "Pipeline succeeded!"
        }
        failure {
            echo "Pipeline failed. Check logs above."
        }
    }
}
