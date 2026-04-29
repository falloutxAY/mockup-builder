# Design Guide: Microsoft Fabric — Ontology Rules Editor

## Overview
- **Design language**: Clean, spacious, Fluent UI v9 — neutral grays with teal accent, low-contrast surfaces, accessible typography
- **Component framework**: Fluent UI v9 (React)
- **Layout approach**: Compact icon-only sidebar (48px) + top header bar + fluid content area, left-aligned form
- **Primary accent**: `#117865` — teal/green (used for Save button, workspace chip, selected radio, entity highlights)

## Color Palette

| Token | Hex | Usage |
|-------|-----|-------|
| `header-bg` | `#1B1B1B` | Top header bar background (estimated) |
| `header-text` | `#FFFFFF` | Header text, Fabric logo |
| `sidebar-bg` | `#FFFFFF` | Sidebar panel background |
| `sidebar-icon` | `#616161` | Sidebar navigation icons (default) |
| `sidebar-icon-active` | `#242424` | Sidebar active/hovered icon |
| `background` | `#FAF9F8` | Page content area background (estimated) |
| `surface` | `#FFFFFF` | Form sections, cards, panels |
| `primary` | `#117865` | Save button, workspace chip, radio selected, entity accent (estimated) |
| `primary-hover` | `#0E6354` | Primary button hover state (estimated) |
| `text-primary` | `#242424` | Headings, body text, labels |
| `text-secondary` | `#616161` | Helper/description text |
| `text-muted` | `#A19F9D` | Placeholder text, disabled labels (estimated) |
| `border` | `#E1DFDD` | Input borders, section dividers (estimated) |
| `border-subtle` | `#EDEBE9` | Subtle separators, table rules (estimated) |
| `required` | `#D13438` | Required field asterisk (*) (estimated) |
| `link` | `#0078D4` | "Learn more" hyperlink — standard Microsoft blue (estimated) |
| `entity-driver` | `#C43E1C` | "Driver" inline entity highlight (estimated) |
| `entity-truck` | `#5B5FC7` | "Truck" inline entity highlight (estimated) |
| `entity-license` | `#0E7363` | "Truck License" inline entity highlight (estimated) |
| `entity-driver-bg` | `#FDF6F4` | Driver chip/tag background (estimated) |
| `entity-truck-bg` | `#F0F0FF` | Truck chip/tag background (estimated) |
| `entity-license-bg` | `#F0FAF8` | Truck License chip/tag background (estimated) |
| `selected-row` | `#E6F5F2` | Selected entity row in entity browser (estimated) |
| `radio-selected` | `#117865` | Selected radio fill (estimated) |
| `tag-bg` | `#F0F0F0` | Metadata tag background (estimated) |
| `tag-text` | `#242424` | Metadata tag text |
| `popup-shadow` | `rgba(0,0,0,0.12)` | Entity browser popup shadow (estimated) |
| `entity-badge-green` | `#117865` | "E" badge for entity types (estimated) |
| `entity-badge-purple` | `#5B5FC7` | "P" badge for properties (estimated) |

## Typography

| Role | Font Family | Size | Weight | Line Height |
|------|-------------|------|--------|-------------|
| Page title (breadcrumb last) | Segoe UI | 20px | 600 | 28px (estimated) |
| Section header | Segoe UI | 14px | 600 | 20px (estimated) |
| Body text | Segoe UI | 14px | 400 | 20px (estimated) |
| Helper / description | Segoe UI | 12px | 400 | 16px (estimated) |
| Input text | Segoe UI | 14px | 400 | 20px (estimated) |
| Chip label | Segoe UI | 12px | 400 | 16px (estimated) |
| Tag label | Segoe UI | 12px | 400 | 16px (estimated) |
| Entity property type | Segoe UI | 12px | 400 | 16px (estimated) |
| Breadcrumb link | Segoe UI | 14px | 400 | 20px (estimated) |
| Breadcrumb separator | Segoe UI | 14px | 400 | 20px (estimated) |

## Spacing Scale

`4px — 8px — 12px — 16px — 20px — 24px — 32px — 48px` (estimated)

