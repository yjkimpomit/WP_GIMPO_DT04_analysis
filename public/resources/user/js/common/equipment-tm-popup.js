(function () {
    'use strict';

    let popup = null;

    // TM 탭이 동적으로 로드된 후에도 버튼 클릭을 처리합니다.
    document.addEventListener('click', function (event) {
        const button = event.target.closest('[data-winbox-popup-id="tm-issue"]');
        if (!button) return;

        if (popup) {
            popup.restore();
            popup.focus();
            return;
        }

        const host = typeof window.top.WinBox === 'function' ? window.top : window;
        const bounds = host.getWinboxGroupOptions?.() || { top: 0, left: 0, right: 0, bottom: 0 };
        popup = new host.WinBox(button.dataset.winboxPopupTitle, {
            ...bounds,
            url: button.dataset.winboxPopupUrl,
            root: host.document.body,
            width: Math.min(Number(button.dataset.winboxPopupWidth), host.innerWidth - bounds.left - bounds.right),
            height: Math.min(Number(button.dataset.winboxPopupHeight), host.innerHeight - bounds.top - bounds.bottom),
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

        const frame = popup.window.querySelector('iframe');
        const instance = popup;
        frame.title = 'TM발행 작성폼';
        frame.addEventListener('load', function () {
            const closeButton = frame.contentDocument.querySelector('[data-popup-close="tm-issue"]');
            closeButton?.addEventListener('click', function () { instance.close(); });
        });
    });
}());
