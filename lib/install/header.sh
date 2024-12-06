# ------------------------------------------------------
# Header
# ------------------------------------------------------
_writeLogHeader "Installation"
_writeLog 0 "Installation started"

clear
echo -e "${GREEN}"
cat <<"EOF"
   ___       __  ____ __      
  / _ \___  / /_/ _(_) /__ ___
 / // / _ \/ __/ _/ / / -_|_-<
/____/\___/\__/_//_/_/\__/___/
                                                        
EOF
echo "for Hyprland"
echo "by JustInTime"
echo -e "${NONE}"

echo "Version: $version"
echo "Platform: $install_platform" 
echo
# echo ":: You're running the script in $(pwd)"
if [[ $(_check_update) == "true" ]] ;then
    _writeLog 0 "An existing Dotfiles installation detected."
    _writeMessage "This script will guide you through the update process of the Dotfiles."
else
    _writeLog 0 "Initial installation of Dotfiles started."
    _writeMessage "This script will guide you through the installation process of the dotfiles."
fi