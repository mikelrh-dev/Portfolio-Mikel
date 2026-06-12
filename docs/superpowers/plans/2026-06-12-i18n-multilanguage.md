# i18n Multi-language Support — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add English/Spanish language switching to the portfolio's index.html with auto-detection, manual toggle, and localStorage persistence.

**Architecture:** JSON key-value translation files in `lang/`, vanilla JS engine in `assets/js/i18n.js`, `data-i18n` attributes in HTML for text replacement. No build tools, no external dependencies.

**Tech Stack:** Vanilla JavaScript, jQuery (already in page for menu/scroll effects — i18n.js uses vanilla to avoid ordering issues).

---

### Task 1: Create lang/en.json

**Files:**
- Create: `lang/en.json`

- [ ] **Create the English translation file**

```json
{
  "nav": {
    "menu": "Menu",
    "home": "Home",
    "about": "About Me",
    "projects": "Projects",
    "contact": "Contact",
    "close": "Close"
  },
  "banner": {
    "greeting": "Hi, I'm Mikel",
    "typed": "Software Developer",
    "subtitle": "Multiplatform application developer passionate about creating innovative and efficient technological solutions.",
    "ctaWork": "See My Work",
    "ctaAbout": "About Me",
    "scroll": "Scroll"
  },
  "about": {
    "title": "About Me",
    "p1": "I am a developer specialized in <strong>multiplatform application development</strong>, passionate about creating efficient and adaptable solutions that provide real value to users. I consider myself a <strong>curious and constantly learning person</strong>, always keeping up with the latest technological trends to stay updated and apply the best in each project.",
    "p2": "Besides programming, <strong>sports and discipline</strong> are an essential part of my life, qualities I bring into my daily work: consistency, organization, and commitment to achieving ambitious goals.",
    "p3": "I am motivated to be part of projects where I can <strong>contribute innovation, work in a team, and continue growing professionally</strong>, always aiming for technical excellence and <strong>continuous improvement</strong>.",
    "link": "See my projects"
  },
  "tech": {
    "title": "Technology Stack",
    "intro": "Technologies and tools I work with across the full development lifecycle.",
    "languages": "Languages",
    "frontend": "Frontend",
    "backend": "Backend & Databases",
    "tools": "Tools & Platforms"
  },
  "projects": {
    "title": "My Projects",
    "intro": "A collection of projects spanning e-commerce, clean energy, and enterprise software. Each one taught me something new about solving real-world problems with code.",
    "seeDemo": "See Demo",
    "comingSoon": "See Demo — Coming Soon",
    "seeCode": "See Code",
    "seeAll": "See all on GitHub",
    "webVersion": "Web Version",
    "desktopVersion": "Desktop Version"
  },
  "contact": {
    "title": "Let's Talk",
    "intro": "If you have a project idea, a job opportunity, or just want to say hi, feel free to write to me. I am always open to new collaborations and challenges.",
    "nameLabel": "Name",
    "emailLabel": "Email",
    "messageLabel": "Message",
    "submit": "Send Message",
    "location": "Barakaldo, Vizcaya, Spain",
    "copyright": "© 2025 Mikel. All rights reserved."
  },
  "meta": {
    "title": "Mikel Romero — Multiplatform Developer Portfolio",
    "description": "Mikel Romero — Multiplatform application developer specializing in ERP, Java, JavaScript, and Velneo V37. Portfolio showcasing projects in e-commerce, clean energy, and enterprise software.",
    "ogTitle": "Mikel Romero — Developer Portfolio",
    "ogDescription": "Multiplatform application developer passionate about creating innovative and efficient technological solutions.",
    "skipLink": "Skip to main content"
  }
}
```

### Task 2: Create lang/es.json

**Files:**
- Create: `lang/es.json`

- [ ] **Create the Spanish translation file**

