pipeline {
    agent any
    environment {
        SERVER_IP = '10.34.4.138'
        SERVER_USERNAME = 'devel'
        DOCKER_IMAGE = 'app-devel-version'
    }
    
    stages {
        
        stage('Preparing') {
            steps {
                script{
                    echo "Ready to prepare dependencies"
                    sh 'sudo apt install git'
                    
                    def directoryPath = '/var/lib/jenkins/workspace/pipe/app-folder'
                    if (dirExists(directoryPath)) {
                        echo "Directory already exists. Start deletion."
                        sh "sudo rm -rf app-folder"
                    } 
                    sh "mkdir app-folder"
                    echo "Directory created."
                    
                    echo "creating dockerization shell script file"
                    sh '''
cat > dockerization.sh << 'EOF'
sudo apt install docker.io -y
sudo apt install docker-compose -y
                    
# stop, delete, all containers and system prune
sudo docker stop $(docker ps -a -q)
sudo docker container prune -f
sudo docker system prune -a -f
                    
# check dockerfile, if not exist exit 1;
if [ -f ~/app/Dockerfile ]
then
    echo "Dockerfile is exist!"
else
    echo "Dockerfile isn't exist. aborting..."
    exit 1
fi
# check docker compose, if exist using that, if not docker run with specified tag name
#if [[ -f docker-compose.yml ]] || [[ -f docker-compose.yaml ]]; then
#    echo "docker-compose is exist. generated container based on give docker-compose file"
#    docker compose up -d
#else
#fi
#echo "Docker-compose file isn't exist. Run container based on Dockerfile"
docker build -t staging-app-img ~/app/
docker run -d -p 8090:3000 --name dev-app staging-app-img
EOF
'''
                sh "chmod +x dockerization.sh"
                }
            }
        }
        stage('Cloning'){
            steps{
                script{
                    dir("app-folder"){
                        echo "Start clone repository"
                        sh 'git clone https://github.com/Daffadon/jenkins-dev.git .'
                        echo "Github repository Cloned"
                        
                        echo "Start dependency installation"
                        sh "npm install"
                        echo "Dependencies installed"
                    }
                    sh 'mv dockerization.sh app-folder/dockerization.sh'
                }
            }
        }
        stage('Testing'){
            steps{
                script{
                    dir("app-folder"){
                        echo "ready to testing the app"
                        sh "npm run lint"
                        sh "npm run test"
                    }
                }
            }
        }
        stage('Building'){
            steps{
                script{
                    dir("app-folder"){
                        echo "Start building the app"
                        sh "npm run build"
                    }
                }
            }
        }
        stage('Deploying'){
            steps{
                withCredentials([sshUserPrivateKey(credentialsId: 'mykey', keyFileVariable: 'identity', usernameVariable: 'userName')]) {
                    script{
                        dir("app-folder"){
                            sh '''
                                ssh -i $identity ${SERVER_USERNAME}@${SERVER_IP} '[[ -d ~/app ]] && rm -rf ~/app/* || mkdir app'
                                scp -i $identity -r dockerization.sh Dockerfile docker-compose.yaml ${SERVER_USERNAME}@${SERVER_IP}:~/app
                                ssh -i $identity ${SERVER_USERNAME}@${SERVER_IP} './app/dockerization.sh'
                            '''
                        }
                    }
                }
            }
        }
    }
}

def dirExists(filePath) {
    return sh(script: "[ -d ${filePath} ]", returnStatus: true) == 0
}
