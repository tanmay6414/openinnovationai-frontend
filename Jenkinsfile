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
    stage('Testing Application') {
      parallel {
        stage('Conpliance Check') {
          steps {
              sh 'echo "helm conftest charts/frontend -p policies"'
           }
        }
        stage('Unit Test') {
          steps {
              sh 'echo "yarn test"'
           }
        }
      }
    }
    stage('Docker Build and Docker Push') {
      steps {
        container('docker-test') {
          // SHORT_COMMIT=sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
          sh 'docker build -t demo.goharbor.io/openinnovationai/frontend:ci .'
          sh 'docker push demo.goharbor.io/openinnovationai/frontend:ci'
          // script {
            // if (env.BRANCH_NAME == 'master') {
                // sh 'docker tag demo.goharbor.io/openinnovationai/frontend:ci demo.goharbor.io/openinnovationai/frontend:master-$SHORT_COMMIT'
                // sh 'docker push demo.goharbor.io/openinnovationai/frontend:master-$SHORT_COMMIT'
            // } 
            // if (env.BRANCH_NAME == 'release') {
                // sh 'docker tag demo.goharbor.io/openinnovationai/frontend:ci demo.goharbor.io/openinnovationai/frontend:release-$SHORT_COMMIT'
                // sh 'docker push demo.goharbor.io/openinnovationai/frontend:release-$SHORT_COMMIT'
            // }
            
          } 
        }
      }
    }
  }
}

