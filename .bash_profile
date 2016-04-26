export PATH=$PATH:/usr/local/mysql/bin
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'

if [[ -s ~/.nvm/nvm.sh ]];
  then source ~/.nvm/nvm.sh
fi
export PATH="$HOME/bin/Sencha/Cmd/6.0.2.14/..:$PATH"

#Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color
export CLICOLOR=1
