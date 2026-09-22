/*
 * Header search
 */

$(function () {
    var $search = $('.site-search');
    var $input = $('#site-search-query');
    var $submitButton = $search.find('button[type="submit"]');
    var $closeButton = $search.find('.site-search__close');
    // 768px 이상에서는 기본 검색 폼을 사용하고, 미만에서는 확장형 검색을 사용한다.
    var tabletMedia = window.matchMedia('(min-width: 768px)');

    if (!$search.length || !$input.length) return;

    // 검색창을 확장하고 접근성 상태를 갱신한 뒤 입력창으로 포커스를 이동한다.
    function openSearch() {
        $search.addClass('is-expanded');
        $submitButton.attr('aria-expanded', 'true');
        $input.trigger('focus');
    }

    // 검색창의 확장 상태를 해제하고, 필요한 경우 검색 버튼으로 포커스를 돌려준다.
    function closeSearch(restoreFocus) {
        $search.removeClass('is-expanded');
        $submitButton.attr('aria-expanded', 'false');

        if (restoreFocus) $submitButton.trigger('focus');
    }

    // 검색 버튼에 초기 확장 상태와 제어 대상 입력창 ID를 지정한다.
    $submitButton.attr({
        'aria-expanded': 'false',
        'aria-controls': $input.attr('id')
    });

    // 모바일에서 접힌 상태로 제출하면 검색창만 연다. 그 외에는 기본 제출을 허용한다.
    $search.on('submit', function (event) {
        if (tabletMedia.matches || $search.hasClass('is-expanded')) return;

        event.preventDefault();
        openSearch();
    });

    // 닫기 버튼은 검색어를 비우고 검색창을 닫은 뒤 검색 버튼으로 포커스를 돌려준다.
    $closeButton.on('click', function () {
        $input.val('');
        closeSearch(true);
    });

    // Escape 키로 확장된 검색창을 닫는다. 입력한 검색어는 유지한다.
    $(document).on('keydown', function (event) {
        if (event.key === 'Escape' && $search.hasClass('is-expanded')) {
            closeSearch(true);
        }
    });

    // 모바일에서 검색 영역 밖을 클릭하면 포커스를 강제로 이동하지 않고 닫는다.
    $(document).on('click', function (event) {
        if (tabletMedia.matches || !$search.hasClass('is-expanded')) return;
        if ($(event.target).closest($search).length === 0) closeSearch(false);
    });

    // 화면 너비가 768px 경계를 넘으면 검색창의 확장 상태를 초기화한다.
    tabletMedia.addEventListener('change', function () {
        closeSearch(false);
    });
});
