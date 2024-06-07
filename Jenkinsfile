node {
    def dockerImage
    def helmChartInitialized = false

    stage('Checkout') {
        checkout scm
    }

    stage('Initialize Helm Chart') {
        script {
            helmChartInitialized = sh(script: 'helm init', returnStatus: true) == 0
            if (!helmChartInitialized) {
                error 'Helm initialization failed'
            }
        }
    }

    parallel(
        'Unit Tests': {
            stage('Unit Tests') {
                script {
                    echo 'Running unit tests...'
                    // Add unit test commands here
                    // Example: sh 'make test'
                }
            }
        },
        'Docker Build': {
            stage('Docker Build') {
                script {
                    echo 'Building Docker image...'
                    dockerImage = docker.build('my-docker-image:latest')
                }
            }
        },
        'Compliance Check': {
            stage('Compliance Check') {
                script {
                    echo 'Running compliance checks...'
                    // Add compliance check commands here
                    // Example: sh 'make compliance-check'
                }
            }
        }
    )

    stage('Deploy') {
        when {
            expression { helmChartInitialized }
        }
        steps {
            script {
                echo 'Deploying application...'
                // Add deployment commands here
                // Example: sh 'helm upgrade --install my-app ./helm-chart'
            }
        }
    }

    stage('Publish') {
        steps {
            script {
                echo 'Publishing results...'
                // Add commands to publish results here
                // Example: archiveArtifacts artifacts: 'results/**'
            }
        }
    }

    stage('Clean Up') {
        steps {
            script {
                echo 'Cleaning up...'
                // Add cleanup commands here
                // Example: sh 'helm delete --purge my-app'
                // Clean up Docker image
                if (dockerImage) {
                    dockerImage.remove(true)
                }
            }
        }
    }
}
