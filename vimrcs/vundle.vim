
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

Plugin 'junegunn/fzf'

Plugin 'terryma/vim-multiple-cursors'

Plugin 'itchyny/lightline.vim'

Plugin 'scrooloose/nerdtree'

Plugin 'tpope/vim-eunuch'

Plugin 'mileszs/ack.vim'

Plugin 'junegunn/goyo.vim'

Plugin 'airblade/vim-gitgutter'

Plugin 'maxbrunsfeld/vim-yankstack'

" Color schemes
Plugin 'crucerucalin/peaksea.vim' 
Plugin 'sjl/badwolf'
Plugin 'flazz/vim-colorschemes'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
