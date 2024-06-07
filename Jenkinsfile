node {
    // Define the Kubernetes pod template
    podTemplate(label: 'my-kubernetes-agent', containers: [
        containerTemplate(name: 'jnlp', image: 'jenkins/inbound-agent:4.6-1-alpine', ttyEnabled: true)
    ]) {

        // Stage to echo "Hello"
        stage('Hello') {
            // Execute the stage in the container
            container('jnlp') {
                // Echo "Hello"
                sh 'echo "Hello"'
            }
        }
    }
}
