alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'

alias cd..='cd ..'

alias tf='tail -F -n 200'
alias h=history

alias ls='ls -G'
alias lrt='ls -lart'
alias lt='ls -lat'
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias less='less -R'

alias fname='find . -name'

alias brake='bundle exec rake'
alias bopen='EDITOR=mvim bundle open'
alias bcuke='bundle exec cucumber'
alias brspec='bundle exec rspec'

alias gitpull='find . -type d -name .git   | xargs -n 1 dirname   | while read line; do cd $line && git pull && cd .. ; done'

alias fs='foreman start'

alias spider='wget -r -nd --delete-after --level=5'

alias netlisten='lsof -i -P | grep LISTEN'

alias zke='zeus rake'
alias zrspec='zeus rspec'

alias popular="tail -n 2000 ~/.bash_history | cut -d ';' -f 2 | awk '{print $1 '' $2}' | sort | uniq -c | sort -rn"

alias beanshell='java jline.ConsoleRunner bsh.Interpreter'

alias gs='git status'
alias gd='git diff'
alias gc='git checkout'
alias ga='git add'
