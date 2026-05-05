# Component cheatsheet

HTML snippets to reuse from `<demo>/base-styles.css`. Each block is annotated with the Fluent v9 component name a dev will use on handoff (see `fluent-v9-mapping.md`).

```html
<!-- Shell layout -->
<div class="shell">
  <header class="header">...</header>
  <div class="body">
    <nav class="sidebar">...</nav> <!-- Fluent: Nav -->
    <main class="main">...</main>
  </div>
</div>

<!-- Buttons → Fluent: Button -->
<button class="btn btn-primary">Primary</button>      <!-- appearance="primary" -->
<button class="btn btn-secondary">Secondary</button>  <!-- appearance="secondary" -->
<button class="btn btn-subtle">Subtle</button>        <!-- appearance="subtle" -->
<button class="btn btn-sm btn-primary">Small</button> <!-- size="small" -->
<button class="btn btn-danger">Danger / Delete</button>

<!-- Table → Fluent: DataGrid (sortable, with TableCellActions for row menu) -->
<table class="table">
  <thead><tr><th>Column</th></tr></thead>
  <tbody><tr><td>Data</td></tr></tbody>
</table>

<!-- Tabs → Fluent: TabList + Tab (appearance="transparent") -->
<div class="tab-list">
  <button class="tab active">Active</button>
  <button class="tab">Inactive</button>
</div>

<!-- Form input → Fluent: Field + Input (or SearchBox for search) -->
<div class="input-wrapper">
  <svg class="icon">...</svg>
  <input type="text" placeholder="Search...">
</div>
<label class="form-label">Field <span class="required">*</span></label>

<!-- Tags / chips → Fluent: Tag — 3 appearances for type hierarchy -->
<span class="chip chip-entitytype">EntityName</span>      <!-- appearance="brand"   (teal) -->
<span class="chip chip-property">property_name</span>     <!-- appearance="filled"  (grey) -->
<span class="chip chip-relationship">relationship</span>  <!-- appearance="outline" (white+border) -->

<!-- Filter dropdown → Fluent: Menu + MenuItemCheckbox (NOT Dropdown) -->
<button class="filter-pill">Entity type ▾</button>

<!-- Dialog → Fluent: Dialog (modalType="modal" or "alert") -->
<div class="dialog-overlay">
  <div class="dialog">
    <h2 class="dialog-title">Title</h2>             <!-- DialogTitle -->
    <p class="dialog-body">Content</p>              <!-- DialogBody / DialogContent -->
    <div class="dialog-actions">                    <!-- DialogActions -->
      <button class="btn btn-secondary">Cancel</button>
      <button class="btn btn-primary">Confirm</button>
    </div>
  </div>
</div>

<!-- Error banner → Fluent: MessageBar (intent="error") -->
<div class="dialog-blocked-msg">
  <span>⛔</span>
  <span>Save is blocked. Reason here.</span>
</div>

<!-- Toast → Fluent: Toast + Toaster (intent="success") -->
<div class="toast">
  <span class="toast-icon">✅</span>
  <span>Rule saved successfully</span>
  <button class="toast-close">✕</button>
</div>

<!-- Explorer / sidebar tree → Fluent: Tree + TreeItem + TreeItemLayout -->
<aside class="explorer">
  <div class="explorer-header"><h3>Explorer</h3></div>
  <div class="explorer-list">
    <div class="explorer-item selected">Item 1</div>
    <div class="explorer-item">Item 2</div>
  </div>
</aside>

<!-- Breadcrumb → Fluent: Breadcrumb + BreadcrumbItem -->
<div class="breadcrumb">
  <a href="#">Home</a>
  <span class="breadcrumb-separator">›</span>
  <span class="breadcrumb-current">Current</span>
</div>

<!-- Avatar → Fluent: Avatar (initials, color="brand") -->
<span class="avatar">AY</span>

<!-- Severity radio → Fluent: RadioGroup + Radio -->
<div class="radio-group">
  <label class="radio-label"><input type="radio" class="radio-input" checked> Advisory</label>
  <label class="radio-label"><input type="radio" class="radio-input"> Blocking</label>
</div>

<!-- Metadata tags → Fluent: TagPicker (noPopover) -->
<div class="tag-group">
  <span class="tag">Category: Security</span>
  <button class="tag-add">＋</button>
</div>

<!-- Content section -->
<div class="content">
  <div class="section">
    <div class="section-header">
      <h4>Section Title</h4>
      <button class="btn btn-secondary">Action</button>
    </div>
    <!-- section content -->
  </div>
</div>

<!-- Empty state (custom — no Fluent component) -->
<div class="empty-state">
  <p class="empty-state-message">No items found.</p>
  <button class="btn btn-primary">Create first item</button>
</div>
```

## Click-to-copy on dialog titles (optional)

Useful for agent-chat workflows: lets the user click a small button next to a dialog title and paste the exact title back to the agent for precise feedback.

```html
<div class="dialog-overlay">
  <div class="dialog">
    <div class="dialog-header">
      <h2 class="dialog-title">Edit User Profile Settings</h2>
      <button type="button" class="btn-copy" title="Copy name to clipboard"
        onclick="const btn=this;const reset=()=>{clearTimeout(btn._copyT);btn.classList.remove('copied','copy-error')};const show=(s)=>{reset();btn.classList.add(s);btn._copyT=setTimeout(()=>btn.classList.remove('copied','copy-error'),1500)};const wt=navigator.clipboard?.writeText;if(!wt){show('copy-error');return;}wt.call(navigator.clipboard,btn.closest('.dialog').querySelector('.dialog-title').textContent).then(()=>show('copied')).catch(()=>show('copy-error'))">
        <svg width="14" height="14" viewBox="0 0 16 16" fill="none" aria-hidden="true">
          <rect x="5" y="5" width="9" height="11" rx="1.5" stroke="currentColor" stroke-width="1.5"/>
          <path d="M3 11H2.5A1.5 1.5 0 0 1 1 9.5v-7A1.5 1.5 0 0 1 2.5 1h7A1.5 1.5 0 0 1 11 2.5V3" stroke="currentColor" stroke-width="1.5"/>
        </svg>
        <span class="btn-copy-label">Copy name</span>
      </button>
    </div>
    <p class="dialog-body">Content</p>
    <div class="dialog-actions">
      <button class="btn btn-secondary">Cancel</button>
      <button class="btn btn-primary">Confirm</button>
    </div>
  </div>
</div>
```

```css
.dialog-header { display: flex; align-items: center; justify-content: space-between; gap: 8px; }
.btn-copy {
  display: inline-flex; align-items: center; gap: 4px;
  padding: 3px 8px; font-size: 12px; line-height: 1.4;
  color: var(--color-text-secondary, #555);
  background: transparent;
  border: 1px solid var(--color-border, #ccc);
  border-radius: 4px; cursor: pointer; white-space: nowrap;
  transition: background 0.15s, color 0.15s, border-color 0.15s;
  flex-shrink: 0;
}
.btn-copy:hover {
  background: var(--color-surface-secondary, #f0f0f0);
  border-color: var(--color-border-strong, #999);
  color: var(--color-text-primary, #111);
}
.btn-copy.copied { color: var(--color-success, #107c10); border-color: var(--color-success, #107c10); }
.btn-copy.copied .btn-copy-label::before { content: "✓ "; }
.btn-copy.copy-error { color: var(--color-danger, #c4000a); border-color: var(--color-danger, #c4000a); }
.btn-copy.copy-error .btn-copy-label::before { content: "✗ "; }
```
