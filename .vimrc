set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" add nerdtree
Plugin 'scrooloose/nerdtree'
" add lightline
Plugin 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on
set nu!
if has('gui_running')
    set background=dark
    colorscheme solarized
    " colorscheme elflord
    
    "cancel find highlight
    nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>
    map <F3> :NERDTreeMirror<CR>
    map <F3> :NERDTreeToggle<CR>
else
    set background=dark
endif
set lines=100 columns=200 
set colorcolumn=90
set guifont=Monaco:h12 "setting font size
filetype indent on
set nowrap
"set tabstop=8
set shiftwidth=6
"set hlsearch
set smartindent
set autoindent
set hlsearch
set laststatus=2 " open status line
set noshowmode

" automatically activate nerdtree 
autocmd VimEnter * NERDTree

" double click to open a new tab in nerdtree
 autocmd VimEnter * call NERDTreeAddKeyMap({ 'key': '<2-LeftMouse>', 'scope': "FileNode", 'callback': "OpenInTab", 'override':1 })
    function! OpenInTab(node)
        call a:node.activate({'reuse': 'all', 'where': 't'})
    endfunction

" show hidden files in nerdtree
let NERDTreeShowHidden=1

" quit nerdtree while there is no vim activated
function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0
  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor
  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()

