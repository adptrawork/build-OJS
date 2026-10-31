/**
 * Journal Editorial theme interactions: dark-mode toggle. No dependencies.
 * Content is never hidden by JS — progressive enhancement only.
 */
(function () {
	'use strict';

	var THEME_KEY = 'jilp-theme';

	function applyTheme(isDark) {
		document.body.classList.toggle('dark-mode', isDark);
		document.querySelectorAll('.jilp-theme-toggle-icon').forEach(function (icon) {
			icon.classList.toggle('bi-moon-stars-fill', !isDark);
			icon.classList.toggle('bi-sun-fill', isDark);
		});
	}

	try {
		applyTheme(localStorage.getItem(THEME_KEY) === 'dark');
	} catch (e) {
		applyTheme(false);
	}

	document.addEventListener('click', function (event) {
		var button = event.target.closest('.jilp-theme-toggle');
		if (!button) {
			return;
		}
		var isDark = !document.body.classList.contains('dark-mode');
		try {
			localStorage.setItem(THEME_KEY, isDark ? 'dark' : 'light');
		} catch (e) {
			// Storage unavailable in private mode; toggle still works.
		}
		applyTheme(isDark);
	});
})();
