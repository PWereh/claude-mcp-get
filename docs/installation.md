# MCP Installation Guide for Windows

This guide provides detailed instructions for installing Model Context Protocol (MCP) servers on Windows systems.

## Prerequisites

1. **Node.js (v18.0.0 or higher)** 
   - Install the LTS version from [https://nodejs.org/](https://nodejs.org/)
   - **Important**: Install in the default location (`C:\Program Files\nodejs\`)
   - Avoid using NVM (Node Version Manager) for MCP servers

2. **Claude Desktop App**
   - Requires Claude Pro or higher subscription
   - [Download Claude Desktop](https://claude.ai/desktop)

## Installation Steps

### 1. Verify Node.js Installation

Open Command Prompt (CMD) as administrator and run:

```cmd
node --version
npm --version
where node
npm root -g
```

Note down the paths returned by the last two commands - you'll need them for configuration.

### 2. Install MCP Server Globally

Choose an MCP server to install. For this example, we'll use the Filesystem MCP server:

```cmd
npm install -g @modelcontextprotocol/server-filesystem
```

Verify installation:

```cmd
npm list -g @modelcontextprotocol/server-filesystem
```

You should see a path like: `C:\Users\YourUsername\AppData\Roaming\npm\node_modules\@modelcontextprotocol\server-filesystem`

### 3. Create Claude Desktop Configuration

1. Open File Explorer
2. Navigate to: `%APPDATA%\Claude\`
3. Create or edit file: `claude_desktop_config.json`
4. Add the following configuration (replace paths with your actual paths):

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": [
        "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@modelcontextprotocol\\server-filesystem\\dist\\index.js",
        "C:\\Users\\YourUsername\\Documents",
        "C:\\Users\\YourUsername\\Downloads"
      ],
      "env": {
        "APPDATA": "C:\\Users\\YourUsername\\AppData\\Roaming\\",
        "PATH": "C:\\Program Files\\nodejs",
        "NODE_PATH": "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules"
      }
    }
  }
}
```

**Important Notes:**
- Replace `YourUsername` with your actual Windows username
- Use double backslashes (`\\`) in all paths
- Include the `env` section to avoid path resolution issues
- The `args` array includes the paths to the server's JS file followed by any directories you want the MCP server to access

### 4. Restart Claude Desktop

1. Close Claude Desktop completely
2. Open Task Manager (Ctrl+Shift+Esc)
3. End any running Claude Desktop processes
4. Restart Claude Desktop as administrator (right-click > Run as administrator)

### 5. Enable Developer Mode

1. In Claude Desktop, click on the menu in the top-left corner
2. Go to Settings > Developer
3. Enable Developer Mode
4. This gives you access to logs for troubleshooting

## Testing the Installation

1. In Claude Desktop, start a new chat
2. Look for the hammer icon in the input field - this indicates MCP servers are available
3. Try asking Claude about files in your allowed directories, such as:
   - "What files are in my Documents folder?"
   - "Can you find all .txt files in my Downloads folder?"

## Automated Installation

For a simplified installation, you can use our provided scripts:

1. Run `find-nodejs.bat` to identify your Node.js installations
2. Run `cleanup-nodejs.bat` if you have multiple installations
3. Run `install-mcp.bat servername` to install a specific MCP server
4. Follow the on-screen instructions

For example:
```cmd
install-mcp.bat filesystem
```

## Additional Resources

- [MCP Windows Troubleshooting Guide](./troubleshooting.md)
- [MCP Server Reference](./servers.md)
- [GitHub Issue #40 Discussion](https://github.com/modelcontextprotocol/servers/issues/40)
- [Official MCP Documentation](https://modelcontextprotocol.io/)
