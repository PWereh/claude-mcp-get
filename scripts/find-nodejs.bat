@echo off
echo Finding all Node.js installations on the system...
echo.

echo === Primary Node.js from PATH ===
where node
where npm
echo.

echo === NPM global root ===
call npm root -g
echo.

echo === Preferred Node.js installation: C:\Program Files\nodejs\ ===
if exist "C:\Program Files\nodejs\node.exe" (
    echo FOUND - This is the recommended installation
) else (
    echo NOT FOUND
)
echo.

echo === Other possible Node.js locations ===
if exist "C:\Program Files (x86)\nodejs\node.exe" echo FOUND: C:\Program Files (x86)\nodejs\node.exe
if exist "%APPDATA%\npm\node.exe" echo FOUND: %APPDATA%\npm\node.exe
if exist "%LOCALAPPDATA%\Programs\nodejs\node.exe" echo FOUND: %LOCALAPPDATA%\Programs\nodejs\node.exe
echo.

echo === Checking for NVM installations ===
if exist "%APPDATA%\nvm\*" (
    echo FOUND NVM installations at: %APPDATA%\nvm\
    dir /b "%APPDATA%\nvm\v*" 2>nul
) else (
    echo NO NVM installations found
)
echo.

echo === Checking Claude Desktop configuration ===
set config_path=%APPDATA%\Claude\claude_desktop_config.json
if exist "%config_path%" (
    echo FOUND Claude Desktop configuration at: %config_path%
    type "%config_path%"
) else (
    echo NOT FOUND - Claude Desktop configuration does not exist
)
echo.

echo All Node.js information collected. Press any key to exit...
pause >nul
