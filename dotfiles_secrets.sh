init_op_secrets() {
  export MAIL_PERSONAL_USER="$(op read 'op://Development/mail.personal/username')"
  export MAIL_PERSONAL_PASS="$(op read 'op://Development/mail.personal/password')"

  export MAIL_WORK_USER="$(op read 'op://Development/mail.work/username')"
  export MAIL_WORK_OAUTH_TOKEN="$(oauth2l fetch --credentials ~/.oauth/mail.work.json --scope https://mail.google.com)"
}

mail() {
  # export OP_SERVICE_ACCOUNT_TOKEN somewhere before loading dotfiles
  init_op_service_account_token
  init_op_secrets
  aerc
}
