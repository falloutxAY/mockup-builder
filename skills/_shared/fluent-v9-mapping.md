# Fluent UI React v9 component mapping

**Hard constraint** for `mockup-extract`, `mockup-build`, and `mockup-end2end`: every UI element in the mockup must be implementable using Fluent UI React v9 components. This reduces dev implementation time on handoff. (`mockup-wow` is exempt — see its own SKILL.md.)

Storybook reference: <https://storybooks.fluentui.dev/react/>

## Component mapping

| UI pattern | Fluent v9 component | Key props / notes |
|---|---|---|
| Data table (sortable, row actions) | **DataGrid** | `sortable`; `DataGridHeaderCell` for sort; `TableCellActions` for row menu |
| Search input | **SearchBox** | `appearance="outline"`, `placeholder` |
| Filter dropdowns (with checkboxes) | **Menu** + **MenuItemCheckbox** | `hasCheckmarks`, `MenuGroup`, `MenuTrigger` |
| Buttons | **Button** | `appearance="primary"` / `"secondary"` / `"subtle"` |
| Breadcrumb | **Breadcrumb** + **BreadcrumbItem** | Direct mapping |
| Form fields | **Field** + **Input** | `required`, `validationState`, `validationMessage` |
| Multi-line text | **Field** + **Textarea** | Plain text only; rich-text NL editors are custom |
| Radio selection | **Field** + **RadioGroup** + **Radio** | Direct mapping |
| Delete / alert dialogs | **Dialog** (`modalType="alert"`) | `DialogTitle`, `DialogBody`, `DialogActions` |
| Modal dialogs | **Dialog** (`modalType="modal"`) | Same sub-components |
| Error / warning banners | **MessageBar** | `intent="error"` / `"warning"` / `"success"` |
| Toast notifications | **Toast** + **Toaster** | `intent="success"`, auto-dismiss |
| Tree navigation (sidebar) | **Tree** + **TreeItem** + **TreeItemLayout** | `selectionMode`, `defaultOpenItems` |
| Tabs | **TabList** + **Tab** | `appearance="transparent"`, `size="medium"` |
| Tags / chips / badges | **Tag** | See "Tag appearance rule" below |
| Metadata input | **TagPicker** (`noPopover`) | Free-form tag entry + removal |
| User avatar | **Avatar** | `initials`, `color="brand"` |
| Row overflow menu (⋮) | **Menu** + **MenuTrigger** | Same Menu family as filter dropdowns |
| Checkboxes | **Checkbox** | Inside dialogs, outside of Menu |
| Two-panel picker | **Popover** + **List** + **Checkbox** | Custom composite from Fluent parts |

## Critical rules

**1. Don't mix component families on the same surface.**
Filter dropdowns → use **Menu** with `MenuItemCheckbox`. Don't also use **Dropdown** on the same surface. Pick one selection family per surface.

**2. Tag appearance rule — three appearances, zero custom CSS.**

| Concept type | Fluent appearance | Visual |
|---|---|---|
| Entity types | `appearance="brand"` | Teal filled — most prominent |
| Properties | `appearance="filled"` | Grey filled — medium emphasis |
| Relationships | `appearance="outline"` | White + border — lightest |

Don't override Tag colors with custom CSS. The three appearances are the visual hierarchy.

## What Fluent v9 cannot do — build custom

| Pattern | Workaround |
|---|---|
| Rich-text NL editor with inline colored entity highlights | Custom `contenteditable` div — wrap in Fluent `Field` for label/description |
| Two-panel concept browser (entity + property picker) | Compose from Fluent: `Popover` container + `List` + `Checkbox` |
| Empty state illustration | Custom HTML layout with Fluent `Button` for CTA |
| Pagination | Custom text + controls |

When you build custom, call it out in the mockup's `<!-- comment -->` and in the design guide's "Gaps" section so devs know which parts won't be a direct Fluent drop-in.
