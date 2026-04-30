# Mockup Builder

> Point an AI agent at any URL → it extracts the design system → another agent creates matching HTML mockups on demand. No Figma. No design skills. Just fast demos.

## What this is

A multi-agent system powered by **GitHub Copilot** (or any AI agent with Playwright access) that lets you:

1. **Extract** a design system from any live web app (colors, fonts, spacing, components)
2. **Generate** realistic HTML/CSS mockups that match the app's look-and-feel
3. **Build end-to-end demos** — complete, multi-screen clickable journeys with navigation and interactions
4. **WOW Mode** — build stunning, innovative UI from scratch with no design system required
5. **Iterate** with natural language feedback in seconds

```
┌─────────────────┐       ┌──────────────┐       ┌──────────────────┐
│  User provides   │──────▶│  Agent 1:    │──────▶│  design-guide.md │
│  URLs/screenshots│       │  Extract     │       │  base-styles.css │
└─────────────────┘       └──────────────┘       └────────┬─────────┘
                                                          │
┌─────────────────┐       ┌──────────────┐                │
│  User provides   │──────▶│  Agent 2:    │◀───────────────┘
│  requirements    │       │  Build       │
│  + feedback      │       │  (single)    │──────▶ HTML/CSS mockup
└─────────────────┘       └──────────────┘

┌─────────────────┐       ┌──────────────┐
│  User provides   │──────▶│  Agent 3:    │
│  requirements    │       │  WOW Mode    │──────▶ Stunning HTML/CSS mockup
│  + theme hint    │       │  (no design  │        (gradients, animations,
└─────────────────┘       │   system     │         glassmorphism, delight)
                          │   needed)    │
                          └──────────────┘

┌─────────────────┐       ┌──────────────┐
│  User provides   │──────▶│  Agent 4:    │
│  journey desc.   │       │  End-to-End  │──────▶ Multi-screen demo
│  + feedback      │       │  Demo        │        with navigation
└─────────────────┘       └──────────────┘
```

## Prerequisites

