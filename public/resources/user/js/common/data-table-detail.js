function initDataTableDetailPopups(root = document) {
	root.querySelectorAll('[data-detail-popup]').forEach((table) => {
		if (table.dataset.detailPopupInitialized === 'true') return;

		const detailUrl = table.dataset.detailPopupUrl;
		const detailMessage = table.dataset.detailMessage;
		if (!detailUrl && !detailMessage) return;

		table.dataset.detailPopupInitialized = 'true';
		const rows = Array.from(table.querySelector('[data-table-body]')?.rows || table.tBodies[0]?.rows || []);
		if (!rows.length) return;

		rows.forEach((row) => {
			row.dataset.detailRow = '';
			row.tabIndex = 0;
			row.setAttribute('aria-selected', 'false');
		});

		const selectRow = (row) => {
			rows.forEach((item) => {
				const selected = item === row;
				item.classList.toggle('data-table__row--selected', selected);
				item.setAttribute('aria-selected', String(selected));
			});
		};

		const openDetailPopup = (row) => {
			const hostWindow = window.parent?.appWinbox ? window.parent : window;
			if (detailMessage) {
				hostWindow.alert(detailMessage);
				return;
			}
			if (!hostWindow.appWinbox?.openDetailWindow) return;

			const titleColumn = Number.parseInt(table.dataset.detailPopupTitleColumn, 10);
			const title = Number.isInteger(titleColumn) && row.cells[titleColumn]
				? row.cells[titleColumn].textContent.trim()
				: table.dataset.detailPopupTitle || '상세정보';
			hostWindow.appWinbox.openDetailWindow({
				title,
				url: detailUrl,
				width: Number(table.dataset.detailPopupWidth) || hostWindow.innerWidth,
				height: Number(table.dataset.detailPopupHeight) || hostWindow.innerHeight,
			});
		};

		table.addEventListener('click', (event) => {
			const row = event.target.closest('tr[data-detail-row]');
			if (!row || !table.contains(row)) return;
			selectRow(row);
			openDetailPopup(row);
		});

		table.addEventListener('keydown', (event) => {
			if (!['Enter', ' '].includes(event.key)) return;
			const row = event.target.closest('tr[data-detail-row]');
			if (!row || !table.contains(row)) return;
			event.preventDefault();
			selectRow(row);
			openDetailPopup(row);
		});
	});
}

document.addEventListener('DOMContentLoaded', () => initDataTableDetailPopups());
document.addEventListener('tabs:content-loaded', (event) => initDataTableDetailPopups(event.target));
