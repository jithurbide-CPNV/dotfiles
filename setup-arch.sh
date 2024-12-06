#!/bin/bash

source ./lib/include/log.sh
source ./lib/include/colors.sh
source ./lib/include/library.sh

clear

repo="jithurbide-CPNV/dotfiles"


# Required packages for the installer
packages=(
    "wget"
    "unzip"
    "gum"
    "rsync"
    "git"
    "base-devel"
)

latest_version=$(get_latest_release)


cat <<"EOF"
   ____         __       ____       
  /  _/__  ___ / /____ _/ / /__ ____
 _/ // _ \(_-</ __/ _ `/ / / -_) __/
/___/_//_/___/\__/\_,_/_/_/\__/_/   
                                    
EOF
echo "ML4W Dotfiles for Hyprland"
echo -e "${NONE}"
while true; do
    read -p "DO YOU WANT TO START THE INSTALLATION NOW? (Yy/Nn): " yn
    case $yn in
        [Yy]* )
            echo ":: Installation started."
            echo
        break;;
        [Nn]* ) 
            echo ":: Installation canceled"
            exit;
        break;;
        * ) 
            echo ":: Please answer yes or no."
        ;;
    esac
done

# Create Downloads folder if not exists
if [ ! -d ~/Downloads ]; then
    mkdir ~/Downloads
    echo ":: Downloads folder created"
fi 

# Remove existing download folder and zip files 
if [ -f $HOME/Downloads/dotfiles-main.zip ]; then
    rm $HOME/Downloads/dotfiles-main.zip
fi
if [ -f $HOME/Downloads/dotfiles-dev.zip ]; then
    rm $HOME/Downloads/dotfiles-dev.zip
fi
if [ -f $HOME/Downloads/dotfiles.zip ]; then
    rm $HOME/Downloads/dotfiles.zip
fi
if [ -d $HOME/Downloads/dotfiles ]; then
    rm -rf $HOME/Downloads/dotfiles
fi
if [ -d $HOME/Downloads/dotfiles_temp ]; then
    rm -rf $HOME/Downloads/dotfiles_temp
fi
if [ -d $HOME/Downloads/dotfiles-main ]; then
    rm -rf $HOME/Downloads/dotfiles-main
fi
if [ -d $HOME/Downloads/dotfiles-dev ]; then
    rm -rf $HOME/Downloads/dotfiles-dev
fi

# Synchronizing package databases
sudo pacman -Sy
echo

# Install required packages
echo ":: Checking that required packages are installed..."
_installPackages "${packages[@]}";
echo


# yay 
echo ":: Checking yay installed..."
_installYay;
echo



gum confirm "Are you ready to start the install?"
result=$?

if [ $result -eq 0 ]; then
    echo ":: Installing will start now."
else
    echo ":: Setup canceled"
    exit 130
fi

#
#starting package installation
figlet "Installing Base Packages"
source ./share/packages/arch/install.sh
install_packages "${packages[@]}"

figlet "Installing Hyprland Packages"
source ./share/packages/arch/hyprland.sh
install_packages "${packages[@]}"

# Start setup
gum confirm "Install is finish, did you want to reboot ?"
result=$?

if [ $result -eq 0 ]; then
    echo ":: Rebooting ..."
    sudo shutdown - h now
else
    echo ":: Setup complete, go in shell"
    exit 1
fi

#
#starting package installation
figlet "Installing Base Packages"
source ./share/packages/arch/install.sh
install_packages "${packages[@]}"

figlet "Installing Hyprland Packages"
source ./share/packages/arch/hyprland.sh
install_packages "${packages[@]}"

# Start setup

