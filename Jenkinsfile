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
            checkout([
                $class                           : 'GitSCM',
                branches                         : [[name: "*/master"]],
                extensions                       : [],
                userRemoteConfigs                : [
                    [url: 'git@github.com:tanmay6414/openinnovationai-frontend.git']
                ]
            ])
                
        }
      }
    }
     stage('Run helm') {
      steps {
        container('maven') {
          sh 'helm version'
        }
      }
    }
  }
}