# Preview & screenshot pattern

Same flow for `mockup-build`, `mockup-end2end`, and `mockup-wow`.

1. Start a local server if one isn't already running (root the server at `<demo>/`):
   ```
   npx http-server <demo>/ -p 8765 -c-1 --silent
   ```
2. Navigate Playwright to `http://localhost:8765/mockups/<name>.html`.
3. Take a full-page screenshot → save to `<demo>/mockups/screenshots/<name>.png`.
4. Save any Playwright helper scripts to `<demo>/mockups/tools/`.
5. Show the screenshot to the user.
6. After the **first** mockup that includes the Design Vocabulary Overlay, add a one-liner:
   > 💡 Tip: click **Show Labels** (bottom-right) to see the name of every component — use those names when giving feedback.

**Iteration target**: < 30 seconds per small change (color tweak, spacing, text edit). Make targeted edits, re-screenshot, show. Don't rewrite the whole file.
