<#
.SYNOPSIS
  Validate that a demo folder is complete and self-contained before sharing.

.DESCRIPTION
  Checks that a `<demo-name>/` folder has the files mockup-builder expects, and
  that every link inside `mockups/index.html` resolves to a real file. Run this
  before `package.ps1` to avoid shipping a broken zip.

  Exits 0 on success, 1 on any failure. Always prints the full report.

.PARAMETER Demo
  Name of the demo folder to validate (e.g. output-rules, business-rules).
  Required. Must be a folder at the workspace root.

.PARAMETER Strict
  Treat warnings (missing optional files / missing screenshots) as errors.

.EXAMPLE
  .\validate.ps1 output-rules
  Validates the output-rules/ folder; exits 0 if everything passes.

.EXAMPLE
  .\validate.ps1 output-rules -Strict
  Same but also fails on missing screenshots / optional files.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true, Position = 0)]
  [string]$Demo,

  [switch]$Strict
)

$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$demoPath = Join-Path $root $Demo

$errors = @()
$warnings = @()

function Add-Error([string]$msg)   { $script:errors   += $msg; Write-Host "  [FAIL] $msg" -ForegroundColor Red }
function Add-Warn ([string]$msg)   { $script:warnings += $msg; Write-Host "  [WARN] $msg" -ForegroundColor Yellow }
function Add-OK   ([string]$msg)   { Write-Host "  [ OK ] $msg" -ForegroundColor Green }

Write-Host ""
Write-Host "Validating demo: $Demo" -ForegroundColor Cyan
Write-Host "Path: $demoPath" -ForegroundColor DarkGray
Write-Host ""

# --- 1. Folder exists -------------------------------------------------------
if (-not (Test-Path $demoPath -PathType Container)) {
  Write-Host "  [FAIL] Demo folder not found." -ForegroundColor Red
  Write-Host ""
  Write-Host "Validation FAILED: demo folder does not exist." -ForegroundColor Red
  exit 1
}

# --- 2. Required files at demo root ----------------------------------------
Write-Host "Required files:" -ForegroundColor White
$requiredFiles = @(
  'design-guide.md',
  'base-styles.css'
)
foreach ($f in $requiredFiles) {
  $p = Join-Path $demoPath $f
  if (Test-Path $p -PathType Leaf) { Add-OK $f } else { Add-Error "Missing required file: $f" }
}

# --- 3. Optional but recommended files -------------------------------------
Write-Host ""
Write-Host "Recommended files:" -ForegroundColor White
$recommendedFiles = @(
  @{ Name = 'overlay.css';      Hint = 'Copy from skills/_shared/overlay/overlay.css for the Design Vocabulary Overlay.' },
  @{ Name = 'overlay.js';       Hint = 'Copy from skills/_shared/overlay/overlay.js for the Design Vocabulary Overlay.' },
  @{ Name = 'fluent-icons.css'; Hint = 'Only needed if mockups use .fi-* icons.' }
)
foreach ($r in $recommendedFiles) {
  $p = Join-Path $demoPath $r.Name
  if (Test-Path $p -PathType Leaf) { Add-OK $r.Name } else { Add-Warn ("Missing: {0} ({1})" -f $r.Name, $r.Hint) }
}

# --- 4. mockups/ folder + index.html ---------------------------------------
Write-Host ""
Write-Host "Mockups folder:" -ForegroundColor White
$mockupsPath = Join-Path $demoPath 'mockups'
if (-not (Test-Path $mockupsPath -PathType Container)) {
  Add-Error "Missing mockups/ folder."
} else {
  Add-OK "mockups/"

  $indexPath = Join-Path $mockupsPath 'index.html'
  if (-not (Test-Path $indexPath -PathType Leaf)) {
    Add-Error "Missing mockups/index.html (the demo launch pad)."
  } else {
    Add-OK "mockups/index.html"

    # --- 5. Resolve every <a href> and <img src> in index.html ------------
    Write-Host ""
    Write-Host "Resolving links in mockups/index.html:" -ForegroundColor White
    $indexContent = Get-Content -Raw -Path $indexPath

    # Match href="..." and src="..." values
    $pattern = '(?:href|src)\s*=\s*"([^"#?][^"#?]*)"'
    $linkMatches = [regex]::Matches($indexContent, $pattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)

    $checked = @{}
    foreach ($m in $linkMatches) {
      $link = $m.Groups[1].Value.Trim()

      # Skip anchors, external URLs, mailto, and javascript:
      if ($link -match '^(https?:|mailto:|javascript:|#|data:)') { continue }
      if ($checked.ContainsKey($link)) { continue }
      $checked[$link] = $true

      # Strip query strings and fragments
      $cleanLink = $link -replace '[?#].*$', ''
      if ([string]::IsNullOrWhiteSpace($cleanLink)) { continue }

      # Resolve relative to mockups/index.html
      $resolved = Join-Path $mockupsPath $cleanLink
      try { $resolved = [System.IO.Path]::GetFullPath($resolved) } catch { }

      if (Test-Path $resolved) {
        Add-OK $link
      } else {
        Add-Error "Broken link in index.html: $link  ->  $resolved"
      }
    }

    if ($checked.Count -eq 0) {
      Add-Warn "index.html contains no href/src links to verify."
    }
  }

  # --- 6. Mockup HTML files exist -----------------------------------------
  $mockupHtml = Get-ChildItem -Path $mockupsPath -Filter '*.html' -File -ErrorAction SilentlyContinue
  if ($mockupHtml.Count -le 1) {
    Add-Warn "Only $($mockupHtml.Count) HTML file(s) in mockups/. Is this demo complete?"
  }

  # --- 7. Screenshots referenced from index actually exist (Strict only) --
  if ($Strict) {
    $screenshotsPath = Join-Path $mockupsPath 'screenshots'
    if (-not (Test-Path $screenshotsPath -PathType Container)) {
      Add-Warn "No mockups/screenshots/ folder (Strict mode: would normally have screenshots for thumbnails)."
    }
  }
}

# --- 8. Report --------------------------------------------------------------
Write-Host ""
Write-Host "----------------------------------------" -ForegroundColor DarkGray
$failOnWarn = $Strict -and ($warnings.Count -gt 0)

if ($errors.Count -eq 0 -and -not $failOnWarn) {
  Write-Host ("PASSED  Errors: 0   Warnings: {0}" -f $warnings.Count) -ForegroundColor Green
  exit 0
} else {
  Write-Host ("FAILED  Errors: {0}   Warnings: {1}{2}" -f $errors.Count, $warnings.Count, $(if ($failOnWarn) { '  (Strict mode: warnings count as failures)' } else { '' })) -ForegroundColor Red
  exit 1
}
