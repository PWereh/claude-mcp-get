@echo off
setlocal enabledelayedexpansion

echo Windows MCP Server Runner
echo -----------------------
echo.

:: Get the MCP server name from arguments
set server_name=%1
if "%server_name%"=="" (
    echo Please specify an MCP server name to run.
    echo.
    echo Example: run-server.bat filesystem
    echo Example: run-server.bat github
    echo Example: run-server.bat memory
    echo.
    echo This tool runs the MCP server outside Claude Desktop for testing.
    echo.
    goto :end
)

:: Prefer the standard Node.js installation if available
set preferred_node=C:\Program Files\nodejs\node.exe
set is_preferred=0

if exist "%preferred_node%" (
    set node_path=%preferred_node%
    set is_preferred=1
    echo Using preferred Node.js installation: %node_path%
) else (
    for /f "tokens=*" %%n in ('where node') do set node_path=%%n
    echo Using available Node.js installation: %node_path%
    echo NOTE: Consider installing Node.js in the standard location (C:\Program Files\nodejs\)
)

:: Get NPM root
for /f "tokens=*" %%r in ('npm root -g') do set npm_root=%%r
echo NPM root: %npm_root%

:: Check if server is installed
set package_path=%npm_root%\@modelcontextprotocol\server-%server_name%
if "%server_name%"=="desktop-commander" set package_path=%npm_root%\@wonderwhy-er\desktop-commander
if "%server_name%"=="mcp-installer" set package_path=%npm_root%\@anaisbetts\mcp-installer

if not exist "%package_path%" (
    echo.
    echo ERROR: MCP server not found at %package_path%
    echo Please run install-mcp.bat %server_name% first.
    echo.
    pause
    exit /b 1
)

set dist_path=%package_path%\dist\index.js

if not exist "%dist_path%" (
    echo.
    echo ERROR: MCP server index.js not found at %dist_path%
    echo The server might be installed but has a different structure.
    echo.
    pause
    exit /b 1
)

:: Special handling for some servers
set "extra_args="
if /i "%server_name%"=="filesystem" (
    set /p doc_path=Enter path to directory to allow access to (default: %USERPROFILE%\Documents): 
    if "!doc_path!"=="" set "doc_path=%USERPROFILE%\Documents"
    set "extra_args=!doc_path!"
)

if /i "%server_name%"=="github" (
    set /p token=Enter your GitHub Personal Access Token: 
    if not "!token!"=="" (
        set "GITHUB_PERSONAL_ACCESS_TOKEN=!token!"
        echo Set GITHUB_PERSONAL_ACCESS_TOKEN environment variable.
    )
)

if /i "%server_name%"=="brave-search" (
    set /p token=Enter your Brave Search API Key: 
    if not "!token!"=="" (
        set "BRAVE_API_KEY=!token!"
        echo Set BRAVE_API_KEY environment variable.
    )
)

:: Run the server directly with node (instead of npx)
echo.
echo Starting %server_name% MCP server using:
echo - Node path: %node_path%
echo - MCP server: %dist_path%
if not "%extra_args%"=="" echo - Parameters: %extra_args%
echo.
echo Press Ctrl+C to stop the server...
echo.

if "%extra_args%"=="" (
    "%node_path%" "%dist_path%"
) else (
    "%node_path%" "%dist_path%" "%extra_args%"
)

:end
echo.
echo Server stopped. Press any key to exit...
pause >nul
endlocal
