pipeline {
    agent any
    
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/vinayhegde105/cloud_build.git'
            }
        }

        stage('SCM Migration') {
            steps {
                script {
            sh '''
                #!/bin/bash
                export AWS_ACCESS_KEY_ID="" 
                export AWS_SECRET_ACCESS_KEY="" 
                export AWS_DEFAULT_REGION="us-east-1"
                terraform init 
                terraform plan -var-file="configs/tek/terraform.tfvars"
            '''
    }
            }
        }
    }
}
