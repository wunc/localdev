# Local.dev

A setup for local web development on Mac with Laravel Valet.

This includes an install script to get all the tools and keeps track of all the components in a Brewfile and Gemfile.

## Prerequisites

- macOS
- Xcode (install from the Mac App store)

## Components

- Homebrew
- Nginx
- PHP
- MySQL
- Node.js
    - NPM
    - Yarn
- Ruby
    - Sass
    - Capistrano
- Git
- Mailhog
- Composer
- DNS Masq
- Laravel Valet

## Installation

Clone this repo and run the install script.

```
git clone git@github.com:wunc/localdev.git
cd localdev
bash install.sh
```

The install script does the following:

- adds the proper paths needed to run the tools
- stops the macOS built-in Apache server
- installs Xcode command-line tools (needed for some Homebrew installs)
- installs Homebrew
- installs the server components using Homebrew Bundler
- installs the Ruby components using Ruby Bundler
- installs Laravel Valet

After that, change to the directory where you have your sites, and inform Valet that is where they are:

```
cd ~/Sites
valet park
```

## Usage

See the [Laravel Valet documentation](https://laravel.com/docs/master/valet).

Alternatively, you can also manually start and stop the components using `brew services`.

```
brew services list
```

See the [Homebrew Services documentation](https://github.com/Homebrew/homebrew-services) for more info.