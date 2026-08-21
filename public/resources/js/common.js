/*
* common.js
*
* */

/* set WinBox */
var targetWinbox;

/* WinBox temp get data */
var winboxIsOpen = true;
var winboxTop;
var winboxHeight;

// winbox device control
var WINBOX_BREAKPOINT = 768;
var WINBOX_DESKTOP_INSET = 16;
var WINBOX_MOBILE_INSET = 8;
var WINBOX_MOBILE_TOP = 56;
var WINBOX_HEADER_HEIGHT = 40;
var WINBOX_MINIMIZED_GAP = 8;

function fnLayoutMinimizedWinboxes() {
    var topWindow = window.top;
    var base = getWinboxGroupOptions();
    var minimizedElements = Array.from(topWindow.document.querySelectorAll(".winbox.app-winbox.min"));
    var count = minimizedElements.length;

    if (count === 0) return;

    var availableWidth = topWindow.innerWidth - base.left - base.right;
    var totalGap = WINBOX_MINIMIZED_GAP * Math.max(0, count - 1);
    var minimizedWidth = Math.min(260, Math.max(160, (availableWidth - totalGap) / count));
    var left = base.left;
    var top = topWindow.innerHeight - base.bottom - WINBOX_HEADER_HEIGHT;

    minimizedElements.forEach(function (element) {
        var winbox = element.winbox;

        if (winbox && winbox.resize && winbox.move) {
            winbox.resize(minimizedWidth, WINBOX_HEADER_HEIGHT, true);
            winbox.move(left, top, true);
        } else {
            element.style.width = minimizedWidth + "px";
            element.style.height = WINBOX_HEADER_HEIGHT + "px";
            element.style.left = left + "px";
            element.style.top = top + "px";
        }

        left += minimizedWidth + WINBOX_MINIMIZED_GAP;
    });
}

function fnScheduleMinimizedWinboxLayout() {
    window.top.requestAnimationFrame(fnLayoutMinimizedWinboxes);
}

function getDesktopGnbWidth() {
    var value = window.top.getComputedStyle(window.top.document.documentElement)
        .getPropertyValue('--gnb-width-collapsed');

    return Number.parseFloat(value) || 80;
}

function getWinboxGroup(isMobileView) {
    if (isMobileView) {
        return {
            top: WINBOX_MOBILE_TOP,
            left: WINBOX_MOBILE_INSET,
            right: WINBOX_MOBILE_INSET,
            bottom: WINBOX_MOBILE_INSET,
            border: 0
        };
    }

    return {
        top: WINBOX_DESKTOP_INSET,
        left: getDesktopGnbWidth(),
        right: WINBOX_DESKTOP_INSET,
        bottom: WINBOX_DESKTOP_INSET,
        border: 0
    };
}

/* pc 모드에서 width 체크 */
function fnGetDeviceWidth() {
    var width = window.top.innerWidth;

    return getWinboxGroup(width < WINBOX_BREAKPOINT);
}

/* 디바이스 체크 */
function getDeviceType() {
    var checkDevice = window.top.checkDevice;

    if (checkDevice === "mobile") {
        return getWinboxGroup(true);
    } else {
        return fnGetDeviceWidth();
    }
}

function getWinboxGroupOptions() {
    return getDeviceType();
}

/* start run resize */
var winboxResizeTimer = null;

function fnResizeOpenedWinbox() {
    var $winboxes = $(".winbox:not(.min)");
    if ($winboxes.length === 0) return;

    // header open/close 상태와 device width 기준으로 top/height 재계산
    fnSetWinboxTop(".winbox:not(.min)", winboxIsOpen, "resize");
}

window.addEventListener("resize", function () {
    clearTimeout(winboxResizeTimer);

    winboxResizeTimer = setTimeout(function () {
        fnResizeOpenedWinbox();
    }, 100);

    // 윈도우 리사이징 메뉴와 운전정보 버튼 초기화
    $('.btn-status img').attr('src', '/resources/images/icons/icon-power.svg').attr('alt', '기타정보 열기');
    //$('#toggle-button img').attr('src', '/resources/images/icons/icon-menu.svg').attr('alt', '메뉴 열기');
    $('.operation-status').removeClass('visible');

});
/* end run resize */

/**
 * 메뉴 팝업창 열기
 * @param url
 * @param target
 */
