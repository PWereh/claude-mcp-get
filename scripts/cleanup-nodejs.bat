@echo off
echo Node.js Clean-up Tool
echo -------------------
echo This script will help clean up Node.js installations to prevent conflicts
echo.

echo === STEP 1: Clear NPM cache ===
echo Cleaning npm cache...
call npm cache clean --force
echo.

echo === STEP 2: Check for NVM installations ===
if exist "%APPDATA%\nvm" (
    echo WARNING: NVM installations detected at %APPDATA%\nvm
    echo NVM can cause conflicts with MCP servers on Windows.
    echo Consider using the standard Node.js installation instead.
    echo.
    
    set /p choice=Would you like to uninstall MCP packages from all NVM installations? (y/n): 
    if /i "%choice%"=="y" (
        echo Uninstalling MCP packages from NVM installations...
        for /d %%d in ("%APPDATA%\nvm\v*") do (
            echo Processing %%d...
            call "%%d\npm" uninstall -g @modelcontextprotocol/server-filesystem
            call "%%d\npm" uninstall -g @modelcontextprotocol/server-github
            call "%%d\npm" uninstall -g @modelcontextprotocol/server-memory
            call "%%d\npm" uninstall -g @modelcontextprotocol/server-brave-search
            echo.
        )
    )
)

echo === STEP 3: Uninstall global MCP packages to prepare for reinstallation ===
echo Uninstalling MCP packages from primary Node.js installation...
call npm uninstall -g @modelcontextprotocol/server-filesystem
call npm uninstall -g @modelcontextprotocol/server-github
call npm uninstall -g @modelcontextprotocol/server-memory
call npm uninstall -g @modelcontextprotocol/server-brave-search
echo.

echo === STEP 4: Install Node.js in standard location (if needed) ===
if not exist "C:\Program Files\nodejs\node.exe" (
    echo The recommended Node.js installation (C:\Program Files\nodejs\) was not found.
    echo Please install Node.js from https://nodejs.org/
    echo Make sure to install in the default location and check "Add to PATH".
    echo.
    set /p choice=Would you like to open the Node.js download page? (y/n): 
    if /i "%choice%"=="y" start https://nodejs.org/
    pause
    exit /b 1
)

echo === Clean-up Complete ===
echo Node path: 
where node
echo NPM root:
call npm root -g
echo.
echo Ready to install MCP servers. Run the install-mcp.bat script next.
echo.
echo Press any key to exit...
pause >nul
