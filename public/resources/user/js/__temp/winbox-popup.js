(function () {
    'use strict';

    const popups = new Map();

    window.fnOpenWinboxPopup = function (button) {
        const modal = button.dataset.winboxPopupModal === 'true';
        const key = (button.dataset.winboxPopupId || button.dataset.winboxPopupUrl) + ':' + modal;
        let popup = popups.get(key);
        if (popup) {
            popup.restore();
            popup.focus();
            return;
        }

        // 호출 문서 내부에 생성하여 설비정보 WinBox와 수명·표시 영역을 공유합니다.
        popup = new window.WinBox(button.dataset.winboxPopupTitle, {
            root: document.body,
            url: button.dataset.winboxPopupUrl,
            width: Math.min(Number(button.dataset.winboxPopupWidth), window.innerWidth),
            height: Math.min(Number(button.dataset.winboxPopupHeight), window.innerHeight),
            minwidth: Math.min(200, window.innerWidth),
            minheight: Math.min(100, window.innerHeight),
            x: 'center',
            y: 'center',
            modal: modal,
            class: ['app-winbox', 'app-winbox--detail'],
            onclose: function () {
                popups.delete(key);
                if (button.isConnected) button.focus();
            }
        });
        popups.set(key, popup);
        const iframe = popup.window.querySelector('iframe');
        if (iframe) iframe.title = button.dataset.winboxPopupTitle;
    };
}());
