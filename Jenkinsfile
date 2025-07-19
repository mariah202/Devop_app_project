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

    stage('Build Docker image') {
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
            echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin ${REGISTRY}
            docker push ${IMAGE_NAME}:${IMAGE_TAG}
            docker logout ${REGISTRY}
          '''
        }
      }
    }

    stage('Apply K8s Manifests') {
      when {
        branch "main"
      }
      steps {
        sh '''
          export KUBECONFIG=$HOME/.kube/config
          kubectl apply --validate=false -f k8s/
        '''
      }
    }

    stage('Deploy to Kubernetes') {
      when {
        branch "main"
      }
      steps {
        sh '''
          export KUBECONFIG=$HOME/.kube/config
          kubectl set image deployment/devop-app-project devop-app-project=${IMAGE_NAME}:${IMAGE_TAG} --record
        '''
      }
    }

    stage('Check Pods') {
      when {
        branch "main"
      }
      steps {
        sh '''
          export KUBECONFIG=$HOME/.kube/config
          kubectl get pods -o wide
        '''
      }
    }
  }

  post {
    success {
      echo "✅ Build & push of ${IMAGE_NAME}:${IMAGE_TAG} successful"
    }
    failure {
      echo "❌ Build or deployment failed. Please check the logs."
    }
    always {
      cleanWs(deleteDirs: true)
    }
  }
}
