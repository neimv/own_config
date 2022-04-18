## Config basic

# History set
HISTTIMEFORMAT="%F-%T "
HISTCONTROL=ignoredups
HISTSIZE=20000
HISTFILESIZE=20000

# Colors
blk='\[\033[01;30m\]'   # Black
red='\[\033[01;31m\]'   # Red
grn='\[\033[01;32m\]'   # Green
ylw='\[\033[01;33m\]'   # Yellow
blu='\[\033[01;34m\]'   # Blue
pur='\[\033[01;35m\]'   # Purple
cyn='\[\033[01;36m\]'   # Cyan
wht='\[\033[01;37m\]'   # White
clr='\[\033[00m\]'      # Reset
e_blk='\e[1;30m'        # Echo Black
e_red='\e[1;31m'        # Echo Red
e_grn='\e[1;32m'        # Echo Green
e_ylw='\e[1;33m'        # Echo Yellow
e_blu='\e[1;34m'        # Echo Blue
e_pur='\e[1;35m'        # Echo Purple
e_cyn='\e[1;36m'        # Echo Cyan
e_wht='\e[1;37m'        # Echo White
e_clr='\e[0m'           # Echo Reset
b_grn='\[\033[01;42m\]'	# Green Background
b_red='\[\033[01;41m\]'	# Red Background
b_cyn='\[\033[01;46m\]'	# Cyan Background
eb_cyn='\e[1;46m'	    # Cyan Background
eb_grn='\e[1;42m'	    # Cyan Background

# Set vi as command line
set -o vi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


## advanced configs
# Display the current Git branch in the Bash prompt.
function git_branch() {
    if [ -d .git ] || git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        printf "%s" "($(git branch 2> /dev/null | awk '/\*/{print $2}'))";
    fi
}

# Set the prompt.
function bash_prompt() {
    local git_modified_color="${grn}"
    local git_status=$(git status 2>/dev/null | grep "Your branch is ahead" 2>/dev/null)

    if [ "$git_status" != "" ]; then
        git_modified_color="${ylw}"
    fi

    local git_status=$(git status --porcelain 2>/dev/null)
    if [ "$git_status" != "" ]; then
        git_modified_color="${red}"
    fi
 
    if test -z "$VIRTUAL_ENV" ; then
        PYTHON_VIRTUALENV=""
    else
        PYTHON_VIRTUALENV="[`basename \"$VIRTUAL_ENV\"`]"
    fi

    PS1='${debian_chroot:+($debian_chroot)}'${b_cyn}'\u@\h'${clr}${git_modified_color}' $(git_branch)'${cyn}' \W '${b_grn}''${wht}'${PYTHON_VIRTUALENV}'${clr}''${wht}' \$ '${clr}
}

PROMPT_COMMAND='bash_prompt'

# through your history for previous run commands
function hg() {
    history | grep "$1";
}

# Creates and install libraries python
function create_venv() {
    EXISTS=0

    if [[ -d venv ]]; then
        echo "exists virtualenv in this folder"
        EXISTS=1
    else
        virtualenv venv
    fi

    if [[ -f requirements.txt ]]; then
        INSTALL="y"
        if [[ $EXISTS -eq 1 ]]; then
            read -n1 -p "Do you like install reqs[y/n]: " INSTALL
        fi

        if [ $INSTALL = "n" ]; then
            printf "\n"
            return
        fi
        echo "Installing requirements.txt"
        source venv/bin/activate
        pip install -r requirements.txt
    fi
}

