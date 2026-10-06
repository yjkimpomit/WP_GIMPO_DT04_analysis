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
    fnOpenPopupStandard("/cctv/view.do?ici_cctvid=" + cctvId, "CCTV");
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