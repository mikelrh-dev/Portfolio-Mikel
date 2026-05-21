/*
	Solid State by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
*/

(function($) {

	var	$window = $(window),
		$body = $('body'),
		$header = $('#header'),
		$banner = $('#banner');

	// Breakpoints.
		breakpoints({
			xlarge:	'(max-width: 1680px)',
			large:	'(max-width: 1280px)',
			medium:	'(max-width: 980px)',
			small:	'(max-width: 736px)',
			xsmall:	'(max-width: 480px)'
		});

	// Play initial animations on page load.
		$window.on('load', function() {
			window.setTimeout(function() {
				$body.removeClass('is-preload');
			}, 100);
		});

	// Header.
		if ($banner.length > 0
		&&	$header.hasClass('alt')) {

			$window.on('resize', function() { $window.trigger('scroll'); });

			$banner.scrollex({
				bottom:		$header.outerHeight(),
				terminate:	function() { $header.removeClass('alt'); },
				enter:		function() { $header.addClass('alt'); },
				leave:		function() { $header.removeClass('alt'); }
			});

		}

	// Menu.
		var $menu = $('#menu');

		$menu._locked = false;

		$menu._lock = function() {

			if ($menu._locked)
				return false;

			$menu._locked = true;

			window.setTimeout(function() {
				$menu._locked = false;
			}, 350);

			return true;

		};

		$menu._show = function() {

			if ($menu._lock())
				$body.addClass('is-menu-visible');

		};

		$menu._hide = function() {

			if ($menu._lock())
				$body.removeClass('is-menu-visible');

		};

		$menu._toggle = function() {

			if ($menu._lock())
				$body.toggleClass('is-menu-visible');

		};

		$menu
			.appendTo($body)
			.on('click', function(event) {

				event.stopPropagation();

				// Hide.
					$menu._hide();

			})
			.find('.inner')
				.on('click', '.close', function(event) {

					event.preventDefault();
					event.stopPropagation();
					event.stopImmediatePropagation();

					// Hide.
						$menu._hide();

				})
				.on('click', function(event) {
					event.stopPropagation();
				})
				.on('click', 'a', function(event) {

					var href = $(this).attr('href');

					event.preventDefault();
					event.stopPropagation();

					// Hide.
						$menu._hide();

					// Redirect.
						window.setTimeout(function() {
							window.location.href = href;
						}, 350);

				});

		$body
			.on('click', 'a[href="#menu"]', function(event) {

				event.stopPropagation();
				event.preventDefault();

				// Toggle.
					$menu._toggle();

			})
			.on('keydown', function(event) {

				// Hide on escape.
					if (event.keyCode == 27)
						$menu._hide();

			});

})(jQuery);

// ── Scroll Reveal (vanilla) ──
(function() {
	const observerOptions = {
		root: null,
		rootMargin: '0px 0px -60px 0px',
		threshold: 0.1
	};
	const observer = new IntersectionObserver((entries) => {
		entries.forEach(entry => {
			if (entry.isIntersecting) {
				entry.target.classList.add('active');
				observer.unobserve(entry.target);
			}
		});
	}, observerOptions);
	document.querySelectorAll('.reveal').forEach(el => observer.observe(el));
})();

// ── Typing Effect ──
(function() {
	const el = document.querySelector('.typing-text');
	if (!el) return;

	const words = ['Software Developer'];
	let wordIndex = 0;
	let charIndex = 0;
	let isDeleting = false;
	const typeSpeed = 80;
	const deleteSpeed = 40;
	const pauseBetween = 2000;

	function type() {
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
			setTimeout(type, pauseBetween);
			return;
		}

		if (isDeleting && charIndex === 0) {
			isDeleting = false;
			wordIndex = (wordIndex + 1) % words.length;
			setTimeout(type, 300);
			return;
		}

		setTimeout(type, isDeleting ? deleteSpeed : typeSpeed);
	}

	// Start after page load
	if (document.readyState === 'complete') {
		setTimeout(type, 500);
	} else {
		window.addEventListener('load', () => setTimeout(type, 500));
	}
})();