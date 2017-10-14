#!/bin/bash

# Adds the parameter to the user's path and login script
addtopath () {
    if ! echo "$PATH" | grep -Eq "(^|:)$1($|:)" ; then
        if [ "$2" = "after" ] ; then
            echo "Appending $1 after PATH"
            PATH="$PATH:$1"
            echo "export PATH=\$PATH:$1" >> ~/.bash_profile
            echo "export PATH=\$PATH:$1" >> ~/.zshrc
        else
            echo "Prepending $1 to PATH"
            PATH="$1:$PATH"
            echo "export PATH=$1:\$PATH" >> ~/.bash_profile
            echo "export PATH=$1:\$PATH" >> ~/.zshrc
        fi
    fi
}

addtopath "/usr/local/bin"
addtopath "$HOME/.composer/vendor/bin" after

# Unload the built-in Apache
echo "[Local.dev] Unloading Apache..."
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist

# Make sure Xcode is in order:
# Command line tools install and license acceptance
echo "[Local.dev] Getting Xcode in order..."
xcode-select --install
sudo xcodebuild -license accept

# Homebrew
echo "[Local.dev] Installing Homebrew..."
if ! hash brew 2>/dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Homebrew fomulas
echo "[Local.dev] Installing Homebrew formulas..."
brew bundle

# Install mhsendmail
echo "[Local.dev] Installing Mailhog sendmail..."
sudo curl -J -L -o /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_darwin_amd64
sudo chmod +x /usr/local/bin/mhsendmail
cp ./php-mhsendmail.ini /usr/local/etc/php/7.1/conf.d/

# Install Ruby things
echo "[Local.dev] Installing Ruby and the Gems..."
gem update --system
gem install bundler
bundle install

# Install Laravel Valet
echo "[Local.dev] Installing Laravel Valet..."
composer global require laravel/valet
valet install
