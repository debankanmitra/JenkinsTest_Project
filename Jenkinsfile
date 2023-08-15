pipeline{
    agent any
    environment{
        FAILED_STAGE = ""
    }
    stages{
        stage("Fetching code from Git"){
            steps{
                script {
                    FAILED_STAGE = "Fetching code from Git"
                }
                echo "Pulling code from git repository"
            }
        }
        stage("Build"){
            steps{
                script {
                    FAILED_STAGE = "Build"
                }
                ech "No need to build the code as we are building image in Docker Build"
            }
        }
        stage("Test"){
            parallel{
                stage("Unit Testing"){
                    steps{
                        script {
                            FAILED_STAGE = "Unit Testing"
                        }
                        echo "====++++executing Unit Testing++++===="
                        
                    }
                }
                stage("Integration Testing"){
                    steps{
                        script {
                            FAILED_STAGE = "Integration Testing"
                        }
                         echo "====++++executing Integration Testing++++===="
                        
                    }
                }
            }
        }
        stage("SONARQUBE Code Quality Scan"){
            steps{
                script {
                        FAILED_STAGE = "SONARQUBE CQ"
                    }
                echo "Sonarqube code Quality scan starts"
            }
        }
        stage("SNYK Vulnerablity Scan"){
            steps{
                script {
                        FAILED_STAGE = "SNYK Vulnerablity Scan"
                    }
                echo "Snyk Vulnerablity Scan Starts"
            }
        }
        stage("Docker Build"){
            steps{
                script {
                        FAILED_STAGE = "Docker Build"
                    }
                echo "Building Docker Image"
            }
        }
        stage("Push to AWS ECR"){
            input {
                message "SHould we continue?"
                ok "Yes please"
            }
            steps{
                script {
                        FAILED_STAGE = "Push to AWS ECR"
                    }
                echo "Push to AWS ECR"
            }
        }
    }
    post{
        always{
            cleanWs() // Clean workspace after the build is complete
        }
        success{
            echo "Successfully Deployed and Pipeline successfully executed without any error"
            mail to: 'imnaftali@gmail.com',
             subject: "Success",
             body: "Pipeline Executed successfully"
        }
        failure{
            echo "--pipeline execution failed--"
            mail to: 'imnaftali@gmail.com',
             subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
             body: "Something is wrong with ${JOB_NAME} on stage ${FAILED_STAGE} Initiated By user ${BUILD_USER}"
        }
    }
}