function fnOpenPopup(url, target) {
    var title = target.data("title");

    // 기존 메뉴 닫기
    //var closeTarget = ['대시보드', '서비스 바로가기', '일일안전현황', '설비정보', '설비상세정보', 'TM현황', '작업현황', '예방점검현황', '조기경보', 'CCTV', '파노라마', '설비검색', '개선요청', '로그시트', '방문자 조회', 'dataPARC', 'P&ID'];
    var closeTarget = ['대시보드'];
    $('.wb-title').each(function () {
        // 이미 열려져 있는 창 닫기
        /*if (closeTarget.includes(title) && title === $(this).text()) {
            $(this).closest('.wb-header').find('.wb-close').trigger('click');
            return false;
        }*/

        // 같은 메뉴 2개 사용안함 - 메뉴 리스트와 비교해서 창닫기
        var title = $(this).text();
        if (closeTarget.some(closeTarget => title.includes(closeTarget))) {
            if (title === "설비상세정보") {
                // Set 3d model flag
                //setRenderActive("false");
            }

            $(this).closest('.wb-header').find('.wb-close').trigger('click');
        }

        // all close
        // $('.wb-close').trigger('click');
    });

    // 모든 창 최소화
    fnCloseAllWinbox();

    var base = getWinboxGroupOptions();
    winboxTop = base.top;
    winboxHeight = base.height;

    targetWinbox = new WinBox(title, Object.assign({}, base, {
        groupId: "winMain-group"
        , header: WINBOX_HEADER_HEIGHT
        , class: ["no-full", "app-winbox"]
        , url: url, onCreate: function (options) {
            options.autoResize = true;
        },
        onmaximize: function () {
            if (this.min) return;
            fnSetWinboxTop(this, winboxIsOpen, "max");
            setRenderActive("false");
        },
        onclose: function (force) {
            var targetText = this.title;

            if (targetText === "대시보드") {
                // iframe check
                var iframe = this.window;
                if (iframe) {
                    // dashboard interval stop
                    clearInterval(iframe.intervalWorkReportT3);
                    clearInterval(iframe.intervalChartDatas9);
                    clearInterval(iframe.intervalChartDatas10);
                    clearInterval(iframe.intervalOutputStatsApiT3);
                }
            }

            setRenderActive("true");
            fnScheduleMinimizedWinboxLayout();
        },
        onminimize: function () {
            setRenderActive("true");
            fnScheduleMinimizedWinboxLayout();
        },
        onrestore: function () {
            fnScheduleMinimizedWinboxLayout();
        },
        onfocus() {
            setRenderActive("false");
        }
    }));

    setRenderActive("false");
    targetWinbox.maximize();
}

/* winbox popupstandard control : check unity activity */
function fnOpenPopupStandardSetUnityControl(isFlag) {
    const topWindow = window.top;

    setTimeout(() => {
        window.top.setRenderActive(isFlag);
    }, 100);

    return false;
}

/**
 * WinBox에서 독립 WinBox로 띄우기
 * 이 메소드만 부모의 scriipt 변수를 필요로 하므로 parent를 사용해야 함
 * 멀티뷰 화면
 *
 * @param url
 * @param target
 */
function fnOpenPopupStandard(url, title) {
    // 열려져 있는 모든 창 최소화
    fnAllMinParentWinbox();

    /* iframe으로 팝업이므로 상위의 checkDevice 정보를 가지고 옴 */
    var checkDevice = window.top.checkDevice;

    // 기존 메뉴 닫기
    var closeTarget = ['파노라마', 'dataPARC', 'P&ID'];

    window.top.$('.wb-title').each(function () {
        var title = $(this).text();
        if (closeTarget.some(closeTarget => title.includes(closeTarget))) {
            $(this).closest('.wb-header').find('.wb-close').trigger('click');
        }
    });

    /* 설비상세정보 - 개수 제한 체크 */
    var count = 0;
    window.top.$('.wb-title').each(function () {
        var title = $(this).text();
        if (title.includes("설비상세정보")) {
            count++;
        }
    });

    if (count >= 3) {
        // 자동으로 이전 팝업 창 닫기
        var tot = count - 3;
        window.top.$('.wb-title').each(function (idx, t) {
            var title = $(this).text();
            if (title.includes("설비상세정보")) {
                if (idx <= tot) {
                    $(this).closest('.wb-header').find('.wb-close').trigger('click');
                }
            }
        });
    }
    /* 설비상세정보 - 개수 제한 체크 끝 */

    // 상위에 팝업창 생성
    var base = getWinboxGroupOptions();
    var topWindow = window.top;

    targetWinbox = new topWindow.WinBox(title, Object.assign({}, base, {
        groupId: "winMain-group"
        , header: WINBOX_HEADER_HEIGHT
        , root: topWindow.document.body
        , class: ["no-full", "app-winbox"]
        , url: url, onCreate: function (options) {
            options.autoResize = true;
        },
        onmaximize: function () {
            if (this.min) return;
            fnSetWinboxTop(this, window.top.winboxIsOpen, "max");
            fnOpenPopupStandardSetUnityControl("false");

        },
        onclose: function (force) {
            //var targetText = this.title;
            fnOpenPopupStandardSetUnityControl("true");
            fnScheduleMinimizedWinboxLayout();
        },
        onminimize: function () {
            fnOpenPopupStandardSetUnityControl("true");
            fnScheduleMinimizedWinboxLayout();
        },
        onrestore: function () {
            fnScheduleMinimizedWinboxLayout();
        },
        onfocus() {
            fnOpenPopupStandardSetUnityControl("false");
        },
        onblur() {
            fnOpenPopupStandardSetUnityControl("true");
        }
    }));

    // model deactive
    window.top.setRenderActive("false");
    targetWinbox.maximize();
}

