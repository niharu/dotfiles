" Vim 起動時に非点滅のブロックタイプのカーソル
let &t_ti.="\e[2 q"
" 挿入モード時に非点滅の縦棒タイプのカーソル
let &t_SI .= "\e[6 q"
" ノーマルモード時に非点滅のブロックタイプのカーソル
let &t_EI .= "\e[2 q"
" 置換モード時に非点滅の下線タイプのカーソル
let &t_SR .= "\e[4 q"
" vim 終了時にカーソルを mintty のデフォルトに設定
let &t_te.="\e[0 q"

call plug#begin('~/.vim/plugged')
  "Plug 'rust-lang/rust.vim'
  Plug 'preservim/nerdtree'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'cespare/vim-toml'
call plug#end()

" Start NERDTree and leave the cursor in it.
"autocmd VimEnter * NERDTree

" fzf settings
"let $FZF_DEFAULT_OPTS="--layout=reverse"
let $FZF_DEFAULT_OPTS='--layout=reverse --preview "bat  --color=always --style=header,grid --line-range :100 {}"'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
let $FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
let $FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height':0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }

let mapleader = "\<Space>"

" fzf
nnoremap <silent> <leader>f :Files<CR>

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
