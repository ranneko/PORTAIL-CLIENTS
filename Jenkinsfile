pipeline {
    agent any

    stages {
        // Stage 1: Checkout code
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ranneko/PORTAIL-CLIENTS.git'
            }
        }

        // Stage 2: Run SonarQube scan
        stage('SonarQube Analysis') {
            steps {
                // Run your Windows batch script for SonarScanner
                bat 'ci\\sonar-scan.sh'
            }
        }

        // Stage 3: Check Quality Gate
        stage('Check Quality Gate') {
            steps {
                script {
                    // Wait a few seconds to ensure SonarQube finished processing
                    sleep 10

                    // Call SonarQube API to get Quality Gate status
                    def status = bat(
                        script: 'curl -s -u sqp_52d3c5d3163c7d48ac50cb554a461e2e26a92384: http://localhost:9000/api/qualitygates/project_status?projectKey=PORTAIL-CLIENTS',
                        returnStdout: true
                    ).trim()

                    echo "Quality Gate Status: ${status}"

                    // Fail build if Quality Gate is not OK
                    if (!status.contains('"status":"OK"')) {
                        error("❌ Quality Gate failed! Build stopped.")
                    } else {
                        echo "✅ Quality Gate passed!"
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished. Check SonarQube dashboard for branch-specific results."
        }
    }
}
