pipeline {
  agent any  // Use any available agent

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
          env.IMAGE_TAG = "${env.BRANCH_NAME}-${env.GIT_COMMIT.take(7)}"
        }
      }
    }

    stage('Build Docker image') {
      steps {
        sh """
          docker build \\
            --label build.branch=${BRANCH_NAME} \\
            --label build.sha=${GIT_COMMIT} \\
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

    stage('Deploy to Kubernetes') {
      when {
        branch 'main'
      }
      steps {
        withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_FILE')]) {
          sh '''
            export KUBECONFIG=$KUBECONFIG_FILE
            kubectl set image deployment/myapp myapp=${IMAGE_NAME}:${IMAGE_TAG} --record
          '''
        }
      }
    }
  }

  post {
    success {
      echo "✅ Build & push of ${IMAGE_NAME}:${IMAGE_TAG} successful"
    }
    always {
      cleanWs(deleteDirs: true)
    }
  }
}