```json
{
  "nav": {
    "menu": "Menú",
    "home": "Inicio",
    "about": "Sobre mí",
    "projects": "Proyectos",
    "contact": "Contacto",
    "close": "Cerrar"
  },
  "banner": {
    "greeting": "Hola, soy Mikel",
    "typed": "Desarrollador de Software",
    "subtitle": "Desarrollador de aplicaciones multiplataforma apasionado por crear soluciones tecnológicas innovadoras y eficientes.",
    "ctaWork": "Ver mi trabajo",
    "ctaAbout": "Sobre mí",
    "scroll": "Desplázate"
  },
  "about": {
    "title": "Sobre mí",
    "p1": "Soy un desarrollador especializado en <strong>desarrollo de aplicaciones multiplataforma</strong>, apasionado por crear soluciones eficientes y adaptables que aporten valor real a los usuarios. Me considero una persona <strong>curiosa y en constante aprendizaje</strong>, siempre al día de las últimas tendencias tecnológicas para mantenerme actualizado y aplicar lo mejor en cada proyecto.",
    "p2": "Además de la programación, el <strong>deporte y la disciplina</strong> son una parte esencial de mi vida, cualidades que traslado a mi trabajo diario: constancia, organización y compromiso para alcanzar objetivos ambiciosos.",
    "p3": "Me motiva formar parte de proyectos donde pueda <strong>aportar innovación, trabajar en equipo y seguir creciendo profesionalmente</strong>, apuntando siempre a la excelencia técnica y la <strong>mejora continua</strong>.",
    "link": "Ver mis proyectos"
  },
  "tech": {
    "title": "Stack Tecnológico",
    "intro": "Tecnologías y herramientas con las que trabajo en todo el ciclo de desarrollo.",
    "languages": "Lenguajes",
    "frontend": "Frontend",
    "backend": "Backend y Bases de Datos",
    "tools": "Herramientas y Plataformas"
  },
  "projects": {
    "title": "Mis Proyectos",
    "intro": "Una colección de proyectos que abarcan e-commerce, energías limpias y software empresarial. Cada uno me enseñó algo nuevo sobre cómo resolver problemas reales con código.",
    "seeDemo": "Ver Demo",
    "comingSoon": "Ver Demo — Próximamente",
    "seeCode": "Ver Código",
    "seeAll": "Ver todo en GitHub",
    "webVersion": "Versión Web",
    "desktopVersion": "Versión Escritorio"
  },
  "contact": {
    "title": "Hablemos",
    "intro": "Si tienes una idea de proyecto, una oportunidad laboral o simplemente quieres saludar, no dudes en escribirme. Siempre estoy abierto a nuevas colaboraciones y retos.",
    "nameLabel": "Nombre",
    "emailLabel": "Correo electrónico",
    "messageLabel": "Mensaje",
    "submit": "Enviar mensaje",
    "location": "Barakaldo, Vizcaya, España",
    "copyright": "© 2025 Mikel. Todos los derechos reservados."
  },
  "meta": {
    "title": "Mikel Romero — Portfolio Desarrollador Multiplataforma",
    "description": "Mikel Romero — Desarrollador de aplicaciones multiplataforma especializado en ERP, Java, JavaScript y Velneo V37. Portfolio con proyectos de e-commerce, energías limpias y software empresarial.",
    "ogTitle": "Mikel Romero — Portfolio de Desarrollo",
    "ogDescription": "Desarrollador de aplicaciones multiplataforma apasionado por crear soluciones tecnológicas innovadoras y eficientes.",
    "skipLink": "Saltar al contenido principal"
  }
}
```

### Task 3: Create assets/js/i18n.js

**Files:**
- Create: `assets/js/i18n.js`

- [ ] **Create the i18n engine**

