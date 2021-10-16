#!/bin/bash


function usage()
{
    echo "Script used to initialize environment with packages, configurations, fixing permissions and other various common procedures for new environments."
    echo ""
    echo "./init.sh"
    echo "\t-h --help"
    echo "\t--all Install all supported features"
    echo "\t--nvim Install NeoVim and add user configs."
    echo "\t--lvim Install LunarVim and add user configs."
    echo "\t-P --packages Install deb/rpm packages defined by user."
    echo "\t-d --docker Fix docker permissions and allow it to work without sudo access"
    echo "\t-r --rust Install rust and some rustup packages."
    echo "\t-n --npm Install Node/NPM and some npm packages."
    echo "\t-p --pip Install pip packages"
    echo "\t-s --shell Install ZSH shell with Oh-My-Zsh and add user zshrc."
    echo ""
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        --all)
            INSTALL_ALL=true
            ;;
        --nvim)
            INSTALL_NVIM=true
            ;;
        --lvim)
            INSTALL_LVIM=true
            ;;
        -P | --packages)
            INSTALL_PACKAGES=true
            ;;
        -d | --docker)
            INSTALL_DOCKER=true
            ;;
        -r | --rust)
            INSTALL_rust=true
            ;;
        -n | --npm)
            INSTALL_NPM=true
            ;;
        -p | --pip)
            INSTALL_PIP=true
            ;;
        -s | --shell)
            INSTALL_SHELL=true
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

packages="zsh \
scala \
git vim curl \
gcc clang cmake \
ack \
docker docker-compose \
synapse \
npm \
emacs \
rsync \
gnome-tweak-tool \
tlp \
libreoffice \
vlc \
p7zip \
gnome-system-monitor \
htop \
gparted \
snapd \
ripgrep \
google-chrome-stable \
xclip \
bat fzf"

prepend_comment() {
	if test -f "$1"; then
		echo "Commenting $1"
		awk '{print "# "$0}' $1 >$1
	fi
}

install_packages_yum() {
	sudo yum update -y
	sudo yum upgrade -y
	sudo yum install -y $packages
	sudo yum autoremove
}

install_packages_dnf() {
	sudo dnf install -y fedora-workstation-repositories
	sudo dnf config-manager --set-enabled google-chrome
	sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

	sudo dnf update -y
	sudo dnf upgrade -y

	sudo dnf install -y $packages
	sudo dnf install -y \
		gcc-go golang-bin \
		python39 \
		python2-devel python3-devel \
		icedtea-web java-1.8.0-openjdk java-latest-openjdk \
		the_silver_searcher

	sudo dnf group install "Java Development" -y
	sudo dnf autoremove -y
}

install_packages_apt() {
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt install -y $packages
	sudo apt install -y \
		gccgo golang \
		openjdk-8-jdk \
		openjdk-17-jdk \
		python3.9
	sudo apt autoremove -y
}

install_packages() {
	echo "Installing Packages..."

	if command -v apt &>/dev/null; then
		install_packages_apt
	elif command -v dnf &>/dev/null; then
		install_packages_dnf
	elif command -v yum &>/dev/null; then
		install_packages_yum
	else
		echo "Error: Not handled package manager!"
		exit 1
	fi
	echo "Done Installing Packages..."

    # configure bat syntax highlighting
    if [[ -f /usr/bin/batcat  && ! -f ~/.local/bin/bat ]]; then
        mkdir -p ~/.local/bin
        ln -s /usr/bin/batcat ~/.local/bin/bat
    fi

}

install_npm() {

  # Install NVM
  curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
  nvm install node --lts

  # Using NPM without sudo
  echo "Installing Npm Stuff..."
  mkdir -p ~/.npm-global
  npm config set prefix '~/.npm-global'

  # Update NPM to latest version
  npm install -g npm@latest

  # npm packages
  npm install -g \
      bash-language-server \
      gtop \
      diff-so-fancy
  echo "Done Installing Npm Stuff..."
}

install_rust() {

  # install rustlang stuff
  echo "Installing Rust..."
  curl https://sh.rustup.rs -sSf | sh
  rustup component add rls rust-analysis rust-src rustfmt
  cargo install mdbook
  echo "Done Installing Rust..."
}

