pipeline {
  agent any
  stages {
    stage('deploy to kube') {
      steps {
        kubernetesDeploy()
      }
    }
  }
}