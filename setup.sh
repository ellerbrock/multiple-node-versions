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
#   Version       0.0.1
#
#
#   Information
#   -----------
#   Shell Script to install Node via nvm


# Configuration
# -------------
{

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
            brew update && brew upgrade -g
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
    sudo rm -rf /usr/local/share/man/man1/node.1
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
}
