@ECHO OFF
REM Installs the Neovim configuration (init.lua) on Windows.
REM NOTE: this COPIES init.lua rather than symlinking it, so re-run this script
REM after every change to the repo. The Linux setup-nvim.sh symlinks instead.

WHERE nvim >NUL 2>NUL
IF ERRORLEVEL 1 (
    ECHO Neovim not found. Please install Neovim first.
    EXIT /B 1
)

ECHO Installing nvim configuration
REM %LOCALAPPDATA% rather than %HOMEPATH%: the latter has no drive letter and so
REM resolves against whatever drive happens to be current.
IF NOT EXIST "%LOCALAPPDATA%\nvim" MKDIR "%LOCALAPPDATA%\nvim"
COPY /Y "%~dp0nvim\init.lua" "%LOCALAPPDATA%\nvim"

ECHO Configure git
git config --global core.editor nvim

ECHO Done. Plugins install on first launch (lazy.nvim).
ECHO Requires Neovim 0.11 or newer.