- Section vertical gap: 24px
- Field vertical gap: 16px
- Inner section padding: 16–20px
- Chip gap: 8px
- Metadata tag gap: 8px
- Content area side padding: 24–32px

## Border & Shadow

| Token | Value | Usage |
|-------|-------|-------|
| `radius-sm` | `2px` | Chips (inner edge), small controls (estimated) |
| `radius-md` | `4px` | Buttons, inputs, cards (estimated) |
| `radius-pill` | `16px` | Chip/tag pill shape (estimated) |
| `radius-dialog` | `8px` | Entity browser popup (estimated) |
| `shadow-popup` | `0 2px 8px rgba(0,0,0,0.12)` | Entity browser panel (estimated) |
| `shadow-card` | `0 1px 4px rgba(0,0,0,0.06)` | Form section cards (estimated) |
| `border-input` | `1px solid #E1DFDD` | Form inputs (estimated) |
| `border-section` | `1px solid #EDEBE9` | Section wrappers (estimated) |

## Component Catalog

### Buttons

**Primary (Save)**
```css
background: #117865;
color: #FFFFFF;
border: none;
border-radius: 4px;
padding: 6px 20px;
font-size: 14px;
font-weight: 600;
cursor: pointer;
/* estimated */
```

**Ghost / Subtle (Add item)**
```css
background: transparent;
color: #242424;
border: 1px solid #E1DFDD;
border-radius: 4px;
padding: 4px 12px;
font-size: 12px;
font-weight: 400;
/* estimated */
```

### Form Inputs

**Text Input**
```css
background: #FFFFFF;
border: 1px solid #E1DFDD;
border-radius: 4px;
height: 32px;
padding: 0 12px;
font-size: 14px;
font-family: 'Segoe UI', sans-serif;
color: #242424;
/* estimated */
```

**Text Input (focused)**
```css
border-bottom: 2px solid #117865;
outline: none;
/* estimated */
```

### Radio Buttons

```css
/* Container */
display: flex;
gap: 24px;
align-items: center;

/* Radio circle — unselected */
width: 16px;
height: 16px;
border: 1px solid #616161;
border-radius: 50%;
background: #FFFFFF;

/* Radio circle — selected */
border: 1px solid #117865;
background: #FFFFFF;
/* Inner dot: 8px #117865 circle */
/* estimated */
```

### Entity Chips (Attached ontology items)

```css
display: inline-flex;
align-items: center;
gap: 4px;
padding: 2px 8px 2px 10px;
border-radius: 16px;
font-size: 12px;
font-weight: 400;
/* Color varies by entity type — see entity tokens */
/* estimated */
```

**Driver chip**: `background: #FDF6F4; color: #C43E1C;`
**Truck chip**: `background: #F0F0FF; color: #5B5FC7;`
**Truck License chip**: `background: #F0FAF8; color: #0E7363;`

### Metadata Tags

```css
display: inline-flex;
align-items: center;
padding: 4px 10px;
background: #F0F0F0;
border-radius: 4px;
font-size: 12px;
color: #242424;
/* estimated */
```

### Tag Entity Type Dialog (Validation Gate)

Modal dialog shown on save when the rule description doesn't reference any known entity types. Forces the user to tag at least one entity type before saving.

**Dialog container**
```css
position: fixed;
top: 50%; left: 50%;
transform: translate(-50%, -50%);
width: 440px;
background: #FFFFFF;
border-radius: 8px;
box-shadow: 0 4px 24px rgba(0,0,0,0.18);
padding: 24px;
z-index: 1000;
/* estimated */
```

**Dialog title bar** — title + close (×) button
```css
display: flex;
justify-content: space-between;
align-items: flex-start;
margin-bottom: 12px;

/* Title */
font-size: 16px;
font-weight: 600;
color: #242424;

/* Close button */
background: none;
border: none;
font-size: 16px;
color: #616161;
cursor: pointer;
/* estimated */
```

**Description text**
```css
font-size: 14px;
color: #616161;
line-height: 20px;
margin-bottom: 16px;
/* estimated */
```

