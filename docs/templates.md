# MCP Configuration Templates for Windows

This document provides ready-to-use configuration templates for various MCP server setups on Windows.

## Basic Template (Single Server)

```json
{
  "mcpServers": {
    "server-name": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": [
        "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@package-name\\dist\\index.js",
        "parameter1",
        "parameter2"
      ],
      "env": {
        "APPDATA": "C:\\Users\\YourUsername\\AppData\\Roaming\\",
        "PATH": "C:\\Program Files\\nodejs",
        "NODE_PATH": "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules",
        "CUSTOM_ENV_VAR": "custom_value"
      }
    }
  }
}
```

## Multiple Servers Template

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
    },
    "github": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": [
        "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@modelcontextprotocol\\server-github\\dist\\index.js"
      ],
      "env": {
        "APPDATA": "C:\\Users\\YourUsername\\AppData\\Roaming\\",
        "PATH": "C:\\Program Files\\nodejs",
        "NODE_PATH": "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules",
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token_here"
      }
    },
    "brave-search": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": [
        "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@modelcontextprotocol\\server-brave-search\\dist\\index.js"
      ],
      "env": {
        "APPDATA": "C:\\Users\\YourUsername\\AppData\\Roaming\\",
        "PATH": "C:\\Program Files\\nodejs",
        "NODE_PATH": "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules",
        "BRAVE_API_KEY": "your_brave_api_key"
      }
    }
  }
}
```

## WSL (Windows Subsystem for Linux) Template

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "wsl.exe",
      "args": [
        "bash",
        "-c",
        "node /home/username/node_modules/@modelcontextprotocol/server-filesystem/dist/index.js /home/username/Documents /home/username/Downloads"
      ]
    },
    "github": {
      "command": "wsl.exe",
      "args": [
        "bash",
        "-c",
        "GITHUB_PERSONAL_ACCESS_TOKEN='your_token_here' node /home/username/node_modules/@modelcontextprotocol/server-github/dist/index.js"
      ]
    }
  }
}
```

## WSL with NVM Template

```json
{
  "mcpServers": {
    "sequential-thinking": {
      "command": "wsl.exe",
      "args": [
        "bash",
        "-c",
        "source ~/.nvm/nvm.sh && /home/username/.nvm/versions/node/v20.12.1/bin/node /home/username/node_modules/@modelcontextprotocol/server-sequential-thinking/dist/index.js"
      ]
    }
  }
}
```

## Python MCP Server Template

```json
{
  "mcpServers": {
    "sqlite": {
      "command": "C:\\Users\\YourUsername\\AppData\\Local\\Programs\\Python\\Python310\\python.exe",
      "args": [
        "-m",
        "mcp_server_sqlite",
        "--db-path",
        "C:\\Users\\YourUsername\\Documents\\database.db"
      ]
    }
  }
}
```

## Desktop Commander Template

```json
{
  "mcpServers": {
    "desktop-commander": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": [
        "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@wonderwhy-er\\desktop-commander\\dist\\index.js"
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

## MCP Installer Template

```json
{
  "mcpServers": {
    "mcp-installer": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": [
        "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@anaisbetts\\mcp-installer\\dist\\index.js"
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

## E2B Code Execution Template

```json
{
  "mcpServers": {
    "e2b": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": [
        "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@e2b-dev\\mcp-server\\dist\\index.js"
      ],
      "env": {
        "APPDATA": "C:\\Users\\YourUsername\\AppData\\Roaming\\",
        "PATH": "C:\\Program Files\\nodejs",
        "NODE_PATH": "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules",
        "E2B_API_KEY": "your_e2b_api_key"
      }
    }
  }
}
```

## Using Custom Node.js Installation Path

If you have Node.js installed in a non-standard location:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "D:\\Custom\\Path\\To\\nodejs\\node.exe",
      "args": [
        "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@modelcontextprotocol\\server-filesystem\\dist\\index.js",
        "C:\\Users\\YourUsername\\Documents"
      ],
      "env": {
        "APPDATA": "C:\\Users\\YourUsername\\AppData\\Roaming\\",
        "PATH": "D:\\Custom\\Path\\To\\nodejs",
        "NODE_PATH": "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules"
      }
    }
  }
}
```

## Getting Path Information Automatically

Run the following commands in Command Prompt to get the paths you need:

```cmd
where node
npm root -g
echo %APPDATA%
```

Use these values to populate your configuration template.