- [GitHub Copilot CLI](https://githubnext.com/projects/copilot-cli/) (or VS Code with Copilot Chat)
- [Playwright MCP server](https://github.com/microsoft/playwright-mcp) (`@playwright/mcp`) configured in your Copilot environment — see setup below
- Node.js 18+ (the Playwright MCP runs via `npx`, and you'll also need it for the local preview server)

## Quick Start

### 1. Configure the Playwright MCP server

All agents drive a real browser via the [Playwright MCP](https://github.com/microsoft/playwright-mcp) server. Add it to your Copilot environment.

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
cp -r skills/mockup-wow ~/.copilot/skills/
cp -r skills/mockup-end2end ~/.copilot/skills/
```

Or on Windows:
```powershell
Copy-Item -Recurse skills\mockup-extract $env:USERPROFILE\.copilot\skills\
Copy-Item -Recurse skills\mockup-build $env:USERPROFILE\.copilot\skills\
Copy-Item -Recurse skills\mockup-wow $env:USERPROFILE\.copilot\skills\
Copy-Item -Recurse skills\mockup-end2end $env:USERPROFILE\.copilot\skills\
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

### 5. Build an end-to-end demo

Need a complete, clickable, multi-screen demo instead of a single page?

```
/mockup-end2end

Build an end-to-end demo for the project management feature:
- Project list view
- Project detail / edit form
- Delete confirmation dialog
- Post-save success screen
```

> ⚠️ **This mode thinks and builds longer.** The agent will plan the full user journey and present a Screen Inventory for your approval before writing a single line of HTML. Expect several minutes of build time for a complete flow.

The agent will:
- Warn you upfront and wait for confirmation before starting
- Map the entire user journey (happy path + branch states)
- Present a Screen Inventory for approval
- Build every screen as a separate HTML file with consistent data
- Link all screens together with navigation and inline JavaScript interactions (modals, confirmations, form submissions)
- Generate an `index.html` launch pad that shows all screens with thumbnails
- Screenshot every screen and show them all at once

### 6. WOW Mode — build without a design system

When you want something breathtaking and innovative without extracting an existing design:

```
/mockup-wow

Build a project dashboard with real-time activity feed, team presence, and KPI cards.
Make it dark mode with a vibrant accent.
```

The agent will:
- Invent a stunning color palette and typography pair
- Build an innovative layout (bento grid, split hero, or floating nav)
- Apply glassmorphism, gradient buttons, entrance animations, and micro-interactions
- Use realistic placeholder data — not "Lorem ipsum"
- Preview with Playwright and show a screenshot

**Example trigger phrases:**
- "surprise me"
- "wow mode"
- "make it beautiful"
- "best possible UX"
- "no constraints, just make it amazing"

### 7. Iterate

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
├── package.ps1                         ← one-line zip helper for sharing demos
├── skills/
│   ├── mockup-extract/
│   │   └── SKILL.md                    ← Agent 1: design extraction prompt
│   ├── mockup-build/
│   │   └── SKILL.md                    ← Agent 2: single-page mockup builder prompt
│   ├── mockup-wow/
│   │   └── SKILL.md                    ← Agent 3: WOW mode — stunning UI from scratch
│   └── mockup-end2end/
│       └── SKILL.md                    ← Agent 4: end-to-end demo builder prompt
├── docs/
│   ├── design-guide-template.md        ← template for the design guide output
│   └── architecture.md                 ← detailed system architecture
└── <demo-name>/                        ← ONE per demo (e.g. output-rules/, business-rules/)
    ├── design-guide.md                 ← design system
    ├── base-styles.css                 ← CSS tokens + component classes
    ├── fluent-icons.css                ← (optional) Fluent icon set
    ├── reference/                      ← source screenshots
    └── mockups/
        ├── index.html                  ← launch pad linking every screen
        ├── <name>.html                 ← individual mockups
        ├── screenshots/
        └── tools/
```

**Each `<demo-name>/` folder is a self-contained, zip-and-share unit.** See [Sharing a demo](#sharing-a-demo) below.

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
4. Injects the **Design Vocabulary Overlay** into every mockup (see below)
5. Previews with Playwright, screenshots, and shows the result
6. Iterates on natural language feedback

### Agent 3: WOW Mode (`/mockup-wow`)

Requires no extracted design system. Creates stunning, innovative UX from scratch:

1. Chooses an award-worthy color palette, typography pair, and layout archetype
2. Applies modern CSS techniques: glassmorphism, gradient buttons, mesh backgrounds, layered shadows
3. Adds entrance animations (`fadeUp`, `slideIn`), hover micro-interactions, and delight details
4. Uses realistic placeholder data with plausible domain content
5. Previews with Playwright, screenshots, and shows the result
6. Iterates on feedback with the same speed as Agent 2

### Agent 4: End-to-End Demo Builder (`/mockup-end2end`)

> ⚠️ Warns user upfront — this mode thinks and builds significantly longer than a single-page mockup.

1. Reads the design guide and CSS
2. **Plans the full user journey** — maps every screen, branch state, and interactive moment
3. **Presents a Screen Inventory** for the user to approve before building starts
4. Builds every screen as a separate HTML file with consistent placeholder data across all files
5. Links screens together with navigation links and inline JavaScript (modals, confirmations, form submissions → redirect)
6. Generates `<demo>/mockups/index.html` — a thumbnail launch pad for the complete demo
7. Screenshots every screen and presents them all at once
8. Iterates at the journey level (add/remove screens) or screen level (tweak individual files)

### Handoff contract

Agent 1 is decoupled from both builder agents — they communicate through the same files:
- `design-guide.md` — human-readable design system documentation
- `base-styles.css` — machine-usable CSS with all tokens as custom properties

This means:
- You can manually edit the design guide to override extracted values
- You can use the CSS directly in your own projects
- You can swap Agent 2 for any other tool that reads CSS

## Design Vocabulary Overlay

Every mockup generated by Agent 2 includes a floating **"Show Labels"** toggle in the bottom-right corner. Click it to reveal the design system name and CSS class of every component on the page.

**Why it's useful:**

Without shared vocabulary, feedback like "make the blue button less important" is ambiguous. With the overlay, users can say "change `.btn-primary` to `.btn-secondary`" — which is precise and directly actionable.

**How it works:**

1. A floating `🏷️ Show Labels` button appears at the bottom-right of every mockup
2. Clicking it scans the DOM and stamps each recognized component with a chip label
3. A one-time legend panel explains how to use the names in feedback
4. Labels include layout shells (`.header`, `.sidebar`), buttons (`.btn-primary`), forms, tables, dialogs, and more

A working standalone demo is available at [`docs/examples/overlay-demo.html`](docs/examples/overlay-demo.html).

> 💡 After the first screenshot, the agent will remind you: "Click **Show Labels** (bottom-right) to see the name of every component — use those names when giving feedback."

## Sharing a demo

Every `<demo-name>/` folder is self-contained — design system + mockups + reference + screenshots in one place. There are no external runtime dependencies, no build step, and no CDN/font requirements (icons are inline SVG).

### One-line zip (recommended)

From the workspace root:

```powershell
.\package.ps1 <demo-name>
```

Produces `<demo-name>.zip` in the workspace root. Default mode includes everything in the demo folder. Use `-Lean` to drop reference screenshots and helper tools (≈70 KB instead of ≈1.3 MB on a typical demo):

```powershell
.\package.ps1 <demo-name> -Lean
```

Override the destination path:

```powershell
.\package.ps1 <demo-name> -OutputPath C:\Temp\demo-for-stakeholder.zip
```

### Manual zip (no script)

```powershell
Compress-Archive -Path <demo-name> -DestinationPath <demo-name>.zip -Force
```

### What the recipient does

1. Unzip anywhere.
2. Open `<demo-name>/mockups/index.html` in any modern browser (Edge, Chrome, Firefox, Safari).
3. Click around — every screen is fully interactive (modals, tabs, navigation).

No install. No server. Works offline.

### What to share for what audience

| Audience | Use | Why |
|---|---|---|
| Engineer building it | Default zip | Includes design-guide.md + base-styles.css + reference screenshots |
| PM/exec walkthrough | `-Lean` zip | Just the live HTML — smaller, focused on the demo not the source material |
| Public link / wide share | Host the demo folder on GitHub Pages or Azure Static Web Apps | Persistent URL, no re-share required when you update |

### Tier check (Microsoft hygiene)

Demos using public sample domains (e.g. ZavaStadium) are tier-1 / public-safe. Before sharing externally, verify the demo contains no customer names, tenant IDs, ICM references, codenames, or unannounced strategy. If it does, treat the zip as tier-3 and don't share outside Microsoft.

## Auth-Protected Pages

If the target URL requires login:
1. Agent 1 will detect the login wall and ask you
2. You can either:
   - Navigate there manually first (so the browser session has cookies)
   - Provide a session cookie for the agent to inject
   - Upload screenshots instead of using a live URL

## Customization

### Demo folder convention

Every demo lives in its own self-contained folder at the workspace root. Pick a kebab-case name when you start a new one (e.g. `business-rules/`, `entity-type-view/`). All four agents read and write inside `<demo-name>/`. The folder structure is fixed (see [Project Structure](#project-structure)), so any agent can pick up where another left off.

**Why one folder per demo:**
- Each demo is independently shareable as a single zip.
- No cross-demo coupling — you can delete or rename one without breaking another.
- Stakeholders only get the demo they care about, not your whole workspace.

### Adding components

If the extracted design system doesn't cover a component you need, Agent 2 will extrapolate from the existing design language. You can also manually add component styles to `<demo>/base-styles.css`.

### Multiple demos in one workspace

Normal pattern. Each demo gets its own folder:
```
mockup-builder/
├── business-rules/
├── entity-type-view/
└── dashboard-redesign/
```
Agents will ask which one to build into when more than one exists.

## License

MIT
