# Mockup Builder

> Point an AI agent at any URL → it extracts the design system → another agent creates matching HTML mockups on demand. No Figma. No design skills. Just fast demos.

## What this is

A two-agent system powered by **GitHub Copilot** (or any AI agent with Playwright access) that lets you:

1. **Extract** a design system from any live web app (colors, fonts, spacing, components)
2. **Generate** realistic HTML/CSS mockups that match the app's look-and-feel
3. **Iterate** with natural language feedback in seconds

```
┌─────────────────┐       ┌──────────────┐       ┌──────────────────┐
│  User provides   │──────▶│  Agent 1:    │──────▶│  design-guide.md │
│  URLs/screenshots│       │  Extract     │       │  base-styles.css │
└─────────────────┘       └──────────────┘       └────────┬─────────┘
                                                          │
┌─────────────────┐       ┌──────────────┐                │
│  User provides   │──────▶│  Agent 2:    │◀───────────────┘
│  requirements    │       │  Build       │
│  + feedback      │       │              │──────▶ HTML/CSS mockup
└─────────────────┘       └──────────────┘
```

## Prerequisites

- [GitHub Copilot CLI](https://githubnext.com/projects/copilot-cli/) (or VS Code with Copilot Chat)
- [Playwright MCP server](https://github.com/microsoft/playwright-mcp) (`@playwright/mcp`) configured in your Copilot environment — see setup below
- Node.js 18+ (the Playwright MCP runs via `npx`, and you'll also need it for the local preview server)

## Quick Start

### 1. Configure the Playwright MCP server

Both agents drive a real browser via the [Playwright MCP](https://github.com/microsoft/playwright-mcp) server. Add it to your Copilot environment.

**Copilot CLI** — edit `~/.copilot/mcp-config.json` (Windows: `%USERPROFILE%\.copilot\mcp-config.json`) and add under `mcpServers`:

```json
"playwright": {
  "type": "stdio",
  "command": "npx",
  "args": ["@playwright/mcp@latest", "--browser", "msedge"]
}
```

Or use the slash command: `/mcp add` and follow the prompts.

**VS Code** — edit `%APPDATA%\Code\User\mcp.json` (macOS/Linux: `~/.config/Code/User/mcp.json`) and add the same entry under `servers` (note the different top-level key):

```json
"playwright": {
  "type": "stdio",
  "command": "npx",
  "args": ["@playwright/mcp@latest", "--browser", "msedge"]
}
```

> **Tip:** keep both files in sync. The CLI uses `mcpServers`, VS Code uses `servers`, but each server entry has the same shape.

Swap `msedge` for `chrome`, `firefox`, or `webkit` if you prefer a different browser. Omit `--browser` to use the Playwright default (Chromium).

### 2. Install the skills

Copy the skill folders into your Copilot skills directory:

```bash
# Copy skills to your Copilot config
cp -r skills/mockup-extract ~/.copilot/skills/
cp -r skills/mockup-build ~/.copilot/skills/
```

Or on Windows:
```powershell
Copy-Item -Recurse skills\mockup-extract $env:USERPROFILE\.copilot\skills\
Copy-Item -Recurse skills\mockup-build $env:USERPROFILE\.copilot\skills\
```

### 3. Extract a design system from any URL

In Copilot CLI or VS Code Copilot Chat:

```
/mockup-extract

Extract the design system from https://your-app.com/dashboard
```

The agent will:
- Navigate to the URL with Playwright
- Take reference screenshots
- Extract colors, fonts, spacing, border radius, shadows from computed styles
- Produce `design-guide.md` (structured design system) and `base-styles.css` (ready-to-use CSS)

### 4. Generate mockups

```
/mockup-build

Create a mockup of a settings page with:
- A user profile form (name, email, role dropdown)
- Notification preferences (toggle switches)
- A "Save Changes" button
```

The agent will:
- Read the design guide
- Build a standalone HTML file using the extracted design tokens
- Preview it with Playwright and show you a screenshot

### 5. Iterate

```
"Make the form two columns instead of one"
"Add a danger zone section at the bottom with a delete account button"
"The spacing feels too tight — add more breathing room"
```

Each iteration takes ~30 seconds for small changes.

## Project Structure

```
mockup-builder/
├── README.md                           ← you are here
├── skills/
│   ├── mockup-extract/
│   │   └── SKILL.md                    ← Agent 1: design extraction prompt
│   └── mockup-build/
│       └── SKILL.md                    ← Agent 2: mockup builder prompt
├── docs/
│   ├── design-guide-template.md        ← template for the design guide output
│   └── architecture.md                 ← detailed system architecture
└── output/                             ← created at runtime (gitignored)
    ├── design-guide.md
    ├── base-styles.css
    ├── reference/
    ├── mockups/
    └── screenshots/
```

## How It Works

### Agent 1: Design Extraction (`/mockup-extract`)

Uses Playwright to:
1. Navigate to the target URL
2. Extract `getComputedStyle()` from key elements (buttons, headers, tables, inputs, etc.)
3. Handle iframes (common in Microsoft apps like Power BI/Fabric)
4. Click through interactions to capture dialog, hover, and selected states
5. Convert RGB values to hex
6. Produce a structured `design-guide.md` with color palette, typography, spacing, component catalog
7. Generate `base-styles.css` with CSS custom properties and reusable component classes

### Agent 2: Mockup Builder (`/mockup-build`)

1. Reads the design guide and CSS
2. Builds semantic HTML5 pages using the design system's classes
3. Uses realistic placeholder data (not "Lorem ipsum")
4. Previews with Playwright, screenshots, and shows the result
5. Iterates on natural language feedback

### Handoff contract

The two agents are decoupled — they communicate through files:
- `design-guide.md` — human-readable design system documentation
- `base-styles.css` — machine-usable CSS with all tokens as custom properties

This means:
- You can manually edit the design guide to override extracted values
- You can use the CSS directly in your own projects
- You can swap Agent 2 for any other tool that reads CSS

## Auth-Protected Pages

If the target URL requires login:
1. Agent 1 will detect the login wall and ask you
2. You can either:
   - Navigate there manually first (so the browser session has cookies)
   - Provide a session cookie for the agent to inject
   - Upload screenshots instead of using a live URL

## Customization

### Output location

By default, output goes to `~/mockup/`. To change this, edit the output path in both `SKILL.md` files.

### Adding components

If the extracted design system doesn't cover a component you need, Agent 2 will extrapolate from the existing design language. You can also manually add component styles to `base-styles.css`.

### Multiple design systems

For multiple apps, use separate output directories:
```
~/mockup-app-a/    ← Design system for App A
~/mockup-app-b/    ← Design system for App B
```

## License

MIT
