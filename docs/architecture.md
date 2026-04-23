# Architecture

## System Design

Mockup Builder is a two-agent system where Agent 1 (extraction) and Agent 2 (building) are decoupled through a file-based handoff contract.

```
                          ┌─────────────────────────────┐
                          │     Handoff Artifacts        │
                          │                             │
  ┌───────────┐           │  design-guide.md            │           ┌───────────┐
  │ Agent 1:  │──writes──▶│  base-styles.css            │──reads──▶│ Agent 2:  │
  │ Extract   │           │  reference/*.png            │           │ Build     │
  └───────────┘           │                             │           └───────────┘
       ▲                  └─────────────────────────────┘                │
       │                                                                │
  URL / screenshots                                              HTML mockups
  from user                                                      + screenshots
                                                                 to user
```

### Why files, not API calls?

1. **Human-editable**: you can manually tweak the design guide before generating mockups.
2. **Debuggable**: if a mockup looks wrong, check the guide — the problem is always in one of two places.
3. **Reusable**: the CSS works outside this system — drop it into any project.
4. **Agent-agnostic**: any AI that reads markdown and writes HTML can be Agent 2.

## Agent 1: Design Extraction

### Playwright workflow

```
navigate(url)
  → screenshot (full page)
  → snapshot (accessibility tree → understand structure)
  → evaluate(getComputedStyle) on:
      - body, header, nav, buttons, inputs, headings, tabs, tables
  → click interactive elements (list items, buttons that open dialogs)
      → screenshot each state
      → extract dialog/modal styles
  → find iframes → enter frame → repeat extraction
  → convert rgb() → hex
  → write design-guide.md
  → write base-styles.css
```

### Iframe handling

Many enterprise apps (Power BI, Fabric, Azure Portal) use nested iframes. The extraction agent handles this via:

```js
// Method 1: Playwright frame API
const frame = page.frames().find(f => f.url().includes('target'));
await frame.evaluate(() => { /* extract styles */ });

// Method 2: MCP ref-based access (crosses iframe boundaries)
// Use element refs from browser_snapshot which already resolve into iframes
```

### Style extraction targets

| Element selector          | What we extract                              |
|---------------------------|----------------------------------------------|
| `body`                    | Font family, base size, background color     |
| `[role="banner"]`         | Header height, bg, text color                |
| `[role="navigation"]`     | Sidebar width, bg, item styles               |
| `button`                  | All button variants (bg, color, radius, padding) |
| `[role="dialog"]`         | Dialog bg, radius, shadow, padding           |
| `[role="tab"]`            | Active/inactive tab styles                   |
| `th`, `td`, `[role="row"]`| Table header/cell/row styles                |
| `input`, `[role="textbox"]`| Input border, radius, height, font          |
| `h1`–`h6`                | Heading hierarchy (size, weight, color)      |

## Agent 2: Mockup Builder

### Build workflow

```
read design-guide.md
  → understand color palette, typography, spacing
read base-styles.css
  → know available CSS classes
receive user requirements
  → choose layout template
  → compose page with existing CSS classes
  → add realistic placeholder data
  → write mockups/<name>.html
  → start http-server (if not running)
  → navigate Playwright to localhost
  → screenshot → show to user
  → iterate on feedback (edit → re-screenshot → show)
```

### HTML output constraints

- Self-contained: each mockup is one HTML file + shared CSS
- No build step: opens in any browser directly
- No frameworks: vanilla HTML/CSS only
- Semantic: uses proper HTML5 elements and ARIA roles
- Accessible: proper contrast, focus indicators
- Responsive: flexbox/grid, works at 1440px and 1024px

## Output directory structure

```
~/mockup/
├── design-guide.md          ← Agent 1 output (human-readable design system)
├── base-styles.css          ← Agent 1 output (CSS custom properties + classes)
├── reference/               ← Agent 1 output (screenshots from live app)
│   ├── home.png
│   └── detail.png
├── mockups/                 ← Agent 2 output (HTML mockup files)
│   ├── settings-page.html
│   └── dashboard-v2.html
└── screenshots/             ← Agent 2 output (screenshots of mockups)
    ├── settings-page.png
    └── dashboard-v2.png
```

## Extensibility

### Custom agents

The skills are Copilot-compatible markdown prompts. They work with:
- GitHub Copilot CLI
- VS Code Copilot Chat (via `/skills`)
- Any agent framework that reads markdown system prompts

### Multiple design systems

Run extraction against different apps into separate directories. Agent 2 reads whichever directory you point it to.

### Integration with CI/CD

The extraction could be automated in a pipeline:
1. Scheduled Playwright run against staging
2. Produces updated design-guide.md
3. PR with visual diff if tokens changed
