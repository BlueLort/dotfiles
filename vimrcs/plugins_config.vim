"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Important:
"       This requries that you install https://github.com/amix/vimrc !
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" => Load pathogen paths
""""""""""""""""""""""""""""""
"let s:vim_runtime = expand('<sfile>:p:h')."/.."
"call pathogen#infect(s:vim_runtime.'/sources_forked/{}')
"call pathogen#infect(s:vim_runtime.'/sources_non_forked/{}')
"call pathogen#infect(s:vim_runtime.'/my_plugins/{}')
"call pathogen#helptags()



""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>m :MRU<CR>


""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
let g:yankstack_yank_keys = ['y', 'd']

nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-n> <Plug>yankstack_substitute_newer_paste


""""""""""""""""""""""""""""""
" => FZF
""""""""""""""""""""""""""""""
nmap <c-f> :FZF<cr>

""""""""""""""""""""""""""""""
" => ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'

""""""""""""""""""""""""""""""
" => UltiSnips
""""""""""""""""""""""""""""""

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>n :NERDTreeFind<cr>
map <leader>N :NERDTreeFromBookmark<Space>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FormatCode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call glaive#Install()
Glaive codefmt clang_format_style="{IndentWidth: 4}"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:syntastic_python_checkers = ['mypy']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_java_checkers = []
let g:syntastic_scala_checkers = []
let g:syntastic_cpp_checkers = []



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rainbow Parentheses
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Deoplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:deoplete#enable_at_startup = 1
"if !exists('g:deoplete#omni#input_patterns')
  "let g:deoplete#omni#input_patterns = {}
"endif
"let g:deoplete#min_pattern_length = 1
"" Auto close the preview after the completion
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"" Using tab to cycle through suggestions
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Goyo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=1
nnoremap <silent> <leader>d :GitGutterToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>] :YcmCompleter GoTo<cr>
nmap <leader>[ :YcmCompleter GetDoc<cr>
"nmap <leader>J :lnext<cr>
"nmap <leader>K :lprevious<cr>
nmap <leader>yf :YcmCompleter FixIt<cr>
nmap <leader>yg :YcmCompleter GoToReferences<cr>
nmap <leader>yi :YcmCompleter OrganizeImports<cr>
nmap <leader>yr :YcmCompleter RefactorRename 
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_always_populate_location_list = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => pangloss/vim-javascript
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:javascript_plugin_jsdoc = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-js-pretty-template
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType javascript JsPreTmpl
autocmd FileType typescript syn clear foldBraces

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rust
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rust_clip_command = 'xclip -selection clipboard'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack searching and cope displaying
"    requires ack.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the the_silver_searcher if possible (much faster than Ack)
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

" Open Ack and put the cursor in the right position
map <leader>g :Ack  

" When you press g you Ack after the selected text
vnoremap <silent> <leader>g :call VisualSelection('gv', '')<CR>


" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

