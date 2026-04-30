<#
.SYNOPSIS
  Package a demo folder into a single zip-and-share file.

.DESCRIPTION
  Each demo lives in its own self-contained folder at the workspace root
  (design-guide.md + base-styles.css + reference/ + mockups/). This script
  zips that folder into <demo-name>.zip in the workspace root.

  Default: zips the entire demo folder verbatim. Use -Lean to drop
  reference screenshots and helper tools (saves space; HTML mockups
  still work as long as they don't <img src="screenshots/..."> from
  the index page).

.PARAMETER Demo
  Name of the demo folder to package (e.g. business-rules, output-rules).
  Required. Must be a folder at the workspace root.

.PARAMETER Lean
  Exclude reference/, mockups/screenshots/, and mockups/tools/.
  Use when you only need the live HTML mockups and want a small zip.

.PARAMETER OutputPath
  Override the destination zip path. Default: ./<demo-name>.zip

.EXAMPLE
  .\package.ps1 output-rules
  Zips the entire output-rules/ folder -> output-rules.zip

.EXAMPLE
  .\package.ps1 output-rules -Lean
  Zips output-rules/ but skips screenshots, tools, and reference

.EXAMPLE
  .\package.ps1 -Demo output-rules -OutputPath C:\Temp\rules-demo.zip
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true, Position = 0)]
  [string]$Demo,

  [switch]$Lean,

  [string]$OutputPath
)

$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$demoPath = Join-Path $root $Demo

if (-not (Test-Path $demoPath -PathType Container)) {
  Write-Error "Demo folder not found: $demoPath"
  exit 1
}

if (-not $OutputPath) {
  $OutputPath = Join-Path $root "$Demo.zip"
}

if (Test-Path $OutputPath) {
  Remove-Item $OutputPath -Force
}

Push-Location $root
try {
  if ($Lean) {
    # Filter out heavy folders, then zip only the surviving relative paths.
    $excludePatterns = @('\\screenshots\\', '\\tools\\', '\\reference\\')
    $files = Get-ChildItem -Path $demoPath -Recurse -File | Where-Object {
      $path = $_.FullName
      $skip = $false
      foreach ($p in $excludePatterns) {
        if ($path -match $p) { $skip = $true; break }
      }
      -not $skip
    }
    if (-not $files) {
      Write-Error "No files left after -Lean exclusions."
      exit 1
    }
    $relativePaths = $files | ForEach-Object { Resolve-Path -Path $_.FullName -Relative }
    Compress-Archive -Path $relativePaths -DestinationPath $OutputPath -Force
    $fileCount = $files.Count
  }
  else {
    # Default: zip the whole folder verbatim, structure preserved.
    Compress-Archive -Path $Demo -DestinationPath $OutputPath -Force
    $fileCount = (Get-ChildItem -Path $demoPath -Recurse -File | Measure-Object).Count
  }
}
finally {
  Pop-Location
}

$zipInfo = Get-Item $OutputPath
$sizeKb = [math]::Round($zipInfo.Length / 1KB, 1)

Write-Host ""
Write-Host "Packaged: $($zipInfo.FullName)" -ForegroundColor Green
Write-Host "  Files:  $fileCount"
Write-Host "  Size:   $sizeKb KB"
if ($Lean) {
  Write-Host "  Mode:   -Lean (screenshots/, tools/, reference/ excluded)" -ForegroundColor DarkGray
}
Write-Host ""
Write-Host "Recipient: unzip and open $Demo/mockups/index.html (or any *.html) in any browser. No build step needed." -ForegroundColor DarkGray

