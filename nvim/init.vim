set directory=~/.config/nvim/temp  ""directory for .swp files
""""""" Plugin management stuff """""""
set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

Plugin 'VundleVim/Vundle.vim'
"
" My Bundles here:
"Plugin 'majutsuxhi/tagbar' " Handelt with git submodule
"Plugin 'jcf/vim-latex' "NOTE: painfully slow
"Plugin 'chriskempson/base16-vim'
Plugin 'Chiel92/vim-autoformat'
"Plugin 'ycm-core/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
"Plugin 'powerline/fonts'
"Plugin 'powerline/powerline'
"Plugin 'rdnetto/YCM-Generator'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive.git'
Plugin 'petRUShka/vim-sage'
Plugin 'rickhowe/diffchar.vim'
"All of your Plugins must be added before the following line
call vundle#end()             " required!
filetype plugin indent on     " required!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" some general vim settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a
set number
"set relativenumber


":imap jk <Esc> "NOTE: cause pain in my right hand

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Some syntax settings
syntax on
au BufNewFile,BufRead *.cu  set filetype=cuda
au BufNewFile,BufRead *.cuh set filetype=cuda

:highlight ExtraWhitespace ctermbg=darkgray guibg=darkgray
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgray guibg=darkgray
:match ExtraWhitespace /\s\+$\|\t/
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"some indenting format options
filetype plugin indent on
let &showbreak='=>  '     "indicates line wrapping
let g:tex_flavor='latex'     "sets *.tex to latex
set expandtab
set shiftwidth=4
set smartindent
set tabstop=4
set wrap linebreak

set nocompatible               " be iMproved
filetype off                   " required!

map<F2> :%s/\s\+$// <bar> retab  <CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colorsettings
if has("gui_running")
  "set guifont=Inconsolata\ 10
  let g:solarized_termcolors=256
  syntax enable
  set background=light
  "colorscheme gruvbox
  colorscheme solarized
  "let g:gruvbox_contrast_dark = 'hard'
else
  syntax enable
  set t_Co=256
  let g:solarized_termcolors=256
  set background=dark
  colorscheme gruvbox
  "colorscheme solarized
  "let g:gruvbox_contrast_dark = 'hard'
  :highlight Normal ctermbg=NONE
endif

" Search settings
:set iskeyword+=_ "Add _ to search pattern (example test_test)
:set hlsearch "Highlighting search matches

" line width settings
":set tw=80 "Deactivated the option because i want to to decide that
:set colorcolumn=80

" spell checking options
:set spell

" set transparent background
"set t_8f=\[[38;2;%lu;%lu;%lum
"set t_8b=\[[48;2;%lu;%lu;%lum
"set termguicolors
"set background=dark
"hi! Normal ctermbg=NONE guibg=NONE
"hi! NonText ctermbg=NONE guibg=NONE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tag-settings
set tags=tags;
" create tags for current directory (recursive)
 map <F4> :!/usr/bin/ctags -R --exclude=.git --exclude=documentation --c++-kinds=+p --langmap=c++:+.cu --fields=+liaS --extra=+q .<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deactivate middle mouse-button (now only double-click)
:map <MiddleMouse> <Nop>
:imap <MiddleMouse> <Nop>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Package options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybindings for fugitive
  map <leader>gw :Gwrite<CR>
  map <leader>gr :Gread<CR>
  map <leader>gs :Gstatus<CR>
  map <leader>gd :Gdiff<CR>
  map <leader>gc :Gcommit<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quickstart for tagbar
  " directory for created ctags
  let Tlist_Ctags_Cmd = "/usr/bin/ctags"
  " tagbar width
  let Tlist_WinWidth  = 50
  " show tagbar
  map <F8> :TagbarToggle<CR>
  " create ycm config file"
  map <F3> :YcmGenerateConfig --compiler clang .<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree settings
  " start automatically, whenn no file is specified
  autocmd vimenter * if !argc() | NERDTree | endif
  " start NERDTree
  map <C-n> :NERDTreeToggle<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Some setting for vim-powerline
  let g:Powerline_symbols = 'fancy'
  set encoding=utf-8
  set laststatus=2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setting for vim-latex
  " REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
  filetype plugin on
  "
  "
  " IMPORTANT: grep will sometimes skip displaying the file name if you
  " search in a singe file. This will confuse Latex-Suite. Set your grep
  " program to always generate a file-name.
  set grepprg=grep\ -nH\ $*
  "
  " OPTIONAL: This enables automatic indentation as you type.
  filetype indent on
  "
  " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults
  " to
  " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
  " The following changes the default filetype back to 'tex':
  let g:tex_flavor='latex'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Syntastic options
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_quiet_messages = { "regex": [
        \ '\mpossible unwanted space at "{"',
        \ '\mWrong length of dash may have been used',
        \ '\mCommand terminated with space',
        \ '\mYou should avoid spaces after parenthesis.',
        \ ] }

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_wq = 0

  "let g:syntastic_check_on_open=1 "Slow opening
  let g:syntastic_enable_signs         = 1
  let g:syntastic_cpp_check_header     = 1
  let g:syntastic_cpp_compiler         = 'clang++'
  let g:syntastic_cuda_compiler        = 'clang++'
  let g:syntastic_cpp_compiler_options = '-std=c++20'
  let g:syntastic_cpp_checkers         = ['gcc']
  let g:syntastic_cuda_checkers        = ['nvcc']
  "let g:syntastic_cpp_flags = ['-I./lib/spdlog/ -I./lib/spdlog/include -I./lib/spdlog/include/spdlog']
  let g:syntastic_cpp_include_dirs = [ 'includes', '../include', '../../include', 'includes/*/', '../include/*/', '../../include/*/', 'external/slog/include']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set wildmenu
set wildmode=list:longest,full

"set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugin 'rickhowe/diffchar.vim'
   let g:DiffUnit = 'Char'
