#!/bin/bash
echo "🚀 Starting automated SonarQube analysis..."

SONAR_SCANNER_HOME="/c/sonar-scanner-7.3.0.5189-windows-x64"
export PATH="$SONAR_SCANNER_HOME/bin:$PATH"

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
echo "📂 Current branch: $BRANCH_NAME"

SONAR_TOKEN="sqp_52d3c5d3163c7d48ac50cb554a461e2e26a92384"
SONAR_URL="http://localhost:9000"
PROJECT_KEY="PORTAIL-CLIENTS"

# Run SonarScanner
"$SONAR_SCANNER_HOME/bin/sonar-scanner.bat" \
  -D"sonar.projectKey=$PROJECT_KEY" \
  -D"sonar.projectName=Portail Clients DevWeb" \
  -D"sonar.sources=." \
  -D"sonar.host.url=$SONAR_URL" \
  -D"sonar.login=$SONAR_TOKEN" \
  -D"sonar.sourceEncoding=UTF-8"

echo "📊 Checking Quality Gate status..."

# Get latest analysis ID for the branch (simple string parsing)
ANALYSIS_ID=$(curl -s -u $SONAR_TOKEN: "$SONAR_URL/api/project_analyses/search?project=$PROJECT_KEY&branch=$BRANCH_NAME" | grep -oP '"key":"\K[^"]+' | head -1)

# Get Quality Gate status
QG_STATUS=$(curl -s -u $SONAR_TOKEN: "$SONAR_URL/api/qualitygates/project_status?analysisId=$ANALYSIS_ID" | grep -oP '"status":"\K[^"]+')

echo "🔍 Quality Gate status: $QG_STATUS"

if [ "$QG_STATUS" != "OK" ]; then
    echo "❌ Quality Gate failed! Blocking merge."
    exit 1
fi

echo "✅ Quality Gate passed. SonarQube scan finished for branch: $BRANCH_NAME"
