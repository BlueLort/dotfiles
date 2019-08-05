prepend_comment() {
    if test -f "$1"; then
        echo "Commenting $1"
        awk '{print "# "$0}' $1 > $1
    fi
}

prepend_comment ~/.bashrc
echo source ~/.dotfiles/.bashrc >> ~/.bashrc >/dev/null

prepend_comment ~/.zshrc
echo source ~/.dotfiles/.zshrc >> ~/.zshrc >/dev/null

prepend_comment ~/.vimrc
echo source ~/.dotfiles/.vimrc >> ~/.vimrc >/dev/null

mkdir -p ~/.config/nvim
prepend_comment ~/.config/nvim/init.vim
echo source ~/.dotfiles/.vimrc >> ~/.config/nvim/init.vim >/dev/null
