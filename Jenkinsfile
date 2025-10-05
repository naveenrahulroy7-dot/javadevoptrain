r/*pipeline {
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
    */





pipeline {
    agent any 

    parameters {
        string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Docker hub tag')
    }
    environment {
        REGISTRY = 'docker.io'
        IMAGE_NAME = 'naveenrroy/app'
        DOCKER_CREDS = 'dockerhub'
    }
    stages {
        stage('git checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/naveenrahulroy7-dot/javadevoptrain.git'
            }
        }
        stage('Testing the application') {
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Build & push the Docker image') {
            steps{
                script{
                     echo "Building the Docker Image !"
                      def dockerImage = docker.build("${IMAGE_NAME}:${params.IMAGE_TAG}")
                    
                     echo "Pushing the Docker Image !"
                      docker.withRegistry("https://${REGISTRY}", DOCKER_CREDS) {
                      dockerImage.push()
                }
                echo "Image pushed succesfully ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }
    }
    stage('Debug Registry Info') {
     steps {
       sh '''
         echo "REGISTRY=$REGISTRY"
         echo "IMAGE_NAME=$IMAGE_NAME"
         docker info
       '''
     }
   }
}
post {
 success{
     echo "Image pushed succesfully"
    }
    failure {
        echo "Image not pushed"
     }
  }
}
