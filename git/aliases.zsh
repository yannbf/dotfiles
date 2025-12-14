# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

# The rest of my fun git aliases
alias gpl='git pull'
alias gplp='git pull --prune'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'

# Remove `+` and `-` from start of diff lines; just rely upon color.
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'

alias ga='git add'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gcb='git copy-branch-name'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gac='git add -A && git commit -m'
alias ge='git-edit-new'
alias ggm='git checkout master && git pull'
alias git-purge="git branch --merged master | grep -v -e 'master' -e '\*' | xargs -n 1 git branch -d && git remote prune origin"

alias gpublish='gp && gco production && gm master && gp && gco master'

alias gdnew="for next in \$( git ls-files --others --exclude-standard ) ; do git --no-pager diff --no-index /dev/null \$next; done;"
alias git-patch="git --no-pager diff > diff.patch; gdnew"

alias gnuke="gco . && git clean -df"
alias gnukef="gco . && git clean -xdf"

function ghpr() {
	GH_FORCE_TTY=100% gh pr list | fzf --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout
}

function release-message() {
  for pr in $(git log main..HEAD --pretty=format:"%s" --merges | grep "pull request" | grep -o "#[0-9]*" | tr -d '#'); do
    gh pr view $pr --json title,author --jq '.title + " - Thanks @" + .author.login + "!"'
  done
}

function canary() {
  # Determine PR number if not provided
  if [[ -z "$1" ]]; then
    echo "🔍 No PR number provided — searching for PR linked to the current branch..."

    # Find the current branch
    local branch=$(git rev-parse --abbrev-ref HEAD)

    # Use GitHub CLI to find an associated PR
    local pr_number=$(gh pr list --head "$branch" --limit 1 --json number -q ".[0].number")

    if [[ -z "$pr_number" ]]; then
      echo "❌ No PR found for branch '$branch'."
      return 1
    fi

    echo "✅ Found PR: #$pr_number"
  else
    local pr_number="$1"
  fi

  # Trigger the workflow
  gh workflow run --repo storybookjs/storybook publish.yml --field pr="$pr_number"
  echo "\n🚀 Preparing canary for PR https://github.com/storybookjs/storybook/pull/$pr_number"

  # Wait a moment to ensure the workflow registers
  sleep 3

  # Fetch the latest run ID for the "publish.yml" workflow specifically
  local run_id=$(gh run list --repo storybookjs/storybook --workflow publish.yml --limit 1 --json databaseId -q ".[0].databaseId")

  echo "🛠️ Run ID: $run_id"
  if [[ -z "$run_id" ]]; then
    echo "❌ Failed to get run ID."
    return 1
  fi

  # Watch only this specific run
  gh run watch $run_id --repo storybookjs/storybook
}
