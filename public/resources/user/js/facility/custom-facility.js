/**
* *******************************************************
* 설비정보의 공통 메소드 *
* *******************************************************
*/

'use strict';

function fnFacilityMultiviewPop(e, iegNo) {
    fnOpenPopupStandard("/multiview/index.do?iegNo=" + iegNo, "설비상세정보");
}
/**
 * 설비정보 > 설비상세 정보 뷰
 *
 * @param e
 * @param iegNo
 */
function fnFacilityDetailInfo(e, iegNo) {
    $('._TR_INFO').removeClass('active');
    $(e).closest('tr._TR_INFO').addClass('active');

    $.ajax({
        type: "post"
        , url: "/facility/infoDetail.do"
        , data: {iegNo: iegNo}
        , dataType: "html"
        , beforeSend: function () {
            $("#loadingBar").css("display", "");
        }
        , success: function (data) {
            $("#_FACILITY_DETAIL_VIEW_INFO").html(data);
        }
        , error: function (request, status, error) {
            console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
        }
        , complete: function () {
            $("#loadingBar").css("display", "none");
        }
    });
}

/**
 * 설비정보 > 정비이력 상세 뷰
 *
 * @param e
 * @param woNo
 */
function fnFacilityDetailMaintenance(e, woNo) {
    $('._TR_INFO_MH').removeClass('active');
    $(e).addClass('active');

    $.ajax({
        type: "post"
        , url: "/facility/maintenanceHistoryDetail.do"
        , data: {woNo: woNo}
        , dataType: "html"
        , beforeSend: function () {
            $("#loadingBar").css("display", "");
        }
        , success: function (data) {
            $("#_FACILITY_DETAIL_VIEW_MH").html(data);
        }
        , error: function (request, status, error) {
            console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
        }
        , complete: function () {
            $("#loadingBar").css("display", "none");
        }
    });
}

/**
 * 설비정보 > 자재정보 상세 뷰
 *
 * @param e
 * @param partNo
 * @param equipNo
 */
function fnFacilityDetailMaterial(e, partNo, equipNo) {
    $('._TR_INFO_MI').removeClass('active');
    $(e).addClass('active');

    $.ajax({
        type: "post"
        , url: "/facility/materialInfoDetail.do"
        , data: {partNo: partNo, equipNo: equipNo}
        , dataType: "html"
        , beforeSend: function () {
            $("#loadingBar").css("display", "");
        }
        , success: function (data) {
            $("#_FACILITY_DETAIL_VIEW_MI").html(data);
        }
        , error: function (request, status, error) {
            console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
        }
        , complete: function () {
            $("#loadingBar").css("display", "none");
        }
    });
}

/**
 * 설비정보 > 포함설비의 설비정보 팝업 뷰
 *
 * @param e
 * @param iegNo
 */
function fnFacilityIncludePopup(e, iegNo) {
    $('._TR_INFO_INCLUDE').removeClass('active');
    $(e).addClass('active');

    var url = "/facility/mainInclude.do?iegNo=" + iegNo;

    var box = new WinBox("설비정보", {
        url: url,
        width: Math.min(1400, window.innerWidth - 20) + "px",
        height: Math.min(720, window.innerHeight - 20) + "px",
        x: "center",
        y: "center",
        modal: true,
        oncreate: fnEnableModalInteraction,
        focus: true,
        class: ["app-winbox", "app-winbox--detail"],
        position: "center",
        onresize: function (w, y) {
            if (this.min) return;
            this.move("center", "center");
        },
        onclose: function () {
        }
    });
}
