(function () {
	'use strict';

	function clearDateInputs(scope) {
		(scope || document).querySelectorAll('input[type="date"]').forEach(function (input) {
			input.removeAttribute('value');
			input.defaultValue = '';
			input.value = '';
			input.valueAsDate = null;
		});
	}

	function clearWithDelay(scope) {
		[0, 100, 500, 1000].forEach(function (delay) {
			window.setTimeout(function () {
				clearDateInputs(scope);
			}, delay);
		});
	}

	window.addEventListener('load', function () {
		clearWithDelay(document);
	});

	document.addEventListener('tabs:content-loaded', function (event) {
		clearWithDelay(event.target);
	});
}());
