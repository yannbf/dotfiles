alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command
alias quit='exit' # It's just easier to type
alias :q='exit'

function pkgadd() {
	if [ -f "package-lock.json" ]; then
		npm install $@
	elif [ -f "pnpm-lock.yaml" ]; then
		pnpm add $@
	else
		yarn add $@
	fi
}

function pkginstall() {
	if [ -f "package-lock.json" ]; then
		npm install
	elif [ -f "pnpm-lock.yaml" ]; then
		pnpm install
	else
		yarn
	fi
}

function pkgrun() {
	if [ -f "package-lock.json" ]; then
    npm run $@
	elif [ -f "pnpm-lock.yaml" ]; then
    pnpm run $@
	else
    yarn $@
	fi
}

alias kst='kill-port 6006'
alias kp='kill-port'

# useful for commands
alias yi='pkginstall'
alias yadd='pkgadd'
alias yaddD='pkgadd -D'
alias yst='pkgrun storybook'
alias ybst='pkgrun build-storybook'
alias ys='pkgrun start'
alias yb='pkgrun build'
alias yt='pkgrun test'
alias ytst='pkgrun test-storybook'
alias ydev='pkgrun dev'

# install and execute
alias yyst='yi && yst'
alias yys='yi && ys'
alias yyb='yi && yb'
alias yybst='yi && ybst'
alias yyt='yi && yt'
alias yydev='yi && dev'
alias yytst='yi && ytst'

alias testy='npx jest --watch'
alias dk='docker-compose up'
alias dkbuild='docker-compose build'

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
alias ybt='yarn --cwd $HOME/open-source/storybook/code task --task compile --start-from install'
alias yc='yarn --cwd $HOME/open-source/storybook/code nx run-many --target="prep" --all --parallel --max-parallel=9 --exclude=@storybook/addon-storyshots,@storybook/addon-storyshots-puppeteer -- --reset'
# alias yc='yarn --cwd $HOME/open-source/storybook/code task --task compile --start-from compile'
alias repro='$HOME/open-source/storybook/lib/cli/bin/index.js repro'
alias sb='$HOME/open-source/storybook/code/lib/cli/bin/index.js'
alias build='yarn --cwd $HOME/open-source/storybook/code build'
alias buildw='yarn --cwd $HOME/open-source/storybook/code build --watch'
alias sandbox='yarn --cwd $HOME/open-source/storybook/code task --task sandbox --debug --template'
# needs update in task command to work. e.g. support --template cra-default-js instead of cra/default-js
alias e2e="yarn --cwd $HOME/open-source/storybook/code task --task sandbox --debug --template `pwd | sed -e 's/\/.*\///g'`"
alias trace="npx playwright show-trace"

alias release-alpha='npm version prerelease --preid=alpha && git push --follow-tags && npm publish --tag alpha'
alias release-patch='yarn build && npm version patch && git push --follow-tags && npm publish'
alias release-minor='yarn build && npm version patch && git push --follow-tags && npm publish'


disable -r time
alias time='time -p'
