#!/bin/sh

# Fail this script if any subcommand fails.
set -e

# The default execution directory of this script is the ci_scripts directory.
cd $CI_PRIMARY_REPOSITORY_PATH # change working directory to the root of your cloned repo.

# echo "$CI_PRIMARY_REPOSITORY_PATH"
echo "cd ok"
#echo $HOME


# Install Flutter using git.
git clone https://github.com/flutter/flutter.git --depth 1 -b 2.10.5 $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"
#export PATH=$HOME/development/flutter/bin:$PATH
flutter --version
echo "flutter found"
# Install Flutter artifacts for iOS (--ios), or macOS (--macos) platforms.
flutter precache --ios
# Install Flutter dependencies.
flutter pub get



# Install CocoaPods using Homebrew.
HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates.
# brew install cocoapods
# brew install cocoapods -v 1.11.2
# export GEM_HOME="$HOME/.gem"
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH
gem install cocoapods -v 1.11.2 --user-install
gem which cocoapods
# gem install cocoapods -v 1.11.2
#export PATH="/usr/local/opt/ruby@3.1/bin:$PATH"# pod install
# Install CocoaPods dependencies.
echo "change to ios folder"
cd /Volumes/workspace/repository/ios
pwd

#cd ios && pod install # run `pod install` in the `ios` directory.
echo "installing pods"
/Users/local/.gem/ruby/2.6.0/bin pod install
# /usr/local/opt/ruby@3.1/bin pod install
exit 0
