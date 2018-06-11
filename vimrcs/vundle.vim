
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'Valloric/YouCompleteMe'

Plugin 'junegunn/fzf'

Plugin 'terryma/vim-multiple-cursors'

Plugin 'itchyny/lightline.vim'

Plugin 'scrooloose/nerdtree'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

Plugin 'mileszs/ack.vim'

Plugin 'junegunn/goyo.vim'

Plugin 'airblade/vim-gitgutter'

Plugin 'crucerucalin/peaksea.vim' 
Plugin 'sjl/badwolf'

Plugin 'maxbrunsfeld/vim-yankstack'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
