pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: maven
            image: maven:alpine
            command:
            - cat
            tty: true
          - name: helm
            image: alpine/helm
            command:
            - cat
            tty: true
        '''
    }
  }
  stages {
    stage('Run maven') {
      steps {
        container('maven') {
          sh 'mvn -version'
                
        }
      }
    }
     stage('Run helm') {
      steps {
        container('helm') {
          sh 'helm version'
        }
      }
    }
  }
}
