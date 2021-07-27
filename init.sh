#!/bin/bash

packages="zsh \
scala \
git vim curl \
gcc clang cmake \
ack \
docker docker-compose \
synapse \
npm \
python3-pip python3-tk \
emacs \
vim python3-neovim \
rsync \
gnome-tweak-tool \
tlp \
libreoffice \
vlc \
p7zip \
gnome-system-monitor \
gparted \
nodejs \
snapd \
openjdk-8-jdk \
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
	sudo yum update
	sudo yum upgrade -y
	sudo yum install -y $packages
	sudo yum autoremove
}

install_packages_dnf() {
	sudo dnf install -y fedora-workstation-repositories
	sudo dnf config-manager --set-enabled google-chrome
	sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

	sudo dnf update
	sudo dnf upgrade -y

	sudo dnf install -y $packages
	sudo dnf install -y \
		gcc-go golang-bin \
		python39 \
		python2-devel python3-devel \
		icedtea-web java-openjdk java-1.8.0-openjdk-devel \
		the_silver_searcher

	sudo dnf group install "Java Development" -y
	sudo dnf autoremove -y
}

install_packages_apt() {
	sudo apt update
	sudo apt upgrade -y
	sudo apt install -y $packages
	sudo apt install -y \
		gccgo golang \
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

	# install rustlang stuff
	echo "Installing Rust..."
	curl https://sh.rustup.rs -sSf | sh
	rustup component add rls rust-analysis rust-src
	cargo install mdbook
	echo "Done Installing Rust..."

	# Using NPM without sudo
	echo "Installing Npm Stuff..."
	mkdir -p ~/.npm-global
	npm config set prefix '~/.npm-global'

	# npm packages
	sudo npm i -g \
		bash-language-server \
		gtop \
		diff-so-fancy
	echo "Done Installing Npm Stuff..."

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

# Require sudo at start
sudo echo "Hello Sudo permissions!"
sudo echo "LETS ROCK!"
# if [[ $UID != 0 ]]; then
#     echo "Please run this script with sudo:"
#     echo "sudo $0 $*"
#     exit 1
# fi

install_packages

echo "Preparing Source Files..."
prepend_comment ~/.bashrc
echo source ~/.dotfiles/.bashrc >>~/.bashrc

prepend_comment ~/.zshrc
echo source ~/.dotfiles/.zshrc >>~/.zshrc

prepend_comment ~/.vimrc
echo source ~/.dotfiles/.vimrc >>~/.vimrc

prepend_comment ~/.ideavimrc
echo source ~/.dotfiles/.ideavimrc >>~/.ideavimrc

prepend_comment ~/.vrapperrc
echo source ~/.dotfiles/.vrapperrc >>~/.vrapperrc

mkdir -p ~/.config/nvim
prepend_comment ~/.config/nvim/init.vim
echo source ~/.dotfiles/.vimrc >>~/.config/nvim/init.vim

ln -s ~/.dotfiles/vimrcs/coc-settings.json ~/.config/nvim/coc-settings.json

mkdir -p ~/.config/efm-langserver
ln -s ~/.dotfiles/efm-config.yaml ~/.config/efm-langserver/config.yaml

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

# configure bat syntax highlighting
mkdir -p ~/.local/bin
if [ -f /usr/bin/batcat ]; then
	ln -s /usr/bin/batcat ~/.local/bin/bat
fi

if [ -f /usr/bin/batcat ]; then
	mkdir -p ~/.local/bin
	ln -s /usr/bin/batcat ~/.local/bin/bat
fi

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
