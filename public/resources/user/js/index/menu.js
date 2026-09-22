/*
 * GNB menu
 */

$(document).ready(function () {
    var $leftBox = $('.left-box');
    var $toggleBtn = $('#toggle-button');
    var $mobileToggleBtn = $('.site-header__menu-button');

    function bringMenuToFront() {
        var maxZIndex = 9;

        $('.winbox, .site-header').each(function () {
            var zIndex = parseInt(window.getComputedStyle(this).zIndex, 10);

            if (!isNaN(zIndex)) {
                maxZIndex = Math.max(maxZIndex, zIndex);
            }
        });

        $leftBox.css('z-index', maxZIndex + 1);
    }

    function resetHoverState() {
        $('#menuList .menu-box').removeClass('active').css('z-index', '');
    }

    function closeMenu() {
        $leftBox.removeClass('expand');
        $toggleBtn.find('span').text('메뉴 열기');
        $mobileToggleBtn.attr({
            'aria-expanded': 'false',
            'aria-label': '전체 메뉴 열기'
        });
        $('#menuList li .menu-box:has(.d2)').addClass('hide');
        $('#menuList .open-icon').addClass('is-collapsed').attr('aria-expanded', 'false');
        resetHoverState();
    }

    function globalMenu() {
        $leftBox.toggleClass('expand');
        resetHoverState();

        if (!$leftBox.hasClass('expand')) {
            closeMenu();
            return;
        }

        $toggleBtn.find('span').text('메뉴 닫기');
        $mobileToggleBtn.attr({
            'aria-expanded': 'true',
            'aria-label': '전체 메뉴 닫기'
        });
        $('#menuList .menu-box').removeClass('active');
        $('#menuList li .menu-box:has(.d2)').removeClass('hide');
        $('#menuList .open-icon').removeClass('is-collapsed').attr('aria-expanded', 'true');

        bringMenuToFront();
    }

    function toggleSubmenu($icon) {
        var $menuBox = $icon.closest('.menu-item').next('.menu-box');
        var isOpen = $icon.attr('aria-expanded') === 'true';

        $menuBox.toggleClass('hide', isOpen);
        $icon.toggleClass('is-collapsed', isOpen).attr('aria-expanded', String(!isOpen));

        if (!isOpen) {
            $menuBox.find('.menu-link').first().focus();
        }
    }

    window.globalMenu = globalMenu;

    $mobileToggleBtn.on('click', globalMenu);

    // WinBox의 전역 포커스 처리보다 먼저 메뉴 레이어를 확정한다.
    $(document).on('pointerdown mousedown touchstart', '.left-box', function (event) {
        bringMenuToFront();
        event.stopPropagation();
    });

    $(document).on('click', function (event) {
        var isTabletOrLarger = window.matchMedia('(min-width: 768px)').matches;
        var isMenuControl = $(event.target).closest($mobileToggleBtn).length > 0;

        if (isTabletOrLarger || !$leftBox.hasClass('expand') || isMenuControl) return;
        if ($(event.target).closest($leftBox).length === 0) closeMenu();
    });

    $('#menuList .menu-item').hover(function () {
        if (!$leftBox.hasClass('expand')) {
            resetHoverState();

            var $menuBox = $(this).siblings('.menu-box');

            bringMenuToFront();
            $menuBox.addClass('active');
        }
    }, function () {
        if (!$leftBox.hasClass('expand')) {
            var $menuBox = $(this).siblings('.menu-box');

            setTimeout(function () {
                if (!$menuBox.is(':hover')) {
                    $menuBox.removeClass('active').css('z-index', '');
                }
            }, 100);
        }
    });

    $(document).on('mouseleave', '#menuList .menu-box', function () {
        if (!$leftBox.hasClass('expand')) {
            $(this).removeClass('active').css('z-index', '');
        }
    });

    $(document).on('focusin', '#menuList .menu-item, #menuList .menu-box', function () {
        if (!$leftBox.hasClass('expand')) {
            var $menuBox = $(this).closest('li').children('.menu-box');

            resetHoverState();
            bringMenuToFront();
            $menuBox.addClass('active');
        }
    });

    $(document).on('focusout', '#menuList li', function () {
        var $li = $(this);

        if (!$leftBox.hasClass('expand')) {
            setTimeout(function () {
                if (!$li.find(':focus').length) {
                    $li.children('.menu-box').removeClass('active').css('z-index', '');
                }
            }, 0);
        }
    });

    $('#menuList .menu-box').mouseleave(function () {
        if (!$leftBox.hasClass('expand')) {
            resetHoverState();
        }
    });

    // WinBox는 포커스될 때 z-index가 증가하므로 메뉴를 항상 최상위로 올린다.
    var winboxObserver = new MutationObserver(function (mutations) {
        var layerChanged = mutations.some(function (mutation) {
            if (mutation.type === 'attributes') {
                return mutation.target.matches('.winbox, .popup, .modal, .model-viewer');
            }

            return Array.from(mutation.addedNodes).some(function (node) {
                return node.nodeType === Node.ELEMENT_NODE &&
                    (node.matches('.winbox, .popup, .modal, .model-viewer') ||
                        node.querySelector('.winbox, .popup, .modal, .model-viewer'));
            });
        });

        if (layerChanged) {
            bringMenuToFront();
        }
    });

    winboxObserver.observe(document.body, {
        attributes: true,
        attributeFilter: ['class', 'style'],
        childList: true,
        subtree: true
    });

    $leftBox.css('z-index', 10);

    // 링크의 onclick 실행이 완료된 뒤 메뉴를 닫는다.
    $(document).on('click', '#menuList .menu-link[onclick]', function () {
        window.setTimeout(closeMenu, 0);
    });

    $(document).on('click', '#menuList .menu-link.d1', function () {
        var $depth1 = $(this);
        var $menuItem = $depth1.closest('.menu-item');
        var $menuBox = $menuItem.next('.menu-box');
        var $openIcon = $menuItem.find('.open-icon');
        var isTabletOrLarger = window.matchMedia('(min-width: 768px)').matches;

        if (!isTabletOrLarger) {
            if ($openIcon.length) toggleSubmenu($openIcon);
            return;
        }

        $menuBox
            .find('a.menu-link[href], button.menu-link[onclick]')
            .first()
            .trigger('click');
    });

    $(document).on('click', '#menuList .open-icon', function (event) {
        event.preventDefault();
        event.stopPropagation();

        var $icon = $(this);

        if (!$leftBox.hasClass('expand')) return;

        toggleSubmenu($icon);
    });

    window.addEventListener('resize', closeMenu);
});
