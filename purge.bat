@ECHO OFF
REM Removes the Vim and Neovim configuration and plugin data on Windows.
REM %LOCALAPPDATA% / %USERPROFILE% rather than %HOMEPATH%: the latter has no
REM drive letter and so resolves against whatever drive happens to be current.

ECHO This will delete:
ECHO   "%LOCALAPPDATA%\nvim"        (Neovim configuration)
ECHO   "%LOCALAPPDATA%\nvim-data"   (lazy.nvim plugins, mason packages)
ECHO   "%USERPROFILE%\vimfiles"     (Vim runtime files, Vundle plugins)
ECHO   "%USERPROFILE%\.vimrc"       (Vim configuration)
ECHO.
SET /P CONFIRM="Are you sure you want to delete all Vim and Neovim configuration files (y/n)? "
IF /I NOT "%CONFIRM%"=="y" (
    ECHO Aborted.
    EXIT /B 0
)

ECHO Uninstalling nvim configuration
IF EXIST "%LOCALAPPDATA%\nvim" RMDIR "%LOCALAPPDATA%\nvim" /S /Q
IF EXIST "%LOCALAPPDATA%\nvim-data" RMDIR "%LOCALAPPDATA%\nvim-data" /S /Q

ECHO Uninstalling vim configuration
REM Windows Vim uses ~\vimfiles, not ~\vim.
IF EXIST "%USERPROFILE%\vimfiles" RMDIR "%USERPROFILE%\vimfiles" /S /Q
IF EXIST "%USERPROFILE%\.vimrc" DEL "%USERPROFILE%\.vimrc"
ECHO Done.
