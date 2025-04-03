# Claude MCP Get

A comprehensive toolkit for installing and configuring Model Context Protocol (MCP) servers with Claude Desktop on Windows systems.

## Overview

This repository contains scripts, configurations, and documentation to help Windows users successfully install and use Model Context Protocol (MCP) servers with Claude Desktop. It focuses on overcoming the common issues that prevent MCP connections on Windows, particularly problems with `npx` commands, path resolution, and multiple Node.js installations.

## Key Features

- Diagnostic tools to identify Node.js installations
- Installation scripts that avoid common pitfalls
- Configuration templates with absolute paths
- Troubleshooting guides for "Could not attach to MCP server" errors
- Solutions for NVM and Node.js path issues

## Quick Start

1. Clone this repository
2. Run `find-nodejs.bat` to identify your Node.js installations
3. Run `cleanup-nodejs.bat` if you have multiple installations
4. Run `install-mcp.bat` to install the MCP server of your choice
5. Follow the configuration instructions displayed

## Common Windows Issues & Solutions

### NPX Connection Failures

The most common issue on Windows is MCP servers failing to connect when using `npx` commands in `claude_desktop_config.json`. This is due to how Claude Desktop launches subprocesses on Windows.

**Solution:** Use direct `node` execution with absolute paths, like:

```json
{
  "mcpServers": {
    "server-name": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": [
        "C:\\Users\\Username\\AppData\\Roaming\\npm\\node_modules\\@modelcontextprotocol\\server-name\\dist\\index.js",
        "parameter1", "parameter2"
      ],
      "env": {
        "APPDATA": "C:\\Users\\Username\\AppData\\Roaming\\",
        "PATH": "C:\\Program Files\\nodejs",
        "NODE_PATH": "C:\\Users\\Username\\AppData\\Roaming\\npm\\node_modules"
      }
    }
  }
}
```

### Multiple Node.js Installations

Having multiple Node.js installations (especially with NVM) causes path resolution issues.

**Solution:** Use the standard Node.js installation in the default location and specify absolute paths.

### Task Manager Restart Required

Simply closing and reopening Claude Desktop often doesn't fully reload configurations.

**Solution:** End all Claude Desktop processes in Task Manager before restarting.

## Documentation

- [Installation Guide](./docs/installation.md)
- [Troubleshooting Guide](./docs/troubleshooting.md)
- [MCP Server Reference](./docs/servers.md)
- [Configuration Templates](./docs/templates.md)

## Scripts

- `find-nodejs.bat` - Identifies all Node.js installations on your system
- `cleanup-nodejs.bat` - Cleans npm cache and fixes common installation issues
- `install-mcp.bat` - Installs MCP servers globally with proper paths
- `run-server.bat` - Runs MCP servers for testing outside Claude Desktop

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License

## Acknowledgments

- [Model Context Protocol](https://modelcontextprotocol.io) team
- Contributors to the [MCP servers GitHub issue #40](https://github.com/modelcontextprotocol/servers/issues/40)