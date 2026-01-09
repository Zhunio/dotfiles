syncsecrets() {
  export VDIRSINCER_USERNAME=$(op read "op://Development/vdirsyncer/username")
  export VDIRSINCER_PASSWORD=$(op read "op://Development/vdirsyncer/password")
}
