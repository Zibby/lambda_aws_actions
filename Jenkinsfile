pipeline {
  agent {
    docker {
      image 'ruby:2.5'
    }

  }
  stages {
    stage('git pull') {
      steps {
        sh 'bundle install --with development --path ./.gem'
        sh 'HOME=./ bundle exec rubocop'
        cleanWs(cleanWhenAborted: true, cleanWhenFailure: true, cleanWhenNotBuilt: true, cleanWhenSuccess: true, cleanWhenUnstable: true, cleanupMatrixParent: true, deleteDirs: true)
      }
    }
  }
}