**Instruction text**
```css
font-size: 14px;
color: #242424;
line-height: 20px;
margin-bottom: 12px;
/* estimated */
```

**Selected entity chip** (inside search area)
```css
display: inline-flex;
align-items: center;
gap: 4px;
padding: 2px 8px 2px 6px;
border-radius: 4px;
background: #117865;
color: #FFFFFF;
font-size: 12px;
font-weight: 400;
/* "in" prefix shown before name — indicates active filter */
/* estimated */
```

**Search input** (inline with chips)
```css
flex: 1;
border: none;
outline: none;
font-size: 14px;
color: #242424;
background: transparent;
padding: 4px 0;
/* Container has bottom border: 1px solid #E1DFDD */
/* estimated */
```

**Entity list (checkbox rows)**
```css
max-height: 220px;
overflow-y: auto;
border-top: 1px solid #EDEBE9;

/* Row */
display: flex;
align-items: center;
padding: 8px 0;
gap: 12px;
border-bottom: 1px solid #EDEBE9;

/* Entity name */
flex: 1;
font-size: 14px;
color: #242424;

/* Property count */
font-size: 14px;
color: #A19F9D;
white-space: nowrap;
/* estimated */
```

**Checkbox — unchecked**
```css
width: 16px;
height: 16px;
border: 1px solid #616161;
border-radius: 2px;
background: #FFFFFF;
cursor: pointer;
/* estimated */
```

**Checkbox — checked**
```css
width: 16px;
height: 16px;
border: none;
border-radius: 2px;
background: #117865;
color: #FFFFFF;
/* White checkmark centered inside */
/* estimated */
```

**Status bar**
```css
font-size: 12px;
color: #616161;
padding: 12px 0;
border-top: 1px solid #EDEBE9;
/* estimated */
```

**Footer buttons**
```css
display: flex;
justify-content: flex-end;
gap: 8px;
padding-top: 16px;

/* Delete button (dark/destructive) */
background: #242424;
color: #FFFFFF;
border: none;
border-radius: 4px;
padding: 6px 20px;
font-size: 14px;
font-weight: 600;

/* Cancel button (ghost/text) */
background: transparent;
color: #242424;
border: 1px solid #E1DFDD;
border-radius: 4px;
padding: 6px 20px;
font-size: 14px;
font-weight: 400;
/* estimated */
```

### Entity Browser Popup

```css
display: flex;
border: 1px solid #E1DFDD;
border-radius: 8px;
box-shadow: 0 2px 8px rgba(0,0,0,0.12);
background: #FFFFFF;
/* estimated */

/* Left panel — entity list */
.entity-list { width: 240px; border-right: 1px solid #EDEBE9; }

/* Right panel — properties */
.property-list { width: 240px; }

/* Selected row */
.entity-row.selected { background: #E6F5F2; }

/* Badge — entity */
.badge-entity {
  width: 20px; height: 20px;
  border-radius: 50%;
  background: #E6F5F2;
  color: #117865;
  font-size: 11px; font-weight: 600;
  text-align: center; line-height: 20px;
}

/* Badge — property */
.badge-property {
  width: 20px; height: 20px;
  border-radius: 50%;
  background: #F0F0FF;
  color: #5B5FC7;
  font-size: 11px; font-weight: 600;
  text-align: center; line-height: 20px;
}
/* estimated */
```

### Breadcrumb

```css
display: flex;
align-items: center;
gap: 8px;
font-size: 14px;
color: #242424;

.breadcrumb-link { color: #242424; text-decoration: none; cursor: pointer; }
.breadcrumb-link:hover { text-decoration: underline; }
.breadcrumb-separator { color: #A19F9D; }
.breadcrumb-current { font-weight: 600; }
/* estimated */
```

### Sidebar (Icon-only)

```css
width: 48px;
background: #FFFFFF;
border-right: 1px solid #EDEBE9;
display: flex;
flex-direction: column;
align-items: center;
padding-top: 8px;

.sidebar-item {
  width: 40px; height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 4px;
  color: #616161;
  cursor: pointer;
}
.sidebar-item:hover { background: #F5F5F5; color: #242424; }
.sidebar-item.active { background: #F0F0F0; color: #242424; }
/* estimated */
```

