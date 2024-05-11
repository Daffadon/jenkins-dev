node {
  stage('Checkout') {
    // Checkout code from GitHub repository
    git 'https://github.com/daffadon/jenkins-dev'
  }

  stage('Build') {
    // Perform build steps here
    // ...
    dir('jenkins-dev'){
      sh 'ls -al'
    }
  }

  stage('Test') {
    // Perform testing steps here
    // ...
  }
}