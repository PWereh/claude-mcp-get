@echo off
setlocal enabledelayedexpansion

echo Windows MCP Server Installer
echo ---------------------------
echo.

:: Get the MCP server name from arguments
set server_name=%1
if "%server_name%"=="" (
    echo Please specify an MCP server name to install.
    echo.
    echo Example: install-mcp.bat filesystem
    echo Example: install-mcp.bat github
    echo Example: install-mcp.bat memory
    echo Example: install-mcp.bat brave-search
    echo.
    echo Available MCP servers:
    echo - filesystem: Access your local files
    echo - github: Interact with GitHub repositories
    echo - memory: Store information across conversations
    echo - brave-search: Search the web
    echo - sequential-thinking: Break down complex problems
    echo - sqlite: Query SQLite databases (Python-based)
    echo.
    goto :end
)

:: Check if Node.js is installed
where node >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Node.js is not installed. Please install Node.js 18 or higher.
    echo Download from: https://nodejs.org/
    pause
    exit /b 1
)

:: Check Node.js version
for /f "tokens=*" %%v in ('node -v') do set node_version=%%v
echo Node.js version: %node_version%

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

:: Get Node directory
set node_dir=%node_path:\node.exe=%

:: Detect commonly installed MCP servers
set "package_name="
if /i "%server_name%"=="filesystem" set "package_name=@modelcontextprotocol/server-filesystem"
if /i "%server_name%"=="github" set "package_name=@modelcontextprotocol/server-github"
if /i "%server_name%"=="memory" set "package_name=@modelcontextprotocol/server-memory"
if /i "%server_name%"=="brave-search" set "package_name=@modelcontextprotocol/server-brave-search"
if /i "%server_name%"=="sequential-thinking" set "package_name=@modelcontextprotocol/server-sequential-thinking"
if /i "%server_name%"=="desktop-commander" set "package_name=@wonderwhy-er/desktop-commander"
if /i "%server_name%"=="mcp-installer" set "package_name=@anaisbetts/mcp-installer"

:: If not a known server, use as package name directly
if "%package_name%"=="" (
    set "package_name=%server_name%"
    echo Installing custom MCP server: %package_name%
) else (
    echo Installing standard MCP server: %package_name%
)

:: Install the MCP server globally
echo.
echo Installing %package_name% globally...
call npm install -g %package_name%

:: Verify installation
if %ERRORLEVEL% neq 0 (
    echo.
    echo ERROR: Failed to install MCP server.
    goto :end
)

:: Create directory for config if it doesn't exist
if not exist "%APPDATA%\Claude" mkdir "%APPDATA%\Claude"

:: Get config file path
set config_file=%APPDATA%\Claude\claude_desktop_config.json

:: Special handling for some servers
set "extra_args="
if /i "%server_name%"=="filesystem" (
    set /p doc_path=Enter path to directory to allow access to (default: %USERPROFILE%\Documents): 
    if "!doc_path!"=="" set "doc_path=%USERPROFILE%\Documents"
    set "extra_args=!doc_path!"
)

if /i "%server_name%"=="github" (
    set /p token=Enter your GitHub Personal Access Token: 
    set "github_token=!token!"
)

if /i "%server_name%"=="brave-search" (
    set /p token=Enter your Brave Search API Key: 
    set "brave_token=!token!"
)

:: Determine JS file path
set "js_file=%npm_root%\%package_name:\=\\%\\dist\\index.js"
set "js_file=%js_file:@=@%"

:: Generate config file content with proper formatting
echo Generating configuration for %server_name%...

echo {> "%config_file%.new"
echo   "mcpServers": {>> "%config_file%.new"
echo     "%server_name%": {>> "%config_file%.new"
echo       "command": "%node_path:\=\\%",>> "%config_file%.new"
echo       "args": [>> "%config_file%.new"
echo         "%js_file%">> "%config_file%.new"

if not "%extra_args%"=="" (
    echo         ,"%extra_args:\=\\%">> "%config_file%.new"
)

echo       ],>> "%config_file%.new"
echo       "env": {>> "%config_file%.new"
echo         "APPDATA": "%APPDATA:\=\\%\\",>> "%config_file%.new"
echo         "PATH": "%node_dir:\=\\%",>> "%config_file%.new"
echo         "NODE_PATH": "%npm_root:\=\\%">> "%config_file%.new"

if /i "%server_name%"=="github" (
    if not "%github_token%"=="" (
        echo         ,"GITHUB_PERSONAL_ACCESS_TOKEN": "%github_token%">> "%config_file%.new"
    )
)

if /i "%server_name%"=="brave-search" (
    if not "%brave_token%"=="" (
        echo         ,"BRAVE_API_KEY": "%brave_token%">> "%config_file%.new"
    )
)

echo       }>> "%config_file%.new"
echo     }>> "%config_file%.new"
echo   }>> "%config_file%.new"
echo }>> "%config_file%.new"

:: Check if the config file already exists
if exist "%config_file%" (
    echo.
    echo INFO: Claude Desktop configuration already exists.
    echo The new configuration has been saved to:
    echo %config_file%.new
    echo.
    echo You'll need to manually merge these configurations.
) else (
    :: Rename the new config file to the actual config file
    move /y "%config_file%.new" "%config_file%" >nul
    echo.
    echo Successfully created Claude Desktop configuration:
    echo %config_file%
)

echo.
echo Installation complete!
echo.
echo IMPORTANT: Make sure to:
echo 1. Completely close Claude Desktop (End Task in Task Manager)
echo 2. Restart Claude Desktop as administrator
echo 3. Enable Developer Mode to access logs if there are issues
echo.

:end
echo Press any key to exit...
pause >nul
endlocal
