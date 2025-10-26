pipeline {
  agent {
      dockerfile true
    }

  environment {
    IMAGENAME = 'cloud-orchestration/aiorch'   // image adını burada ver
  }

  stages {
    stage('Compile') {
      steps {
        // Quoting düzeltildi
        sh 'echo "Compiling the project..."'

        // Wrapper varsa bunu kullan; yoksa yukarıdaki GRADLE_HOME yolunu aç
        script {
          def status = sh(script: 'gradle build', returnStatus: true)
          if (status != 0) {
            error 'Compile işlemi başarısız oldu. Build durduruluyor.'
          }
        }
      }
    }

    stage('Build image') {
      steps {
        // Env değişkeni genişlesin diye çift tırnak
        sh "docker build -t ${IMAGENAME}:ci ."
      }
    }

    stage('Run once') {
      options { timeout(time: 5, unit: 'MINUTES') }
      steps {
        // Çok satırlı komutta da çift tırnak (env genişlemesi için)
        sh """
          echo "Running aiorch-once container..."
          docker run --rm --name aiorch-once ${IMAGENAME}:ci
        """
      }
    }
  }

  post {
    always {
      // Log/temizlik için küçük bir örnek
      sh 'docker images | head -n 5 || true'
    }
  }
}
