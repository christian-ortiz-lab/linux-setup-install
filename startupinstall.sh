#!/bin/bash

# Getting install date
echo "Today is $(date)"
echo "User: $(whoami)"

echo "###################"
echo "Starting Software Install Script"
echo "###################"

# Update and Upgrade System
echo "Updating and Upgrading System"
sudo apt-get update && sudo apt-get upgrade -y

# Install Neofetch
echo "Installing Neofetch"
sudo apt install -y neofetch

# Install Zsh
echo "Installing Zsh"
sudo apt install -y zsh

# Install Oh-My-Zsh
echo "Installing Oh-My-Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Add PowerLevel10K for Oh-My-Zsh
echo "Adding PowerLevel10K theme for Oh-My-Zsh"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Define the path to the .zshrc file
ZSHRC_FILE="$HOME/.zshrc"

# Check if the .zshrc file exists
if [[ -f "$ZSHRC_FILE" ]]; then
    # Use sed to find and replace the ZSH_THEME line, setting its value to powerlevel10k/powerlevel10k
    sed -i.bak '/^ZSH_THEME=/s|=.*|="powerlevel10k/powerlevel10k"|' "$ZSHRC_FILE"
    echo "ZSH_THEME updated to powerlevel10k/powerlevel10k"
else
    echo "$ZSHRC_FILE not found!"
fi

# Define the path to the .zshrc file
ZSHRC="$HOME/.zshrc"

# Check if the .zshrc file exists
if [ -f "$ZSHRC" ]; then
    # Use sed to replace the line containing 'plugins=(git)' with the new plugin list
    sed -i 's/^plugins=(git)$/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)/' "$ZSHRC"
    
    # Apply the changes by sourcing the .zshrc
    source "$ZSHRC"
    
    echo "Plugins updated successfully."
else
    echo ".zshrc file not found."
fi

# Set Zsh as the default shell
echo "Setting Zsh as the default shell"
chsh -s $(which zsh)

echo "User Configured Zsh with PowerLevel10k"
echo "Please log out and log back in for the changes to take effect."

# Install Terminator
echo "Installing Terminator"
sudo apt-get install -y terminator
sudo update-alternatives --config x-terminal-emulator


# Install Neovim (with dependencies)
echo "Installing Neovim"
sudo apt update
sudo apt install -y make gcc ripgrep unzip git xclip curl

# Download and install Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# Make Neovim available in /usr/local/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/

# Clean up downloaded tar file
rm nvim-linux-x86_64.tar.gz

# Confirm Neovim installation
nvim --version

# Install AwesomeWM
echo "Installing AwesomeWM"
sudo apt install -y awesome

# Install necessary packages for AwesomeWM (optional, for better experience)
echo "Installing packages for AwesomeWM (optional)"
sudo apt install -y x11-xserver-utils lightdm rofi

# Confirm AwesomeWM installation
echo "AwesomeWM installation complete. You can start it using the command 'awesome'."

echo "Installing command-line fuzzy finder"
sudo apt install fzf
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

#installing Discord 
# Define the URL for downloading Discord
URL="https://discord.com/api/download?platform=linux"

# Define the output file name
OUTPUT="discord-linux.deb"

# Use wget to download the file
echo "Downloading Discord for Linux..."
wget -O "$OUTPUT" "$URL"

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Download completed successfully!"
else
    echo "Download failed!"
fi
#Installing Development Tools
sudo apt install build-essential
sudo apt install default-jre
sudo apt install default-jdk
sudo apt install -y python3 python3-pip
sudo apt install zathura
sudo apt install tmux

#Installing Virtual Box
sudo apt install virtualbox


echo "Installation Complete!"