```javascript
/**
 * i18n — Lightweight multi-language engine
 * Auto-detects browser language, persists choice in localStorage.
 */
(function () {
  'use strict';

  var currentLang = 'en';
  var translations = {};
  var observers = [];

  // ── Detect ──
  function detectLanguage() {
    var stored = localStorage.getItem('lang');
    if (stored === 'es' || stored === 'en') return stored;
    var navLang = (navigator.language || navigator.userLanguage || '').substring(0, 2);
    return navLang === 'es' ? 'es' : 'en';
  }

  // ── Fetch & Apply ──
  function applyLanguage(lang) {
    currentLang = lang;
    localStorage.setItem('lang', lang);

    fetch('lang/' + lang + '.json')
      .then(function (r) {
        if (!r.ok) throw new Error('Failed to load ' + lang);
        return r.json();
      })
      .then(function (data) {
        translations = data;
        translatePage();
        updateMeta();
        updateTypingAnimation();
        updateToggleButton();
        document.documentElement.lang = lang;
        // Fire observers
        for (var i = 0; i < observers.length; i++) {
          observers[i](lang, data);
        }
      })
      .catch(function () {
        // Fallback: try English
        if (lang !== 'en') {
          applyLanguage('en');
        }
      });
  }

  // ── Translate DOM ──
  function translatePage() {
    var els = document.querySelectorAll('[data-i18n]');
    for (var i = 0; i < els.length; i++) {
      var el = els[i];
      var key = el.getAttribute('data-i18n');
      var value = resolveKey(key);
      if (value !== undefined) {
        // Check if element has HTML content (use innerHTML for rich text)
        if (el.hasAttribute('data-i18n-html')) {
          el.innerHTML = value;
        } else {
          el.textContent = value;
        }
      }
    }

    // Handle placeholders (inputs, textareas)
    var phs = document.querySelectorAll('[data-i18n-placeholder]');
    for (var j = 0; j < phs.length; j++) {
      var ph = phs[j];
      var phKey = ph.getAttribute('data-i18n-placeholder');
      var phValue = resolveKey(phKey);
      if (phValue !== undefined) {
        ph.setAttribute('placeholder', phValue);
      }
    }
  }

  // ── Resolve dotted key ──
  function resolveKey(key) {
    var parts = key.split('.');
    var val = translations;
    for (var i = 0; i < parts.length; i++) {
      if (val === undefined || val === null) return undefined;
      val = val[parts[i]];
    }
    return val;
  }

  // ── Update Meta Tags ──
  function updateMeta() {
    var title = resolveKey('meta.title');
    var desc = resolveKey('meta.description');
    var ogTitle = resolveKey('meta.ogTitle');
    var ogDesc = resolveKey('meta.ogDescription');
    var skip = resolveKey('meta.skipLink');

    if (title) document.title = title;
    if (desc) {
      var m = document.querySelector('meta[name="description"]');
      if (m) m.setAttribute('content', desc);
    }
    if (ogTitle) {
      var ot = document.querySelector('meta[property="og:title"]');
      if (ot) ot.setAttribute('content', ogTitle);
    }
    if (ogDesc) {
      var od = document.querySelector('meta[property="og:description"]');
      if (od) od.setAttribute('content', ogDesc);
    }
    if (skip) {
      var sk = document.querySelector('.skip-link');
      if (sk) sk.textContent = skip;
    }
  }

  // ── Update Typing Animation ──
  function updateTypingAnimation() {
    var typedText = resolveKey('banner.typed');
    var typingEl = document.querySelector('.typing-text');
    if (typingEl && typedText) {
      // Reset the typing animation state
      typingEl.textContent = '';
      // Update the word list in the IIFE closure
      if (window.__i18nTypedWord) {
        window.__i18nTypedWord = typedText;
        // Restart typing if it finished
        if (window.__i18nRestartTyping) {
          window.__i18nRestartTyping();
        }
      }
    }
  }

  // ── Toggle Button ──
  function updateToggleButton() {
    var btn = document.getElementById('lang-toggle');
    if (!btn) return;
    btn.textContent = currentLang === 'en' ? 'ES' : 'EN';
    btn.setAttribute('aria-label', currentLang === 'en' ? 'Switch to Spanish' : 'Cambiar a inglés');
    btn.setAttribute('data-active-lang', currentLang);
  }

  // ── Toggle handler ──
  function toggleLanguage() {
    var next = currentLang === 'en' ? 'es' : 'en';
    applyLanguage(next);
  }

  // ── Observer API ──
  function onLanguageChange(cb) {
    observers.push(cb);
    // If already loaded, fire immediately
    if (currentLang && translations.meta) {
      cb(currentLang, translations);
    }
  }

  // ── Init ──
  function init() {
    var detected = detectLanguage();
    applyLanguage(detected);

    // Wire toggle
    var btn = document.getElementById('lang-toggle');
    if (btn) {
      btn.addEventListener('click', function (e) {
        e.preventDefault();
        toggleLanguage();
      });
    }
  }

  // Expose public API
  window.i18n = {
    currentLang: function () { return currentLang; },
    translate: applyLanguage,
    t: resolveKey,
    onLanguageChange: onLanguageChange,
    toggle: toggleLanguage
  };

  // Wait for DOM
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
```