# Show status of system
function status_system() {
    cpuName=$(lscpu | grep 'Model name' | cut -f 2 -d ":" | awk '{$1=$1}1')
    cores=$(grep -c ^processor /proc/cpuinfo)
    processors=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}')
    pythonVersion=$(python3 --version 2>&1)
    golangVersion=$(go version | cut -f 3 -d " ")
    rustVersion=$(rustc --version)
    # rustVersion="Hello"
    nodeVersion=$(npm --version)
    bashVersion=${BASH_VERSION}
    cVersion=$(gcc --version | grep gcc | awk '{print $3}')
    dockerVersion=$(docker --version)
    vimVersion=$(vim --version | head -1 | cut -d ' ' -f 5)

    echo -e "${e_blu}          .?77777777777777S.             ${e_clr}| ${eb_cyn}USER: $(echo $USER)${e_clr}"
    echo -e "${e_blu}          777..777777777777S+            ${e_clr}| ${eb_cyn}HOSTNAME: $(hostname -f)${e_clr}"
    echo -e "${e_blu}         .77    7777777777SSS            ${e_clr}| ${eb_cyn}DATE: $(date)${e_clr}"
    echo -e "${e_blu}         .777 .7777777777SSSS            ${e_clr}| ${eb_cyn}UPTIME: $(uptime -p)${e_clr}"
    echo -e "${e_blu}         .7777777777777SSSSSS            ${e_clr}| ${eb_cyn}KERNEL: $(uname -rms)${e_clr}"
    echo -e "${e_blu}         ..........:77SSSSSSS            ${e_clr}| ${eb_cyn}PACKAGES: $(dpkg --get-selections | wc -l)${e_clr}"
    echo -e "${e_blu}  .77777777777777777SSSSSSSSS${e_clr}${e_ylw}.=======.   ${e_clr}| ${eb_cyn}RESOLUTION: $(xrandr | awk '/\*/{printf $1" "}')${e_clr}"
    echo -e "${e_blu} 777777777777777777SSSSSSSSSS${e_clr}${e_ylw}.========   ${e_clr}| ${eb_cyn}MEMORY: $(free -m -h | awk '/Mem/{print $3"/"$2}')${e_clr}"
    echo -e "${e_blu}7777777777777777SSSSSSSSSSSSS${e_clr}${e_ylw}.=========  ${e_clr}| ${eb_cyn}PROCESSOR NAME: ${cpuName}, CORES: ${cores}, PROCESSORS: ${processors}${e_clr}"
    echo -e "${e_blu}77777777777777SSSSSSSSSSSSSSS${e_clr}${e_ylw}.=========  ${e_clr}| ${eb_grn}PROGRAM VERSIONS:${e_clr}"
    echo -e "${e_blu}777777777777SSSSSSSSSSSSSSSS${e_clr}${e_ylw} :========+. ${e_clr}|     ${eb_grn}${pythonVersion} | ${golangVersion}${e_clr}"
    echo -e "${e_blu}77777777777SSSSSSSSSSSSSS${e_clr}${e_ylw}+..=========++~ ${e_clr}|     ${eb_grn}${rustVersion} | Node: ${nodeVersion}${e_clr}"
    echo -e "${e_blu}777777777SS${e_clr}${e_ylw}..~=====================+++++ ${e_clr}|     ${eb_grn}Bash: ${bashVersion} | C/C++: ${cVersion}${e_clr}"
    echo -e "${e_blu}77777777S${e_clr}${e_ylw}~.~~~~=~=================+++++. ${e_clr}|     ${eb_grn}${dockerVersion} | Vim: ${vimVersion}${e_clr}"
    echo -e "${e_blu}777777SSS${e_clr}${e_ylw}.~~~===================+++++++. ${e_clr}| "
    echo -e "${e_blu}77777SSSS${e_clr}${e_ylw}.~~==================++++++++:  ${e_clr}| "
    echo -e "${e_blu} 7SSSSSSS${e_clr}${e_ylw}.==================++++++++++.  ${e_clr}| "
    echo -e "${e_blu} .,SSSSSS${e_clr}${e_ylw}.================++++++++++~.   ${e_clr}| "
    echo -e "${e_ylw}         .=========~.........            ${e_clr}| "
    echo -e "${e_ylw}         .=============++++++            ${e_clr}| "
    echo -e "${e_ylw}         .===========+++..+++            ${e_clr}| "
    echo -e "${e_ylw}         .==========+++.  .++            ${e_clr}| "
    echo -e "${e_ylw}          ,=======++++++,,++,            ${e_clr}| "
    echo -e "${e_ylw}          ..=====+++++++++=.             ${e_clr}| "
    echo -e "${e_ylw}                ..~+=...                 ${e_clr}| "
	printf "\n"
}

# Cargo run
. "$HOME/.cargo/env"

status_system

source /etc/profile.d/bash_completion.sh
# Alias
alias la='ls -lha'                  # show list of files with hidden files
alias ll='ls -lh'                   # Show list of files with details
alias gs='git status'               # View Git status.
alias ga='git add'                  # Add a file to Git.
alias gaa='git add --all'           # Add all files to Git.
alias gc='git commit'               # Commit changes to the code.
alias gl='git log --oneline'        # View the Git log.
alias gb='git checkout -b'          # Create a new Git branch and move to the new branch at the same time.
alias gd='git diff'                 # View the difference.
alias ..='cd ..;pwd'                # Move to the parent folder.
alias ...='cd ../..;pwd'            # Move up two parent folders.
alias ....='cd ../../..;pwd'        # Move up three parent folders.
alias c='clear'                     # Press c to clear the terminal screen.
alias r='reset'                     # another clear screen
alias h='history'                   # Press h to view the bash history.
alias tree='tree --dirsfirst -F'    # Display the directory structure better.
alias mkdir='mkdir -p -v'           # Make a directory and all parent directories with verbosity.
alias python='python3'
# use only three letter to show calendar
alias jan='cal -m 01'
alias feb='cal -m 02'
alias mar='cal -m 03'
alias apr='cal -m 04'
alias may='cal -m 05'
alias jun='cal -m 06'
alias jul='cal -m 07'
alias aug='cal -m 08'
alias sep='cal -m 09'
alias oct='cal -m 10'
alias nov='cal -m 11'
alias dec='cal -m 12'
