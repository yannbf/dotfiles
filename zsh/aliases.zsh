alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command
alias quit='exit' # It's just easier to type
alias :q='exit'

alias yst='yarn storybook'
alias ys='yarn start'
alias yb='yarn build'
alias test='npx jest --watch'
alias dk='docker-compose up'
alias dkbuild='docker-compose build'

alias --="cd -"
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

# storybook monorepo specific
alias streact='yarn --cwd examples/official-storybook storybook'
alias staurelia='yarn --cwd examples/aurelia-kitchen-sink storybook'
alias stangular='yarn --cwd examples/angular-cli storybook'
alias stvue='yarn --cwd examples/vue-kitchen-sink storybook'
alias stsvelte='yarn --cwd examples/svelte-kitchen-sink storybook'

# hybrid-core specific
alias iphone='cd dist/app && cordova platform add ios@5.0.1 && cordova platform remove ios && cordova platform add ios@5.0.1 && cordova run ios'