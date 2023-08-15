pipeline{
    agent any
    environment {
        FAILED_STAGE = ""
    }
    stages{
        stage("Fetching code from Git"){
            steps{
                echo "Pulling code from git repository"
                catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                    FAILED_STAGE = 'Stage 1'
                    // Your stage 2 steps
                }
            }
        }
        stage("Build"){
            steps{
                ech "No need to build the code as we are building image in Docker Build"
                catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                    FAILED_STAGE = 'Stage 2'
                    // Your stage 2 steps
                }
            }
        }
        stage("Test"){
            parallel{
                //FAILED_STAGE = 'Stage 3'
                stage("Unit Testing"){
                    steps{
                        echo "====++++executing Unit Testing++++===="
                    }
                }
                stage("Integration Testing"){
                    steps{
                        echo "====++++executing Integration Testing++++===="
                    }
                }
            }
        }
        stage("SONARQUBE Code Quality Scan"){
            steps{
                echo "Sonarqube code Quality scan starts"
            }
        }
        stage("SNYK Vulnerablity Scan"){
            steps{
                echo "Snyk Vulnerablity Scan Starts"
            }
        }
        stage("Docker Build"){
            steps{
                echo "Building Docker Image"
            }
        }
        stage("Push to AWS ECR"){
            input {
                message "SHould we continue?"
                ok "Yes please"
            }
            steps{
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
            echo "========pipeline execution failed========"
            mail to: 'imnaftali@gmail.com',
             subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
             body: "Something is wrong with ${JOB_NAME} on stage {FAILED_STAGE}"
        }
    }
}