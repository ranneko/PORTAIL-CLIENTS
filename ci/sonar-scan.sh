#!/bin/bash
echo "🚀 Starting automated SonarQube analysis..."

# Set SONAR_SCANNER_HOME if not in PATH
SONAR_SCANNER_HOME="/c/sonar-scanner-7.3.0.5189-windows-x64"
export PATH="$SONAR_SCANNER_HOME/bin:$PATH"

# Run sonar-scanner
sonar-scanner \
  -D"sonar.projectKey= Test-sonar" \
  -D"sonar.sources=." \
  -D"sonar.host.url=http://localhost:9000" \
  -D"sonar.token=sqp_54a8d78de896adf517b9148a93d5254146fe54e3"

echo "✅ SonarQube scan finished!"