- [ ] **Update main.js typing effect to support dynamic word**

Edit `assets/js/main.js` at the typing effect section (~lines 166-211): Change the `words` array and add the restart mechanism.

Replace the typing effect IIFE with:

```javascript
// ── Typing Effect ──
(function() {
  const el = document.querySelector('.typing-text');
  if (!el) return;

  let words = ['Software Developer'];
  let wordIndex = 0;
  let charIndex = 0;
  let isDeleting = false;
  let typeSpeed = 80;
  let deleteSpeed = 40;
  let pauseBetween = 2000;
  let timeoutId = null;

  window.__i18nTypedWord = 'Software Developer';

  function updateWords() {
    if (window.__i18nTypedWord) {
      words = [window.__i18nTypedWord];
    }
  }

  function type() {
    updateWords();
    const current = words[wordIndex];

    if (isDeleting) {
      el.textContent = current.substring(0, charIndex - 1);
      charIndex--;
    } else {
      el.textContent = current.substring(0, charIndex + 1);
      charIndex++;
    }

    if (!isDeleting && charIndex === current.length) {
      isDeleting = true;
      timeoutId = setTimeout(type, pauseBetween);
      return;
    }

    if (isDeleting && charIndex === 0) {
      isDeleting = false;
      wordIndex = (wordIndex + 1) % words.length;
      timeoutId = setTimeout(type, 300);
      return;
    }

    timeoutId = setTimeout(type, isDeleting ? deleteSpeed : typeSpeed);
  }

  window.__i18nRestartTyping = function() {
    if (timeoutId) clearTimeout(timeoutId);
    isDeleting = false;
    charIndex = 0;
    wordIndex = 0;
    el.textContent = '';
    setTimeout(type, 100);
  };

  // Start after page load
  if (document.readyState === 'complete') {
    setTimeout(type, 500);
  } else {
    window.addEventListener('load', () => setTimeout(type, 500));
  }
})();
```

### Task 4: Modify index.html

**Files:**
- Modify: `index.html`

- [ ] **Add `data-i18n` attributes to all translatable elements**
- [ ] **Add language toggle button in the header nav**
- [ ] **Add `data-i18n-html` for elements with HTML content (about paragraphs)**
- [ ] **Load i18n.js before main.js**

**Details:**

Add the toggle button after the menu link in `<header id="header">`:
```html
<nav>
  <a href="#menu">Menu</a>
  <a href="#" id="lang-toggle" class="lang-toggle" aria-label="Switch to Spanish">ES</a>
</nav>
```

Add `data-i18n` to every translatable element. For example:
```html
<h1><a href="index.html" data-i18n="nav.home">My Portfolio</a></h1>
```

For HTML-rich text like about paragraphs, add `data-i18n-html`:
```html
<p data-i18n="about.p1" data-i18n-html></p>
```

Remove original text from elements with `data-i18n` (it will be replaced by JS, but keep as fallback).

Load i18n.js before main.js:
```html
<script src="assets/js/i18n.js"></script>
<script src="assets/js/jquery.min.js" defer></script>
...
```

### Task 5: Self-review

- [ ] Open index.html in browser, check that:
  - English loads by default on non-Spanish browser
  - Toggle button shows "ES" initially
  - Clicking toggle switches to Spanish, button shows "EN"
  - All text updates: nav, banner, about, tech, projects, contact, meta title
  - Typing animation shows "Desarrollador de Software" in Spanish
  - Refresh keeps the selected language
  - Meta tags are updated in the DOM