/**
 * 설비정보 메뉴 팝업창 열기
 * @param url
 * @param target
 */
function fnOpenPopupFacilityMenu(url, target) {
    var title = target.data("title");
    var base = getWinboxGroupOptions();
    var isMobileView = window.top.innerWidth < WINBOX_BREAKPOINT;

    // Update global top/height
    winboxTop = base.top;
    winboxHeight = base.height;

    if (isMobileView) {
        targetWinbox = new WinBox(title, Object.assign({}, base, {
            groupId: "winMain-group", header: WINBOX_HEADER_HEIGHT, class: ["no-full", "app-winbox", "facility"], width: "100%", height: "100%", url: url, onCreate: function (options) {
                options.autoResize = true;
            },
            onmaximize: function () {
                if (this.min) return;
                fnSetWinboxTop(this, winboxIsOpen, "max");
                setRenderActive("false");
            },
            onminimize: function () {
                setRenderActive("true");
                fnScheduleMinimizedWinboxLayout();
            },
            onrestore: function () {
                fnScheduleMinimizedWinboxLayout();
            },
            onclose: function () {
                fnScheduleMinimizedWinboxLayout();
            },
            onfocus() {
                setRenderActive("false");
            },
            onblur() {
                setRenderActive("true");
            }
        }));
    } else {
        targetWinbox = new WinBox(title, Object.assign({}, base, {
            groupId: "winMain-group", header: WINBOX_HEADER_HEIGHT, class: ["no-full", "app-winbox", "facility"], width: 480, height: 720, x: "center", y: "center", url: url, onCreate: function (options) {
                options.autoResize = true;
            },
            onmaximize: function () {
                if (this.min) return;
                fnSetWinboxTop(this, winboxIsOpen, "max");
                setRenderActive("false");
            },
            onminimize: function () {
                setRenderActive("true");
                fnScheduleMinimizedWinboxLayout();
            },
            onrestore: function () {
                fnScheduleMinimizedWinboxLayout();
            },
            onclose: function () {
                fnScheduleMinimizedWinboxLayout();
            },
            onfocus() {
                setRenderActive("false");
            },
            onblur() {
                setRenderActive("true");
            }
        }));
    }

    if (isMobileView) {
        fnSetWinboxTop(targetWinbox, winboxIsOpen, "facilityMenu");
    }
}

/**
 * 모든 창 닫기
 */
function fnWinPopAllClose() {
    if (!targetWinbox || !targetWinbox.g) return;

    if (confirm("모든 창을 닫겠습니까?")) {
        $(".wb-close").trigger('click');

        setRenderActive("true");
    }
}

/**
 * 모든 창 최소화
 */
function fnWinPopMinimize() {
    if (!targetWinbox || !targetWinbox.g) return;

    if ($(".winbox:not(.min)").length > 0) {
        if (confirm("모든 창을 최소화하겠습니까?")) {
            fnCloseAllWinbox();
        }
    }
}

function fnWinOpenLogVisit(target) {
    fnOpenPopup("/log/index.do", target);
    $('.left-box').removeClass('expand');
}

/**
 * 페이지의 탭메뉴에 대한 기능 설정
 * tab trigger event
 * @param target
 */
function fnSetCommonBootstrapTab(target) {
    try {
        // Normalize to a DOM element (supports jQuery object or DOM node)
        var el = target && target.jquery ? target[0] : target;
        if (!el) return;

        if (window.bootstrap && typeof window.bootstrap.Tab === 'function') {
            var bsTab = new bootstrap.Tab(el);
            bsTab.show();
        } else if (window.jQuery) {
            // Bootstrap이 없더라도 최소한 ARIA/클래스 정리
            var $this = $(el);
            $('.nav-link').removeClass('active').attr('aria-selected', false);
            $this.addClass('active').attr('aria-selected', true);
            var targetSel = $this.attr('data-bs-target') || $this.attr('href');
            // 탭 패널 show 처리
            if (targetSel && targetSel.charAt(0) === '#') {
                $('.tab-pane').removeClass('show active');
                $(targetSel).addClass('show active');
            }
        }
    } catch (e) {
        console.log(e);
    }
}

// 3D모델 사용가이드 버튼제어
function closeControlGuide() {
    window.top.$('.unity-guide').fadeOut(500);
}

// 유니티에서 하단 버튼클릭시 가이드팝업 나타남
function openControlGuide() {
    window.top.$('.unity-guide').fadeIn(500);
}

// 공통 z-index 함수
function getMaxZIndex() {
    let maxZIndex = 0;

    $('.winbox, .site-header').each(function () {
        const zIndex = parseInt($(this).css('z-index'), 10);

        if (!isNaN(zIndex)) {
            maxZIndex = Math.max(maxZIndex, zIndex);
        }
    });

    return maxZIndex;
}

function bringToFront($target) {
    $target.css('z-index', getMaxZIndex() + 1);
}

