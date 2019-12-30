
if empty(glob('~/.vim/autoload/plug.vim'))
 	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	    			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
 	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
	    			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'VundleVim/Vundle.vim'

Plug 'Valloric/YouCompleteMe'
"if has('nvim')
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
  "Plug 'Shougo/deoplete.nvim'
  "Plug 'roxma/nvim-yarp'
  "Plug 'roxma/vim-hug-neovim-rpc'
"endif Plug 'zchee/deoplete-clang'

Plug 'vim/killersheep'

Plug 'scrooloose/nerdcommenter'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'junegunn/fzf'

Plug 'terryma/vim-multiple-cursors'

Plug 'itchyny/lightline.vim'

Plug 'scrooloose/nerdtree'

Plug 'tpope/vim-eunuch'

Plug 'mileszs/ack.vim'
"Plug 'gabesoft/vim-ags'
"Plug 'jremmen/vim-ripgrep'

Plug 'junegunn/goyo.vim'

Plug 'airblade/vim-gitgutter'

Plug 'maxbrunsfeld/vim-yankstack'

Plug 'tell-k/vim-autopep8'

Plug 'vim-syntastic/syntastic'

Plug 'rust-lang/rust.vim'

Plug 'yegappan/mru'

Plug 'kien/rainbow_parentheses.vim'

Plug 'machakann/vim-swap'

Plug 'mhinz/vim-startify'

Plug 'jiangmiao/auto-pairs'

Plug 'mattn/emmet-vim'

Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

Plug 'pangloss/vim-javascript'
Plug 'Quramy/vim-js-pretty-template'

" Other plugins require curl
if executable("curl")

    " Webapi: Dependency of Gist-vim
    Plug 'mattn/webapi-vim'

    " Gist: Post text to gist.github
    Plug 'mattn/gist-vim'
endif

" Color schemes
Plug 'arcticicestudio/nord-vim'
Plug 'crucerucalin/peaksea.vim' 
Plug 'sjl/badwolf'
Plug 'flazz/vim-colorschemes'

call plug#end()
