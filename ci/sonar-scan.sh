#!/bin/bash
echo "🚀 Starting automated SonarQube analysis..."

SONAR_SCANNER_HOME="/c/sonar-scanner-7.3.0.5189-windows-x64"
export PATH="$SONAR_SCANNER_HOME/bin:$PATH"

# Get the current Git branch
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
echo "📂 Current branch: $BRANCH_NAME"

SONAR_TOKEN="sqp_52d3c5d3163c7d48ac50cb554a461e2e26a92384"
SONAR_URL="http://localhost:9000"
PROJECT_KEY="PORTAIL-CLIENTS"

# Run SonarScanner with branch analysis
"$SONAR_SCANNER_HOME/bin/sonar-scanner.bat" \
  -D"sonar.projectKey=$PROJECT_KEY" \
  -D"sonar.projectName=Portail Clients DevWeb" \
  -D"sonar.sources=." \
  -D"sonar.host.url=$SONAR_URL" \
  -D"sonar.login=$SONAR_TOKEN" \
  -D"sonar.sourceEncoding=UTF-8" \
  -D"sonar.branch.name=$BRANCH_NAME"
