document.addEventListener('DOMContentLoaded', () => {
	const layout = document.querySelector('.admin-shell > main');
	const panelToggle = document.querySelector('[data-panel-toggle]');

	panelToggle?.addEventListener('click', () => {
		const isOpen = layout.classList.toggle('is-panel-open');
		panelToggle.setAttribute('aria-expanded', String(isOpen));
		panelToggle.setAttribute('aria-label', isOpen ? '좌측 패널 닫기' : '좌측 패널 열기');
	});

	document.querySelectorAll('aside nav button[aria-expanded]').forEach((button) => {
		button.addEventListener('click', () => {
			button.setAttribute('aria-expanded', String(button.getAttribute('aria-expanded') !== 'true'));
		});
	});

	const treeExpandToggle = document.querySelector('.equipment-search__expand-button');
	treeExpandToggle?.addEventListener('click', () => {
		const willExpand = treeExpandToggle.classList.contains('is-collapsed');
		document.querySelectorAll('aside nav button[aria-expanded]').forEach((button) => {
			button.setAttribute('aria-expanded', String(willExpand));
		});
		treeExpandToggle.classList.toggle('is-collapsed', !willExpand);
		treeExpandToggle.classList.toggle('is-expanded', willExpand);
		treeExpandToggle.setAttribute('aria-label', willExpand ? '트리 전체 접기' : '트리 전체 펼치기');
	});

});
