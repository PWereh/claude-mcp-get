# MCP Windows Troubleshooting Guide

This guide helps solve common issues when setting up Model Context Protocol (MCP) servers on Windows systems.

## Common Error: "Could not attach to MCP server"

This is the most frequent error on Windows. Here are steps to diagnose and fix it:

### 1. Check MCP Server Logs

1. Enable Developer Mode in Claude Desktop
2. Go to menu > Developer > Open MCP Log File
3. Look for files named `mcp-server-SERVERNAME.log`

Common log errors and solutions:

#### Error: "spawn npx ENOENT"

**Cause**: Claude Desktop can't find the `npx` command.  
**Solution**: Use absolute path to `node.exe` instead of `npx` in your configuration.

```json
// Change this:
"command": "npx",
"args": ["-y", "@modelcontextprotocol/server-name", "path1", "path2"],

// To this:
"command": "C:\\Program Files\\nodejs\\node.exe",
"args": ["C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@modelcontextprotocol\\server-name\\dist\\index.js", "path1", "path2"],
```

#### Error: "SyntaxError: Unexpected token {"

**Cause**: Node.js version mismatch or ES module issues.  
**Solution**: 
1. Ensure you're using Node.js v18+ 
2. Consider using the direct node execution approach above

#### Error: "Error: Node Sass does not yet support your current environment"

**Cause**: Incompatible Node.js version with some dependencies.  
**Solution**: Install a compatible Node.js version (usually LTS).

#### Error: "${APPDATA} within a path"

**Cause**: Environment variable not properly set or expanded.  
**Solution**: Add the APPDATA environment variable to your configuration:

```json
"env": {
  "APPDATA": "C:\\Users\\YourUsername\\AppData\\Roaming\\"
}
```

### 2. Test Server Outside Claude Desktop

Run the server directly in Command Prompt to check if it works:

```cmd
"C:\Program Files\nodejs\node.exe" "C:\Users\YourUsername\AppData\Roaming\npm\node_modules\@modelcontextprotocol\server-name\dist\index.js" "path1" "path2"
```

If it works here but not in Claude Desktop, it's likely a configuration or path issue.

### 3. Multiple Node.js Installations

If you have multiple Node.js installations (especially with NVM), run `find-nodejs.bat` to identify them.

**Solution**: 
1. Use the standard Node.js installation (`C:\Program Files\nodejs\node.exe`)
2. Use absolute paths in configuration
3. Consider uninstalling NVM if not needed for other projects

### 4. PowerShell Security Errors

When using PowerShell, you might see execution policy errors.

**Solution**:
1. Use Command Prompt (CMD) instead, or
2. Run `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser` in PowerShell as admin

### 5. Complete Claude Desktop Restart

Simply closing Claude Desktop often doesn't fully reload the configuration.

**Solution**:
1. Open Task Manager (Ctrl+Shift+Esc)
2. End all Claude Desktop processes
3. Relaunch Claude Desktop as administrator

### 6. Claude Desktop Config Syntax Errors

JSON syntax errors in your `claude_desktop_config.json` file can prevent servers from loading.

**Solution**:
1. Validate your JSON using a tool like [jsonlint.com](https://jsonlint.com/)
2. Ensure all paths use double backslashes (`\\`)
3. Check for missing commas or braces

## Advanced Troubleshooting

### Server-Specific Issues

#### Filesystem Server

If you're having issues with the Filesystem server:

1. Ensure the directories you specify exist and are accessible
2. Try using a simple path first (like `C:\\Users\\YourUsername\\Documents`)
3. Avoid network drives or OneDrive/cloud folders initially

#### GitHub Server

For GitHub server authentication issues:

1. Ensure your PAT (Personal Access Token) has the correct permissions
2. Set the token in the environment variables section of your config
3. Test the token independently using curl or another tool

### WSL Integration

If you prefer using WSL (Windows Subsystem for Linux) Node.js:

```json
{
  "mcpServers": {
    "server-name": {
      "command": "wsl.exe",
      "args": [
        "bash", 
        "-c", 
        "node /home/username/path/to/node_modules/@modelcontextprotocol/server-name/dist/index.js parameter1 parameter2"
      ]
    }
  }
}
```

For NVM in WSL:

```json
{
  "mcpServers": {
    "server-name": {
      "command": "wsl.exe",
      "args": [
        "bash",
        "-c",
        "source ~/.nvm/nvm.sh && /home/username/.nvm/versions/node/v20.12.1/bin/node /path/to/node_modules/@modelcontextprotocol/server-name/dist/index.js parameter1 parameter2"
      ]
    }
  }
}
```

## Still Having Issues?

If you're still experiencing problems after trying these solutions:

1. Check [GitHub issue #40](https://github.com/modelcontextprotocol/servers/issues/40) for the latest community solutions
2. Run our diagnostic script: `diagnose-mcp.bat`
3. Consider using a Python-based MCP server instead (fewer installation issues on Windows)
4. Try setting up in a clean Windows user account to rule out permission issues