$(document).ready(function () {
    // 사이드 패널 열고닫기
    $('.js-panel-toggle').click(function () {

        var $btn = $(this);
        var $panel = $btn.closest('.panel-box').find('.side-panel');

        $panel.toggleClass('is-open');

        if ($panel.hasClass('is-open')) {
            $btn.find('span').text('좌측패널 닫기');
        } else {
            $btn.find('span').text('좌측패널 열기');
        }
    });
});

//날짜 한달 전으로 세팅하는 공통 함수
function setDateS() {
    //날짜 현재날짜 기준 한 달 전 세팅
    var today = new Date();
    var yyyy = today.getFullYear();
    var mm = ("0" + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
    var dd = ("0" + today.getDate()).slice(-2);
    var currentDate = yyyy + "-" + mm + "-" + dd;
    $('#designDateEnd').val(currentDate); // 첫 번째 input에 오늘 날짜 설정

    // 두 번째 input 태그 (한 달 전 날짜로 설정)
    today.setMonth(today.getMonth() - 1); // 현재 날짜 기준 한 달 전으로 설정
    var lastMonthDate = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + ("0" + today.getDate()).slice(-2);
    $('#designDateStart').val(lastMonthDate); // 두 번째 input에 한 달 전 날짜 설정
}

function fnWoSearchForm() {
    $.ajax({
        type: "POST", url: "/common/wolInfo.do", dataType: "html", beforeSend: function () {
            $("#loadingBar").css("display", "");
        }, success: function (data) {
            $("#woSearchListForm").html(data);
        }, error: function (request, status, error) {
            console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
        }, complete: function () {
            $("#loadingBar").css("display", "none");
        }
    });
}

// 검색박스내 W/O  팝업
function searchWoTreePopup(target) {
    $("#searchWoTreePopup").bPopup({
        modalClose: false, opacity: 0.2, speed: 450, closeClass: "close", onOpen: function () {
            $("#searchWoTreePopup").addClass('show');
            fnWoSearchForm();
        }, onClose: function () {
            $("#searchWoTreePopup").removeClass('show');
            $("#woSearchListForm").html('');
        }
    });
}

//W/O 상세 검색
function fnWoDetailSearch() {
    var startVal = "";
    var endVal = "";

    //조회 시작일
    startVal = document.getElementById("designDateStart").value;
    //조회 종료일
    endVal = document.getElementById("designDateEnd").value;

    if (startVal !== "" && endVal === "") {
        alert("조회 종료일을 선택해주세요");
        return false;
    } else if (startVal === "" && endVal !== "") {
        alert("조회 시작일을 선택해주세요");
        return false;
    } else if (startVal > endVal) {
        alert("조회 종료일을 시작일 이전으로 설정할 수 없습니다.\n조회 종료일을 다시 선택해주세요.");
        return false;
    }

    $.ajax({
        type: "POST", url: "/common/wolList.do", data: $("#form_search_woresult1").serialize(), dataType: "html", beforeSend: function () {
            $("#loadingBar").css("display", "");
        }, success: function (data) {
            $("#_VIEW_WO_RESULTS_LIST").html(data);
        }, error: function (request, status, error) {
            console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
        }, complete: function () {
            $("#loadingBar").css("display", "none");
        }
    });
}

//설비마스터 상세 검색
function fnFacilityDetailSearch() {
    $.ajax({
        type: "POST", url: "/common/facilitydetailList.do?searchUseYn=S", data: $("#form_search_result1").serialize(), dataType: "html", beforeSend: function () {
            $("#loadingBar").css("display", "");
        }, success: function (data) {
            $("#facilityMasterList").html(data);
        }, error: function (request, status, error) {
            console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
        }, complete: function () {
            $("#loadingBar").css("display", "none");
        }
    });
}

//설비마스터 페이지 이동 부분
function fnfacilityDetailPageMove(f) {
    var detailCurrentPage = parseInt($("#detailCurrentPage").val());

    var flg = $("#chkItemNo").val();
    var flgNo = "";
    if (f === 'P') {
        if (detailCurrentPage === 1) {
            alert("처음 페이지입니다.");
            return false;
        }

        detailCurrentPage = detailCurrentPage - 1;
    } else if (f === 'N') {
        if (detailCurrentPage == totalPage) {
            alert("마지막 페이지입니다.");
            return false;
        }

        detailCurrentPage = detailCurrentPage + 1;
    } else if (f === 'M') {
        if (detailCurrentPage > totalPage) {
            alert("마지막 페이지는 " + totalPage + "입니다. 이 페이지를 초과할 수 없습니다.");
            $("#detailCurrentPage").val(totalPage);
            return false;
        }
    }

    $("#detailCurrentPage").val(detailCurrentPage);
    var dataToSend = {};

    if (flg === "S") {
        $.ajax({
            type: "POST", url: "/common/facilitydetailList.do?searchUseYn=S&pageIndex=" + detailCurrentPage, data: $("#form_search_result1").serialize(), dataType: "html", beforeSend: function () {
                $("#loadingBar").css("display", "");
            }, success: function (data) {
                $("#facilityMasterList").html(data);
            }, error: function (request, status, error) {
                console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
            }, complete: function () {
                $("#loadingBar").css("display", "none");
            }
        });
    } else {
        flgNo = $("#chkItemVal").val();
        if (flg === "M1") {
            dataToSend = {locNo: flgNo}
        } else if (flg === "M2") {
            dataToSend = {eqCategory: flgNo}
        } else if (flg === "M3") {
            dataToSend = {eqType: flgNo}
        }

        $.ajax({
            type: "POST", url: "/common/facilitydetailList.do?searchUseYn=" + flg + "&pageIndex=" + detailCurrentPage, data: dataToSend, dataType: "html", beforeSend: function () {
                $("#loadingBar").css("display", "");
            }, success: function (data) {
                $("#facilityMasterList").html(data);
            }, error: function (request, status, error) {
                console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
            }, complete: function () {
                $("#loadingBar").css("display", "none");
            }
        });
    }
}

// 검색박스내 설비종류 검색팝업
function searchFacilityTypeTreePopup(target) {
    $("#searchFacilityTypeTreePopup").bPopup({
        modalClose: false, opacity: 0.2, speed: 450, closeClass: "close", onOpen: function () {
            $("#searchFacilityTypeTreePopup").addClass('show');
        }, onClose: function () {
            $("#searchFacilityTypeTreePopup").removeClass('show');
        }
    });
}

// 검색박스내 설비기능위치 검색팝업
function searchFacilityLocTreePopup(target) {
    $("#searchFacilityLocTreePopup").bPopup({
        modalClose: false, opacity: 0.2, speed: 450, closeClass: "close", onOpen: function () {
            $("#searchFacilityLocTreePopup").addClass('show');
        }, onClose: function () {
            $("#searchFacilityLocTreePopup").removeClass('show');
        }
    });
}

// 검색박스내 감독부서 검색팝업
function searchReqTreePopup(target) {
    $("#searchReqTreePopup").bPopup({
        modalClose: false, opacity: 0.2, speed: 450, closeClass: "close", onOpen: function () {
            // #searchTreePopup에 클래스 추가
            $("#searchReqTreePopup").addClass('show');
        }, onClose: function () {
            var tree = $.fn.zTree.getZTreeObj('reqTree1');
            if (tree) {
                tree.expandAll(false);
                tree.cancelSelectedNode();
            }
            $("#searchReqTreePopup").removeClass('show');
        }
    });
}

// 검색박스내 설계부서 검색팝업
function searchdesignDeptTreePopup(target) {
    // 모달이 닫힐 때 초기화 작업 수행
    $("#searchdesignDeptTreePopup #searchdesignDeptTreeTitle").empty();

    var title = target.siblings('label').text();

    // 모달 제목 설정
    $("#searchdesignDeptTreeTitle").text(title);

    $("#searchdesignDeptTreePopup").bPopup({
        modalClose: false, //zIndex: 1200,
        opacity: 0.2, speed: 450, closeClass: "close", onOpen: function () {
            // #searchTreePopup에 클래스 추가
            $("#searchdesignDeptTreePopup").addClass('show');
        }, onClose: function () {
            var tree = $.fn.zTree.getZTreeObj('designDeptTree1');
            if (tree) {
                tree.expandAll(false);
                tree.cancelSelectedNode();
            }
            $("#searchdesignDeptTreePopup").removeClass('show');
        }
    });
}

// 검색박스내 요청부서 검색팝업
function searchReqDeptTreePopup(target) {

    $("#searchReqDeptTreePopup").bPopup({
        modalClose: false, opacity: 0.2, speed: 450, closeClass: "close", onOpen: function () {
            // #searchTreePopup에 클래스 추가
            $("#searchReqDeptTreePopup").addClass('show');
        }, onClose: function () {
            var tree = $.fn.zTree.getZTreeObj('reqDeptTree1');
            if (tree) {
                tree.expandAll(false);
                tree.cancelSelectedNode();
            }
            $("#searchReqDeptTreePopup").removeClass('show');
        }
    });
}

// 검색박스내 운전부서 검색팝업
function searchopDeptTreePopup(target) {
    $("#searchopDeptTreePopup").bPopup({
        modalClose: false, //zIndex: 1200,
        opacity: 0.2, speed: 450, closeClass: "close", onOpen: function () {
            // #searchTreePopup에 클래스 추가
            $("#searchopDeptTreePopup").addClass('show');
        }, onClose: function () {
            var tree = $.fn.zTree.getZTreeObj('opDeptTree1');
            if (tree) {
                tree.expandAll(false);
                tree.cancelSelectedNode();
            }
            $("#searchopDeptTreePopup").removeClass('show');
        }
    });
}

// 검색박스내 정비부서 검색팝업
function searchmainDeptTreePopup(target) {
    // 모달이 닫힐 때 초기화 작업 수행
    $("#searchmainDeptTreePopup #searchmainDeptTreeTitle").empty();

    var title = target.siblings('label').text();

    // 모달 제목 설정
    $("#searchmainDeptTreeTitle").text(title);

    $("#searchmainDeptTreePopup").bPopup({
        modalClose: false, //zIndex: 1200,
        opacity: 0.2, speed: 450, closeClass: "close", onOpen: function () {
            // #searchTreePopup에 클래스 추가
            $("#searchmainDeptTreePopup").addClass('show');
        }, onClose: function () {
            // 모달이 닫힐 때 초기화 작업 수행
            var tree = $.fn.zTree.getZTreeObj('mainDeptTree1');
            if (tree) {
                tree.expandAll(false);
                tree.cancelSelectedNode();
            }
            $("#searchmainDeptTreePopup").removeClass('show');
        }
    });
}

// 검색박스내 사용자검색 팝업
function searchItemPopup(target) {
    // 모달이 닫힐 때 초기화 작업 수행
    $("#searchItemPopup #searchItemTitle").empty();
    var title = target.siblings('label').text();

    if (title == "요청자 검색") {
        $("#chkTitleTree").val("1");
    } else if (title == "감독자 검색") {
        $("#chkTitleTree").val("2");
    } else if (title == "점검자 검색") {
        $("#chkTitleTree").val("3");
    } else if (title == "발행자 검색") {
        $("#chkTitleTree").val("4");
    } else if (title == "회수자 검색") {
        $("#chkTitleTree").val("5");
    } else if (title == "설계자 검색") {
        $("#chkTitleTree").val("6");
    }

    // 모달 제목 설정
    $("#searchItemTitle").text(title);
    $("#searchItemPopup").bPopup({
        modalClose: false, opacity: 0.2, speed: 0, closeClass: "close", onOpen: function () {
            // #searchItemPopup에 클래스 추가
            $("#searchItemPopup").addClass('show');

        }, onClose: function () {
            // 모달이 닫힐 때 초기화 작업 수행
            $("#userDetailList").html('');
            $("#searchItemPopup").removeClass('show');
            var tree = $.fn.zTree.getZTreeObj('divisionTree2');
            if (tree) {
                tree.cancelSelectedNode();
                tree.expandAll(false);
            }
            $('#id_code1').prop('checked', false);
        }
    });
}

function userDetailList(id) {
    var chkVal = "";
    var checkbox = document.getElementById('id_code1');
    if (checkbox.checked) {
        chkVal = "N"
    } else {
        chkVal = "Y"
    }
    var deptNo = id;
    $("#loadingBar").css("display", "");
    $.ajax({
        type: "post", url: "/common/userList.do", data: {deptNo: deptNo, isJoin: chkVal}, dataType: "html", success: function (data) {
            $("#userDetailList").html(data);
            $("#loadingBar").css("display", "none");
        }, error: function (request, status, error) {
            console.log("code:" + request.status + "\n error:" + error);
        }
    });
}

// 검색박스내 설비마스터 팝업
function searchFacilityPopup(target) {
    $("#searchFacilityPopup").bPopup({
        modalClose: false, //zIndex: 1100,
        opacity: 0.2, speed: 450, closeClass: "close", onOpen: function () {
            // #searchFacilityPopup에 클래스 추가
            $("#searchFacilityPopup").addClass('show');

        }, onClose: function () {
            $("#searchFacilityPopup").removeClass('show');
        }
    });
}

//검색박스내 점검종류 팝업
function searchResultPopup(target) {
    $("#loadingBar").css("display", "");
    //ajax detail load
    var setData = "";
    $.ajax({
        url: "/common/pmlList.do", type: "POST", dataType: "html", success: function (data) {
            if (data !== "") {
                setData = data;
            }
        }, complete: function () {
            $("#codeDetailList").html(setData);

            $('#searchResultPopup').bPopup({
                modalClose: false, position: [0, 0], opacity: 0.2, speed: 450, //zIndex: 1200,
                closeClass: "close", onOpen: function () {
                    $(this).addClass('show');
                    $("#loadingBar").css("display", "none");
                }, onClose: function () {
                    $(this).removeClass('show');
                    $('#inspectorTypeCode').val('');
                    $('#inspectorTypeDesc').val('');
                }
            });
        }, error: function (request, status, error) {
            console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
        }
    });
}

//검색박스내 점검종류 검색기능
function fnCodeSearch() {
    $("#loadingBar").css("display", "");
    $.ajax({
        type: "post", url: "/common/pmlList.do", data: $("#form_search_result2").serialize(), dataType: "html", success: function (data) {
            $("#codeDetailList").html(data);
            $("#loadingBar").css("display", "none");
        }, error: function (request, status, error) {
            console.log("code:" + request.status + "\n error:" + error);
        }
    });
}

/* 메인페이지 왼쪽 메뉴에서 도면보기 팝업 */
function fnOpenDrawing(url) {
    $('#menuList').removeClass('show');
    $("#toggle-button").attr('aria-expanded', 'false');
    $('#toggle-button img').attr('src', '/resources/images/icons/gnb-menu.svg').attr('alt', '메뉴 열기');

    var popup = window.open(url, '_viewDrawing', 'height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes');
    popup.focus();
}

/* 메인페이지 왼쪽 메뉴에서 파노라마 팝업 */
function fnOpenPano() {
    $('#menuList').removeClass('show');
    $("#toggle-button").attr('aria-expanded', 'false');
    $('#toggle-button img').attr('src', '/resources/images/icons/gnb-menu.svg').attr('alt', '메뉴 열기');

    var popup = window.open("/pcm/vi/main.do?pct_sn=84&pci_tag=Taean9_10", '_viewPano', 'height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes');
    popup.focus();
}

/* 모달 팝업창 띄우기 */
function fnOpenModal(url, title, x, y, width, height) {
    title = "Modal Window";
    x = "center";
    y = "center";
    width = "50%";
    height = "50%";

    new WinBox(title, {
        modal: true, header: WINBOX_HEADER_HEIGHT, x: x, y: y, width: width, height: height, url: url
    });
}

// closeOtherPopups
// 메인 화면에 종속된 모달 이외의 추가로 생성된 팝업 제거
function closeOtherPopups() {
    $('.modal').each(function () {
        const popupId = $(this).attr('id');

        if (popupId !== 'externalPopup' && popupId !== 'externalPopup2' && popupId !== 'cctvInstall' && popupId !== 'searchItemPopup' && popupId !== 'searchReqTreePopup' && popupId !== 'searchReqDeptTreePopup' && popupId !== 'searchFacilityPopup' && popupId !== 'searchResultPopup' && popupId !== 'searchopDeptTreePopup' && popupId !== 'searchmainDeptTreePopup' && popupId !== 'searchdesignDeptTreePopup' && popupId !== 'searchFacilityTypeTreePopup' && popupId !== 'searchFacilityLocTreePopup' && popupId !== 'searchWoTreePopup') {
            $(this).remove();
        }
    });
}

/* cctv nvl download file */
function downloadCctvView() {
    window.location.href = "/cctv/setupFilwDownload.do";

    if ($('#cctvInstall.show').length > 0) {
        $('#cctvInstall.show').find('.close').trigger('click');
    }
}

/* root의 winbox 창 최소화 */
function fnAllMinParentWinbox() {
    window.parent.parent.$(".winbox:not(.min) .wb-min").trigger('click');
}

/**
 * 로딩바 제어
 * @param flag
 */
function fnLoadingBarFlag(flag) {
    $("#loadingBar").css("display", flag);
}

$(document).ready(function () {
    // 터치디바이스 체크
    function checkTouchDevice() {
        const isTouchDevice = 'ontouchstart' in window || navigator.maxTouchPoints > 0;

        // 기존 클래스 제거 (터치 디바이스 여부 갱신)
        $('body').removeClass('touch-device');

        if (isTouchDevice) {
            //console.log("터치 디바이스입니다.");
            $('body').addClass('touch-device');
        } else {
            $('body').removeClass('touch-device');
        }
    }

    checkTouchDevice();
    window.addEventListener('resize', checkTouchDevice);
});

// 헤더 > 발전소 선택
function initPlantSelect() {
    const $plantGroup = $('.plant-group');
    const $selectBtn = $('.select-plant .icon-arrow');

    // 발전소 선택 버튼 클릭 시 (토글 방식)
    $selectBtn.on('click', function (e) {
        e.stopPropagation();
        $plantGroup.toggleClass('active');
    });

    // 발전소 목록(span) 클릭 시
    $plantGroup.on('click', 'span', function (e) {
        e.stopPropagation();
        const plantName = $(this).text().trim();
        const plantCode = $(this).attr("data-code");

        /* 이동 */
        const $form = $('<form>', {method: 'POST', action: '/index.do'})
            .append($('<input>', {type: 'hidden', name: 'eqOrgNo', value: plantCode}));

        $form.appendTo('body').submit();
    });

    // 외부 클릭 시 active 제거
    $(document).on('click', function (e) {
        if (!$plantGroup.is(e.target) && $plantGroup.has(e.target).length === 0 && !$selectBtn.is(e.target)) {
            $plantGroup.removeClass('active');
        }
    });
}

/* 3D Model/운전정보 데이터 연계 박스 start */
let operationInfoInterval = null;

function open_opDataBox(targetId, id) {
    if (operationInfoInterval != null) {
        clearInterval(operationInfoInterval);
        operationInfoInterval = null;
    }

    operationInfoInterval = setInterval(() => {
        fnOperationLoadInterval(targetId, id);
    }, 60000);

    $(targetId).addClass('active');
}

function close_opDataBox(targetId) {
    clearInterval(operationInfoInterval);
    operationInfoInterval = null;
    $(targetId).removeClass('active');
}

/* 모든 winbox 최소화 처리 */
function fnCloseAllWinbox() {
    if (!targetWinbox || !targetWinbox.g) return;

    if ($(".winbox:not(.min)").length > 0) {
        $(".winbox:not(.min) .wb-min").trigger('click');
        setRenderActive("true");
    }
}

function fnOpDataBoxToggle(targetId) {
    fnCloseAllWinbox();

    if ($(targetId).hasClass('active')) {
        $(targetId).removeClass('active');
    } else {
        $(targetId).addClass('active');
    }
}

/* 3D Model/운전정보 데이터 연계 박스 End */

// 페이지 로드 후 실행
$(document).ready(function () {
    initPlantSelect();
});

// ESC로 모달 닫히는거 방지
document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') {
        const modalOpen = document.querySelector('.modal.show');
        if (modalOpen) {
            e.preventDefault();
            e.stopPropagation();
            return false;
        }
    }
}, true);

