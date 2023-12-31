#!/bin/bash

# Application Insights Connection String
connectionString=$(az monitor app-insights component show --app 'appi-myjavaapp' -g 'rg-myjavaapp' --query 'connectionString' -o tsv)

# Java Agent
appiver="3.4.17"
appiOutput="applicationinsights-agent-$appiver.jar"
appiUri="https://github.com/microsoft/ApplicationInsights-Java/releases/download/$appiver/applicationinsights-agent-$appiver.jar"

rm -rf $appiOutput
rm -rf "applicationinsights.log"

curl -L -o $appiOutput $appiUri

# Exports
export APPLICATIONINSIGHTS_CONNECTION_STRING=$connectionString
export MAVEN_OPTS="-javaagent:applicationinsights-agent-$appiver.jar"
