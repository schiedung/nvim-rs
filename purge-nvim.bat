@ECHO OFF
REM Removes the Neovim configuration and plugin data on Windows.
REM %LOCALAPPDATA% rather than %HOMEPATH%: the latter has no drive letter and so
REM resolves against whatever drive happens to be current.

ECHO This will delete:
ECHO   "%LOCALAPPDATA%\nvim"        (configuration)
ECHO   "%LOCALAPPDATA%\nvim-data"   (lazy.nvim plugins, mason packages)
ECHO.
SET /P CONFIRM="Are you sure you want to delete all Neovim configuration files (y/n)? "
IF /I NOT "%CONFIRM%"=="y" (
    ECHO Aborted.
    EXIT /B 0
)

ECHO Uninstalling nvim configuration
IF EXIST "%LOCALAPPDATA%\nvim" RMDIR "%LOCALAPPDATA%\nvim" /S /Q
IF EXIST "%LOCALAPPDATA%\nvim-data" RMDIR "%LOCALAPPDATA%\nvim-data" /S /Q
ECHO Done.
