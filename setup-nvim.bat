ECHO Installing nvim configuration
MKDIR %HOMEPATH%\AppData\Local\nvim
COPY %cd%\nvim\init.lua %HOMEPATH%\AppData\Local\nvim
ECHO Configure git
git config --global core.editor nvim
