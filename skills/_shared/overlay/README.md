# Design Vocabulary Overlay

Floating "Show Labels" toggle that overlays every recognized component with its design system name (CSS class or ARIA role). Closes the vocabulary gap: users can click the toggle, read the labels, then give precise feedback like "change `.btn-primary` to `.btn-secondary`" instead of "make the blue button look less important".

## What's here

| File | Purpose |
|---|---|
| `overlay.css` | Toggle button, legend dialog, chip styling |
| `overlay.js` | Auto-injects the toggle on DOM load; scans known selectors and stamps labels |

## How to use it (agent workflow)

1. **Once per demo folder**, copy both files to `<demo>/`:
   ```powershell
   Copy-Item skills\_shared\overlay\overlay.css <demo>\overlay.css
   Copy-Item skills\_shared\overlay\overlay.js  <demo>\overlay.js
   ```
   (The `mockup-extract` skill seeds these automatically when it creates a new demo folder.)

2. **In every mockup HTML file**, link the two files in `<head>`:
   ```html
   <link rel="stylesheet" href="../overlay.css">
   <script src="../overlay.js" defer></script>
   ```
   No markup to copy-paste; the script auto-injects the toggle button and legend on `DOMContentLoaded`.

3. **After the first mockup**, tell the user:
   > 💡 Tip: click **Show Labels** (bottom-right) to see the name of every component — use those names when giving feedback.

## Why externalized

Originally the overlay was ~140 lines of HTML + CSS + JS pasted into every mockup. That meant: bug fixes never propagated, the per-mockup file was hard to scan, and the "delete the overlay block" cleanup was a fragile manual edit. With two linked files, fixing the overlay updates every mockup in the demo at once.

## Adding new component selectors

Edit `SELECTOR_LABELS` in `overlay.js`. Each entry is `[cssSelector, label]`. Keep labels concise: `'.btn-primary — primary CTA'` reads better than a sentence.

## Standalone demo

`docs/examples/overlay-demo.html` shows the overlay applied to a single page in isolation. Useful when explaining the feature to someone outside the project.
