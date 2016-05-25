#(d) is default on

# ------------------------------
# # General Settings
# # ------------------------------
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/usr/local/Cellar/vim/7.4.1832/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/bin/Sencha/Cmd:$PATH
export PATH="$(brew --prefix homebrew/php/php54)/bin:$PATH"
export PATH=/usr/local/Cellar/mysql56/5.6.29/bin:$PATH
#MAMPを起動しないでphp5.3を使うなら、このPATHをコメントアウトすること
#export PATH=/Applications/MAMP/bin/php/php5.6.10/bin:$PATH

export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export PATH=$PATH:~/Library/Python/2.7/bin
export CLICOLOR=1
export TERM=xterm-256color

#source ~/.phpbrew/bashrc

bindkey -v              # キーバインドをviモードに設定
setopt NO_beep
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
#setopt correct           # コマンドのスペルを訂正する
#setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
#setopt notify            # バックグラウンドジョブの状態変化を即時報告する
##setopt equals            # =commandを`which command`と同じ処理にする

### Complement ###
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# すべてのヒストリを表示する
function history-all { history -E 1 }
autoload -U colors; colors

# -----------------------------
# git-prompt
# git-completion
# -----------------------------
source ~/.git-prompt.sh
#source ~/.git-completion.zsh
# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
unset LSCOLORS
case "${TERM}" in
xterm)
  export TERM=xterm-color
		;;
kterm)
	export TERM=kterm-color
	# set BackSpace control character
	stty erase
  ;;
cons25)
	unset LANG
	export LSCOLORS=ExFxCxdxBxegedabagacad
    export
LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors \
		'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
	;;
esac
## #Prompt ###
## プロンプトに色を付ける
# 一般ユーザ時
setopt prompt_subst
autoload colors
colors
#local cur_dir="%F{white} %~ %f"$'\n'
#local main="%B%F{black}%n%f%b@%F{yellow}%m%f"
#PROMPT=" $cur_dir$main %F{cyan}>>%f "
#RPROMPT='$(__git_ps1 "%s")'

local cur_dir="%F{white} %~ %f"$'\n'
local main="%B%F{black}%n%f%b@%F{yellow}%m%f"
PROMPT=" $cur_dir %F{cyan}>%f "
RPROMPT='$(__git_ps1 "%s")'

# ------------------------------
# Other Settings
# ------------------------------
#zsh-syntax-highlighting コマンドをハイライトする
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi 

#eval $(gdircolors ~/dircolors/dircolors-solarized/dircolors.ansi-universal)
#if [ -f ~/.dircolors ]; then
#    if type dircolors > /dev/null 2>&1; then
#        eval $(dircolors ~/.dircolors)
#    elif type gdircolors > /dev/null 2>&1; then
#        eval $(gdircolors ~/.dircolors)
#    fi
#fi 
if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-color ${(s.:.)LS_COLORS}
fi
##########
#alias
##########
alias history='history -E'
alias ls='ls -G'
alias ll='ls -Gl'
alias la='ls -Gal'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias desk='cd ~/Desktop'
alias down='cd ~/Downloads'

# cdコマンド実行後、lsを実行する
#function cd() {
#  builtin cd $@ && ls;
#}

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# tmux 起動時 attach
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
    if is_screen_or_tmux_running; then
        ! is_exists 'tmux' && return 1

        if is_tmux_runnning; then
            echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
            echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
            echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
            echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
            echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
        elif is_screen_running; then
            echo "This is on screen."
        fi
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                read
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
tmux_automatically_attach_session
