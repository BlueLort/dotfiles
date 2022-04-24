
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

" Syntax for Typescript
Plug 'HerringtonDarkholme/yats.vim'

" Syntax highlighting for multiple langs
Plug 'sheerun/vim-polyglot' 
" Language servers
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-rls', 'coc-python', 'coc-omnisharp', 'coc-docker', 'coc-snippets']

" INVESTIGATE
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Shows indent lines
Plug 'Yggdroot/indentLine'

" For making comments on most filetypes
Plug 'scrooloose/nerdcommenter'

" Fzf <3
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'

" Using multiple cursors on different places in the same time with ctrl n
Plug 'terryma/vim-multiple-cursors'

" Cool status line
Plug 'itchyny/lightline.vim'

" Files navigation
Plug 'scrooloose/nerdtree'
" Adding git indications in nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'

" Case preserving string replacement in vim
Plug 'tpope/vim-abolish'


" Vim sugar for the UNIX shell commands
Plug 'tpope/vim-eunuch'

" Ripgrep for quick string matching
Plug 'jremmen/vim-ripgrep'

" Fullscreen mode with <leader> z
Plug 'junegunn/goyo.vim'

" Shows lines that are modified from git
Plug 'airblade/vim-gitgutter'

" INVESTIGATE
Plug 'maxbrunsfeld/vim-yankstack'

" INVESTIGATE
Plug 'vim-syntastic/syntastic'

" Shows most recently used files <leader> m
Plug 'yegappan/mru'

" INVESTIGATE
Plug 'kien/rainbow_parentheses.vim'

" INVESTIGATE
Plug 'machakann/vim-swap'

" Cool intro screen with a cow
Plug 'mhinz/vim-startify'

" Auto close brackets
Plug 'jiangmiao/auto-pairs'

" Create directories automatically for files
Plug 'duggiefresh/vim-easydir'

" INVESTIGATE
Plug 'mattn/emmet-vim'

" INVESTIGATE ALL BELOW
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
" CHECK IF BETTER THAN GOOGLE CODEFMT
Plug 'sbdchd/neoformat'

" INVESTIGATE
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
Plug 'ayu-theme/ayu-vim' 
Plug 'chrisbra/csv.vim'

call plug#end()
