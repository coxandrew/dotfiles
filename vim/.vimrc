" Install vim-plug if not installed
if empty(glob('$HOME/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

source $HOME/.vim/functions.vim

" Settings
set nocompatible
set cursorline									       " Background color for current line
set nospell                            " Don't do spellcheck
set number                             " Show line numbers
set title titlestring=[%F]             " Set iTerm title to current file name
set linebreak                          " Don't break words when wrapping

if has("autocmd")
  filetype plugin indent on
endif

" Soft tabs
set tabstop=2
set shiftwidth=2                       " When indenting with '>', use 2 spaces
set expandtab												   " On pressing tab, insert 2 spaces

" cursor customization
if $TERM_PROGRAM =~ "iTerm.app"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

runtime macros/matchit.vim                   " Jump between opening and closing keywords (def/end)


" autocmd
" --------------------------------------------------------------
" trim trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Leader commands
let mapleader = "\<Space>"              " Map the space key as the leader
nmap <leader>vr :vsp $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>
nmap <leader>f :Files<cr>               " Search in files with fzf
nmap <leader>h :History<cr>             " Search in recent history
nmap <leader>a :Ag<cr>                  " Find in project

" NERD tree
map <C-n> :NERDTreeToggle<CR>

" Tab controls
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

" Access tabs by number key
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 10gt

" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
" command -nargs=0 -bar Update if &modified
"                            \|    if empty(bufname('%'))
"                            \|        browse confirm write
"                            \|    else
"                            \|        confirm write
"                            \|    endif
"                            \|endif
" nmap <silent> <C-S> :<C-u>Update<CR>
" imap <C-s> <Esc>:Update<CR>

" insert mode mappings
imap jj <ESC>

" Insert current date
nmap <leader>td i<C-R>=strftime(" %Y-%m-%d")<CR><Esc>
" imap <F3> <C-R>=strftime("%Y-%m-%d")<CR>

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins. Make sure you use single quotes
" Reload .vimrc and :PlugInstall to install plugins.
" -------------------------------------------------------------
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'

Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' " find or install fzf
Plug 'slim-template/vim-slim'
Plug 'gabrielelana/vim-markdown'
Plug 'rakr/vim-one'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'vim-ruby/vim-ruby'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

let g:vim_markdown_folding_disabled = 1         " Disable folding in markdown docs
let g:NERDTreeNodeDelimiter = "\u00a0"          " Remove ^G character in nerdtree

" Color scheme
" colorscheme Tomorrow-Night
autocmd BufEnter * colorscheme Tomorrow-Night
autocmd BufEnter * set background=dark
autocmd BufEnter *.md colorscheme one
autocmd BufEnter *.md set background=light

" autocmd BufEnter *.md set background=light
" autocmd BufEnter *.md colorscheme Tomorrow
