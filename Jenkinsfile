pipeline {
    environment {
        imagename = "cloud-orchestration/aiorch"
        BITBUCKET_CREDENTIALS = credentials('odine-bitbucket-admin')
        GRADLE_HOME = '/opt/gradle/gradle-7.6'
        PATH = "${env.PATH}:${env.GRADLE_HOME}/bin"
    }
    agent { label 'bst-jenkins-worker-01' }

    stages {
        stage('Fetch external file') {
          steps {
            script {
              def RAW_URL        = 'https://bst-bitbucket.odine.tech:8443/projects/AIORCH/repos/krakendnew/browse/krakend.json'
              def DEST_FILE_PATH = 'src/main/resources/krakend-new.json'

              sh """
                curl -fSL "${RAW_URL}" -o "${DEST_FILE_PATH}"
              """
            }
          }
        }

        stage('Compile') {
            steps {
                script {
                    def status = sh(script: "gradle build", returnStatus: true)
                    if (status != 0) {
                        error "Compile işlemi başarısız oldu. Build durduruluyor."
                    }
                }
            }
        }

        stage('Build image') {
          steps {
            sh 'docker build -t ${imagename}:ci .'
          }
        }

        stage('Run once') {
          options { timeout(time: 5, unit: 'MINUTES') }
          steps {
            sh '''
              # Pass env/files as needed with -e / -v
              docker run --rm --name aiorch-once ${imagename}:ci
            '''
          }
        }


    }
}
