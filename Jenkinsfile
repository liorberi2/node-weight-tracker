pipeline {
  agent any
  stages{
    stage('initialization') {
      steps {
        sh 'npm init -y'
      }
    }
    stage('publish package') {
      steps {
        sh 'npm publish'
      }
    }
  }
}