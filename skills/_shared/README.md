# Shared skill includes

These files are referenced by multiple skills in `skills/mockup-*/SKILL.md` so the source-of-truth lives in one place. When a skill says "Read `_shared/<file>.md` first", load that file as additional context before acting.

| File | Used by | Purpose |
|---|---|---|
| `demo-folder-convention.md` | extract, build, end2end, wow | Demo folder layout, multi-folder ask, naming |
| `fluent-v9-mapping.md` | extract, build, end2end | Fluent UI React v9 component mapping table + critical rules |
| `component-cheatsheet.md` | build, end2end | Reusable HTML snippets for buttons, tables, dialogs, etc. |
| `html-rules.md` | build, end2end, wow | Semantic HTML5, base-styles linking, responsive, accessible |
| `preview.md` | build, end2end, wow | http-server + Playwright preview pattern |
| `sharing.md` | extract, build, end2end, wow | `package.ps1` instructions and tier check |
| `overlay/overlay.css` + `overlay.js` | build, end2end | Design Vocabulary Overlay — drop into `<demo>/` once, link from every mockup |

**When installing skills:** copy the entire `skills/` folder (including `_shared/`) to `~/.copilot/skills/`. The README install steps reflect this.
