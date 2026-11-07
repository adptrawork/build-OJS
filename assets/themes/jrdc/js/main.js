/**
 * JRDC Theme — Frontend scripts
 * Dark mode persistence + mobile nav
 */
(function () {
	'use strict';

	var STORAGE_KEY = 'jrdc-theme-mode';

	function getPreferred() {
		var stored = null;
		try {
			stored = localStorage.getItem(STORAGE_KEY);
		} catch (e) {}
		if (stored === 'dark' || stored === 'light') return stored;
		if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
			return 'dark';
		}
		return 'light';
	}

	function applyMode(mode) {
		var root = document.documentElement;
		if (mode === 'dark') {
			root.classList.add('dark');
		} else {
			root.classList.remove('dark');
		}
		try {
			localStorage.setItem(STORAGE_KEY, mode);
		} catch (e) {}
	}

	// Apply early to avoid flash
	applyMode(getPreferred());

	document.addEventListener('DOMContentLoaded', function () {
		// Dark mode toggle
		var toggles = document.querySelectorAll('[data-jrdc-theme-toggle]');
		toggles.forEach(function (btn) {
			btn.addEventListener('click', function () {
				var isDark = document.documentElement.classList.contains('dark');
				applyMode(isDark ? 'light' : 'dark');
			});
		});

		// Mobile nav
		var navToggle = document.querySelector('[data-jrdc-nav-toggle]');
		var mobileNav = document.querySelector('[data-jrdc-mobile-nav]');
		if (navToggle && mobileNav) {
			navToggle.addEventListener('click', function () {
				mobileNav.classList.toggle('is-open');
				var expanded = mobileNav.classList.contains('is-open');
				navToggle.setAttribute('aria-expanded', expanded ? 'true' : 'false');
			});
		}
	});
})();
