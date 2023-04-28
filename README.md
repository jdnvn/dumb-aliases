# dumb-aliases
generates aliases from your most used shell commands

## how to use it
```
cd ~ && git clone https://github.com/jdnvn/dumb-aliases.git
cd dumb-aliases
ruby aliaser.rb
```
this will generate two files:
1. `command_counts.json` - lists all of your latest shell commands and how many times you've run them.
```
{
  "git push": 932,
  "bin/go": 170,
  "git stash pop": 167,
  "git commit": 149,
  "rails c": 133,
  "git pull origin develop": 126,
  "git stash": 124,
  "git add .": 121,
  "git checkout develop": 119,
  "bundle install": 104,
  ...
}
```
2. `dumb_aliases.txt` - subject to change aliases for the commands to be edited/copied into your `.zshrc` or `.bashrc` file. Now all you gotta do is remember them!
```
alias gp="git push"
alias bg="bin/go"
alias gsp="git stash pop"
alias gc="git commit"
alias rc="rails c"
alias gpod="git pull origin develop"
alias gs="git stash"
alias ga="git add ."
alias gcd="git checkout develop"
alias bi="bundle install"
...
```
