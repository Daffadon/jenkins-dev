node {
  stage('Checkout') {
    // Checkout code from GitHub repository
    git 'https://github.com/daffadon/jenkins-dev'
  }

  stage('Build') {
    // Perform build steps here
    // ...
    dir('jenkins-dev'){
      sh 'npm ci'
    }
  }

  stage('Test') {
    // Perform testing steps here
    // ...
  }
}