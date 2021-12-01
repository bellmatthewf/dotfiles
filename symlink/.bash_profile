echo 'Terminal of MattyB'

alias grmain="git reset --hard origin/main"
alias grmaster="git reset --hard origin/master"
alias gac="git add --all && git commit -a -m "
alias gst="git status"
alias dc='docker-compose'

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# The original version is saved in .bash_profile.pysave
export PIPENV_NO_INHERIT=True
export PIPENV_VERBOSITY="-1"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \$(parse_git_branch) $ "

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Github pull request function
gprmaster() {
  if [ $? -eq 0 ]; then
    github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@' -e 's%\.git$%%'`;
    branch_name=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`;
    pr_url=$github_url"/compare/master..."$branch_name
    open $pr_url;
  else
    echo 'failed to open a pull request.';
  fi
}

gprmain() {
  if [ $? -eq 0 ]; then
    github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@' -e 's%\.git$%%'`;
    branch_name=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`;
    pr_url=$github_url"/compare/main..."$branch_name
    open $pr_url;
  else
    echo 'failed to open a pull request.';
  fi
}

gpo() {
    branch_name=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`;
    git push origin $branch_name
}

# Fixes issue with pyenv and links tkinter
# https://github.com/pyenv/pyenv/issues/1737
export CFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix bzip2)/include -I$(brew --prefix readline)/include -I$(xcrun --show-sdk-path)/usr/include -I$(brew --prefix tcl-tk)/include"
export CPPFLAGS="-I/usr/local/opt/tcl-tk/include "
export LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix zlib)/lib -L$(brew --prefix bzip2)/lib -L/usr/local/opt/tcl-tk/lib -L$(brew --prefix tcl-tk)/lib"
export PKG_CONFIG_PATH="$(brew --prefix tcl-tk)/lib/pkgconfig"
export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
export PYTHON_CONFIGURE_OPTS="--with-tcltk-includes='-I$(brew --prefix tcl-tk)/include' --with-tcltk-libs='-L$(brew --prefix tcl-tk)/lib -ltcl8.6 -ltk8.6'"
