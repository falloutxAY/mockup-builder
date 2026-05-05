/* ============================================================================
   Design Vocabulary Overlay — behavior
   Drop this file into <demo>/ and load it from each mockup:
     <link rel="stylesheet" href="../overlay.css">
     <script src="../overlay.js" defer></script>
   The script auto-injects the toggle button + legend on DOMContentLoaded so
   each mockup only needs the two tags above (no markup to copy-paste).
   ============================================================================ */
(function () {
  'use strict';

  /* Map of CSS selectors → design vocabulary label.
     Add to this list when introducing new component classes. */
  var SELECTOR_LABELS = [
    /* Layout shell */
    ['.shell',                          '.shell — page shell'],
    ['.header',                         '.header — top header bar'],
    ['.sidebar',                        '.sidebar — left nav'],
    ['.main',                           '.main — main content'],
    ['.body',                           '.body — header + sidebar + main wrapper'],
    /* Navigation */
    ['nav',                             'nav — navigation'],
    ['.breadcrumb',                     '.breadcrumb — breadcrumb trail'],
    /* Buttons */
    ['.btn-primary',                    '.btn-primary — primary CTA'],
    ['.btn-secondary',                  '.btn-secondary — secondary action'],
    ['.btn-subtle',                     '.btn-subtle — ghost / subtle action'],
    ['.btn-danger',                     '.btn-danger — destructive action'],
    ['.btn-sm',                         '.btn-sm — small button'],
    /* Forms */
    ['.input-wrapper',                  '.input-wrapper — input with icon'],
    ['.form-label',                     '.form-label — field label'],
    ['input[type="text"]',              'text input'],
    ['input[type="email"]',             'email input'],
    ['select',                          'select dropdown'],
    ['textarea',                        'textarea'],
    /* Tabs */
    ['.tab-list',                       '.tab-list — tab navigation'],
    ['.tab.active',                     '.tab.active — active tab'],
    ['.tab:not(.active)',               '.tab — inactive tab'],
    /* Table */
    ['table.table',                     '.table — data table'],
    ['thead',                           'thead — table head'],
    ['tbody',                           'tbody — table body'],
    ['th',                              'th — column header'],
    /* Content */
    ['.content',                        '.content — content area'],
    ['.section',                        '.section — section'],
    ['.section-header',                 '.section-header — section header'],
    ['.card',                           '.card — card panel'],
    /* Overlays */
    ['.dialog-overlay',                 '.dialog-overlay — modal backdrop'],
    ['.dialog',                         '.dialog — dialog / modal'],
    ['.dialog-title',                   '.dialog-title — dialog title'],
    ['.dialog-actions',                 '.dialog-actions — dialog action row'],
    /* Misc */
    ['.explorer',                       '.explorer — explorer panel'],
    ['.explorer-item.selected',         '.explorer-item.selected — selected item'],
    ['.explorer-item:not(.selected)',   '.explorer-item — list item'],
    ['.entity-node',                    '.entity-node — entity node'],
    ['.badge',                          '.badge — status badge'],
    ['[role="alert"]',                  '[role="alert"] — alert / toast']
  ];

  var firstActivation = true;

  function ensureUI() {
    if (document.getElementById('dv-toggle')) return;

    var toggle = document.createElement('div');
    toggle.id = 'dv-toggle';
    toggle.setAttribute('role', 'button');
    toggle.setAttribute('tabindex', '0');
    toggle.setAttribute('aria-pressed', 'false');
    toggle.setAttribute('title', 'Toggle design vocabulary labels');
    toggle.innerHTML = '<span id="dv-icon">🏷️</span><span id="dv-text">Show Labels</span>';
    toggle.addEventListener('click', toggleOverlay);
    toggle.addEventListener('keydown', function (e) {
      if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); toggleOverlay(); }
    });
    document.body.appendChild(toggle);

    var legend = document.createElement('div');
    legend.id = 'dv-legend';
    legend.setAttribute('role', 'dialog');
    legend.setAttribute('aria-label', 'Design vocabulary guide');
    legend.hidden = true;
    legend.innerHTML =
      '<strong>Design Vocabulary</strong>' +
      '<p>Labels show the CSS class / ARIA role of each component.<br>' +
      'Use these names when giving feedback — e.g. ' +
      '"change the <code>btn-primary</code> to <code>btn-secondary</code>".</p>' +
      '<button type="button" aria-label="Dismiss design vocabulary guide">Got it</button>';
    legend.querySelector('button').addEventListener('click', dismissLegend);
    document.body.appendChild(legend);

    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') dismissLegend();
    });
  }

  function toggleOverlay() {
    var on = document.body.classList.toggle('dv-on');
    var btn = document.getElementById('dv-toggle');
    document.getElementById('dv-text').textContent = on ? 'Hide Labels' : 'Show Labels';
    btn.setAttribute('aria-pressed', String(on));
    btn.classList.toggle('active', on);
    if (on) {
      labelComponents();
      if (firstActivation) {
        document.getElementById('dv-legend').hidden = false;
        firstActivation = false;
      }
    }
  }

  function dismissLegend() {
    var legend = document.getElementById('dv-legend');
    if (legend) legend.hidden = true;
  }

  function labelComponents() {
    SELECTOR_LABELS.forEach(function (pair) {
      var selector = pair[0];
      var label = pair[1];
      try {
        document.querySelectorAll(selector).forEach(function (el) {
          if (el.dataset.dv) return; /* already labelled */
          el.dataset.dv = label;
          var chip = document.createElement('span');
          chip.className = 'dv-chip';
          chip.textContent = label;
          chip.setAttribute('aria-hidden', 'true');
          if (getComputedStyle(el).position === 'static') {
            el.classList.add('dv-pos-set');
          }
          el.appendChild(chip);
        });
      } catch (e) { /* invalid selector — skip */ }
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', ensureUI);
  } else {
    ensureUI();
  }
})();
