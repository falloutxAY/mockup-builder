# Sharing a demo

Every `<demo-name>/` folder is self-contained — design system + mockups + reference + screenshots all in one place. No external runtime dependencies, no build step, no CDN/font requirements (icons are inline SVG via `fluent-icons.css`).

## Validate first

From the workspace root:

```powershell
.\validate.ps1 <demo-name>
```

Exits 0 if the demo is complete (required files present, every link in `mockups/index.html` resolves). Add `-Strict` to also fail on missing screenshots / overlay assets. Run this before `package.ps1` so you don't ship a broken zip.

## One-line zip (recommended)

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

## Manual zip (no script)

```powershell
Compress-Archive -Path <demo-name> -DestinationPath <demo-name>.zip -Force
```

## What the recipient does

1. Unzip anywhere.
2. Open `<demo-name>/mockups/index.html` in any modern browser (Edge, Chrome, Firefox, Safari).
3. Click around — every screen is fully interactive (modals, tabs, navigation).

No install. No server. Works offline.

## Tier check (Microsoft hygiene)

Demos using public sample domains are tier 1 (public-safe). Before sharing externally, verify the demo contains no customer names, tenant IDs, ICM references, codenames, or unannounced strategy. If it does, treat the zip as tier 3 and don't share outside Microsoft.
