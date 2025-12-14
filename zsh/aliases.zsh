alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command
alias quit='exit' # It's just easier to type
alias :q='exit'

# utilities to figure out which package manager
# to run commands from - used in the "y*" alisases below
function pkgadd() {
	if [ -f "package-lock.json" ]; then
		ni $@
	elif [ -f "pnpm-lock.yaml" ]; then
		ni $@
	else
		ni $@
	fi
}

function pkginstall() {
	if [ -f "package-lock.json" ]; then
		ni
	elif [ -f "pnpm-lock.yaml" ]; then
		ni
	elif [ -f "bun.lockb" ]; then
    ni
	else
		ni
	fi
}

# run any command from the correct package manager. Instead of: npm run build:watch, yarn storybook
# You would use: y build:watch, y storybook and it would figure out the right package manager to use
function y() {
	if [ -f "package-lock.json" ]; then
    nr "$1" "${@:2}"
	elif [ -f "pnpm-lock.yaml" ]; then
    nr $@
	elif [ -f "bun.lockb" ]; then
    nr $@
	else
    nr $@
	fi
}

# opens the link to the release of the current storybook version in the project
function get-release() {
    local package_json="./package.json"
    local version=$(jq -r '.devDependencies | to_entries[] | select(.key | test("(@storybook/.*|^storybook$)")) | .value' $package_json | cut -d '"' -f 2 | grep -E "^\^?(6|7|8|9|10)\." | head -n 1 | sed -E 's/^[\^~]//')
    if [ -z "$version" ]; then
        echo "No matching version found for @storybook/* or storybook in $package_json"
    else
        echo "open https://github.com/storybookjs/storybook/releases/tag/v$version"
    fi
}

alias kst='kill-port 6006'
alias kp='kill-port'
alias uninstall='npx @hipster/sb-utils uninstall --yes'

# useful for commands
alias yi='pkginstall'
alias yadd='pkgadd'
alias yaddD='pkgadd -D'
alias yst='y storybook --ci'
alias ybst='y build-storybook'
alias ys='y start'
alias yb='y build'
alias yt='y test'
alias ytw='y test:watch'
alias ytst='y test-storybook'
alias ydev='y dev'

# install and execute
alias yyst='yi && yst'
alias yys='yi && ys'
alias yyb='yi && yb'
alias yybst='yi && ybst'
alias yyt='yi && yt'
alias yydev='yi && dev'
alias yytst='yi && ytst'

function yy() {
  yi && y $@
}

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
alias yci='yarn --cwd $HOME/open-source/storybook/code && yarn --cwd $HOME/open-source/storybook/code task --task compile --start-from=compile'
alias ycli='nx run-many --target="prep" --parallel --all --exclude="*addon*,*builder*,*react*,*vite*,*webpack*,angular,*web*,vue3,nextjs,html,svelte*,create-storybook,ember,server*,eslint*" -- --reset'
# alias yc='yarn --cwd $HOME/open-source/storybook/code task --task compile --start-from compile'
alias repro='$HOME/open-source/storybook/code/lib/cli-storybook/bin/index.cjs repro'
alias cst='$HOME/open-source/storybook/code/lib/create-storybook/bin/index.cjs'
alias sb='$HOME/open-source/storybook/code/lib/cli-storybook/dist/bin/index.js'
alias sbinternal='node $HOME/open-source/storybook/code/core/dist/cli/bin/index.cjs'
alias sbx='yarn exec $HOME/open-source/storybook/code/lib/cli/bin/index.cjs'
alias build='yarn --cwd $HOME/open-source/storybook/code build'
alias buildd='yarn --cwd $HOME/open-source/storybook/code build core-server core-events cli telemetry "$1" --watch'
alias buildw='yarn --cwd $HOME/open-source/storybook/code build --watch'
alias sandbox='sandbox_func() { yarn --cwd $HOME/open-source/storybook/code task --task sandbox --debug --template "$1"/default-ts; }; sandbox_func'

alias gpll='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias gpo='git push origin $(git rev-parse --abbrev-ref HEAD)'

