pipeline{
    agent {label 'dev2'}
    
    stages{
        
        stage("Cloning"){
            steps{
                git 'https://github.com/AYuS-V/Lots_of_Money.git'
            }
        }
        
        stage("Deleting Build"){
            steps{
                sh '''
                    rm -rf /node_modules
                    rm -rf ./dist/*.zip
                    rm -rf app_build
                '''
            }
        }
        
        stage("NPm install"){
            steps{
                sh 'npm install'
            }
        }
        
        
        stage("Build"){
            steps{
                sh 'npm run build'
            }
        }
        
        
        stage("Ziping the build"){
            steps{
                sh '''
                    npm install archiver
                    node /home/shaikh-aftab/Desktop/jenkins/workspace/angular_pipeline/scripts/zipBuild.js
                    '''
            }
        }
        
        stage("uploading to nexus"){
            steps{
                sh '''
                    FILE=$(ls -t ./dist/*.zip) 
                    curl -v -u admin:admin --upload-file $FILE "http://localhost:8081/repository/npm_repo_2/expense_tracker/1.0.0/$(basename "$FILE")"
                '''
            }
        }
        
        stage("Downloading latest build from nexus"){
            steps{
                sh '''
                    rm -rf lots_of_money.zip
                    curl -L -o lots_of_money.zip 'http://localhost:8081/service/rest/v1/search/assets/download?sort=name&direction=desc&repository=npm_repo_2&format=raw&group=%2Fexpense_tracker%2F1.0.0'
                '''
            }
        }
        
        stage("Uploding to Production"){
            steps{
                sh '''
                    unzip lots_of_money.zip -d app_build
                    ls app_build
                    ansible-playbook deployscript.yml
                '''
            }
        }
    }
}