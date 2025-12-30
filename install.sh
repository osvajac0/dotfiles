#!/bin/bash

# Dotfiles Installation Script for Arch Linux
# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Error tracking
ERRORS=()

# Function to center text
center_text() {
    local text="$1"
    local width=$(tput cols)
    local padding=$(( (width - ${#text}) / 2 ))
    printf "%${padding}s%s\n" "" "$text"
}

# Clear screen and display banner
clear
echo ""
echo -e "${GREEN}"
center_text "                                             "
center_text "▄▄▄▄▄▄                 ▄▄     ▄▄             "
center_text "███▀▀██▄        ██    ██  ▀▀  ██             "
center_text "███  ███ ▄███▄ ▀██▀▀ ▀██▀ ██  ██ ▄█▀█▄ ▄█▀▀▀ "
center_text "███  ███ ██ ██  ██    ██  ██  ██ ██▄█▀ ▀███▄ "
center_text "██████▀  ▀███▀  ██    ██  ██▄ ██ ▀█▄▄▄ ▄▄▄█▀ "
echo -e "${NC}"
echo ""
center_text "=== Installation Script ==="
echo ""
echo ""

# Get sudo password upfront
echo -e "${YELLOW}Please enter your password for sudo access:${NC}"
sudo -v

# Keep sudo alive
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Function to log errors
log_error() {
    ERRORS+=("$1")
}

# Check if we're in the dotfiles directory
if [ ! -d ".config" ] || [ ! -d "scripts" ]; then
    echo -e "${RED}Error: Please run this script from the dotfiles directory${NC}"
    exit 1
fi

DOTFILES_DIR=$(pwd)

echo -e "${GREEN}Step 1: Installing base dependencies...${NC}"
sudo pacman -S --needed --noconfirm base-devel git libx11 libxft libxinerama freetype2 fontconfig || log_error "Failed to install base dependencies"

echo -e "\n${GREEN}Step 2: Installing yay (AUR helper)...${NC}"
if ! command -v yay &> /dev/null; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm || log_error "Failed to install yay"
    cd "$DOTFILES_DIR"
else
    echo "yay is already installed"
fi

echo -e "\n${GREEN}Step 3: Compiling dwm, dmenu, slstatus, and slock...${NC}"

# Compile dwm
if [ -d "dwm" ]; then
    echo "Compiling dwm..."
    cd dwm
    sudo make clean install || log_error "Failed to compile dwm"
    cd "$DOTFILES_DIR"
else
    log_error "dwm directory not found"
fi

# Compile dmenu
if [ -d "dmenu" ]; then
    echo "Compiling dmenu..."
    cd dmenu
    sudo make clean install || log_error "Failed to compile dmenu"
    cd "$DOTFILES_DIR"
else
    log_error "dmenu directory not found"
fi

# Compile slstatus
if [ -d "slstatus" ]; then
    echo "Compiling slstatus..."
    cd slstatus
    sudo make clean install || log_error "Failed to compile slstatus"
    cd "$DOTFILES_DIR"
else
    log_error "slstatus directory not found"
fi

# Compile slock
if [ -d "slock" ]; then
    echo "Compiling slock..."
    cd slock
    sudo make clean install || log_error "Failed to compile slock"
    cd "$DOTFILES_DIR"
else
    log_error "slock directory not found"
fi

echo -e "\n${GREEN}Step 4: Optional package installation${NC}"
echo "Would you like to install the following packages?"
echo "- picom-ftlabs-git (AUR)"
echo "- flameshot"
echo "- firefox"
echo "- pywal"
echo "- alacritty"
echo "- brightnessctl"
echo "- kitty"
echo "- ncmpcpp"
echo "- mpd"
echo "- mpc"
echo "- nvim"
echo "- feh"
echo "- dunst"

read -p "Install these packages? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing packages..."
    
    # Install from official repos
    sudo pacman -S --needed --noconfirm flameshot firefox python-pywal alacritty brightnessctl kitty ncmpcpp mpd mpc neovim feh dunst || log_error "Failed to install some official packages"
    
    # Install from AUR
    yay -S --needed --noconfirm picom-ftlabs-git || log_error "Failed to install picom-ftlabs-git"
fi

echo -e "\n${GREEN}Step 5: Copying configuration files...${NC}"

# Create .config directory if it doesn't exist
mkdir -p ~/.config

# Copy all folders from .config to ~/.config
if [ -d ".config" ]; then
    echo "Copying .config files..."
    cp -r .config/* ~/.config/ || log_error "Failed to copy .config files"
else
    log_error ".config directory not found"
fi

# Copy .bashrc to home directory
if [ -f ".bashrc" ]; then
    echo "Copying .bashrc..."
    cp .bashrc ~/ || log_error "Failed to copy .bashrc"
else
    log_error ".bashrc not found"
fi

echo -e "\n${GREEN}Step 6: Installing scripts...${NC}"

# Copy scripts to /bin
if [ -d "scripts" ]; then
    echo "Copying scripts to /usr/local/bin..."
    sudo cp -r scripts/* /usr/local/bin/ || log_error "Failed to copy scripts"
    sudo chmod +x /usr/local/bin/* || log_error "Failed to set execute permissions on scripts"
else
    log_error "scripts directory not found"
fi

echo -e "\n${GREEN}Step 7: Setting up pywal configuration...${NC}"

# Copy .Xresources to home
if [ -f "pywal/.Xresources" ]; then
    echo "Copying .Xresources..."
    cp pywal/.Xresources ~/ || log_error "Failed to copy .Xresources"
else
    log_error "pywal/.Xresources not found"
fi

# Copy dwm.Xresources template to pywal templates
PYWAL_TEMPLATE_DIR="/usr/lib/python3.13/site-packages/pywal/templates"
if [ -f "pywal/dwm.Xresources" ]; then
    echo "Copying dwm.Xresources template..."
    sudo mkdir -p "$PYWAL_TEMPLATE_DIR"
    sudo cp pywal/dwm.Xresources "$PYWAL_TEMPLATE_DIR/" || log_error "Failed to copy dwm.Xresources template"
else
    log_error "pywal/dwm.Xresources not found"
fi

echo -e "\n${GREEN}=== Installation Complete ===${NC}\n"

# Display errors if any
if [ ${#ERRORS[@]} -gt 0 ]; then
    echo -e "${RED}Errors occurred during installation:${NC}"
    for error in "${ERRORS[@]}"; do
        echo -e "${RED}- $error${NC}"
    done
    exit 1
else
    echo -e "${GREEN}No errors detected!${NC}"
    echo -e "${YELLOW}Please restart your system or log out and log back in for all changes to take effect.${NC}"
fi
