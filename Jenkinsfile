pipeline {
  agent {
    label 'slave'
  }

  environment {
    dockerImage =''
    registry = 'liorberi/node-weight-tracker:v03'
    registryCredential ='liorberi'
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