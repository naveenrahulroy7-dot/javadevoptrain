pipeline {
    agent any

     tools {
        maven 'Maven3'
    }
   /* environment {
        DOCKERHUB_CREDENTIALS=credentials('dockerhub-credentials-id')
        DOCKER_IMAGE = "naveenrroy/java"
    } */
    
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
       /* stage("Build Docker Image") {
            steps {
            sh 'docker build -t $DOCKERIMAGE:$BUILD_NUMBER .'
        }
     }*/
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
    
