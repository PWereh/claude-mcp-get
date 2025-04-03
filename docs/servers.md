# MCP Server Reference

This document provides information about popular MCP servers and their Windows-specific configuration requirements.

## Official MCP Servers

These are the official MCP servers maintained by the Model Context Protocol team.

### Filesystem MCP Server

**Package:** `@modelcontextprotocol/server-filesystem`  
**Purpose:** Access and manipulate files on your local filesystem.  
**Installation:** `npm install -g @modelcontextprotocol/server-filesystem`

**Windows Configuration:**
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": [
        "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@modelcontextprotocol\\server-filesystem\\dist\\index.js",
        "C:\\Path\\To\\Directory1",
        "C:\\Path\\To\\Directory2"
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

### GitHub MCP Server

**Package:** `@modelcontextprotocol/server-github`  
**Purpose:** Interact with GitHub repositories.  
**Installation:** `npm install -g @modelcontextprotocol/server-github`

**Windows Configuration:**
```json
{
  "mcpServers": {
    "github": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": [
        "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@modelcontextprotocol\\server-github\\dist\\index.js"
      ],
      "env": {
        "APPDATA": "C:\\Users\\YourUsername\\AppData\\Roaming\\",
        "PATH": "C:\\Program Files\\nodejs",
        "NODE_PATH": "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules",
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_github_token_here"
      }
    }
  }
}
```

### Memory MCP Server

**Package:** `@modelcontextprotocol/server-memory`  
**Purpose:** Store and retrieve information across conversations.  
**Installation:** `npm install -g @modelcontextprotocol/server-memory`

**Windows Configuration:**
```json
{
  "mcpServers": {
    "memory": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": [
        "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@modelcontextprotocol\\server-memory\\dist\\index.js"
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

### Brave Search MCP Server

**Package:** `@modelcontextprotocol/server-brave-search`  
**Purpose:** Access Brave Search API.  
**Installation:** `npm install -g @modelcontextprotocol/server-brave-search`

**Windows Configuration:**
```json
{
  "mcpServers": {
    "brave-search": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": [
        "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@modelcontextprotocol\\server-brave-search\\dist\\index.js"
      ],
      "env": {
        "APPDATA": "C:\\Users\\YourUsername\\AppData\\Roaming\\",
        "PATH": "C:\\Program Files\\nodejs",
        "NODE_PATH": "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules",
        "BRAVE_API_KEY": "your_brave_api_key_here"
      }
    }
  }
}
```

### SQLite MCP Server

**Package:** `mcp-server-sqlite`  
**Purpose:** Query SQLite databases.  
**Installation:** `pip install mcp-server-sqlite`

**Windows Configuration:**
```json
{
  "mcpServers": {
    "sqlite": {
      "command": "python",
      "args": [
        "-m",
        "mcp_server_sqlite",
        "--db-path",
        "C:\\Path\\To\\database.db"
      ]
    }
  }
}
```

## Community MCP Servers

These are popular community-created MCP servers.

### Desktop Commander

**Package:** `@wonderwhy-er/desktop-commander`  
**Purpose:** Execute terminal commands and manage processes.  
**Installation:** `npm install -g @wonderwhy-er/desktop-commander`

**Windows Configuration:**
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

### MCP Installer

**Package:** `@anaisbetts/mcp-installer`  
**Purpose:** Install other MCP servers directly from Claude.  
**Installation:** `npm install -g @anaisbetts/mcp-installer`

**Windows Configuration:**
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

### Sequential Thinking

**Package:** `@modelcontextprotocol/server-sequential-thinking`  
**Purpose:** Helps Claude break down complex problems into steps.  
**Installation:** `npm install -g @modelcontextprotocol/server-sequential-thinking`

**Windows Configuration:**
```json
{
  "mcpServers": {
    "sequential-thinking": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": [
        "C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@modelcontextprotocol\\server-sequential-thinking\\dist\\index.js"
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

## Using Multiple MCP Servers

You can configure multiple MCP servers in the same `claude_desktop_config.json` file:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": ["C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@modelcontextprotocol\\server-filesystem\\dist\\index.js", "C:\\Users\\YourUsername\\Documents"]
    },
    "github": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": ["C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@modelcontextprotocol\\server-github\\dist\\index.js"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_github_token_here"
      }
    },
    "memory": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": ["C:\\Users\\YourUsername\\AppData\\Roaming\\npm\\node_modules\\@modelcontextprotocol\\server-memory\\dist\\index.js"]
    }
  }
}
```

## Finding More MCP Servers

- [Official MCP Servers Repository](https://github.com/modelcontextprotocol/servers)
- [Awesome MCP Servers List](https://github.com/punkpeye/awesome-mcp-servers)
- [MCP Hub](https://mcphub.dev/) - Community registry of MCP servers
