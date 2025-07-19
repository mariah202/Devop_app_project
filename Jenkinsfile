pipeline {
  agent any

  options {
    skipDefaultCheckout()
    buildDiscarder(logRotator(daysToKeepStr: '14'))
    timestamps()
  }

  environment {
    REGISTRY     = 'docker.io'
    IMAGE_NAME   = 'mhorlabisi/devop_app_project'
    DOCKER_CREDS = credentials('dockerhub')
    KUBECONFIG   = "$HOME/.kube/config"
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
        script {
          def gitCommit = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
          def branchName = env.BRANCH_NAME ?: sh(script: "git rev-parse --abbrev-ref HEAD", returnStdout: true).trim()
          env.IMAGE_TAG = "${branchName}-${gitCommit}"
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        sh """
          docker build \\
            --label build.branch=${BRANCH_NAME} \\
            --label build.sha=${IMAGE_TAG} \\
            -t ${IMAGE_NAME}:${IMAGE_TAG} .
        """
      }
    }

    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'dockerhub',
          usernameVariable: 'DOCKER_USERNAME',
          passwordVariable: 'DOCKER_PASSWORD'
        )]) {
          sh '''
            echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin ${REGISTRY} || exit 1
            docker push ${IMAGE_NAME}:${IMAGE_TAG}
            docker logout ${REGISTRY}
          '''
        }
      }
    }

    stage('Apply Kubernetes Manifests') {
      when { branch 'main' }
      steps {
        sh '''
          kubectl apply -f k8s/
        '''
      }
    }

    stage('Deploy to Kubernetes') {
      when { branch 'main' }
      steps {
        sh '''
          kubectl set image deployment/devop-app-project devop-app-project=${IMAGE_NAME}:${IMAGE_TAG} --record
        '''
      }
    }

    stage('Check Pods') {
      when { branch 'main' }
      steps {
        sh 'kubectl get pods -o wide'
      }
    }
  }

  post {
    success {
      echo "✅ Build and deployment of ${IMAGE_NAME}:${IMAGE_TAG} completed successfully."
    }
    failure {
      echo "❌ Build or deployment failed. Please check the logs."
    }
    always {
      cleanWs(deleteDirs: true)
    }
  }
}
