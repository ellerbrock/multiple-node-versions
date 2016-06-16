![logo](https://github.frapsoft.com/top/nodejs-logo.png)

Multiple Node Versions [![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://github.com/ellerbrock/open-source-badge/) [![Gitter Chat](https://badges.gitter.im/frapsoft/frapsoft.svg)](https://gitter.im/frapsoft/frapsoft/)
==============================================================================================================================================================================================================================================================

**Quick and Dirty Setup for the lazy!**

Cleanup your old messed up Node.js installation and get you running with a new fresh and funky [nvm](https://github.com/creationix/nvm) enviroment with multiple Node Versions on OS X.

You can download the [setup.sh](https://github.com/ellerbrock/multiple-node-versions/blob/master/setup.sh) or run the Script directly via:

`curl -s -L https://raw.githubusercontent.com/ellerbrock/multiple-node-versions/master/setup.sh -o setup.sh; bash setup.sh`

![multiple node versions](https://github.frapsoft.com/screenshots/multiple-node-versions.jpg)

Functionality
-------------

-	find Node versions installed via Homebrew

	-	uninstall this version?

-	delete old Node, npm and nvm folders?

-	download and install nvm?

-	install Node LTS 4.4.5?

	-	install node-gyp for this version?
	-	install Typescript for this version?
	-	install useful Development Tools for this version?

-	install Node latest version?

	-	install node-gyp for this version?
	-	install Typescript for this version?
	-	install useful Development Tools for this version?

Cleanup
-------

```bash
sudo rm -rf /usr/local/lib/node*
sudo rm -f /usr/local/bin/npm
sudo rm -f /usr/local/bin/node
sudo rm -rf /usr/local/include/node*
sudo rm -f /usr/local/share/man/man1/node.1
sudo rm -f /var/db/receipts/org.nodejs.*
sudo rm -rf ~/.npm
sudo rm -rf ~/.nvm
sudo rm -rf ~/.node-gyp
```

TypeScript Modules
------------------

-	[TypeScript](https://www.npmjs.com/package/typescript) - TypeScript is a language for application scale JavaScript development
-	[tslint](https://www.npmjs.com/package/tslint) - An extensible static analysis linter for the TypeScript language
-	[typings](https://www.npmjs.com/package/typings) - The TypeScript Definition Manager.

Development Modules
-------------------

-	[nodemon](https://www.npmjs.com/package/nodemon) - Monitor script for development of a node.js app.
-	[pm2](https://www.npmjs.com/package/pm2) - Production process manager for Node.JS applications with a built-in load balancer.
-	[node-inspector](https://www.npmjs.com/package/node-inspector) - Web Inspector based nodeJS debugger
-	[npm-check-updates](https://www.npmjs.com/package/npm-check-updates) - Find newer versions of dependencies than what your package.json or bower.json allows
-	[np](https://www.npmjs.com/package/np) - A better npm publish
-	[npm-name](https://www.npmjs.com/package/npm-name) - Check whether a package name is available on npm

This script is meant to be a skeleton. Best way to use it is to make a fork and change it for your individual needs with all the modules and versions you prefere. Your very welcome to make a pull request to bring more functionality ...

### Optional Parameter

-	`setup.sh delnode` - run cleanup process
-	`setup.sh brewnode` - search for node installation via brew with uninstall option
-	`setup.sh nvm` - download and install nvm
-	`setup.sh modules` - install npm modules
-	`setup.sh nodelts` - install Node LTS 4.4.5
-	`setup.sh nodelatest` - install Node latest version

or just run `./setup.sh` to walk through the steps ...

### Source

```bash
#!/usr/bin/env bash
#
#   /$$$$$$$$                                                /$$$$$$   /$$
#  | $$_____/                                               /$$__  $$ | $$
#  | $$     /$$$$$$  /$$$$$$   /$$$$$$   /$$$$$$$  /$$$$$$ | $$  \__//$$$$$$
#  | $$$$$ /$$__  $$|____  $$ /$$__  $$ /$$_____/ /$$__  $$| $$$$   |_  $$_/
#  | $$__/| $$  \__/ /$$$$$$$| $$  \ $$|  $$$$$$ | $$  \ $$| $$_/     | $$
#  | $$   | $$      /$$__  $$| $$  | $$ \____  $$| $$  | $$| $$       | $$ /$$
#  | $$   | $$     |  $$$$$$$| $$$$$$$/ /$$$$$$$/|  $$$$$$/| $$       |  $$$$/
#  |__/   |__/      \_______/| $$____/ |_______/  \______/ |__/        \___/
#                            | $$
#                            | $$
#                            |__/
#
#   Developer     Maik Ellerbrock
#   GitHub        https://github.com/ellerbrock
#
#   Company       Frapsoft Web Agency
#
#   Twitter       https://twitter.com/frapsoft
#   Facebook      https://facebook.com/frapsoft
#   Homepage      https://frapsoft.com
#
#   Version       1.0.0
#
#
#   Information
#   -----------
#   Shell Script to install Node via nvm


# Configuration
# -------------

NVM_URL="https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh "
BREW_PATH="/usr/local/bin/brew"
BREW_FOUND=false
NVM_LOADED=false

# Functions
# ---------

ascii_font()
{
clear
echo ''
echo '                              $$\'
echo '                              $$ |'
echo '    $$$$$$$\   $$$$$$\   $$$$$$$ | $$$$$$\      $$\  $$$$$$$\'
echo '    $$  __$$\ $$  __$$\ $$  __$$ |$$  __$$\     \__|$$  _____|'
echo '    $$ |  $$ |$$ /  $$ |$$ /  $$ |$$$$$$$$ |    $$\ \$$$$$$\'
echo '    $$ |  $$ |$$ |  $$ |$$ |  $$ |$$   ____|    $$ | \____$$\'
echo '    $$ |  $$ |\$$$$$$  |\$$$$$$$ |\$$$$$$$\ $$\ $$ |$$$$$$$  |'
echo '    \__|  \__| \______/  \_______| \_______|\__|$$ |\_______/'
echo '                                          $$\   $$ |'
echo '                                          \$$$$$$  |'
echo '                                           \______/'
echo ''
echo 'Quick and Dirty Node.js Setup via nvm'
echo '====================================='
}


brew_cleanup()
{
  echo ""
  read -p "search for brew node versions? (y/n) " -n 1 answere
  echo ""
  if [[ $answere == "y" || $answere == "Y" ]]; then
    if [ -x $BREW_PATH ]; then
      for ver in `brew list -1 | grep ^node`
        do
          BREW_FOUND=true
          echo ""
          read -p "uninstall $ver?? (y/n) " -n 1 answere
          if [[ $answere == "y" || $answere == "Y" ]]; then
            echo ""
            echo "  => uninstalling $ver"
            brew uninstall $ver
          fi
        done

        if [ $BREW_FOUND == false ]; then
          echo ""
          echo "  => no node version installed with homebrew"
        fi

        echo ""
        read -p "update and cleanup brew? (y/n) " -n 1 answere
        echo ""
          if [[ $answere == "y" || $answere == "Y" ]]; then
            echo "  => updating and cleaning brew ..."
            brew prune && brew doctor
            brew update && brew upgrade
          fi
    else
      echo "seems you dont have homebrew installed ..."
    fi
  fi
}


delete_node_folders()
{
  echo ""
  read -p "delete node, npm and nvm folders? (y/n) " -n 1 answere
  echo ""
  if [[ $answere == "y" || $answere == "Y" ]]; then
    echo "  => deleting folders ..."
    sudo rm -rf /usr/local/lib/node*
    sudo rm -f /usr/local/bin/npm
    sudo rm -f /usr/local/bin/node
    sudo rm -rf /usr/local/include/node*
    sudo rm -f /usr/local/share/man/man1/node.1
    sudo rm -f /var/db/receipts/org.nodejs.*
    sudo rm -rf ~/.npm
    sudo rm -rf ~/.nvm
    sudo rm -rf ~/.node-gyp
  fi
}


install_nvm()
{
  echo ""
  read -p "install nvm? (y/n) " -n 1 answere
  echo ""
  if [[ $answere == "y" || $answere == "Y" ]]; then
    echo "  => installing nvm ..."
    curl -o- $NVM_URL| bash
    set_nvm_env
  fi
}


install_node_lts()
{
  test $NVM_LOADED || set_nvm_env

  echo ""
  read -p "install node 4.4.5 lts? (y/n) " -n 1 answere
  echo ""
  if [[ $answere == "y" || $answere == "Y" ]]; then
    echo "  => installing node lts ..."
    nvm install 4.4.5
    nvm alias lts 4.4.5
    nvm use lts
    npm update && npm upgrade -g
  fi
}


install_node_latest()
{
  test $NVM_LOADED || set_nvm_env

  echo ""
  read -p "install node latest version? (y/n) " -n 1 answere
  echo ""
  if [[ $answere == "y" || $answere == "Y" ]]; then
    echo "  => installing node latest ..."
    nvm install node
    nvm alias default node
    nvm alias latest node
    nvm alias latest node
    nvm use node
    npm update && npm upgrade -g
  fi
}


install_modules()
{
  test $NVM_LOADED || set_nvm_env
  ver=`nvm current`

  echo ""
  read -p "install node-gyp for node $ver? (y/n) " -n 1 answere
  echo ""
  if [[ $answere == "y" || $answere == "Y" ]]; then
    echo "  => installing node-gyp for node version $ver ..."
    npm i -g node-gyp
  fi

  echo ""
  read -p "install some useful development tools for node $ver? (y/n) " -n 1 answere
  echo ""
  if [[ $answere == "y" || $answere == "Y" ]]; then
    echo "  => installing developer modules for node $ver ..."
    npm i -g npm-check-updates np npm-name nodemon pm2 node-inspector
  fi

  echo ""
  read -p "install typescript for node $ver? (y/n) " -n 1 answere
  echo ""
  if [[ $answere == "y" || $answere == "Y" ]]; then
    echo "  => installing typescript for node version $ver ..."
    npm i -g typescript@next tslint@next typings
  fi
}


set_nvm_env()
{
  if [ -f "$NVM_DIR/nvm.sh" ]; then
    source $NVM_DIR/nvm.sh
    NVM_LOADED=true
  else
    echo "cant load the nvm enviroment. is nvm installed?"
  fi
}

# run script
ascii_font

case "$1" in
  delnode)
    delete_node_folders
  ;;
  brewnode)
    brew_cleanup
  ;;
  nvm)
    install_nvm
  ;;
  modules)
    install_modules
  ;;
  nodelts)
    install_node_lts
  ;;
  nodelatest)
    install_node_latest
  ;;
  *)
    set_nvm_env
    brew_cleanup
    delete_node_folders
    install_nvm
    install_node_lts
    install_modules
    install_node_latest
    install_modules
  ;;
esac
```
### Contact / Social Media

*Get the latest News about Web Development, Open Source, Tooling, Server & Security*

[![Twitter](https://github.frapsoft.com/social/twitter.png)](https://twitter.com/frapsoft/)[![Facebook](https://github.frapsoft.com/social/facebook.png)](https://www.facebook.com/frapsoft/)[![Google+](https://github.frapsoft.com/social/google-plus.png)](https://plus.google.com/116540931335841862774)[![Gitter](https://github.frapsoft.com/social/gitter.png)](https://gitter.im/frapsoft/frapsoft/)[![Github](https://github.frapsoft.com/social/github.png)](https://github.com/ellerbrock/)

### Development by

Developer / Author: [Maik Ellerbrock](https://github.com/ellerbrock/)  
Company: [Frapsoft](https://github.com/frapsoft/)

### License 

Copyright (c) 2016 [Maik Ellerbrock](https://github.com/ellerbrock/)  

[![MIT Licence](https://badges.frapsoft.com/os/mit/mit-125x28.png?v=102)](https://opensource.org/licenses/mit-license.php)  

