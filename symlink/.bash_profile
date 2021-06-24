echo 'Terminal of MattyB'

# The original version is saved in .bash_profile.pysave
export PIPENV_NO_INHERIT=True
export PIPENV_VERBOSITY="-1"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

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
