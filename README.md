# My dotfiles

Your dotfiles are how you personalize your system. This repo contains mine.
ps: This is focused on MacOS. Try this at your own risk.

If you're interested in the philosophy behind why projects like these are
awesome, you might want to [read holman's post on the
subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## What this does
TLDR: Sets an entire development setup from a freshly installed mac in under 10 minutes.

* Installs a set of applications: 
Iterm2 (along with powerline fonts), VSCode, Slack, Docker, Spetacle, Alfred, Charles proxy, Chrome, Firefox and Spotify from the [brewfile](/homebrew/Brewfile).

* Installs command line tools:
ack, git, git-flow, watchman, wget, yarn, zlib, zsh, zsh-completions, zsh-syntax-highlighting, oh-my-zsh also from the [brewfile](/homebrew/Brewfile)

* Sets macOS defaults for better experience, such as:
Enable key repeats, tap to click on trackpad, add bluetooth and battery % on menubar, etc. Check [the file](/macos/set-defaults.sh) to see all it does.

* Sets iterm2 configuration to use the custom versioned config for zero effort setup.

* Sets aliases for all kinds of things. Look for all aliases.zsh files to check them.


## Topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## Components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `script/install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## Install
ps: If you want to install this with your own customizations, skip this section.

If you come from a fresh mac install, run this first:
```sh
xcode-select --install
```

Run this:

```sh
sh -c "`curl -fsSL https://raw.githubusercontent.com/guilhermewaess/dotfiles/master/start.sh `"
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane macOS
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

## Install with my own customization

If you want to strip out or add more things to your setup, you might want to fork this repo first, remove what you don't need, tweak with which applications you want installed in the [brewfile](/homebrew/Brewfile), along with other config files with the extension `.zsh`.

Once you do that, then just run `script/bootstrap`.

ps: To better understand the flow of the scripts, check `script/bootstrap`, `script/install`, `bin/dot` and `zsh/zshrc.symlink` (where the zsh files are run)

## Adding new apps

When using homebrew/cask/mas, if you need to add a new application or tool, just go to the Brewfile (for CLI and UI tools) and BrewfileAppStore (for app store apps) and add a new entry there. After doing that, run `brew-update` and you're set!

## Thanks

I forked [Zach Holman](http://github.com/holman)'s excellent
[dotfiles](http://github.com/holman/dotfiles) and customized it for my own needs.
