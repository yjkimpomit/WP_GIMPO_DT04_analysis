<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/header.do"/>

<body class="sub">
<%-- <!-- 로딩박스 --> --%>
<div class="loading-box" id="loadingBar" style="display: none;">
    <div class="loader"></div>
</div>

<main class="winbox-layout tabs tabs--scrollable" data-tabs>

    <!-- tab-menu -->
    <ul class="nav nav-tabs" id="tmTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="issusRedTag" data-bs-toggle="tab" data-bs-target="#issusRedTagPane" type="button" role="tab" aria-controls="issusRedTagPane" aria-selected="false" data-page="/redTag/issusList.do">Red Tag 발행</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="manageRedTag" data-bs-toggle="tab" data-bs-target="#manageRedTagPane" type="button" role="tab" aria-controls="manageRedTagPane" aria-selected="false" data-page="/redTag/manageStats.do">Red Tag 관리대장</button>
        </li>
    </ul>

    <!-- tab content -->
    <div class="tab-content" id="tmTabContent">
        <div class="tab-pane fade _TAB_CONTENT" id="issusRedTagPane" role="tabpanel" aria-labelledby="issusRedTag" tabindex="0"></div>
        <div class="tab-pane fade _TAB_CONTENT" id="manageRedTagPane" role="tabpanel" aria-labelledby="manageRedTag" tabindex="0"></div>
    </div>
</main>

<%-- modal popup --%>
<c:import url="/common/modalPopup.do"/>

<script>
    $(document).ready(function () {
        // 탭 인덱스 (기본 0)
        var rawIdx = '${empty redTagVO.tabIdx ? 0 : redTagVO.tabIdx}';
        var tabIdx = parseInt(rawIdx);
        var $tabs = $('._TAB_PAGE');

        // view content
        function fnLoadTabContent($btn) {
            // 대상 탭 버튼/패널
            var targetContentId = $btn.attr('data-bs-target');
            var targetUrl = $btn.attr('data-page');
            if (!targetContentId || !targetUrl) return;

            // 기존 팝업/콘텐츠 정리
            $('._TAB_CONTENT').empty();
            closeOtherPopups();

            $.ajax({
                url: targetUrl,
                type: "POST",
                dataType: "html",
                beforeSend: function () {
                    $("#loadingBar").css("display", "");
                },
                success: function (data) {
                    $(targetContentId).html(data);

                    if (targetContentId === "#issusRedTagPane") {
                        fnIssusRequestSearch();
                    } else {
                        $.ajax({
                            url: "/redTag/manageStats.do",
                            type: "POST",
                            dataType: "html",
                            success: function (data) {
                                if (data !== "") {
                                    $("#manageRedTagPane").html(data);
                                    setDate();
                                    fnManageRequestSearch();
                                } else {
                                    $("#manageRedTagPane").empty();
                                }
                            },
                            error: function (request, status, error) {
                                console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
                            }
                        });
                    }
                },
                error: function (request, status, error) {
                    console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
                },
                complete: function () {
                    $("#loadingBar").css("display", "none");
                }
            });
        }

        // 탭 클릭 시: Bootstrap 탭 전환 + Ajax 로딩
        $('._TAB_PAGE').on('click', function (e) {
            e.preventDefault();

            // Bootstrap 탭 활성화 보장 : common.js에서 공통으로 사용
            fnSetCommonBootstrapTab($(this));

            // 데이터 로딩
            fnLoadTabContent($(this));
        });

        // 페이지 로딩시 tabIndex 실행
        var $initial = $tabs.eq(tabIdx);
        if ($initial.length) {
            // BS 탭 전환 후 컨텐츠 로드
            if (window.bootstrap && typeof window.bootstrap.Tab === 'function') {
                new bootstrap.Tab($initial[0]).show();
            }
            $initial.trigger('click');
        }
    });
</script>

</body>
<c:import url="/footer.do"/>