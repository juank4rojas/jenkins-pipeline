pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'us-central1-docker.pkg.dev/primer-proyecto-450603/mi-repo-nginx/nginx-hola-mundo:latest'
    }
    
    stages {
        stage('Preparar Workspace') {
            steps {
                cleanWs() // Mejor práctica que deleteDir()
            }
        }
        
        stage('Clonar Repositorio') {
            steps {
                git branch: 'main',
                    credentialsId: 'git-credentials-jenkins',
                    url: 'https://github.com/juank4rojas/jenkins-pipeline.git'
            }
        }
        
        stage('Construir Imagen Docker') {
            steps {
                script {
                    try {
                        sh """
                            podman build --format docker -t ${DOCKER_IMAGE} .
                        """
                    } catch (Exception e) {
                        error "Error construyendo la imagen Docker: ${e.message}"
                    }
                }
            }
        }
        
        stage('Subir Imagen a Artifact Registry') {
            steps {
                script {
                    try {
                        sh """
                            podman push ${DOCKER_IMAGE}
                        """
                    } catch (Exception e) {
                        error "Error subiendo la imagen a Artifact Registry: ${e.message}"
                    }
                }
            }
        }
        
        stage('Desplegar en Kubernetes') {
            steps {
                script {
                    try {
                        sh '''
                            kubectl apply -f deployment.yaml
                            kubectl apply -f service.yaml
                        '''
                    } catch (Exception e) {
                        error "Error en el despliegue a Kubernetes: ${e.message}"
                    }
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline ejecutado exitosamente'
        }
        failure {
            echo 'El pipeline falló'
        }
    }
}

