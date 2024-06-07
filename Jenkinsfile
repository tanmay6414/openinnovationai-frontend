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
          
          sh 'docker login demo.goharbor.io/openinnovationai  --username tanmay8898 --password Tanmay@8898'
        }
      }
    }
  }
}