## Layout Templates

### Full Page Layout
```
┌──────────────────────────────────────────────┐
│ [≡] Fabric  [Workspace ×] │ Tenant ▾  [🔍] │  ← Header (48px, #1B1B1B)
├──┬───────────────────────────────────────────┤
│🏠│ ← Back > Rules > Edit rule               │  ← Breadcrumb bar
│📁│                                           │
│☁ │ ┌─ Form Section ────────────────────────┐ │
│⏱ │ │ Rule name *                           │ │
│📊│ │ [_______________________________]     │ │
│👥│ └───────────────────────────────────────┘ │
│🤖│ ┌─ Form Section ────────────────────────┐ │
│⚽│ │ Rule definition *                      │ │
│··│ │ A [Driver] assigned to a [Truck]...   │ │
│  │ │                                       │ │
│  │ │ Attached: [Driver ×] [Truck ×] [+]   │ │
│  │ └───────────────────────────────────────┘ │
│  │ ┌─ Severity ───────────────────────────┐ │
│  │ │ (●) Advisory  ( ) Blocking           │ │
│  │ └───────────────────────────────────────┘ │
│  │ ┌─ Metadata ───────────────────────────┐ │
│  │ │ [Region:EMEA] [Category:Safety] [+]  │ │
│  │ └───────────────────────────────────────┘ │
│  │                                           │
│  │ [Save]                                    │
├──┴───────────────────────────────────────────┤
│ 🔷 Fabric                                    │  ← Footer bar
└──────────────────────────────────────────────┘
```

### Tag Entity Type Dialog (overlay — save-gate)
```
┌──────────────────────────────────────────┐
│ Tag at least one entity type          ×  │
│                                          │
│ Your rule description doesn't reference  │
│ any known entity types. Every rule must   │
│ be tagged to one or more entity types so │
│ consumers can discover it.               │
│                                          │
│ Search and select entity types this      │
│ rule applies to.                         │
│                                          │
│ [■ Pilot ×]  Search entity types...      │
│ ─────────────────────────────────────    │
│ ☑ Pilot                    8 properties  │
│ ☐ Driver                  12 properties  │
│ ☐ Flight                   6 properties  │
│ ☐ Crew member              9 properties  │
│ ☐ Truck                   10 properties  │
│ ─────────────────────────────────────    │
│ 1 entity type selected. Save will        │
│ proceed once you confirm.                │
│                        [Delete] [Cancel]  │
└──────────────────────────────────────────┘
```

### Entity Browser Popup (overlay)
```
┌─────────────────────┬──────────────────────┐
│ Entity types with   │ Properties on        │
│ "expiry_date"       │ selected entity      │
├─────────────────────┼──────────────────────┤
│ E Truck License  3▸ │ P expiry_date   date │
│ E License Document  │ P license_class str  │
│                     │ P issue_state   str  │
└─────────────────────┴──────────────────────┘
```

## CSS Custom Properties

```css
:root {
  /* Colors — Core */
  --color-header-bg: #1B1B1B;
  --color-header-text: #FFFFFF;
  --color-sidebar-bg: #FFFFFF;
  --color-background: #FAF9F8;
  --color-surface: #FFFFFF;
  --color-primary: #117865;
  --color-primary-hover: #0E6354;
  --color-link: #0078D4;
  --color-required: #D13438;

  /* Colors — Text */
  --color-text-primary: #242424;
  --color-text-secondary: #616161;
  --color-text-muted: #A19F9D;

  /* Colors — Borders */
  --color-border: #E1DFDD;
  --color-border-subtle: #EDEBE9;

  /* Colors — Entity types */
  --color-entity-driver: #C43E1C;
  --color-entity-driver-bg: #FDF6F4;
  --color-entity-truck: #5B5FC7;
  --color-entity-truck-bg: #F0F0FF;
  --color-entity-license: #0E7363;
  --color-entity-license-bg: #F0FAF8;

  /* Colors — Interactive */
  --color-selected-row: #E6F5F2;
  --color-tag-bg: #F0F0F0;
  --color-radio-selected: #117865;

  /* Typography */
  --font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
  --font-size-xs: 11px;
  --font-size-sm: 12px;
  --font-size-base: 14px;
  --font-size-lg: 16px;
  --font-size-xl: 20px;

  /* Spacing */
  --space-xxs: 4px;
  --space-xs: 8px;
  --space-sm: 12px;
  --space-md: 16px;
  --space-lg: 20px;
  --space-xl: 24px;
  --space-2xl: 32px;
  --space-3xl: 48px;

  /* Border radius */
  --radius-sm: 2px;
  --radius-md: 4px;
  --radius-pill: 16px;
  --radius-dialog: 8px;

  /* Shadows */
  --shadow-card: 0 1px 4px rgba(0,0,0,0.06);
  --shadow-popup: 0 2px 8px rgba(0,0,0,0.12);

  /* Layout */
  --sidebar-width: 48px;
  --header-height: 48px;
}
```

