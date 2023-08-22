pipeline {
    agent any

    // tools are like an runtime environment just like go ,and above it we install dependencies to run our application
    tools {
        nodejs "20.5.1"
        //dockerTool 'docker-latest'
        }
    environment {
        FAILED_STAGE = ""
    }
    stages {
        stage("Fetching code from Git") {
            steps {
                
                script {
                    FAILED_STAGE = "Fetching code from Git"
                }
                
                echo "Pulling code from git repository"
                checkout scmGit(branches: [[name: '*/main']],extensions: [],userRemoteConfigs: [[url:"https://github.com/debankanmitra/JenkinsTest_Project.git"]])
                sh 'npm version'
                sh 'pwd'  
                sh 'ls'        
            }
        }
        stage("Build") {
            steps {
                script {
                    FAILED_STAGE = "Build"
                }
                echo "No need to build the code as we are building image in Docker Build"
                // The specified tools are available here
                sh 'npm install'
                sh 'npm run build'
                sh 'ls'
            }
        }
        stage("Test") {
            parallel {
                stage("Unit Testing") {
                    steps {
                        script {
                            FAILED_STAGE = "Unit Testing"
                        }
                        echo "Executing Unit Testing"
                        //sh 'npm run test'

                    }
                }
                stage("Integration Testing") {
                    steps {
                        script {
                            FAILED_STAGE = "Integration Testing"
                        }
                        echo "Executing Integration Testing"
                        //sh 'npm run test'    

                    }
                }
            }
        }
        stage("SONARQUBE Code Quality Scan") {
            //Run this command to get the container IP address.
            //-$ docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' sonarqube

            environment {
                scannerHome = tool 'Sonarscanner_3.2.0.1227'
            }
            steps {
                script {
                    FAILED_STAGE = "SONARQUBE CQ"
                }
                echo "Sonarqube code Quality scan starts"
                withSonarQubeEnv('sonarserver'){
                    sh '''
                ${scannerHome}/bin/sonar-scanner \
                -D sonar.projectKey=reactinitial \
                -D sonar.projectName=reactinitial \
                -D sonar.projectVersion=1.0 \
                -D sonar.sources=. \
                -D sonar.exclusions=src/**/test/**/*  
                '''
                }
            }
        }
        stage("SNYK Vulnerablity Scan") {
            steps {
                script {
                    FAILED_STAGE = "SNYK Vulnerablity Scan"
                }
                echo "Snyk Vulnerablity Scan Starts"
                snykSecurity(
                    organisation: 'debankanmitra', 
                    //projectName: 'react_jenkins', 
                    snykInstallation: 'snyk_latest', 
                    snykTokenId: 'snyk', 
                    //targetFile: 'package.json'
                )
            }
        }
        stage("Docker Build") {
            steps {
                script {
                    FAILED_STAGE = "Docker Build"
                }
                echo "Building Docker Image"
                script {
                    sh 'docker --version'
                    sh 'docker build -t reactapp .'
                }
            }
        }
        stage("Push to AWS ECR") {
            input {
                message "Should we continue?"
                ok "Yes please"
            }
            steps {
                script {
                    FAILED_STAGE = "Push to AWS ECR"
                }
                echo "Push to AWS ECR"
                script {
                    withCredentials([aws(credentialsId: 'aws-credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                sh '''
                    aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/j5w4o3h9
                    docker tag reactapp:latest public.ecr.aws/j5w4o3h9/reactapp:latest
                    docker push public.ecr.aws/j5w4o3h9/reactapp:latest
                '''
            }
                }
            }
        }
    }
    post {
        always {
            cleanWs() // Clean workspace after the build is complete
        }
        success {
            echo "Successfully Deployed and Pipeline successfully executed without any error"
            mail to: 'imnaftali@gmail.com',
                subject: "Success",
                body: "Pipeline Executed successfully"
        }
        failure {
            echo "--pipeline execution failed--"
            mail to: 'imnaftali@gmail.com',
                subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
                body: "Something is wrong with ${JOB_NAME} on stage ${FAILED_STAGE} ."
        }
    }
}