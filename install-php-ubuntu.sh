#!/bin/bash

# Freshly installs any PHP version into an existing Ubuntu system.
#
# ** WARNING **
# !!! ALL currently installed PHP versions will be REMOVED PERMANENTLY !!!
#
# This script is intended for setting up a development environment quickly.
# Due to its destructive purging, this is NOT SUITABLE FOR DEPLOYMENT purposes.


#
# ---- SETTINGS ----
#

# Configure the PHP version to install, change as needed.
PhpVersionString="8.0"

# Configure a list of PHP extensions to install, change as needed.
# The essential `common` and `cli` PHP packages for the desired PHP version will always be installed first.
PhpExtensions="bcmath bz2 ctype curl fileinfo intl mbstring pcov pdo readline tokenizer xdebug xml zip"


#
# ---- EXECUTION ----
#

# Purge any currently installed PHP versions from the system.
# This also removes any related configuration files.
sudo apt purge '^php5*'
sudo apt purge '^php7*'
sudo apt purge '^php8*'

# Add `ondrej/php` PPA and update sources
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update

# Remove unneeded packages.
sudo apt-get auto-remove

# Compose the package name prefix once.
PackageNamePrefix="php${PhpVersionString}-"

# Compose list of package names for `apt install` command.
AllPackages=""
PhpExtensions="common cli $PhpExtensions"
for ExtensionName in $PhpExtensions
do
    FullPackageName="${PackageNamePrefix}${ExtensionName}"
    AllPackages="${AllPackages} ${FullPackageName}"
done

# Install all packages at once.
sudo apt install $AllPackages -y


# --- DONE ---

echo
echo "Installation complete"
echo
php -v
php -r 'echo PHP_EOL . "Happy Coding, friend! (PHP v" . PHP_VERSION . ")" . PHP_EOL;'
