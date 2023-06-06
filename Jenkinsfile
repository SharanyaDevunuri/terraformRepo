pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    
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
                        terraform init 
                        terraform validate
                        terraform plan -var-file="configs/Test20/terraform.tfvars"
                        terraform apply --auto-approve -var-file="configs/Test20/terraform.tfvars"
                    '''
    }
            }
        }        
        
    }
}
