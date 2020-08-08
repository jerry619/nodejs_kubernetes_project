# Hello world NodeJs application

## Requirements:
* Minikube, DockerHub account, GitHub account. 

### Instructions for setting up the environment, applying RBAC and deploying the application

```bash
* Starting the minikube with RBAC and Ingress addon.
  # minikube start --vm-driver=none --docker-env NO_PROXY=$NO_PROXY --extra-config=apiserver.Authorization.Mode=RBAC
  # minikube addons enable ingress
* Cloning the repository.
  # git clone https://github.com/jerry619/nodejs_kubernetes_project.git
* Setting up Helm, Installing the required RBAC and deploying the helm charts (nodejsapp and Jenkins).
  # cd nodejs_kubernetes_project/init
  # sh init.sh
```
NOTE: The application can be reached both via Ingress. In a real scenario Ingress is the best option for configuring multiple api endpoints. To reach via Ingress, Kindly execute the below command.
```bash
# echo "$(minikube ip) dev.minikube.local" | sudo tee -a /etc/hosts
# echo "$(minikube ip) prod.minikube.local" | sudo tee -a /etc/hosts
* Now you can call 
  Dev environment: http://dev.minikube.local
  Prod environment: http://prod.minikube.local
```
### Instructions for Setting up CI/CD using Jenkins
```bash
  a) Kindly update your DockerHub account details in the Jenkinsfile under REGISTRY variable and Upload the downloaded repo to your GitHub account.
  b) Jenkins is configured using jenkins helm chart using Jcasc. Login to the Jenkins using the credentials provided by the mail. Go to Manage Jenkins > System Configuration and correct the Jenkins URL (Without this webhook will not work) and add the system-admin -mail address.
  c) Run the below commands in minikube and notedown the outputs (Used to configure the Kubernetes cloud):
    # SECRET=$(kubectl -n devops get sa jenkins -o jsonpath='{.secrets[].name}')
    # TOKEN=$(kubectl get secrets -n devops $SECRET -o jsonpath='{.data.token}' | base64 -d)
  d) Go to the path "Manage Jenkins > Manage Credentials" and add the following credentials.
     * Kind - Username and Password (Use any scope but preferred not to use global) 
       1) Username: <Your DockerHub Username>
          Password: <Your DockerHub Password>
          Id: DockerHub
          Description: DockerHub
       2) Username: <Your GitHub Username>
          Password: <Your GitHub Password>
          Id: GitHub
          Description: GitHub
     * Kind - Secret Text
       1) Scope: Global
          Secret: <Copy the above generated token in step c here>
          Id: kubernetes
          Description: kubernetes
  e) Configure Kubernetes cloud.
      Go to "HomePage > Manage Jenkins > Manage Nodes and Clouds > Configure cloud" 
     * Under kubernetes editthe below three fields:
       Kubernetes server certificate key: <Paste the SECRET KEY value in step c>
       Kubernetes Namespace: devops
       Credentials: <From drop down select "kubernetes"(Credential created in step d)
     * Click on "Test" button to verify connection with the API server.
  f) Creating Multibranch Pipeline "nodejsapp".
     * Go to "HomePage > items > Enter the name "nodejsapp" > Select Multibanch Pipeline.
     * In General tab Display name and description as "nodejsapp".
     * Under the "Branch Sources" select, Click on "Add source" > GitHub.
     * From the drop-down "Credentials", Select the GitHub credentials created step in d.2.
     * Kindly fill your GitHub url in the HTTPS URL.
     * Under the "Scan Repository Triggers", Select the check box and paste the URL (In below format) in the "Scan by webhook". 
       http://<YOUR Hostname>:8080/github-webhook/
       Note: Be sure to add the 8080 port and that your URL ends with a slash/. Select "application/json" as Content-Type and "select send me everything".
     * Click on "save".
  h) Cofiguring Webhook in repository
     * Login to your GitHub account repo on browser > settings > Webhooks
     * You will be presented with a form. In the Payload URL used in step f.
```
### Project Structure

```bash
.
├── Dockerfile
├── Jenkinsfile
├── K8s
│   ├── helmcharts
│   │   └── nodejsapp
│   │       ├── Chart.yaml
│   │       ├── README.md
│   │       ├── charts
│   │       │   └── postgres
│   │       │       ├── Chart.yaml
│   │       │       ├── templates
│   │       │       │   ├── NOTES.txt
│   │       │       │   ├── _helpers.tpl
│   │       │       │   ├── deployment.yaml
│   │       │       │   ├── persistentvolume.yml
│   │       │       │   ├── secrets.yaml
│   │       │       │   ├── service.yaml
│   │       │       │   └── tests
│   │       │       │       └── test-connection.yaml
│   │       │       └── values.yaml
│   │       ├── requirements.yaml
│   │       ├── templates
│   │       │   ├── NOTES.txt
│   │       │   ├── _helpers.tpl
│   │       │   ├── deployment.yaml
│   │       │   ├── ingress.yaml
│   │       │   ├── service.yaml
│   │       │   └── tests
│   │       │       └── test-connection.yaml
│   │       └── values.yaml
│   └── manifests
│       ├── clusterrole.yaml
│       ├── clusterrolebinding.yaml
│       ├── namespaces.yaml
│       ├── rolebindings.yaml
│       ├── roles.yaml
│       └── sa.yaml
├── README.md
├── build.yaml
├── init
│   ├── init.sh
│   └── kubeconfig.sh
├── requirements.txt
├── src
│   ├── config.py
│   ├── datacheck.py
│   ├── package.json
│   ├── script.py
│   └── server.js
└── test
    ├── config.py
    └── test.py
```
### Namespaces
* prod
* devops
* dev

NOTE: Each Namepsace has it's own tiller and strict RBAC rules.

### Database
Application uses PostgreSQL Database.

#### Schema and Datatype:
* name - String   
* data - String

### NOTES
1) Since production and Development is in the same environment. Strict RBAC is implemented and the RBAC files are available under K8s/manifests. Taken out any creation of RBAC from helm charts, So that we can have strict security in place.
2) Application and Database is run as deployment. Eventhough I prefer database to run outside of the cluster or atleast as statefulset. But since we are running as pod in minikube and has to use hostpath. I chose deployment.
3) CI/CD is implemented using Multibranch Pipeline. We even can integrate JaCoCo code coverage, Sonar code quality Anlysis and many other things which is not implemented in this test.
