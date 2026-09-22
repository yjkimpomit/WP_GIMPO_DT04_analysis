/*
 * Model tree panel
 */

$(function () {
    var $panel = $('.model-viewer .model-tree').first();
    var $toggleButton = $('.model-tree-button');

    if (!$panel.length || !$toggleButton.length) return;

    // 트리 표시 상태(hidden, is-active)와 버튼의 접근성 상태를 함께 갱신한다.
    function setPanelOpen(isOpen, restoreFocus) {
        $panel.prop('hidden', !isOpen).toggleClass('is-active', isOpen);
        $toggleButton.attr('aria-pressed', String(isOpen));

        // 키보드로 닫은 경우 토글 버튼으로 포커스를 돌려준다.
        if (restoreFocus) $toggleButton.first().trigger('focus');
    }

    // HTML에 지정된 트리 ID로 버튼을 연결하고, 클릭할 때 열기·닫기를 전환한다.
    $toggleButton.attr('aria-controls', $panel.attr('id')).on('click', function () {
        setPanelOpen($panel.prop('hidden'), false);
    });

    // Escape 키로 열린 트리를 닫는다.
    $(document).on('keydown', function (event) {
        if (event.key === 'Escape' && !$panel.prop('hidden')) {
            setPanelOpen(false, true);
        }
    });

    // 버튼의 초기 aria-pressed 값에 맞춰 트리 표시 상태를 설정한다.
    setPanelOpen($toggleButton.first().attr('aria-pressed') === 'true', false);
});
