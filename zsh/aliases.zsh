alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command
alias quit='exit' # It's just easier to type
alias :q='exit'

alias yst='yarn storybook'
alias ys='yarn start'
alias yb='yarn build'

alias -- -="cd -"
alias grep='grep --color=auto'

alias ip='ipconfig getifaddr en0 && ipconfig getifaddr en0 | pbcopy'

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

# for easy http requests
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "${method}"="lwp-request -m '${method}'"
done