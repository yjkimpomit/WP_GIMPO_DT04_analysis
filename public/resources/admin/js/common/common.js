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

// Shared WinBox group margins to ensure minimized windows stack together
var WINBOX_GROUP = {
    pc: {top: 32, left: 0, right: 0, bottom: 0, border: 0}
    , tablet: {top: 32, left: 0, right: 0, bottom: 0, border: 0}
    , mobile: {top: 32, left: 0, right: 0, bottom: 0, border: 0}
};

/* pc 모드에서 width 체크 */
function fnGetDeviceWidth() {
    var width = $(window).width();

    if (window.parent || window.parent.parent) {
        width = $(window.parent).width();

        if (width === undefined) {
            width = $(window.parent.parent).width();
        }
    }

    if (width <= 767) {
        return WINBOX_GROUP.mobile;
    } else if (width >= 768 && width <= 1537) {
        return WINBOX_GROUP.tablet;
    } else {
        return WINBOX_GROUP.pc;
    }
}

/* 디바이스 체크 */
function getDeviceType() {
    if (checkDevice === "mobile") {
        return WINBOX_GROUP.mobile;
    } else if (checkDevice === "tablet") {
        return WINBOX_GROUP.tablet;
    } else {
        return fnGetDeviceWidth();
    }
}

function getWinboxGroupOptions() {
    return getDeviceType();
}

window.addEventListener("resize", () => {
    // 화면 크기 변경에 따른 처리
    getWinboxGroupOptions();
});

/**
 * 메뉴 팝업창 열기
 * @param url
 * @param target
 */
function fnOpenPopup(url, target) {
    var title = target.data("title");

    // all close
    $('.wb-close').trigger('click');

    var base = getWinboxGroupOptions();
    winboxTop = base.top;
    winboxHeight = base.height;

    targetWinbox = new WinBox(title, Object.assign({}, base, {
        groupId: "winMain-group",
        class: ["app-winbox", "app-winbox--detail"],
        url: url,
        onCreate: function (options) {
            options.autoResize = true;
        },
        onmaximize: function () {
            if (this.min) return;
        },
        onclose: function (force) {
        }
    }));

    targetWinbox.maximize();

    /* 브라우저를 조절할때 처리 */
    window.addEventListener("resize", () => {
        if (!targetWinbox || !targetWinbox.g) return;
        if (!targetWinbox.min) {
            targetWinbox.restore();
            targetWinbox.maximize();
        }
    });
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

    var base = getWinboxGroupOptions();
    var topWindow = window.top;

    targetWinbox = new topWindow.WinBox(title, Object.assign({}, base, {
        groupId: "winMain-group",
        root: topWindow.document.body,
        width: Math.min(1020, topWindow.innerWidth - 20) + "px",
        height: Math.min(720, topWindow.innerHeight - 20) + "px",
        class: ["app-winbox"],
        url: url,
        onCreate: function (options) {
            options.autoResize = true;
        },
        onmaximize: function () {
            if (this.min) return;
        },
        onclose: function (force) {
            // Set 3d model flag
            var iframe = $("#_MULTI_UNITY_VIEW iframe")[0];
            if (iframe && iframe.contentWindow) {
                iframe.contentWindow.fnCloseUnity();
            }
        }
    }));

    /* 브라우저를 조절할때 처리 */
    window.addEventListener("resize", () => {
        if (!targetWinbox || !targetWinbox.g) return;
        if (!targetWinbox.min) {
            targetWinbox.restore();
            targetWinbox.maximize();
        }
    });
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
    $('.unity-guide').fadeOut(500);
}

// 유니티에서 하단 버튼클릭시 가이드팝업 나타남
function openControlGuide() {
    $('.unity-guide').fadeIn(500);
}

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

/* 모달 팝업창 띄우기 */
function fnOpenModal(url, title, x, y, width, height) {
    title = "Modal Window";
    x = "center";
    y = "center";
    width = "50%";
    height = "50%";

    new WinBox(title, {
        modal: true, x: x, y: y, width: width, height: height, url: url
    });
}

/* root의 winbox 창 최소화 */
function fnAllMinParentWinbox() {
    window.parent.parent.$(".winbox:not(.min) .wb-min").trigger('click');
}

/* 멀티뷰 : 3D 이동 */
function fnFacilityTo3D(modelType, equipNo) {
    fnAllMinParentWinbox();
    window.parent.parent.modelLoadToUnity(modelType, equipNo);
}

/* 멀티뷰 : 파노라마 이동 */
function fnFacilityToPanorama(e, iegNo) {
    var url = "/pcm/vi/panoview.do?pct_sn=84&tagno=" + iegNo;
    fnOpenPopupStandard(url, "파노라마");
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

/* 모든 winbox 최소화 처리 */
function fnCloseAllWinbox() {
    if (!targetWinbox || !targetWinbox.g) return;

    if ($(".winbox:not(.min)").length > 0) {
        $(".winbox:not(.min) .wb-min").trigger('click');
    }
}

// MultiView 토글: 클릭한 cell 내부의 doc-box만 열기/닫기
function toggleDocuList(e) {
    e.stopPropagation();

    const cell = e.currentTarget.closest('.cell');
    const box = cell.querySelector('.doc-box');

    box.classList.toggle('active');
}

// 닫기 버튼: 해당 doc-box만 닫기
function closeDocuList(e) {
    e.stopPropagation();

    const box = e.currentTarget.closest('.doc-box');
    box.classList.remove('active');
}

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

/**
 * 메세지 팝업
 */
var title = "";
var content = "";

function fnAlert() {
    $.alert({
        title: title,
        content: content,
        type: 'red',
        buttons: {
            '확인': {
                btnClass: 'btn-red',
                action: function () {
                }
            }
        }
    });
}

/**
 * 메세지 팝업 후 현재 창 닫기
 */
function fnAlertClose() {
    $.alert({
        title: title,
        content: content,
        type: 'red',
        buttons: {
            '확인': {
                btnClass: 'btn-red',
                action: function () {
                    window.parent.$(".winbox.app-winbox.app-winbox--detail.focus").find(".wb-close").trigger("click");
                }
            }
        }
    });
}