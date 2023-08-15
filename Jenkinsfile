pipeline{
    agent any
    stages{
        stage("Fetching code from Git"){
            environment {
                FAILED_STAGE = 'Fetching code from Git'
            }
            steps{
                echo "Pulling code from git repository"
            }
        }
        stage("Build"){
            environment {
                FAILED_STAGE = 'Build'
            }
            steps{
                ech "No need to build the code as we are building image in Docker Build"
            }
        }
        stage("Test"){
            environment {
                FAILED_STAGE = 'Test'
            }
            parallel{
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
            environment {
                FAILED_STAGE = 'SONARQUBE Code Quality Scan'
            }
            steps{
                echo "Sonarqube code Quality scan starts"
            }
        }
        stage("SNYK Vulnerablity Scan"){
            environment {
                FAILED_STAGE = 'SNYK Vulnerablity Scan'
            }
            steps{
                echo "Snyk Vulnerablity Scan Starts"
            }
        }
        stage("Docker Build"){
            environment {
                FAILED_STAGE = 'Docker Build'
            }
            steps{
                echo "Building Docker Image"
            }
        }
        stage("Push to AWS ECR"){
            environment {
                FAILED_STAGE = 'Push to AWS ECR'
            }
            input {
                message "Should we continue?"
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
             body: "Something is wrong with ${JOB_NAME} on stage ${FAILED_STAGE}"
        }
    }
}