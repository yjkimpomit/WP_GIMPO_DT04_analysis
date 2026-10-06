/** ************************
 * webUtils.js
 * *************************
 */

'use strict';

/**
 * Check Url
 * @param url
 * @returns {*|boolean}
 */
function isValidRedirectCCTV(url) {
    const allowedProtocol = "rtsp://";

    try {
        return url.includes(allowedProtocol);
    } catch (e) {
        //console.log("# ERROR # " + e);
        return false;
    }
}

/**
 * Check VLC url 스킴 체크
 *
 * @param callback
 */
function isAppInstalled(callback) {
    const iframeAppInstall = document.createElement("iframe");
    iframeAppInstall.id = "iframeAppInstall";
    iframeAppInstall.style.display = "none";
    iframeAppInstall.src = "rtsp://";

    document.body.appendChild(iframeAppInstall);

    const timeoutIframeAppInstall = setTimeout(function () {
        document.body.removeChild(iframeAppInstall);
        callback(false); // 앱이 없음
    }, 1500);

    window.addEventListener("blur", function () {
        clearTimeout(timeoutIframeAppInstall);
        document.body.removeChild(iframeAppInstall);
        callback(true); // 앱이 실행되어 포커스가 나감
    });
}

/**
 * Run VLC cctv
 *
 * @param rtspUrl
 */
function showVlcRtsp(rtspUrl) {
    window.location.href = rtspUrl;
}

/**
 * VLC - CCTV 실행
 *
 * @param cctvId
 */
function fnViewVlcRtsp(cctvId) {
    fnOpenPopupStandard("/cctv/view.do?ici_cctvid=" + cctvId, "CCTV");
}

/**
 * 3D Model TO CCTV 실행
 *
 * @param cctvId
 */
function receiveCctvView(cctvId) {
    //console.log("## receiveCctvView ## " + cctvId);
    fnOpenPopupStandard("/cctv/view.do?ici_cctvid=" + cctvId, "CCTV");

    /*$.ajax({
        url: "/cctv/getCctvInfo.do",
        type: "POST",
        data: {ici_cctvid: cctvidx},
        dataType: "json",
        success: function (data) {
            console.table(data);
            var result = data.result;

            if (result === 1) {
                var rtspUrl = data.cctvUrl;
                fnViewVlcRtsp(rtspUrl);
            }
        },
        error: function (request, status, error) {
            console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
        }
    });*/
}

/**
 * CCTV 페이지에서 사용
 * 3d Model로 이동
 * Call function - /main/unityUtil.js
 *
 * @param cctvId
 */
function fnCctvtoUnity(modelTarget, cctvId) {
    window.parent.$(".winbox:not(.min) .wb-min").trigger('click');
    window.parent.cctvToUnity(modelTarget, cctvId);
}

/* 데이터 제어 */
/**
 * 모델에서 데이터 정보 팝업창으로 띄우기
 * @param tagId 고유코드
 * @param tagType 작업모델타입(설비:model, cctv, qrcode, 소화설비:fireequip, 전기차단기판넬:elecpanel)
 * @param modelTarget 모델건물
 * @param position 모델좌표
 */
function fnModelContentsPopup(tagId, tagType, modelTarget, position) {
    //console.log("## fnModelContentsPopup ## tagId: " + tagId + " ## tagType: " + tagType + " ## modelTarget: " + modelTarget + " ## position:" + position);
    fnMappingLocPop(tagId, tagType, modelTarget, position);
}
