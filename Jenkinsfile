pipeline {
  agent {
    label 'slave'
  }

  environment {
    dockerImage =''
    registry = 'liorberi/wtapp:$BUILD_NUMBER'
    registryCredential ='dockerhub_id'
  }

  // clean environment with new files
  stages {
    stage('Checkout') {
      steps {
        cleanWs()
        checkout scm
      }
    }

    // Build docker image
    stage('Create Docker Image') {
      steps {
        script {
          dockerImage = docker.build registry
        }
      }
    }

    // Push the image into docker registry
    stage ('Push To Registry') {
      steps {
        script {
          docker.withRegistry( '', registryCredential ) {
          dockerImage.push()
          }
        }
      }
    }
  }
}