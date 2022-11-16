##############################
#         COLORS
##############################

export NC='\e[0m' # No Color
export BLACK='\e[0;30m'
export GRAY='\e[1;30m'
export RED='\e[0;31m'
export LIGHT_RED='\e[1;31m'
export GREEN='\e[0;32m'
export LIGHT_GREEN='\e[1;32m'
export BROWN='\e[0;33m'
export YELLOW='\e[1;33m'
export BLUE='\e[0;34m'
export LIGHT_BLUE='\e[1;34m'
export PURPLE='\e[0;35m'
export LIGHT_PURPLE='\e[1;35m'
export CYAN='\e[0;36m'
export LIGHT_CYAN='\e[1;36m'
export LIGHT_GRAY='\e[0;37m'
export WHITE='\e[1;37m'

##############################
#         OPTIONS
##############################

export TERM=xterm-color
unset GREP_OPTIONS
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

##############################
#         ENV
##############################

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH=$PATH:~/.platformio/penv/bin
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH
export DOTNET_ROOT=/opt/dotnet
export gitpriv="${USER}/.ssh/gitpriv"


##############################
#         Functions
##############################

if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

##############################
#           ALIASES
##############################

alias ls='ls --color=auto'
alias l='ls -la'
alias lr='ls -la -R'
alias rf='rm -rf'
alias py='python3'
alias d='rm -rf'

alias up='python3 -m http.server 8000'
alias psa='ps aux | grep'
alias sc='SSH_AUTH_SOCK='
alias root='sudo su'
alias fix-ssh="eval \`ssh-agent -s\` && ssh-add ~/.ssh/gitpriv"

alias thmvpn='sudo openvpn ~/Desktop/thm.ovpn'
alias htbvpn='sudo openvpn ~/Desktop/htb.ovpn'

alias r='FILE=$1; rustc $FILE && bash $FILE | rev | cut -c4- | rev'

get_git() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    repo=$(basename `git rev-parse --show-toplevel`)
    branch=$(git branch | grep \* | cut -f2 -d" " 2> /dev/null)
    commit=$(git rev-list HEAD --count)
    if [[ `git status --porcelain` ]]; then
      mod="m"
    else
      mod=""
    fi
    if [[ `git stash list | grep stash` == No* ]]; then
      stash=""
    elif [[ `git stash list | grep stash` == fatal* ]]; then
      stash=""
    elif [[ `git stash list | grep stash` == stash* ]]; then
      stash="s"
    fi
    echo "${GREEN}[${repo}:${branch}:${commit}] ${YELLOW}[${mod}${stash}]"
  fi
}
alias gic='git clone'
alias gid='git diff'
alias gidn='git diff --name-only'
alias gis='git status'
alias gib='git checkout'
alias gibn='git checkout -b'
alias gibd='git branch -d'
alias gibr='git branch --format "%(refname:short) <> %(upstream)"'
alias gim='git merge'
alias gip='git add -A && git commit -m'
alias gir='git reset --soft HEAD^'
alias gisub='git submodule update --init --recursive'
alias yeet='git push --set-upstream origin'
alias yoink='git pull'
gipull() {
  branch=`git rev-parse --abbrev-ref HEAD`
  git fetch --all
  git checkout $branch
  git push fork origin/$branch:$branch
  git pull
}


alias doi="docker images"
alias doc="docker container ls"
alias docp="docker container prune"
alias dov="docker volume ls"
alias dovp="docker volume prune"
alias dop='docker pull'
alias dops='docker ps --format "{{ .Names }}\t{{ .Ports }}\t{{ .Status }}"'
alias dologs='docker logs -f'
alias doexec='docker exec -it'
alias dormi='docker rmi'
alias dorm='docker rm'
alias dopp='docker push'
alias doit='docker images --format "{{.Repository}}:{{.Tag}}"'
dokill () {
	docker kill $1
	docker rm $1
}


alias ju='jupyter'
alias jun='jupyter notebook &'
alias jul='jupyter lab &'
alias dotnet='/opt/dotnet/dotnet'
alias msbuild='/opt/dotnet/dotnet msbuild'
alias cultparrot='curl parrot.live'

# kubectl aliases
kns="kube-system"
kconfig="$HOME/.kube/config"
function kns() {
    if [[ -z  $1 ]]; then
        echo $kns
        return
    fi
    kns=$1
}
alias kns-kube-system='kns kube-system' 
alias kns-kube-default='kns default' 
function kconfig() {
    if [[ -z  $1 ]]; then
        echo $kconfig
        return
    fi
    kconfig=$1
}
preamble='kubectl --kubeconfig $kconfig --namespace $kns'
alias k=$preamble
alias kp="$preamble get pods"
alias kp-net="$preamble get pods -o custom-columns=NAME:.metadata.name,IP:.status.podIP,HOST_IP:.status.hostIP,NODE:.spec.nodeName"
alias kd="$preamble get deployments"
alias kdel="$preamble delete"
alias ks="$preamble get services" 
alias kn="$preamble get nodes" 
alias kdesc="$preamble describe"
alias kexec="$preamble exec"
alias kiexec="$preamble exec -i -t"
alias klogs="$preamble logs --timestamps "
alias klogsf="$preamble logs --timestamps --follow "

alias mcr='macchanger -r'
alias delexif='for f in ./*; do exiftool -all= -overwrite_original $f; done'
alias autorecon='python3 /opt/AutoRecon/autorecon.py'
alias photon='python3 /opt/Photon/photon.py'
alias dirsearch='python3 /opt/dirsearch/dirsearch.py'
alias dnschef='python3 /opt/dnschef/dnschef.py'
alias GetUserSPNs='python3 /opt/impacket/examples/GetUserSPNs.py'
alias getTGT='python3 /opt/impacket/examples/getTGT.py'
alias smbserver='python3 /opt/impacket/examples/smbserver.py'
alias secretsdump='python3 /opt/impacket/examples/secretsdump.py'
alias psexec='python3 /opt/impacket/examples/psexec.py'
alias mssqlclient='python3 /opt/impacket/examples/mssqlclient.py'

alias ghidra='bash /opt/ghidra/ghidraRun'

# Folding at home client
alias fah='/etc/init.d/FAHClient'

##############################
#           Prompt
##############################

[[ $- != *i* ]] && return

PS1="${BLUE}\u${PURPLE}@${RED}\h ${CYAN}[\w] $(get_git)\n${WHITE}\$→ ${LIGHT_GRAY}"

