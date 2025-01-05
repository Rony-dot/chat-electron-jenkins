pipeline {
    agent {
      dockerfile {
        filename 'Dockerfile'
        args '-u docker'
        reuseNode true
      }
    }

    stages {
        stage('Setup node environment') {
          steps {
            git branch: 'main', url: 'https://github.com/ankurk91/google-chat-electron.git'
            sh '''
              curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
              export NVM_DIR="$HOME/.nvm"
              [ -s "$NVM_DIR/nvm.sh" ] && \\. "$NVM_DIR/nvm.sh"
              [ -s "$NVM_DIR/bash_completion" ] && \\. "$NVM_DIR/bash_completion"
              nvm install 18
              node -v
              nvm current
              npm -v
              npm install -g pnpm@^7
              pnpm install --frozen-lockfile
              pwd
              ls -ltaha
              cat ~/.bashrc
              echo $PATH
            '''
          }
        }

        stage('Pack for linux'){
          steps {
            sh '''
              pwd
              ls -ltaha
              cat ~/.bashrc
              echo $PATH
              rm -rf ./.github
              npm run pack:linux
            '''
          }
        }
        stage('Create debian package'){
          steps {
            sh '''
              npm run build:deb
              npm run build:deb-checksum
            '''
          }
        }
    }
}
