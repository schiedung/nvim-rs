ECHO Installing nvim configuration
MKDIR %HOMEPATH%\AppData\Local\nvim
COPY %cd%\nvim_win\init.vim %HOMEPATH%\AppData\Local\nvim
git clone https://github.com/VundleVim/Vundle.vim.git %HOMEPATH%\AppData\Local\nvim\bundle\Vundle.vim
nvim +VundleInstall +qall
git config --global core.editor "nvim"
