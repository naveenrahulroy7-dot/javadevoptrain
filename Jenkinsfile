/*pipeline {
    agent any

     tools {
        maven 'Maven3'
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        DOCKER_IMAGE = "naveenrroy/java"
    } 
    
    stages {
        stage("Git checkout") {
            steps {
             git branch: 'main', url: 'https://github.com/naveenrahulroy7-dot/javadevoptrain.git'
            }
        }                 
        stage("Build") {
            steps {
                echo 'Building the application'
                sh 'mvn clean install'
            }
        }
        stage("Test") {
            steps {
                echo 'Testing the application'
                sh 'mvn test'
            }
        }
        stage("Build Docker Image") {
            steps {
            sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER .'
        }
     }
     stage("Push Docker Image") {
         steps {
            echo 'Pushing Docker Image to Docker Hub'
             withDockerRegistry([credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/']) {
               sh 'docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}'
              }
            }
        }   
    }
     post {
        success {
             echo 'Build executed succesfully !'
        }
        failure {
             echo 'pipeline failed ! check logs once !'
            }
        }
    }
    







pipeline {
    agent any
    
    environment {
        DOCKERHUB_CREDS = credentials('dockerhub')  // Jenkins credentials ID
        IMAGE = "naveenrroy/app:latest"
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/naveenrahulroy7-dot/javadevoptrain.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE .'
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push $IMAGE'
            }
        }
    }
}
*/




pipeline {
    agent any 
    
    environment {
        DOCKER_CREDS = 'dockerhub'
        DOCKER_IMAGE = 'naveenrroy/app'
    }
    stages {
        stage("git checkout") {
            steps {
                git branch: 'main', url:'https://github.com/naveenrahulroy7-dot/javadevoptrain.git'
            }
        }
        stage('Build & Push Docker Image') {
            steps {
                    echo "Building the Docker Image ...!"
                    sh 'docker build -t $DOCKER_IMAGE .'
                    
                    echo "Login into Docker ...!"
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                     
                     echo "Pushing the Docker Image ...!"
                     sh 'docker push $DOCKER_IMAGE'
                     
                }
            }
        }
    }
    post {
        success{
            echo "IMAGE PUSHED SUCCESFULLY ...!"
        }
        failure {
            echo  "PUSH FAILED"
        }
    }
}