// 메인공지팝업 - 범용으로 사용가능
function closeThisPopup(button) {
    var thisPopup = button.closest('.popup-layer');
    if (!thisPopup) return;

    if ($("#checkViewToday").is(":checked")) {
        Cookies.set('notice_view_today', 'Y', {expires: 1});
    }

    thisPopup.classList.remove('open');
}

/**
 * 헤더 토글 이벤트에 따른 windowbox top 처리
 * winbox가 maximized 상태일 경우 height를 100%로 설정
 *
 * @param target
 * @param isOpen
 * @param isFlag
 */
function fnSetWinboxTop(target, isOpen, isFlag) {
    var winboxInstance = null;
    var selector = target;
    var isForceFullLayout = isFlag === "max";
    var isSyncFullLayout = isFlag === "resize" || isFlag === "header";

    // target이 WinBox 객체인 경우 (문자열이 아닌 경우)
    if (typeof target !== 'string') {
        winboxInstance = target;
        selector = "#" + winboxInstance.id;
    }

    var base = getWinboxGroupOptions();
    var top = base.top;
    var left = base.left;
    var right = base.right;
    var bottom = base.bottom;
    var width = window.top.innerWidth - left - right;

    if (!isOpen) {
        top = 0;
    }

    function applyWinboxLayout(element, instance) {
        var $element = $(element);
        var isMaximized = instance && (instance.max || $element.hasClass("max"));
        var isFacility = isFlag === "facilityMenu" || $element.hasClass("facility");
        var isFullLayout = isForceFullLayout || (isSyncFullLayout && isMaximized);
        var layoutBottom = (isFullLayout || isFacility) ? WINBOX_HEADER_HEIGHT + (right * 2) : bottom;
        var height = isOpen ? window.top.innerHeight - top - layoutBottom : window.top.innerHeight;

        var layoutCss = {
            "left": left + "px",
            "top": top + "px"
        };

        if (isFullLayout || isFacility) {
            layoutCss.height = height + "px";
        }

        if (isFullLayout) {
            layoutCss.width = width + "px";
        }

        $element.css(layoutCss);

        if (instance) {
            if(instance.resize && isFullLayout) {
                instance.resize(width, height, true);
            }

            if (instance.move) {
                instance.move(left, top, isFullLayout);
            }
        }
    }

    if (winboxInstance) {
        applyWinboxLayout(selector, winboxInstance);
        return;
    }

    $(selector).each(function () {
        applyWinboxLayout(this, this.winbox);
    });
}

