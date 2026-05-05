# Demo folder convention

Every demo lives in its own self-contained folder at the workspace root, named in kebab-case (e.g. `business-rules/`, `entity-type-view/`). The whole folder is the share unit: zip it, send it, recipient unzips and opens an HTML file in any browser.

## Folder structure

```
<demo-name>/
├── design-guide.md          ← extracted design system (markdown)
├── base-styles.css          ← CSS custom properties + component classes
├── fluent-icons.css         ← Fluent SVG icon set (CSS mask-image system)
├── overlay.css              ← Design Vocabulary Overlay styles (from _shared/overlay/)
├── overlay.js               ← Design Vocabulary Overlay behavior (from _shared/overlay/)
├── reference/               ← (optional) source screenshots from the live app
│   └── *.png
└── mockups/
    ├── index.html           ← launch pad linking every screen
    ├── *.html               ← individual mockups
    ├── screenshots/         ← (optional) Playwright screenshots
    │   └── *.png
    └── tools/               ← (optional) helper scripts (e.g. screenshot scripts)
```

`reference/`, `mockups/screenshots/`, and `mockups/tools/` are generated as needed. They're not required for the demo to work.

## Picking the demo folder to build into

If multiple demo folders exist (each containing a `design-guide.md`), **ask the user which one** to build into. If only one exists, default to it. If none exists, ask the user for a kebab-case name and create it.

## Why one folder per demo

- Each demo is independently shareable as a single zip.
- No cross-demo coupling — delete or rename one without breaking another.
- Stakeholders only get the demo they care about, not your whole workspace.

**Don't** link across demo folders with `../` paths. If a screen needs to live in two demos, duplicate it. The portability of the zip is worth the duplication.
