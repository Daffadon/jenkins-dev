node {
  stage('Checkout') {
    // Checkout code from GitHub repository
    sh 'git clone https://github.com/daffadon/jenkins-dev'
  }

  stage('Build') {
    // Perform build steps here
    // ...
    dir('jenkins-dev'){
      sh 'ls -al'
      sh 'cat Jenkinsfile'
    }
  }

  stage('Test') {
    // Perform testing steps here
    // ...
  }
}