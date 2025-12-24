# MCP Server Guide

This guide covers how MCP (Model Context Protocol) servers work in Aura Frog and how to create your own.

## What is MCP?

MCP (Model Context Protocol) is an open protocol by Anthropic that enables LLMs to interact with external tools and data sources. Instead of custom bash scripts, Aura Frog uses MCP servers for all integrations.

**Benefits:**
- **Standard protocol** - Works with any MCP-compatible client
- **Auto-install** - `npx` downloads servers on first use
- **Zero-config** - Just add credentials to `.envrc`
- **Community-maintained** - Benefit from open-source improvements

## Included MCP Servers

### Always Enabled

| Server | Package | Purpose |
|--------|---------|---------|
| context7 | @upstash/context7-mcp | Library documentation lookup |
| playwright | @playwright/mcp | E2E testing, browser automation |
| filesystem | @modelcontextprotocol/server-filesystem | File read/write operations |
| memory | @modelcontextprotocol/server-memory | Persistent key-value storage |

### Optional (Require Credentials)

| Server | Package | Purpose |
|--------|---------|---------|
| github | @modelcontextprotocol/server-github | Git/GitHub operations |
| vitest | @madrus/vitest-mcp-server | Unit testing, coverage |
| atlassian | mcp-remote (Official Atlassian) | JIRA + Confluence |
| figma | figma-developer-mcp | Design token extraction |
| slack | slack-mcp-server | Team notifications |

## Configuration

MCP servers are configured in `.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "my-server": {
      "command": "npx",
      "args": ["-y", "my-mcp-package@latest"],
      "env": {
        "API_KEY": "${MY_API_KEY}"
      },
      "disabled": false
    }
  }
}
```

**Fields:**
- `command` - Command to run (usually `npx` or `node`)
- `args` - Arguments (package name for npx)
- `env` - Environment variables (use `${VAR}` for .envrc values)
- `disabled` - Set `true` to disable

## Creating Your Own MCP Server

### Option 1: TypeScript (Recommended)

**1. Create Project**

```bash
mkdir my-mcp-server
cd my-mcp-server
npm init -y
npm install @modelcontextprotocol/sdk typescript
```

**2. Create Server**

```typescript
// src/index.ts
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";

const server = new Server(
  { name: "my-server", version: "1.0.0" },
  { capabilities: { tools: {} } }
);

// Define a tool
server.setRequestHandler("tools/list", async () => ({
  tools: [
    {
      name: "my_tool",
      description: "Does something useful",
      inputSchema: {
        type: "object",
        properties: {
          input: { type: "string", description: "Input value" }
        },
        required: ["input"]
      }
    }
  ]
}));

// Handle tool calls
server.setRequestHandler("tools/call", async (request) => {
  if (request.params.name === "my_tool") {
    const input = request.params.arguments.input;
    // Do something with input
    return {
      content: [{ type: "text", text: `Processed: ${input}` }]
    };
  }
  throw new Error(`Unknown tool: ${request.params.name}`);
});

// Start server
const transport = new StdioServerTransport();
await server.connect(transport);
```

**3. Build and Test**

```bash
npx tsc
node dist/index.js
```

**4. Register in mcp.json**

```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["/path/to/my-mcp-server/dist/index.js"]
    }
  }
}
```

### Option 2: Python

```python
# server.py
from mcp.server import Server
from mcp.server.stdio import stdio_server

app = Server("my-server")

@app.tool()
async def my_tool(input: str) -> str:
    """Does something useful"""
    return f"Processed: {input}"

async def main():
    async with stdio_server() as (read_stream, write_stream):
        await app.run(read_stream, write_stream)

if __name__ == "__main__":
    import asyncio
    asyncio.run(main())
```

**Register:**

```json
{
  "mcpServers": {
    "my-server": {
      "command": "python",
      "args": ["/path/to/server.py"]
    }
  }
}
```

## Integrating with Aura Frog Auto-Invoke

To make your MCP server auto-invoke based on patterns, update `.cursor/rules/skills/auto-invoke/mcp-integrations.mdc`:

```markdown
### My Custom Server
**Trigger:** "my keyword", "another pattern"

**Action:** Use `my-server` MCP tools:
- `my_tool` - Description of tool

**Chain:**
1. **MCP:** my-server tools
2. **Agent:** relevant-agent
3. **Skill:** relevant-skill
```

Add to the Agent Selection Matrix:

```markdown
| my-server | my-agent | my-skill | my-expert |
```

## Publishing Your MCP Server

### To npm (Public)

```bash
# Update package.json
{
  "name": "@yourorg/my-mcp-server",
  "bin": { "my-mcp-server": "./dist/index.js" }
}

# Publish
npm publish --access public
```

Users can then use:
```json
{
  "mcpServers": {
    "my-server": {
      "command": "npx",
      "args": ["-y", "@yourorg/my-mcp-server"]
    }
  }
}
```

### Private (Local Only)

Keep the server in your project:
```
.cursor/
├── mcp-servers/
│   └── my-server/
│       ├── package.json
│       ├── src/
│       └── dist/
```

Reference locally:
```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": [".cursor/mcp-servers/my-server/dist/index.js"]
    }
  }
}
```

## MCP Server Examples

### JIRA Server (Simplified)

```typescript
server.setRequestHandler("tools/list", async () => ({
  tools: [
    {
      name: "get_issue",
      description: "Get JIRA issue details",
      inputSchema: {
        type: "object",
        properties: {
          key: { type: "string", description: "Issue key (e.g., PROJ-123)" }
        },
        required: ["key"]
      }
    }
  ]
}));

server.setRequestHandler("tools/call", async (request) => {
  if (request.params.name === "get_issue") {
    const key = request.params.arguments.key;
    const response = await fetch(
      `${process.env.JIRA_URL}/rest/api/3/issue/${key}`,
      {
        headers: {
          Authorization: `Basic ${Buffer.from(
            `${process.env.JIRA_EMAIL}:${process.env.JIRA_TOKEN}`
          ).toString("base64")}`
        }
      }
    );
    const issue = await response.json();
    return {
      content: [{
        type: "text",
        text: JSON.stringify(issue, null, 2)
      }]
    };
  }
});
```

### Database Query Server

```typescript
const tools = [
  {
    name: "query",
    description: "Run SQL query",
    inputSchema: {
      type: "object",
      properties: {
        sql: { type: "string" }
      },
      required: ["sql"]
    }
  }
];

// In handler:
const result = await db.query(request.params.arguments.sql);
return { content: [{ type: "text", text: JSON.stringify(result) }] };
```

## Resources

- [MCP Specification](https://modelcontextprotocol.io/docs)
- [MCP TypeScript SDK](https://github.com/modelcontextprotocol/typescript-sdk)
- [MCP Python SDK](https://github.com/modelcontextprotocol/python-sdk)
- [Official MCP Servers](https://github.com/modelcontextprotocol/servers)
- [MCP Server Registry](https://github.com/modelcontextprotocol/servers#community-servers)

## Troubleshooting

### Server Not Starting

1. Check command path is correct
2. Verify `npx` can access the package
3. Check environment variables are set
4. Look at Cursor's MCP logs

### Tools Not Appearing

1. Verify `tools/list` returns correct schema
2. Check server connects via stdio
3. Restart Cursor after changes

### Environment Variables Not Working

1. Use `${VAR_NAME}` syntax in mcp.json
2. Ensure `.envrc` is sourced
3. Variables must be exported

---

**Version:** 1.3.0
**Last Updated:** 2025-12-22
