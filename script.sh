#!/bin/bash

set -e

echo "Install the Dependencies"
npm install

echo "Installing the Angular CLI"
npm i @angular/cli

echo "Build the file"
npm run build

#echo "Sonar-Scanner"
#sonar-scanner

echo "Deploy it to Nexus"

# Define the zip file name with timestamp
zip_file="./dist/app_$(date +%Y-%m-%d_%H-%M-%S).zip"

# Check if any zip file exists and remove it
if ls ./dist/*.zip 1> /dev/null 2>&1; then
    echo "Zip file found. Removing the zip file."
    rm -rf ./dist/*.zip
else
    echo "No zip file found. Proceeding to create a new zip file."
fi

# Create a new zip file with the timestamp
zip -r "$zip_file" ./dist/expense_management_app

# Upload the zip file to Nexus
curl -v -u admin:admin123 --upload-file "$zip_file" "http://localhost:8081/repository/npm-boom/Angular/Expense_Data/V1.0/$(basename $zip_file)"


