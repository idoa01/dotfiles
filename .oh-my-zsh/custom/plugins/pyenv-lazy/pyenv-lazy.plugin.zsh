# Lazy load pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  PY_COMMANDS=(pyenv poetry python3 pip3 pyzr)

  load_pyenv () {
    eval "$(pyenv init -)"
    eval "$(pyenv init --path)"
    if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
  }

  # Making commands for lazy loading
  for cmd in "${PY_COMMANDS[@]}"; do
    eval "${cmd}(){ unset -f ${PY_COMMANDS}; load_pyenv; ${cmd} \$@ }"
  done
fi