/*
* android
* */

/* unity 보기 */
function fnAndroidShowUnity() {
    if (window.Android) {
        window.Android.showUnityActivity(eqOrgNo, hoki);
    }
}

/* 외부라이브러리 오버라이드용 스타일 헤더에 추가로드시 사용 */
function loadCss(url) {
    if (!document.querySelector(`link[href="${url}"]`)) {
        const link = document.createElement("link");
        link.rel = "stylesheet";
        link.href = url;
        document.head.appendChild(link);
    }
}

/* 테이블 내에 해당클래스(auto-size) 적용시 value 값에 따라 자동 너비 조정 */
document.querySelectorAll(".form-control.auto-size").forEach(input => {
    resizeInput(input);

    input.addEventListener("input", () => {
        resizeInput(input);
    });
});

function resizeInput(input) {
    input.size = Math.max(input.value.length + 1, 1);
}

/* view test model */
function fnViewTestModel() {
    var testModelTarget = $("._TEST_MODEL_JS");

    if (testModelTarget.hasClass("d-none")) {
        testModelTarget.removeClass("d-none");
    } else {
        testModelTarget.addClass("d-none");
    }
}

function fnViewAdminPage() {
    window.open("/admin/index.do", '_viewAdmin', 'height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes');
}

/* app : 서비스 바로가기 스크립트 */
function fnAppMainWinboxOpen(url, t) {
    /*$('.wb-title').each(function () {
        if ("서비스 바로가기".includes($(this).text())) {
            $(this).closest('.wb-header').find('.wb-close').trigger('click');
        }
    });*/

    // all close
    fnCloseAllWinbox();

    fnOpenPopup(url, t);
}
