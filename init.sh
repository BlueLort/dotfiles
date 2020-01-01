prepend_comment() {
    if test -f "$1"; then
        echo "Commenting $1"
        awk '{print "# "$0}' $1 > $1
    fi
}

prepend_comment ~/.bashrc
echo source ~/.dotfiles/.bashrc >> ~/.bashrc

prepend_comment ~/.zshrc
echo source ~/.dotfiles/.zshrc >> ~/.zshrc

prepend_comment ~/.vimrc
echo source ~/.dotfiles/.vimrc >> ~/.vimrc

mkdir -p ~/.config/nvim
prepend_comment ~/.config/nvim/init.vim
echo source ~/.dotfiles/.vimrc >> ~/.config/nvim/init.vim

ln -s ~/.dotfiles/vimrcs/coc-settings.json ~/.config/nvim/coc-settings.json

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
