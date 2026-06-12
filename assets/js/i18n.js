/**
 * i18n — Lightweight multi-language engine
 * Auto-detects browser language, persists choice in localStorage,
 * applies translations via data-i18n attributes.
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
        for (var i = 0; i < observers.length; i++) {
          observers[i](lang, data);
        }
      })
      .catch(function () {
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
        if (el.hasAttribute('data-i18n-html')) {
          el.innerHTML = value;
        } else {
          el.textContent = value;
        }
      }
    }

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

    // Handle value attributes (input submit, buttons)
    var vals = document.querySelectorAll('[data-i18n-value]');
    for (var k = 0; k < vals.length; k++) {
      var vEl = vals[k];
      var vKey = vEl.getAttribute('data-i18n-value');
      var vValue = resolveKey(vKey);
      if (vValue !== undefined) {
        vEl.setAttribute('value', vValue);
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
      typingEl.textContent = '';
      if (window.__i18nTypedWord) {
        window.__i18nTypedWord = typedText;
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
    btn.setAttribute('aria-label',
      currentLang === 'en' ? 'Switch to Spanish' : 'Cambiar a inglés'
    );
    btn.setAttribute('data-active-lang', currentLang);
  }

  function toggleLanguage() {
    var next = currentLang === 'en' ? 'es' : 'en';
    applyLanguage(next);
  }

  // ── Observer API ──
  function onLanguageChange(cb) {
    observers.push(cb);
    if (currentLang && translations.meta) {
      cb(currentLang, translations);
    }
  }

  // ── Init ──
  function init() {
    var detected = detectLanguage();
    applyLanguage(detected);

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

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
