pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: helm
            image: alpine/helm
            command:
            - cat
            tty: true
          - name: docker-test
            image: docker:19.03.12
            command:
            - cat
            tty: true
        '''
      
    }
  }
  stages {
     stage('Initialize Helm Repo') {
      steps {
        container('helm') {
          sh 'helm repo login openonnovationai demo.harbor.com'
        }
      }
    }
    stage('Docker Login') {
      steps {
        container('docker-test') {
          withCredentials([usernamePassword(credentialsId: 'docker-login', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh 'docker login demo.goharbor.io/openinnovationai  --username $DOCKER_USERNAME --password $DOCKER_PASSWORD'
          }
        }
      }
    }
    stage('Application Build') {
      steps {
          sh 'echo "yarn build app"'
      }
    }
  }
}
