# i18n Multi-language Support — Design

## Goal

Add English/Spanish language switching to the portfolio's `index.html` so visitors can browse in their preferred language.

## Requirements

- Automatic language detection from browser settings (`navigator.language`)
- Manual toggle (EN/ES button) in the page header
- Persist choice in `localStorage` across visits
- All user-facing text must be translatable: hero, about, tech stack intro, projects, contact form, menu, footer
- Meta tags (`description`, `og:title`, `og:description`, `title`) must update on language switch
- The typing animation text must switch per language
- Fallback to English if a translation key is missing

## Architecture

### Files

| File | Role |
|------|------|
| `lang/en.json` | English translations (key-value pairs) |
| `lang/es.json` | Spanish translations |
| `assets/js/i18n.js` | New vanilla JS file — loads, applies, and persists language |
| `index.html` | Add `data-i18n` attributes, language toggle, and load `i18n.js` |

### Data Flow

1. Page loads → `i18n.js` reads `localStorage.getItem('lang')`
2. If null → detect from `navigator.language` (prefix `es` → Spanish, else English)
3. Fetch the matching JSON (`lang/en.json` or `lang/es.json`)
4. Walk all `[data-i18n]` elements and set `textContent` (or `placeholder` for inputs)
5. Update `<title>`, meta tags, and typing animation text
6. Toggle button shows current language; clicking it switches, saves to localStorage, and re-applies

### Translation Keys

Nested JSON with dot-separated keys used via `data-i18n`:

```json
{
  "nav": {
    "menu": "Menu",
    "home": "Home",
    "about": "About Me",
    "projects": "Projects",
    "contact": "Contact"
  }
}
```

Used as: `data-i18n="nav.menu"`

## Language Toggle

- A small control in the `<nav>` next to the menu link
- Shows `EN` or `ES` (current language highlighted)
- On click: switch, persist, re-apply translations without page reload
- Styled inline with the existing header

## Dependencies

- jQuery already loaded (used by the template). i18n.js uses vanilla JS to avoid ordering issues.
- No external libraries needed.

## Non-goals

- Translation of `generic.html` or `elements.html` (out of scope)
- Translation of project content inside dropdowns or images (only text)
- Right-to-left languages
- Server-side rendering

## Risk

- JSON files must load before translations apply → slight flash of untranslated content on slow connections. Mitigation: set `lang` attribute and apply translations synchronously after fetch.
