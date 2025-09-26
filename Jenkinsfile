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
                sh 'mvn clean install'
            }
        }
        stage("Test") {
            steps {
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

    
