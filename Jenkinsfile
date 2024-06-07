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
          - name: docker-dind
            image: docker:20-dind
            command:
            - cat
            tty: true
            securityContext:
              privileged: true
            env:
            - name: DOCKER_TLS_CERTDIR
              value: ''
            - name: DOCKER_HOST
              value: tcp://localhost:2375
          volumes:
          - name: docker-graph-storage
            emptyDir: {}
       
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
    stage('Artifact CI') {
      parallel {
        stage('Docker tag and push ci artifact') {
          steps {
              // SHORT_COMMIT=sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
              sh 'echo "docker build demo.goharbor.io/openinnovationai/frontend:ci-hfnvjfu ."'
              sh 'echo "docker push demo.goharbor.io/openinnovationai/frontend:ci-hfnvjfu"'
              sh 'echo "In this step we are building and pushing artifact with out ci tag"'
            
          }
        }
        stage('Package and publish helm CI') {
          steps {
              sh 'echo "Here we update the helm values file with above updated sha, packege it and publish it to harbor repo"'
           }
        }
      }
    }

    stage('Deploy sample app to k8s') {
      steps {
        container('helm') {
          sh 'echo "helm upgrade -i oci://demo.goharbor.io/openinnovationai/frontend --version 0.1.0-ci-hfnvjfu"'
        }
      }
    }
    stage('Integration Test') {
      steps {
          sh 'echo "some integration test"'
      }
    }
    stage('Sonar Test') {
      steps {
          sh 'echo "some sonar test"'
      }
    }
    stage('Final artifact publishing if everything works') {
      steps {
        sh 'echo "docker pull demo.goharbor.io/openinnovationai/frontend:ci-hfnvjfu"'
        sh 'echo "docker tag demo.goharbor.io/openinnovationai/frontend:ci-hfnvjfu demo.goharbor.io/openinnovationai/frontend:master-hfnvjfu"'
        sh 'echo "docker push demo.goharbor.io/openinnovationai/frontend:master-hfnvjfu"'
        sh 'echo "Here we update the helm values file with above updated sha, packege it and publish it to harbor repo"'
            
      }
    }
    stage('Cleanup') {
      steps {
        sh 'echo "Cleanup all the resources"'
      }
    }
    stage('Itest') {
      steps {
        container('docker-dind') {
          sh 'docker build -t test/test .'
        }
      }
    }
    
  }
}

