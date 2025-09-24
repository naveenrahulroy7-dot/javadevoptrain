pipeline {
  agent any
  environment {
    IMAGE = "dockerhub-user/task2" // change
  }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Install') {
      steps { sh 'npm install' }
    }
    stage('Test') {
      steps { sh 'npm test' }
    }
    stage('Docker Build') {
      steps {
        script {
          sh "docker build -t ${IMAGE}:${env.BUILD_NUMBER} ."
        }
      }
    }
    stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
          sh "docker push ${IMAGE}:${env.BUILD_NUMBER}"
          sh 'docker logout'
        }
      }
    }
    stage('Deploy') {
      steps {
        sh '''
          docker stop jenkins-demo || true
          docker rm jenkins-demo || true
          docker run -d --name jenkins-demo -p 4000:3000 ${IMAGE}:${BUILD_NUMBER}
        '''
      }
    }
  }
  post {
    always {
      echo "Pipeline finished - cleaning workspace"
      deleteDir()
    }
  }
}
