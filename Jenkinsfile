pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'github_creds', url: 'https://github.com/seeit99/JupyterPOC'
            }
        }
        stage('Terraform init') {
            steps {
                //echo "${params.Terraform_Action}"
                withAWS(credentials: 'AWS_Creds', region: 'us-east-1') {
                //sh 'terraform get -update' 
                sh 'terraform init'}
            }
        }
        stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
        
    }
}
