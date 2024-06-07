pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    echo 'Building...'
                    // Add build steps here
                    // Example: sh 'make'
                    sh 'curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash'
                    sh 'helm version'
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    echo 'Testing...'
                    // Add test steps here
                    // Example: sh 'make test'
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Pipeline finished'
                // Add any cleanup steps here
            }
        }
    }
}
