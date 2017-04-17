node('linux && amd64 && docker') {
  docker.image('icedream/gmad:latest').inside {
    ansiColor('xterm') {
      git checkout
      sh 'gmad create -folder . -out icedream-tauntmenu.gma'
      archive '*.gma'
    }
  }
}
