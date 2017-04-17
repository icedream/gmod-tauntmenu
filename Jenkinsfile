node('linux && amd64 && docker') {
  docker.image('icedream/gmad:latest').inside {
    ansiColor('xterm') {
      checkout scm
      sh 'gmad_linux create -folder . -out icedream-tauntmenu.gma'
      archive '*.gma'
    }
  }
}