install_pip() {
  # python packages
  pip3 install pynvim
}

install_nvim() {

  # Prepare config files
  prepend_comment ~/.vimrc
  echo source ~/.dotfiles/.vimrc >>~/.vimrc

  prepend_comment ~/.ideavimrc
  echo source ~/.dotfiles/.ideavimrc >>~/.ideavimrc

  prepend_comment ~/.vrapperrc
  echo source ~/.dotfiles/.vrapperrc >>~/.vrapperrc

  mkdir -p ~/.config/nvim
  prepend_comment ~/.config/nvim/init.vim
  echo source ~/.dotfiles/.vimrc >>~/.config/nvim/init.vim

  ln -s ~/.dotfiles/vimrcs/coc-settings.json ~/.config/nvim/coc-settings.json || echo "Unable to create soft link to nvim:coc-settings.json"

  mkdir -p ~/.config/efm-langserver
  ln -s ~/.dotfiles/efm-config.yaml ~/.config/efm-langserver/config.yaml || echo "Unable to create soft link to nvim:efm-langserver"

  # install neovim and all packages
  echo "Installing Neovim..."
  curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  mkdir -p ~/bin
  mv nvim.appimage ~/bin/nvim
  chmod u+x ~/bin/nvim
  nvim +PlugInstall +qall
  echo "Done Installing Neovim..."
  echo "Enjoy the Coolest Vim Ever..."
}

install_lvim() {

  yes | bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

  mkdir -p ~/.config/lvim/

  # Reference the lua files inside lvim runtime
  ln -s ~/.dotfiles/lvimrcs ~/.config/lvim/ || echo "Unable to create soft link to lvim:lvimrcs"

  # backup existing configuration
  if [ -f ~/.config/lvim/config.lua ]; then
    mv ~/.config/lvim/config.lua{,.old}
  fi
  # Use the config file in lvimrcs
  echo 'require("lvimrcs/config")' > ~/.config/lvim/config.lua
}

fix_docker_permissions() {

  # Using docker without sudo
  sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker
  # fix permissions if folder already exists
  if [ -d /home/"$USER"/.docker/ ]; then
    sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
    sudo chmod g+rwx "$HOME/.docker" -R
  fi
  docker run hello-world
}

install_shell() {

    echo "Preparing Source Files..."
    prepend_comment ~/.bashrc
    echo source ~/.dotfiles/.bashrc >>~/.bashrc

    prepend_comment ~/.zshrc
    echo source ~/.dotfiles/.zshrc >>~/.zshrc

    echo "Done Preparing Source Files..."

    # install oh-my-zsh
    if [ ! -d ~/.oh-my-zsh ]; then
        echo "Installing Oh-my-zsh..."
        sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        echo "Done Installing Oh-my-zsh..."
    fi

    # set default shell to zsh
    chsh -s /bin/zsh
}

acquire_sudo_permissions() {
  sudo echo "Hello Sudo permissions!"
  sudo echo "LETS ROCK!"
  # if [[ $UID != 0 ]]; then
  #     echo "Please run this script with sudo:"
  #     echo "sudo $0 $*"
  #     exit 1
  # fi
}

if [ -z $1 ]; then
    usage
    exit 0
fi

# Require sudo at start
acquire_sudo_permissions

if [[ ! -z $INSTALL_ALL || ! -z $INSTALL_PACKAGES ]]; then
    install_packages
fi
if [[ ! -z $INSTALL_ALL || ! -z $INSTALL_NPM ]]; then
    install_npm
fi
if [[ ! -z $INSTALL_ALL || ! -z $INSTALL_RUST ]]; then
    install_rust
fi
if [[ ! -z $INSTALL_ALL || ! -z $INSTALL_PIP ]]; then
    install_pip
fi
if [[ ! -z $INSTALL_ALL || ! -z $INSTALL_NVIM ]]; then
    install_nvim
fi
if [[ ! -z $INSTALL_ALL || ! -z $INSTALL_LVIM ]]; then
    install_lvim
fi
if [[ ! -z $INSTALL_ALL || ! -z $INSTALL_SHELL ]]; then
    install_shell
fi

if [[ ! -z $INSTALL_ALL || ! -z $INSTALL_DOCKER ]]; then
    fix_docker_permissions
fi
