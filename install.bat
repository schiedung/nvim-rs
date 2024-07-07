ECHO Installing nvim configuration
MKDIR %HOMEPATH%\AppData\Local\nvim
COPY %cd%\nvim_win\init.vim %HOMEPATH%\AppData\Local\nvim
git clone https://github.com/VundleVim/Vundle.vim.git %HOMEPATH%\AppData\Local\nvim\bundle\Vundle.vim
nvim +VundleInstall +qall
ECHO Installing vim configuration
MKDIR %HOMEPATH%\vim
COPY %cd%\vim_win\vimrc %HOMEPATH%\.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git %HOMEPATH%\AppData\Local\vim\bundle\Vundle.vim
vim +VundleInstall +qall
ECHO Configure git
git config --global core.editor nvim
git config --global merge.tool vimdiff
git config --global diff.tool vimdiff
