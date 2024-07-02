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
which flutter
#export PATH=$HOME/development/flutter/bin:$PATH
# echo $HOME/development/flutter/
# echo "1 podhelper start"
# cat $HOME/flutter/packages/flutter_tools/bin/podhelper.rb
# echo "1 podhelper done"
echo "sed start"
sed -i'' -e 's/File.exists/File.exist/g' $HOME/flutter/packages/flutter_tools/bin/podhelper.rb
echo "sed end"
# echo "start file"
# cat $HOME/flutter/packages/flutter_tools/bin/podhelper.rb
# echo "start file sed review complete"

flutter --version
# Install Flutter artifacts for iOS (--ios), or macOS (--macos) platforms.
flutter precache --ios
# Install Flutter dependencies.
flutter pub get

# Install CocoaPods using Homebrew.
HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates.
brew install cocoapods
echo "change to ios folder"
cd /Volumes/workspace/repository/ios
pwd
pod install

exit 0
