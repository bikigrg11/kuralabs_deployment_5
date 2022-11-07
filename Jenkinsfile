pipeline{
    agent any
    environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub-cred-biki')
	}
    stages {
        stage ('Build') {
            steps {
                sh '''#!/bin/bash
                python3 -m venv test3
                source test3/bin/activate
                pip install pip --upgrade
                cd app
                pip install -r requirements.txt
                export FLASK_APP=app
                flask run &
                '''
            }
        }
        stage('Test') {
            steps {
                sh '''#!/bin/bash
                source test3/bin/activate
                py.test --verbose --junit-xml test-reports/results.xml
                '''
            }
            post {
                always {
                    junit 'test-reports/results.xml'
                }
            }
        }
        
        stage ('Create'){
            agent{label 'dockerAgent'}
            steps{
                sh '''#!/bin/bash
                    sudo docker build -t url_shortener:v1 .
                '''
            }
        }
        stage ('Push'){
            agent{label 'dockerAgent'}
            steps{
                sh '''#!/bin/bash
                    echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                    docker tag url_shortener_app:v2 bikigrg/url_shortener:v1
                    docker push bikigrg/url_shortener:v1
                '''
            }
        }
        stage ('Deploy'){
            agent{label 'terraformAgent'}
            steps{
                sh '''#!/bin/bash
               
                '''
            }
        }
    }
}