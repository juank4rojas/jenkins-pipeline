pipeline {
    agent any

    stages {
        stage('Clonar Repositorio') {
            steps {
               git branch: 'main', url: 'https://github.com/juank4rojas/jenkins-pipeline.git'
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
