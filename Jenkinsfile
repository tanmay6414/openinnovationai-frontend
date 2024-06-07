pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    echo 'Building...'
                    // Add build steps here
                    // Example: sh 'make'
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
