pipeline {
    agent {
      dockerfile {
        filename 'Dockerfile'
        args '-u docker'
      }
    }
    options {
      timeout(time: 10, unit: 'MINUTES')
    }

    stages {
        stage('Setup node environment') {
          steps {
            git branch: 'main', url: 'https://github.com/ankurk91/google-chat-electron.git'
            sh '''
              hostname
              whoami
              echo 'export NVM_DIR="$HOME/.nvm"' > ~/.source_nvm.sh
              echo '[ -s "$NVM_DIR/nvm.sh" ] && \\. "$NVM_DIR/nvm.sh"' >> ~/.source_nvm.sh
              echo '[ -s "$NVM_DIR/bash_completion" ] && \\. "$NVM_DIR/bash_completion"' >> ~/.source_nvm.sh
              if [ ! -d "$HOME/.nvm" ]; then
                curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
              fi
              cat ~/.source_nvm.sh
              . ~/.source_nvm.sh
              nvm install 18
              node -v
              nvm current
              npm -v
              npm install -g pnpm@^7
              pnpm install --frozen-lockfile
              pwd
              ls -ltaha
              echo $PATH
            '''
          }
        }

        stage('Pack for linux'){
          steps {
            sh '''
              cat ~/.source_nvm.sh
              . ~/.source_nvm.sh
              pwd
              ls -ltaha
              rm -rf ./.github
              npm run pack:linux
            '''
          }
        }
        stage('Create debian package'){
          steps {
            sh '''
              cat ~/.source_nvm.sh
              . ~/.source_nvm.sh
              npm run build:deb
              npm run build:deb-checksum
            '''
          }
        }
    }
}
