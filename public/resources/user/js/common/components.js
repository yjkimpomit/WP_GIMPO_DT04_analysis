/* 
initFilterPanels: 모바일 필터 패널 접기/펼치기
initInteractiveTables: 테이블 행 클릭·키보드 선택 및 팝업 실행
initMasterDetailTables: 마스터 테이블 행 선택 상태 관리
initPressedButtonGroups: 토글 버튼 그룹의 단일 선택 처리
initPopupForms: 팝업 폼 제출 방지 및 팝업 닫기
initComponents: 위 컴포넌트 일괄 초기화
DOM 로드 및 탭 콘텐츠 동적 로드 시 자동 재초기화
*/

function initFilterPanels(root = document) {
	root.querySelectorAll('.filter-panel').forEach((panel) => {
		if (panel.dataset.initialized) return;
		const header = panel.querySelector('.filter-panel__header');
		const toggle = panel.querySelector('.filter-panel__toggle');
		const searchGroup = panel.querySelector(':scope > .filter-panel__search');
		if (!header || !toggle) return;

		panel.dataset.initialized = 'true';
		const desktopQuery = window.matchMedia('(min-width: 992px)');
		const toggleLabel = (toggle.getAttribute('aria-label') || '정보 검색').replace(/\s*(접기|펼치기)$/, '');
		const setCollapsed = (collapsed) => {
			panel.classList.toggle('is-collapsed', collapsed);
			if (searchGroup) searchGroup.hidden = collapsed;
			toggle.setAttribute('aria-expanded', String(!collapsed));
			toggle.setAttribute('aria-label', `${toggleLabel} ${collapsed ? '펼치기' : '접기'}`);
		};

		header.addEventListener('click', () => {
			if (!desktopQuery.matches) setCollapsed(!panel.classList.contains('is-collapsed'));
		});
		desktopQuery.addEventListener('change', (event) => {
			if (event.matches) setCollapsed(false);
		});
		if (desktopQuery.matches) setCollapsed(false);
	});
}

/*
function initInteractiveTables(root = document) {
	root.querySelectorAll('.data-table--interactive').forEach((table) => {
		if (table.dataset.initialized) return; table.dataset.initialized = 'true';
		const rows = Array.from(table.tBodies[0]?.rows || []); rows.forEach((row) => { row.tabIndex = 0; row.setAttribute('aria-selected','false'); });
		const activate = (row) => { rows.forEach((item) => item.setAttribute('aria-selected',String(item === row))); row.querySelector('[data-winbox-popup]')?.click(); };
		table.addEventListener('click',(event)=>{const row=event.target.closest('tbody tr');if(row)activate(row);});
		table.addEventListener('keydown',(event)=>{if(!['Enter',' '].includes(event.key))return;const row=event.target.closest('tbody tr');if(row){event.preventDefault();activate(row);}});
	});
}
function initMasterDetailTables(root = document) {
	root.querySelectorAll('[data-master-detail]').forEach((table) => {
		if (table.dataset.masterDetailInitialized) return;
		const detail = document.getElementById(table.dataset.masterDetail);
		const rows = Array.from(table.tBodies[0]?.rows || []);
		if (!detail || !rows.length) return;

		table.dataset.masterDetailInitialized = 'true';
		rows.forEach((row) => {
			row.dataset.detailRow = '';
			row.tabIndex = 0;
			row.setAttribute('aria-selected', 'false');
			row.setAttribute('aria-controls', detail.id);
		});
		const select = (selectedRow) => rows.forEach((row) => {
			const selected = row === selectedRow;
			row.classList.toggle('data-table__row--selected', selected);
			row.setAttribute('aria-selected', String(selected));
		});
		table.addEventListener('click', (event) => {
			const row = event.target.closest('tr[data-detail-row]');
			if (row && table.contains(row)) select(row);
		});
		table.addEventListener('keydown', (event) => {
			if (!['Enter', ' '].includes(event.key)) return;
			const row = event.target.closest('tr[data-detail-row]');
			if (!row || !table.contains(row)) return;
			event.preventDefault();
			select(row);
		});
	});
}*/


// dataPARC 좌측패널 버튼 클릭 이벤트
// 여러 토글 버튼 중 하나만 선택되도록 관리하는 함수
function initPressedButtonGroups(root = document) {
	root.querySelectorAll('[data-pressed-button-group]').forEach((group) => {
		if (group.dataset.pressedButtonGroupInitialized) return;
		const buttons = Array.from(group.querySelectorAll('button[aria-pressed]'));
		if (!buttons.length) return;
		group.dataset.pressedButtonGroupInitialized = 'true';
		group.addEventListener('click', (event) => {
			const selectedButton = event.target.closest('button[aria-pressed]');
			if (!selectedButton || !group.contains(selectedButton)) return;
			buttons.forEach((button) => button.setAttribute('aria-pressed', String(button === selectedButton)));
		});
	});
}

function initPopupForms(root = document) {
	root.querySelectorAll('[data-popup-form]').forEach((form) => {
		if (form.dataset.popupFormInitialized) return;
		form.dataset.popupFormInitialized = 'true';
		form.addEventListener('submit', (event) => event.preventDefault());
	});
	root.querySelectorAll('[data-popup-close]').forEach((button) => {
		if (button.dataset.popupCloseInitialized) return;
		button.dataset.popupCloseInitialized = 'true';
		button.addEventListener('click', () => {
			const host = window.parent?.appWinbox ? window.parent : window;
			host.appWinbox?.closePopupWindow(button.dataset.popupClose);
		});
	});
}
function initComponents(root = document) {
	initFilterPanels(root);
	//initInteractiveTables(root);
	//initMasterDetailTables(root);
	initPressedButtonGroups(root);
	initPopupForms(root);
}
document.addEventListener('DOMContentLoaded',()=>initComponents());
document.addEventListener('tabs:content-loaded', (event) => {
	initComponents(event.target);
});