> **Note**: All values are estimated from a static screenshot. For pixel-perfect extraction, use the `/mockup-extract` skill with a live URL and Playwright.

## Reference Screenshots

| File | Description |
|------|-------------|
| `reference/rules-edit-page.png` | Full "Edit rule" page showing form, entity browser popup, sidebar, header |
| `reference/rules-tag-entity-dialog.png` | "Tag at least one entity type" validation dialog — search + checkbox list of entity types |
| `reference/rules-list-blank.png` | Empty state — no rules yet, CTA to create first rule |
| `reference/rules-list.png` | Rules list with entries — data table, search, filter pills, severity/state badges |
| `reference/rules-list-filter.png` | Rules list with Entity Type filter dropdown open — checkbox multi-select |

---

## Rules List View — Components

> The following components are extracted from the "Business rules" list view. This view introduces a 3-column layout (icon sidebar + Explorer panel + main content area) and a data table with toolbar controls.

### Explorer Panel

A persistent tree navigation panel between the icon sidebar and the main content area. ~200px wide. Shows the ontology structure.

```css
width: 200px;
background: #FFFFFF;
border-right: 1px solid #EDEBE9;
font-size: 14px;
overflow-y: auto;
/* estimated */

/* Header */
padding: 8px 12px;
font-size: 14px;
font-weight: 600;
color: #242424;
/* Has a panel-toggle icon button on the right */

/* Tree section header */
font-size: 14px;
font-weight: 400;
color: #242424;
padding: 4px 12px;
/* Collapse chevron ▸/▾ on the left */

/* Tree item */
padding: 4px 12px 4px 28px; /* indented */
font-size: 14px;
color: #242424;
cursor: pointer;

/* Tree item — selected */
background: #EBF3FC; /* light blue highlight */
font-weight: 600;

/* Tree item — hover */
background: #F5F5F5;

/* Section toolbar (inside Ontology section) */
/* Add ▾ button, search icon, filter icon — inline toolbar row */
padding: 4px 12px;
gap: 8px;
```

### Toolbar (Search + Filters + Action)

Horizontal bar above the data table with search, filter pills, and a primary action button.

```css
display: flex;
align-items: center;
gap: 12px;
padding: 12px 0;
/* estimated */
```

**Search input**
```css
display: flex;
align-items: center;
width: 240px;
height: 32px;
padding: 0 12px;
border: 1px solid #E1DFDD;
border-radius: 4px;
background: #FFFFFF;
font-size: 14px;
color: #242424;
/* Search icon (🔍) on the left, ~14px, color: #A19F9D */
/* Placeholder: "Search rules by name" */
/* estimated */
```

**Filter pill (default)**
```css
display: inline-flex;
align-items: center;
gap: 4px;
padding: 4px 12px;
border: 1px solid #E1DFDD;
border-radius: 4px;
background: #FFFFFF;
font-size: 14px;
font-weight: 400;
color: #242424;
cursor: pointer;
/* Dropdown arrow ▾ after label */
/* estimated */
```

**Filter pill (active/open)**
```css
background: #117865;
color: #FFFFFF;
border-color: #117865;
/* estimated */
```

