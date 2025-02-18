pipeline {
    agent any

    stages {
        stage('Preparar Workspace') {
            steps {
                script {
                    deleteDir() // Limpia el workspace antes de empezar
                }
            }
        }

        stage('Clonar Repositorio') {
            steps {
                checkout scm
            }
        }

        stage('Construir Imagen Docker') {
            steps {
                script {
                    sh 'docker build -t us-central1-docker.pkg.dev/primer-proyecto-450603/mi-repo-nginx/nginx-hola-mundo:latest .'
                }
            }
        }

        stage('Subir Imagen a Artifact Registry') {
            steps {
                script {
                    sh 'docker push us-central1-docker.pkg.dev/primer-proyecto-450603/mi-repo-nginx/nginx-hola-mundo:latest'
                }
            }
        }

        stage('Desplegar en Kubernetes') {
            steps {
                script {
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
    }
}

