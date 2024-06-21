set directory=~/.config/nvim/tmp  ""directory for .swp files
""""""" Plugin management stuff
set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

Plugin 'VundleVim/Vundle.vim'
"
" My Bundles here:
"Plugin 'chriskempson/base16-vim'
"Plugin 'jcf/vim-latex' "NOTE: painfully slow
"Plugin 'majutsuxhi/tagbar' " Handelt with git submodule
"Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'rdnetto/YCM-Generator'
"Plugin 'ycm-core/YouCompleteMe'
Plugin 'Chiel92/vim-autoformat'
Plugin 'altercation/vim-colors-solarized'
Plugin 'github/copilot.vim'
Plugin 'godlygeek/tabular'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'morhetz/gruvbox'
Plugin 'petRUShka/vim-sage'
Plugin 'psliwka/vim-smoothie' "Smooth scrolling for Ctrl-D and Ctrl-U
Plugin 'rhysd/vim-clang-format'
Plugin 'rickhowe/diffchar.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'takac/vim-hardtime'
Plugin 'tpope/vim-fugitive.git'
Plugin 'vim-airline/vim-airline'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"tabac/vim-hardtime settings
let g:hardtime_default_on = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"All of your Plugins must be added before the following line
call vundle#end()             " required!
filetype plugin indent on     " required!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" some general vim settings
set mouse=a
set number
"set relativenumber
":imap jk <Esc> "NOTE: cause pain in my right hand

" Some syntax settings
syntax on
au BufNewFile,BufRead *.cu  set filetype=cuda
au BufNewFile,BufRead *.cuh set filetype=cuda

:highlight ExtraWhitespace ctermbg=darkgray guibg=darkgray
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgray guibg=darkgray
:match ExtraWhitespace /\s\+$\|\t/

"some indenting format options
filetype plugin indent on
let &showbreak='=>  ' "indicates line wrapping
let g:tex_flavor='latex' "sets *.tex to latex
set expandtab
set shiftwidth=4
set smartindent
set tabstop=4
set wrap linebreak

set nocompatible " be iMproved

map<F2> :%s/\s\+$// <bar> retab  <CR>

" Color settings
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
  try
    colorscheme gruvbox
  catch /^Vim\%((\a\+)\)\=:E185/
  endtry
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
" Package options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybindings for fugitive
  map <leader>gw :Gwrite<CR>
  map <leader>gr :Gread<CR>
  map <leader>gs :Git status<CR>
  map <leader>gd :Gvdiff<CR>
  map <leader>gc :Git commit<CR>
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
  map <C-n> :NERDTreeToggle<CR>
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
  let g:syntastic_cpp_compiler         = 'gcc'
  let g:syntastic_cuda_compiler        = 'nvcc'
  let g:syntastic_cpp_compiler_options = '-std=c++20 -I/opt/netapps/gcc/11.2/include/c++/11.2.0/ctime'
  let g:syntastic_cpp_checkers         = ['gcc']
  let g:syntastic_cuda_checkers        = ['nvcc']
  let g:syntastic_cpp_config_file      = '.syntastic_cpp_config'
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""Plugin 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"tabac/vim-hardtime settings
let g:hardtime_default_on = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