**Filter dropdown**
```css
position: absolute;
top: 100%;
left: 0;
min-width: 200px;
background: #FFFFFF;
border: 1px solid #E1DFDD;
border-radius: 8px;
box-shadow: 0 2px 8px rgba(0,0,0,0.12);
padding: 8px 0;
z-index: 200;
/* estimated */

/* "Clear all" link */
padding: 8px 16px;
font-size: 14px;
color: #242424;
cursor: pointer;

/* Checkbox row */
display: flex;
align-items: center;
gap: 12px;
padding: 6px 16px;
cursor: pointer;
/* Checkbox: same green (#117865) when checked */

/* Checkbox row — hover */
background: #F5F5F5;
/* estimated */
```

### Data Table

Full-width table for displaying rule entries with sortable headers.

```css
width: 100%;
border-collapse: collapse;
font-size: 14px;
/* estimated */

/* Header row */
border-bottom: 1px solid #EDEBE9;
/* th */
padding: 8px 12px;
font-weight: 600;
font-size: 12px;
color: #616161;
text-align: left;
/* Sort indicator ↑ next to sortable column name */

/* Data row */
border-bottom: 1px solid #EDEBE9;
/* td */
padding: 10px 12px;
vertical-align: middle;

/* Data row — hover */
background: #F5F5F5;
/* estimated */
```

**Column widths (approximate)**
| Column | Width | Notes |
|--------|-------|-------|
| Rule name | ~35% | Text, sortable |
| Entity types | ~35% | Chip group |
| Severity | ~12% | Badge |
| State | ~12% | Badge |
| Actions | ~6% | ⋮ menu icon |

### Severity Badge

Inline badge with icon + text indicating rule severity level.

```css
display: inline-flex;
align-items: center;
gap: 6px;
padding: 2px 10px;
border-radius: 16px;
font-size: 12px;
font-weight: 600;
/* estimated */
```

**Blocking**
```css
background: #FDE7E7;
color: #D13438;
/* Icon: filled red circle (●) before text */
/* estimated */
```

**Advisory**
```css
background: transparent;
color: #616161;
font-weight: 400;
/* Icon: amber/yellow triangle (⚠) before text, color #C48700 */
/* estimated */
```

### State Badge

Inline indicator showing rule verification state.

```css
display: inline-flex;
align-items: center;
gap: 4px;
font-size: 12px;
/* estimated */
```

**Verified**
```css
color: #117865;
/* Icon: green checkmark (✓) before text */
/* estimated */
```

**Intent** (unverified / draft)
```css
color: #616161;
font-weight: 400;
/* No icon, plain text */
/* estimated */
```

### Row Actions Menu

Three-dot vertical menu on each table row.

```css
width: 28px;
height: 28px;
display: flex;
align-items: center;
justify-content: center;
border-radius: 4px;
cursor: pointer;
color: #616161;
font-size: 16px;
/* Visible on row hover, or always visible */
/* estimated */

/* Hover */
background: #F0F0F0;
/* estimated */
```

### Empty State

Centered content shown when no rules exist yet.

```css
display: flex;
flex-direction: column;
align-items: center;
justify-content: center;
padding: 80px 24px;
text-align: center;
/* estimated */

/* Illustration */
width: 120px;
height: 120px;
margin-bottom: 16px;
/* Grayscale illustration — abstract document/rules icon */

/* Heading */
font-size: 16px;
font-weight: 600;
color: #242424;
margin-bottom: 16px;

/* CTA button — primary green */
/* Same as .btn-primary */
/* estimated */
```

### Pagination

Footer bar showing record count and page navigation.

```css
display: flex;
align-items: center;
justify-content: space-between;
padding: 12px 0;
font-size: 12px;
color: #616161;
border-top: 1px solid #EDEBE9;
/* estimated */

/* Left: "Showing 5 of 12 rules" */
/* Right: "Page 1 of 1 · 50 per page ▾" */
```

## Layout Templates — Rules List

