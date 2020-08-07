pipeline {
    options {
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        preserveStashes()
        disableConcurrentBuilds()
        }
    environment {
        DEPLOY = "${env.BRANCH_NAME == "master" || env.BRANCH_NAME == "develop" ? "true" : "false"}"
        NAME = "${env.BRANCH_NAME == "master" ? "prod" : "dev"}"
	APP = 'nodejsapp'
        DOMAIN = 'localhost'
        REGISTRY = 'jjjje/nodejsapp'
	HELMREPO = 'jjjje/nodejsapp'
        REGISTRY_CREDENTIAL = 'DockerHub'
	KUBE_PATH = '/root/nodejs_kubernetes_project/init/config'
	BUILD_NUMBER = 'latest'
    }
    agent {
        kubernetes {
            defaultContainer 'jnlp'
            yamlFile 'build.yaml'
        }
    }
    stages {
        stage("Docker Build") {
            when {
                branch 'develop'
            }
            steps {
                container('docker') {
                    sh "docker build -t ${REGISTRY}:${BUILD_NUMBER} ."
                }
            }
        }
	stage("Docker Publish") {
            when {
                branch 'develop'
	    }
            steps {
                container('docker') {
                    withDockerRegistry([credentialsId: "${REGISTRY_CREDENTIAL}", url: ""]) {
                        sh "docker push ${REGISTRY}:${BUILD_NUMBER}"
                    }
                }
            }
        }
        stage("Kubernetes Deploy") {
            steps {
                container('helm') {
		    sh "/usr/local/bin/helm repo update"
                    sh "/usr/local/bin/helm upgrade --install --force ${APP} ${REGISTRY} --set=image.tag=${BUILD_NUMBER} --tiller-namespace ${NAME} --kubeconfig ${KUBE_PATH} --namespace ${NAME} --set=rbac.create=false"
                }
            }
        }
        stage("Testing") {
            when {
                branch 'develop'
            }
            steps {
                container('pytest') {
                    sh "cd test;pytest"
                }
            }
        }
        stage("Docker Clean") {
            when {
                branch 'develop'
            }
            steps {
                container('docker') {
                    sh "docker rmi -f ${REGISTRY}:${BUILD_NUMBER}"
                }
            }
        }


    }
}
