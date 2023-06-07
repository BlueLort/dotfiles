source ~/.dotfiles/vimrcs/basic.vim
source ~/.dotfiles/vimrcs/plug.vim
source ~/.dotfiles/vimrcs/filetypes.vim
source ~/.dotfiles/vimrcs/plugins_config.vim
source ~/.dotfiles/vimrcs/extended.vim
source ~/.dotfiles/vimrcs/keybinds.vim
if exists("g:neovide")
    set guifont=DejaVuSansMono\ Nerd\ Font:h14
    let g:neovide_refresh_rate = 120
    let g:neovide_refresh_rate_idle = 5

    let g:neovide_remember_window_size = v:true

    
    let g:gui_font_size = 12
    silent! execute('set guifont=Menlo:h'.g:gui_font_size)
    function! ResizeFont(delta)
      let g:gui_font_size = g:gui_font_size + a:delta
      execute('set guifont=Menlo:h'.g:gui_font_size)
    endfunction
    noremap <expr><D-=> ResizeFont(1)
    noremap <expr><D--> ResizeFont(-1)

endif

" Credits://github.com/amix/vimrc 
