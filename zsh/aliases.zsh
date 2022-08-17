alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command
alias quit='exit' # It's just easier to type
alias :q='exit'

alias yst='yarn storybook'
alias ys='yarn start'
alias yb='yarn build'
alias yt='yarn test'
alias ytst='yarn test-storybook'
alias kst='kill-port 6006'

alias yyst='yarn && yst'
alias yys='yarn && ys'
alias yyb='yarn && yb'
alias yyt='yarn && yt'
alias yytst='yarn && ytst'

alias ns='npm run start'
alias nt='npm run test'
alias nti='rm -rf dist && npm run test-int-ui'
alias ntiprod='npm run configure -- --build acceptance && npm run build-min -- --verbose && npm run test-int-ui'
alias testy='npx jest --watch'
alias dk='docker-compose up'
alias dkbuild='docker-compose build'

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

# storybook monorepo specific
alias ybt='yarn --cwd $HOME/open-source/storybook/code bootstrap --core'
alias ybp='yarn --cwd $HOME/open-source/storybook/code bootstrap --prep'
alias ystreact='yarn --cwd examples/react-ts storybook'
alias ystofficial='yarn --cwd examples/official-storybook storybook'
alias ystaurelia='yarn --cwd examples/aurelia-kitchen-sink storybook'
alias ystangular='yarn --cwd examples/angular-cli storybook'
alias ystvue='yarn --cwd examples/vue-kitchen-sink storybook'
alias ystsvelte='yarn --cwd examples/svelte-kitchen-sink storybook'
alias repro='$HOME/open-source/storybook/lib/cli/bin/index.js repro'
alias sb='$HOME/open-source/storybook/code/lib/cli/bin/index.js'

alias release-alpha='npm version prerelease --preid=alpha && git push --follow-tags && npm publish --tag alpha'
alias release-patch='yarn build && npm version patch && git push --follow-tags && npm publish'
alias release-minor='yarn build && npm version patch && git push --follow-tags && npm publish'


disable -r time
alias time='time -p'