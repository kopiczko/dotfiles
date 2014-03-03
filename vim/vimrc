syntax on
filetype plugin indent on

set encoding=utf-8      " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.

set modeline

set clipboard=unnamedplus

execute pathogen#infect()

" CtrlP {{{
let g:ctrlp_working_path_mode = 'ra'
" }}}

augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

