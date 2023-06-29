pipeline {
    agent any
    stages {
        stage('Preparing') {
            steps {
                sh 'echo Preparing'
            }
        }
        stage('Git Pulling') {
            steps {
                git branch: 'main', url: 'https://github.com/seeit99/JupyterPOC.git'
                sh 'ls'
            }
        }
        stage('Init') {
            steps {
                echo "Enter File Name ${params.File_Name}"
                echo "Pipeline Name ${params.Pipeline}"
                withAWS(credentials: 'AWS_Creds', region: 'us-east-1') {
                //sh 'terraform -chdir=/var/lib/jenkins/jobs/${Pipeline}/workspace/Jupiter-pipeline/${File_Name}/ init --lock=false'
                //sh 'Test 1 OK'
                }
            }
        }
        stage('Code Analysis') {
            when {
                expression { params.Terraform_Action != 'destroy'}
            }
            steps {
                sh 'pip3 install checkov'
                // sh 'checkov -d Non-Modularized/${File_Name}/ --compact --quiet'
            }
        }
        stage('Action') {
            steps {
                echo "${params.Terraform_Action}"
                withAWS(credentials: 'AWS_Creds', region: 'us-east-1') {
                sh 'terraform get -update' 
                    script {    
                        if (params.Terraform_Action == 'plan') {
                            sh 'terraform -chdir=JupyterPOC/${File_Name}/ plan --lock=false'
                        }   else if (params.Terraform_Action == 'apply') {
                            sh 'terraform -chdir=JupyterPOC/${File_Name}/ apply --lock=false -auto-approve'
                        }   else if (params.Terraform_Action == 'destroy') {
                            sh 'terraform -chdir=JupyterPOC/${File_Name}/ destroy --lock=false -auto-approve'
                        } else {
                            error "Invalid value for Terraform_Action: ${params.Terraform_Action}"
                        }
                    }
                }
                sh 'rm -rf /var/lib/jenkins/jobs/Terraform-Deployment/workspace/env.properties'
            }
        }
    }
}
