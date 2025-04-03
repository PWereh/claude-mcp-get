@echo off
echo MCP Server Diagnostic Tool
echo ------------------------
echo.

:: Check if Claude Desktop is installed
set claude_path=%LOCALAPPDATA%\AnthropicClaude
if not exist "%claude_path%" (
    echo ERROR: Claude Desktop not found at %LOCALAPPDATA%\AnthropicClaude
    echo Please make sure Claude Desktop is installed.
    goto :end
)
echo Claude Desktop installation found at: %claude_path%

:: Check if config file exists
set config_file=%APPDATA%\Claude\claude_desktop_config.json
if not exist "%config_file%" (
    echo ERROR: Claude Desktop configuration not found at %config_file%
    echo You need to create this file to use MCP servers.
    echo Run install-mcp.bat to set up a server.
    goto :end
)
echo Claude Desktop configuration found at: %config_file%

:: Check if Developer Mode is enabled
set log_dir=%APPDATA%\Claude\logs
if not exist "%log_dir%" mkdir "%log_dir%"
echo Log directory: %log_dir%

:: Display config content
echo.
echo === Claude Desktop Configuration ===
type "%config_file%"
echo.

:: Check for recent logs
echo === Recent MCP Logs ===
dir /b "%USERPROFILE%\AppData\Local\AnthropicClaude\logs\mcp*.log" 2>nul
if %ERRORLEVEL% neq 0 (
    echo No MCP logs found. Make sure Developer Mode is enabled in Claude Desktop.
)
echo.

:: Check latest mcp.log if it exists
set mcp_log=%USERPROFILE%\AppData\Local\AnthropicClaude\logs\mcp.log
if exist "%mcp_log%" (
    echo === Latest MCP Log Content (last 20 lines) ===
    powershell -Command "Get-Content '%mcp_log%' -Tail 20"
    echo.
)

:: Check server-specific logs
echo === Server-specific Logs (if any) ===
powershell -Command "Get-ChildItem '%USERPROFILE%\AppData\Local\AnthropicClaude\logs\mcp-server-*.log' | Sort-Object LastWriteTime -Descending | Select-Object -First 1 | ForEach-Object { Write-Host $_.FullName; Get-Content $_ -Tail 20 }"
echo.

:: Check Node.js installation
echo === Node.js Installation ===
where node 2>nul
if %ERRORLEVEL% neq 0 (
    echo ERROR: Node.js not found in PATH
    echo Please install Node.js from https://nodejs.org/
) else (
    node --version
    npm --version
    echo NPM global root: 
    call npm root -g
)
echo.

:: Check installed MCP servers
echo === Installed MCP Servers ===
call npm list -g @modelcontextprotocol/server-filesystem 2>nul
call npm list -g @modelcontextprotocol/server-github 2>nul
call npm list -g @modelcontextprotocol/server-memory 2>nul
call npm list -g @modelcontextprotocol/server-brave-search 2>nul
call npm list -g @anaisbetts/mcp-installer 2>nul
call npm list -g @wonderwhy-er/desktop-commander 2>nul
echo.

:: Check NVM installations
echo === Checking for NVM installations ===
if exist "%APPDATA%\nvm\*" (
    echo WARNING: NVM installations detected at %APPDATA%\nvm\
    echo These can cause conflicts with MCP servers.
    dir /b "%APPDATA%\nvm\v*" 2>nul
) else (
    echo NO NVM installations found
)
echo.

:: Check Claude processes
echo === Claude Desktop Processes ===
powershell -Command "Get-Process | Where-Object { $_.ProcessName -like '*Claude*' } | Format-Table Id, ProcessName, Path -AutoSize"
echo.

echo Diagnostic information collected. If you're having issues:
echo 1. Make sure you're using absolute paths in your claude_desktop_config.json
echo 2. Make sure Claude Desktop is completely closed before restarting
echo 3. Run Claude Desktop as administrator
echo 4. Check logs for specific error messages
echo.

:end
echo Press any key to exit...
pause >nul
