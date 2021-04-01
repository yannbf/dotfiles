# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Run ./set-defaults.sh and you'll be good to go.

function ask {
  while true; do
    if [ "$2" == "Y" ]; then
      prompt="\033[1;32mY\033[0m/n"
      default=Y
    elif [ "$2" == "N" ]; then
      prompt="y/\033[1;32mN\033[0m"
      default=N
    else
      prompt="y/n"
      default=
    fi

    printf "• $1 [$prompt] "

    if [ "$auto" == "Y" ]; then
      echo
    else
      read yn
    fi

    if [ -z "$yn" ]; then
      yn=$default
    fi

    case $yn in
      [Yy]*) return 0 ;;
      [Nn]*) return 1 ;;
    esac
  done
}

if ask "Do you want to update default configurations for macOS?" Y; then

    ###############################################################################
    # Keyboard & Trackpad                                                         #
    ###############################################################################

    # if ask "Use scroll gesture with the Ctrl (^) modifier key to zoom?" Y; then
    #     defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
    #     defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 1048576
    # fi

    if ask "Disable press-and-hold for keys in favor of key repeat?" Y; then
        defaults write -g ApplePressAndHoldEnabled -bool false
        defaults write NSGlobalDomain KeyRepeat -int 2
    fi

    if ask "Enable tap to click on trackpad?" Y; then
        defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
        defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    fi

    if ask "Enable drag with three fingers on trackpad?" Y; then
        defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
    fi

    ###############################################################################
    # Menu bar                                                                    #
    ###############################################################################

    if ask "Show remaining battery percentage in menu widget?" Y; then
        defaults write com.apple.menuextra.battery ShowPercent -string "YES"
    fi

    if ask "Add bluetooth to menu bar?" Y; then
        open '/System/Library/CoreServices/Menu Extras/Bluetooth.menu'
    fi

    ###############################################################################
    # System, Finder and files                                                    #
    ###############################################################################

    if ask "Open and save files as UTF-8 in TextEdit?" Y; then
        defaults write com.apple.TextEdit PlainTextEncoding -int 4
        defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
    fi

    # if ask "Automatically open a new Finder window when a volume is mounted?" Y; then
    #     defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
    #     defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
    #     defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
    # fi

    # if ask "Always open everything in Finder's list view?" Y; then
    #     defaults write com.apple.Finder FXPreferredViewStyle Nlsv
    # fi

    # if ask "Show the ~/Library folder in Finder?" Y; then
    #     chflags nohidden ~/Library
    # fi

    # if ask "Set Finder to show external hard drives and removable media volumes on the Desktop?" Y; then
    #     defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    #     defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
    # fi

    # if ask "Enable AirDrop over Ethernet and on unsupported Macs running Lion?" Y; then
    #     defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1
    # fi

    if ask "Run the screensaver if mouse touches the bottom-left hot corner?" Y; then
        defaults write com.apple.dock wvous-bl-corner -int 5
        defaults write com.apple.dock wvous-bl-modifier -int 0
    fi

    # if ask "Ask for password after going into screensaver mode?" Y; then
    #     defaults write com.apple.screensaver askForPassword -int 1
    #     defaults write com.apple.screensaver askForPasswordDelay -int 0
    # fi


    ###############################################################################
    # Safari                                                                      #
    ###############################################################################
    
    # if ask "Hide Safari's bookmark bar?" Y; then
    #     defaults write com.apple.Safari ShowFavoritesBar -bool false
    # fi

    if ask "Enable the Develop menu and the Web Inspector in Safari?" Y; then
        defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
        defaults write com.apple.Safari IncludeDevelopMenu -bool true
        defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
        defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
        defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
    fi

    killall SystemUIServer &> /dev/null
    echo -e "\033[1;33m› MacOS default configurations updated.\033[0m"
fi