### Rules List (with Explorer panel)
```
┌──────────────────────────────────────────────────────┐
│ [≡] Fabric  [ZavaStadium ×]  │ Tenant ▾  [🔍]  AY  │  ← Header (48px, #1B1B1B)
├──┬──────────┬────────────────────────────────────────┤
│🏠│ Explorer │ Business rules                        │
│📁│          │                                        │
│☁ │ Overview │ [🔍 Search...] [Entity▾][Sev▾][St▾] [+New rule] │
│⚡│  Biz imp │                                        │
│📊│  Lineage │ Rule name ↑    │ Entity types │ Sev │ State │
│👥│  Health  │ ───────────────┼──────────────┼─────┼────── │
│🤖│          │ Truck license…│ [D×][T×][TL×]│🔴Blk│✓ Vrf │
│📎│ Ontology │ Truck license…│ [D×][T×]     │🔴Blk│ Int  │
│··│  ◈Add Q≡│ Truck license…│ [D×][T×][TL×]│🔴Blk│✓ Vrf │
│  │  ▸Biz rl│ Truck license…│ [D×][T×][TL×]│🔴Blk│✓ Vrf │
│  │  ▾Entity│                                        │
│  │   Venue │ Showing 5 of 12 rules    Page 1 · 50/pg│
│  │   Park… │                                        │
│  │   Event │                                        │
│  │  ▸Relat │                                        │
├──┴──────────┴────────────────────────────────────────┤
│ 🔷 Fabric                                            │
└──────────────────────────────────────────────────────┘
```

### Rules List — Empty State
```
┌──────────────────────────────────────────────────────┐
│ [≡] Fabric  [ZavaStadium ×]  │ Tenant ▾  [🔍]  AY  │
├──┬──────────┬────────────────────────────────────────┤
│🏠│ Explorer │ Business rules                        │
│📁│          │                                        │
│  │ Overview │                                        │
│  │  …       │          ┌─────────────┐               │
│  │ Ontology │          │  📄 (illus) │               │
│  │  ▸Biz rl│          │             │               │
│  │  ▾Entity│     Start creating your first rule     │
│  │   …     │         [ Create rule ]                │
│  │  ▸Relat │                                        │
│  │         │                                        │
├──┴──────────┴────────────────────────────────────────┤
│ 🔷 Fabric                                            │
└──────────────────────────────────────────────────────┘
```

### Rules List — Filter Dropdown Open
```
┌──────────────────────────────────────────────────────┐
│ [≡] Fabric  [ZavaStadium ×]  │ Tenant ▾  [🔍]  AY  │
├──┬──────────┬────────────────────────────────────────┤
│  │ Explorer │ Business rules                        │
│  │          │                                        │
│  │          │ [🔍 Search] [Entity type▾]…            │
│  │          │              ┌──────────────┐          │
│  │          │              │ Clear all    │          │
│  │          │              │ ☑ Event      │          │
│  │          │              │ ☑ Employee   │          │
│  │          │              │ ☑ Entrance   │          │
│  │          │              │ ☐ Shuttle    │          │
│  │          │              │ ☐ Venue      │          │
│  │          │              └──────────────┘          │
│  │          │ Rule name…   Entity types…  Sev  State │
│  │          │ …                                      │
├──┴──────────┴────────────────────────────────────────┤
│ 🔷 Fabric                                            │
└──────────────────────────────────────────────────────┘
```

## New Color Tokens (Rules List)

| Token | Hex | Usage |
|-------|-----|-------|
| `severity-blocking` | `#D13438` | Blocking severity badge text + icon (estimated) |
| `severity-blocking-bg` | `#FDE7E7` | Blocking severity badge background (estimated) |
| `severity-advisory` | `#C48700` | Advisory severity triangle icon (estimated) |
| `severity-advisory-bg` | `transparent` | Advisory has no background badge (estimated) |
| `state-verified` | `#117865` | Verified state checkmark + text (estimated) |
| `state-verified-bg` | `#E6F5F2` | Verified badge background (estimated) |
| `explorer-selected` | `#EBF3FC` | Selected tree item in Explorer panel (estimated) |
| `explorer-width` | `200px` | Explorer panel width (estimated) |
