# HTML output rules

Rules every mockup HTML file must follow.

- **Semantic HTML5**: `<header>`, `<nav>`, `<main>`, `<section>`, `<table>`, `<dialog>`.
- **Reference base-styles.css**: `<link rel="stylesheet" href="../base-styles.css">` (relative path from inside `mockups/`).
- **Reference fluent-icons.css** if the mockup uses any `.fi-*` icon: `<link rel="stylesheet" href="../fluent-icons.css">`.
- **Reference the overlay** (build / end2end only — see `_shared/overlay/`):
  ```html
  <link rel="stylesheet" href="../overlay.css">
  <script src="../overlay.js" defer></script>
  ```
- **Page-specific styles**: a `<style>` block in `<head>` for anything not in base-styles.
- **Responsive**: flexbox / CSS grid; works at 1440px and 1024px (and down to 768px / 320px for WOW mode).
- **Realistic placeholder data**: plausible names, emails, dates, numbers, status labels — never "Lorem ipsum" or "User 1".
- **Accessible**: WCAG AA contrast, alt text, visible `:focus-visible` ring, `role` and `aria-*` on interactive elements.
- **No framework dependencies**: opens in any browser with no build step. Google Fonts via `<link>` is OK for WOW mode.
- **JavaScript**: minimal and inline. Only add JS when the user asks for interactive behavior (tabs, modals, accordion, form-submit-redirect). The overlay script and the optional click-to-copy button are exceptions.
