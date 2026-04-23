# Design Guide Template

> This template shows the structure that Agent 1 (`/mockup-extract`) produces. You don't need to fill this in manually — the extraction agent generates it automatically from a live URL.

---

# Design Guide: [App Name]

## Overview
- **Design language**: [e.g., "Clean, spacious, Fluent UI-inspired with soft shadows and 4px border radius"]
- **Component framework**: [e.g., "Fluent UI v9" or "Custom — closest to Tailwind utility classes"]
- **Layout approach**: [e.g., "Fixed sidebar (280px) + fluid main content, max-width 1200px"]
- **Primary accent**: [hex + description, e.g., "#0078D4 — Microsoft blue"]

## Color Palette

| Token              | Hex       | Usage                                    |
|--------------------|-----------|------------------------------------------|
| `primary`          | `#XXXXXX` | Primary buttons, links, active states    |
| `primary-hover`    | `#XXXXXX` | Button hover state                       |
| `header-bg`        | `#XXXXXX` | Top header bar                           |
| `header-text`      | `#XXXXXX` | Header text & icons                      |
| `background`       | `#XXXXXX` | Page background                          |
| `surface`          | `#XXXXXX` | Cards, panels, content areas             |
| `text-primary`     | `#XXXXXX` | Headings, body text                      |
| `text-secondary`   | `#XXXXXX` | Secondary text, captions                 |
| `text-muted`       | `#XXXXXX` | Placeholders, disabled text              |
| `border`           | `#XXXXXX` | Input borders, dividers                  |
| `selected`         | `#XXXXXX` | Selected item background                 |
| `overlay`          | `rgba(0,0,0,0.X)` | Modal backdrop                  |

## Typography

| Role       | Font Family      | Size  | Weight | Line Height |
|------------|------------------|-------|--------|-------------|
| h1         | [extracted]      | XXpx  | 600    | XXpx        |
| h2         | [extracted]      | XXpx  | 600    | XXpx        |
| h3         | [extracted]      | XXpx  | 600    | XXpx        |
| h4         | [extracted]      | XXpx  | 700    | XXpx        |
| body       | [extracted]      | XXpx  | 400    | XXpx        |
| caption    | [extracted]      | XXpx  | 400    | XXpx        |
| label      | [extracted]      | XXpx  | 600    | XXpx        |

## Spacing Scale

`Xpx — Xpx — Xpx — Xpx — Xpx — Xpx`

## Border & Shadow

| Token              | Value                        | Usage                    |
|--------------------|------------------------------|--------------------------|
| `radius-sm`        | `Xpx`                       | Buttons, inputs          |
| `radius-md`        | `Xpx`                       | Cards, dialogs           |
| `shadow-dialog`    | `[extracted]`                | Modals                   |
| `shadow-callout`   | `[extracted]`                | Tooltips, popovers       |

## Component Catalog

### Buttons

**Primary (Filled)**
```css
background: var(--color-primary);
color: #FFFFFF;
border-radius: Xpx;
padding: Xpx Xpx;
font-size: Xpx;
font-weight: 600;
```

**Secondary (Outlined)**
```css
background: var(--color-surface);
color: var(--color-text);
border: 1px solid var(--color-border);
```

**Subtle / Ghost**
```css
background: transparent;
color: var(--color-text-secondary);
```

### Dialog / Modal
```css
background: var(--color-surface);
border-radius: var(--radius-md);
box-shadow: var(--shadow-dialog);
padding: 24px;
```

### Form Inputs
```css
border: 1px solid var(--color-border);
border-radius: var(--radius-sm);
height: 32px;
padding: 0 12px;
font-size: 14px;
```

### Tables
```css
/* Header: font-weight 600, border-bottom */
/* Rows: 44px height, border-bottom subtle */
/* Hover: surface-secondary background */
```

### Tabs
```css
/* Active: border-bottom 2px solid, font-weight 600 */
/* Inactive: transparent border, font-weight 400 */
```

### [Other components as observed]
...

## Layout Templates

### Layout: [Name]
```
┌──────────────────────────────────┐
│ Header (48px)                    │
├─────┬────────────────────────────┤
│Side │ Main Content               │
│bar  │                            │
│     │                            │
└─────┴────────────────────────────┘
```

## CSS Custom Properties

```css
:root {
  --color-primary: #XXXXXX;
  --color-primary-hover: #XXXXXX;
  --color-bg: #XXXXXX;
  --color-surface: #XXXXXX;
  --color-text: #XXXXXX;
  --color-text-secondary: #XXXXXX;
  --color-border: #XXXXXX;
  --font-family: "...", sans-serif;
  --font-size-base: 14px;
  --radius-sm: 4px;
  --radius-md: 8px;
  --shadow-dialog: ...;
  --space-sm: 8px;
  --space-md: 16px;
  --space-lg: 24px;
}
```

## Reference Screenshots

| File                  | Description          |
|-----------------------|----------------------|
| `reference/page-1.png`| Main dashboard view  |
| `reference/page-2.png`| Detail/form page     |
