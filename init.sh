prepend_comment() {
    if test -f "$1"; then
        echo "Commenting $1"
        awk '{print "# "$0}' $1 > $1
    fi
}

# prepend_comment ~/.bashrc
# echo source ~/.dotfiles/.bashrc >> ~/.bashrc

prepend_comment ~/.zshrc
echo source ~/.dotfiles/.zshrc >> ~/.zshrc

prepend_comment ~/.vimrc
echo source ~/.dotfiles/.vimrc >> ~/.vimrc

prepend_comment ~/.ideavimrc
echo source ~/.dotfiles/.ideavimrc >> ~/.ideavimrc

prepend_comment ~/.vrapperrc
echo source ~/.dotfiles/.vrapperrc >> ~/.vrapperrc

mkdir -p ~/.config/nvim
prepend_comment ~/.config/nvim/init.vim
echo source ~/.dotfiles/.vimrc >> ~/.config/nvim/init.vim

ln -s ~/.dotfiles/vimrcs/coc-settings.json ~/.config/nvim/coc-settings.json

mkdir -p ~/.config/efm-langserver
ln -s ~/.dotfiles/efm-config.yaml ~/.config/efm-langserver/config.yaml

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Using NPM without sudo
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'


# Using docker without sudo
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
# fix permissions if folder already exists
if [ -d /home/"$USER"/.docker/ ]
then
    sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
    sudo chmod g+rwx "$HOME/.docker" -R
fi
docker run hello-world


mkdir -p ~/.local/bin
if [ -f /usr/bin/batcat ]
then
    ln -s /usr/bin/batcat ~/.local/bin/bat
fi