# needs update in task command to work. e.g. support --template cra-default-js instead of cra/default-js
alias e2e="yarn --cwd $HOME/open-source/storybook/code task --task sandbox --debug --template `pwd | sed -e 's/\/.*\///g'`"
alias trace="npx playwright show-trace"
alias playwright="STORYBOOK_URL=http://localhost:8001 STORYBOOK_TEMPLATE_NAME=`pwd | sed -e 's/\/.*\///g'` yarn --cwd $HOME/open-source/storybook/code playwright test"
alias serve="yarn --cwd $HOME/open-source/storybook/code http-server `pwd`/storybook-static --port 8001"

alias release-alpha='npm version prerelease --preid=alpha && git push --follow-tags && npm publish --tag alpha'
alias release-patch='yarn build && npm version patch && git push --follow-tags && npm publish'
alias release-minor='yarn build && npm version patch && git push --follow-tags && npm publish'

alias reset-registry='npm config set registry https://registry.npmjs.org && yarn config set npmRegistryServer https://registry.yarnpkg.com && yarn config set npmScopes --json '\''{ "storybook": { "npmRegistryServer": "https://registry.yarnpkg.com" } }'\'''

alias set-local-registry='npm config set registry http://localhost:6001/ && yarn config set npmRegistryServer http://localhost:6001/ && yarn config set npmScopes --json '\''{ "storybook": { "npmRegistryServer": "http://localhost:6001/" } }'\'''

function update-registry() {
    npm config set registry https://registry.npmjs.org/
    yarn config set npmRegistryServer https://registry.yarnpkg.com
    yarn config set npmScopes --json '\''{ "storybook": { "npmRegistryServer": "https://registry.yarnpkg.com" } }'\'
}

disable -r time
alias time='time -p'

# Reset Storybook development environment
alias sbreset='cd $HOME/open-source/storybook && gnukef && cd $HOME/open-source/storybook/scripts && yi && cd $HOME/open-source/storybook/code && yci'

function npxgrep() {
  local dirs
  dirs=($(ls -td ~/.npm/_npx/*(/N) 2>/dev/null | head -n 10))

  local valid_dirs=()
  for dir in $dirs; do
    if [[ -d "$dir" ]]; then
      valid_dirs+=("$dir")
    fi
    [[ ${#valid_dirs[@]} -eq 4 ]] && break
  done

  if [[ ${#valid_dirs[@]} -eq 0 ]]; then
    echo "No valid recent npx directories found." >&2
    return 1
  fi

  rg --vimgrep "$@" "${valid_dirs[@]}" \
    --glob "**/{@storybook,storybook}/**/*.js" \
    --glob "**/{@storybook,storybook}/**/*.cjs"
}

function pnpmgrep() {
  local pnpm_store_dir="$HOME/Library/pnpm/store"
  local dirs
  dirs=($(ls -td "$pnpm_store_dir"/*/ 2>/dev/null | head -n 10))

  local valid_dirs=()
  for dir in "${dirs[@]}"; do
    if [[ -d "$dir" ]]; then
      valid_dirs+=("$dir")
    fi
    [[ ${#valid_dirs[@]} -eq 4 ]] && break
  done

  if [[ ${#valid_dirs[@]} -eq 0 ]]; then
    echo "No valid pnpm store directories found." >&2
    return 1
  fi

  # echo "Running: rg --vimgrep $@ ${valid_dirs[@]} --glob \"**/{@storybook,storybook}/**/*.js\" --glob \"**/{@storybook,storybook}/**/*.cjs\""
  rg --vimgrep "$@" "${valid_dirs[@]}"
  # rg --vimgrep "$@" "${valid_dirs[@]}" \
  #   --glob "**/{@storybook,storybook}/**/*.js" \
  #   --glob "**/{@storybook,storybook}/**/*.cjs"
}

function dlxgrep() {
  local dlx_cache_dir="$HOME/Library/Caches/pnpm/dlx"
  local dirs
  dirs=($(ls -td "$dlx_cache_dir"/*/ 2>/dev/null | head -n 10))

  local valid_dirs=()
  for dir in "${dirs[@]}"; do
    if [[ -d "$dir" ]]; then
      valid_dirs+=("$dir")
    fi
    [[ ${#valid_dirs[@]} -eq 4 ]] && break
  done

  if [[ ${#valid_dirs[@]} -eq 0 ]]; then
    echo "No valid recent pnpm dlx directories found." >&2
    return 1
  fi

  rg --vimgrep "$@" "${valid_dirs[@]}" \
    --glob "**/{@storybook,storybook}/**/*.js" \
    --glob "**/{@storybook,storybook}/**/*.cjs"
}