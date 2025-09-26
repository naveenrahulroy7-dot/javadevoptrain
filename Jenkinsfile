pipeline {
    agent any 

    stages {
        stage("Git checkout") {
            steps {
              git branch: 'main', url: 'https://github.com/naveenrahulroy7-dot/javadevoptrain.git'
            }
        }                 
        stage("Build") {
            steps {
                echo 'Building the application'
                sh 'mvn clean install
            }
        }
        stage("Test") {
            steps {
                echo 'Testing the application'
                sh 'mvn test'
            }
        }
        post {
            success {
                echo 'Build executed succesfully !'
            }
            failure {
                echo 'Build failed !'
            }
        }
    }
}

    
