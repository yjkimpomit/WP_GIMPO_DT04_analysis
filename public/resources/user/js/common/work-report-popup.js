(function () {
    'use strict';

    let popup = null;

    // 탭에서 동적으로 불러온 등록 버튼에도 동일하게 적용합니다.
    document.addEventListener('click', function (event) {
        const button = event.target.closest('[data-work-report-popup]');
        if (!button) return;

        const host = typeof window.top.WinBox === 'function' ? window.top : window;
        if (popup) {
            popup.restore();
            popup.focus();
            return;
        }

        const bounds = host.getWinboxGroupOptions?.() || { top: 0, left: 0, right: 0, bottom: 0 };
        popup = new host.WinBox('일일안전작업 현황등록', {
            ...bounds,
            url: '/pages/daily-status/workReportForm.html',
            root: host.document.body,
            width: Math.min(960, host.innerWidth - bounds.left - bounds.right),
            height: Math.min(580, host.innerHeight - bounds.top - bounds.bottom),
            x: 'center',
            y: 'center',
            class: ['app-winbox', 'app-winbox--detail'],
            onmaximize: function () {
                if (this.min) return;
                host.fnSetWinboxTop?.(this, host.winboxIsOpen, 'max');
            },
            onclose: function () {
                popup = null;
                if (button.isConnected) button.focus();
            }
        });
        popup.window.querySelector('iframe').title = '일일안전작업 현황등록 작성폼';
    });
}());
