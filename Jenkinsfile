pipeline {
  /* -------- Global -------- */
  agent { label 'docker' }          // agent must have docker cli
  options {
    skipDefaultCheckout()           // we'll handle checkout ourselves
    buildDiscarder(logRotator(daysToKeepStr: '14'))  // keep logs tidy
    timestamps()                    // nicer console logs
  }

  environment {
    REGISTRY       = 'docker.io'                   // could be ghcr.io, ECR, etc.
    IMAGE_NAME     = 'mhorlabisi/devop_app_project'         // change to your repo
    DOCKER_CREDS   = credentials('dockerhub')
  }

  /* -------- Stages -------- */
  stages {

    stage('Checkout') {
      steps {
        checkout scm
        script {
          // Generate a unique, traceable tag e.g. "feature-login-abc1234"
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

    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub',
                                          usernameVariable: 'DOCKER_USERNAME',
                                          passwordVariable: 'DOCKER_PASSWORD')]) {
          sh '''
            echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin ${REGISTRY}
            docker push ${IMAGE_NAME}:${IMAGE_TAG}
            docker logout ${REGISTRY}
          '''
        }
      }
    }

    /* ---- Optional deploy step ---- */
    stage('Deploy to Kubernetes') {
      when { branch 'main' }       // deploy only from main (adjust as needed)
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

  /* -------- Post section -------- */
  post {
    success {
      echo "✅ Build & push of ${IMAGE_NAME}:${IMAGE_TAG} successful"
    }
    always {
      cleanWs(deleteDirs: true)    // reclaim workspace
    }
  }
}
