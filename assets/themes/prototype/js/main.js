/**
 * Prototype Theme — Frontend scripts
 * Dark mode persistence + mobile nav + dropdown (parity with prototype script.js)
 */
(function () {
	'use strict';
	if (window.__prototypeMainLoaded) return;
	window.__prototypeMainLoaded = true;

	var STORAGE_KEY = 'jrdc-theme-mode';

	function getPreferred() {
		var stored = null;
		try { stored = localStorage.getItem(STORAGE_KEY); } catch (e) {}
		if (stored === 'dark' || stored === 'light') return stored;
		if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) return 'dark';
		return 'light';
	}

	function applyMode(mode) {
		var root = document.documentElement;
		if (mode === 'dark') root.classList.add('dark');
		else root.classList.remove('dark');
		try { localStorage.setItem(STORAGE_KEY, mode); } catch (e) {}
		updateToggleIcons();
	}

	function updateToggleIcons() {
		var isDark = document.documentElement.classList.contains('dark');
		document.querySelectorAll('[data-jrdc-theme-toggle]').forEach(function (btn) {
			btn.setAttribute('aria-pressed', isDark ? 'true' : 'false');
			btn.innerHTML = isDark
				? '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="5"/><path d="M12 1v2M12 21v2M4.22 4.22l1.42 1.42M18.36 18.36l1.42 1.42M1 12h2M21 12h2M4.22 19.78l1.42-1.42M18.36 5.64l1.42-1.42"/></svg>'
				: '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"/></svg>';
		});
	}

	applyMode(getPreferred());

	function init() {
		// Dark mode toggle (delegation)
		document.addEventListener('click', function (e) {
			var btn = e.target && e.target.closest ? e.target.closest('[data-jrdc-theme-toggle]') : null;
			if (btn) {
				var isDark = document.documentElement.classList.contains('dark');
				applyMode(isDark ? 'light' : 'dark');
				return;
			}
			// Dropdown toggle
			var toggle = e.target && e.target.closest ? e.target.closest('.jrdc-dropdown-toggle') : null;
			if (toggle) {
				e.preventDefault();
				var dd = toggle.closest('.jrdc-dropdown');
				if (dd) dd.classList.toggle('is-open');
				return;
			}
			// close open dropdowns when clicking outside
			document.querySelectorAll('.jrdc-dropdown.is-open').forEach(function (d) {
				if (!d.contains(e.target)) d.classList.remove('is-open');
			});
		});

		// Mobile nav
		var navToggle = document.querySelector('[data-jrdc-nav-toggle]');
		var mobileNav = document.querySelector('[data-jrdc-mobile-nav]');
		if (navToggle && mobileNav) {
			navToggle.addEventListener('click', function () {
				mobileNav.classList.toggle('is-open');
				navToggle.setAttribute('aria-expanded', mobileNav.classList.contains('is-open') ? 'true' : 'false');
			});
		}

		// Escape close
		document.addEventListener('keydown', function (e) {
			if (e.key === 'Escape') {
				document.querySelectorAll('.jrdc-dropdown.is-open').forEach(function (d) { d.classList.remove('is-open'); });
				var mn = document.querySelector('[data-jrdc-mobile-nav]');
				if (mn && mn.classList.contains('is-open')) {
					mn.classList.remove('is-open');
					var nt = document.querySelector('[data-jrdc-nav-toggle]');
					if (nt) nt.setAttribute('aria-expanded', 'false');
				}
			}
		});

		updateToggleIcons();
	}

	if (document.readyState === 'loading') {
		document.addEventListener('DOMContentLoaded', init);
	} else {
		init();
	}
})();
