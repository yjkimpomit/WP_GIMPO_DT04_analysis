/*
 * Realtime information panel
 */

$(function () {
    var $panel = $('#realtime-panel');
    var $toggleButton = $('.realtime-button');
    var $closeButton = $panel.find('.realtime-panel__close');

    if (!$panel.length || !$toggleButton.length) return;

    // 패널을 표시하고 토글 버튼의 접근성 상태를 활성화한다.
    function openPanel() {
        $panel.prop('hidden', false);
        $toggleButton.attr('aria-pressed', 'true');

        // 페이지 요소의 최대 z-index보다 높게 설정해 패널을 앞으로 올린다.
        var highestZIndex = 0;
        document.body.querySelectorAll('*').forEach(function (element) {
            var zIndex = Number.parseInt(window.getComputedStyle(element).zIndex, 10);
            if (!Number.isNaN(zIndex)) highestZIndex = Math.max(highestZIndex, zIndex);
        });
        $panel.css('z-index', highestZIndex + 1);
    }

    // 패널을 숨기고 인라인 z-index와 버튼의 활성 상태를 해제한다.
    function closePanel(restoreFocus) {
        $panel.prop('hidden', true);
        $panel.css('z-index', '');
        $toggleButton.attr('aria-pressed', 'false');

        // 닫기 버튼이나 Escape로 닫은 경우 토글 버튼으로 포커스를 돌려준다.
        if (restoreFocus) $toggleButton.trigger('focus');
    }

    // 패널 ID로 버튼을 연결하고, 클릭할 때 열기·닫기를 전환한다.
    $toggleButton.attr('aria-controls', $panel.attr('id')).on('click', function () {
        if ($panel.prop('hidden')) {
            openPanel();
            return;
        }

        closePanel(false);
    });

    // 패널 내부 닫기 버튼으로 패널을 닫는다.
    $closeButton.on('click', function () {
        closePanel(true);
    });

    // Escape 키로 열린 패널을 닫는다.
    $(document).on('keydown', function (event) {
        if (event.key === 'Escape' && !$panel.prop('hidden')) closePanel(true);
    });
});
