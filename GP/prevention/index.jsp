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
            <button class="nav-link _TAB_PAGE" id="costFailureTrendsTab" data-bs-toggle="tab" data-bs-target="#costFailureTrendsTabPane" type="button" role="tab" aria-controls="costFailureTrendsTabPane" aria-selected="false" data-page="/prevention/costFailureTrends.do">정비비용 고장경향 분석</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="reportTab" data-bs-toggle="tab" data-bs-target="#reportTabPane" type="button" role="tab" aria-controls="reportTabPane" aria-selected="false" data-page="/prevention/report.do">점검 보고서</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="resultTab" data-bs-toggle="tab" data-bs-target="#resultTabPane" type="button" role="tab" aria-controls="resultTabPane" aria-selected="false" data-page="/prevention/result.do">점검 결과</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="resultChartTab" data-bs-toggle="tab" data-bs-target="#resultChartTabPane" type="button" role="tab" aria-controls="resultChartTabPane" aria-selected="false" data-page="/prevention/resultChart.do">점검 결과(chart)</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="abnormalResultTab" data-bs-toggle="tab" data-bs-target="#abnormalResultTabPane" type="button" role="tab" aria-controls="abnormalResultTabPane" aria-selected="false" data-page="/prevention/abnormalResults.do">이상 점검 결과</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="unispectionTab" data-bs-toggle="tab" data-bs-target="#unispectionTabPane" type="button" role="tab" aria-controls="unispectionTabPane" aria-selected="false" data-page="/prevention/unispection.do">미점검 일정</button>
        </li>
    </ul>

    <!-- tab content -->
    <div class="tab-content" id="tmTabContent">
        <div class="tab-pane fade _TAB_CONTENT" id="costFailureTrendsTabPane" role="tabpanel" aria-labelledby="costFailureTrendsTab" tabindex="0"></div>
        <div class="tab-pane fade _TAB_CONTENT" id="reportTabPane" role="tabpanel" aria-labelledby="reportTab" tabindex="0"></div>
        <div class="tab-pane fade _TAB_CONTENT" id="resultTabPane" role="tabpanel" aria-labelledby="resultTab" tabindex="0"></div>
        <div class="tab-pane fade _TAB_CONTENT" id="resultChartTabPane" role="tabpanel" aria-labelledby="resultChartTab" tabindex="0"></div>
        <div class="tab-pane fade _TAB_CONTENT" id="abnormalResultTabPane" role="tabpanel" aria-labelledby="abnormalResultTab" tabindex="0"></div>
        <div class="tab-pane fade _TAB_CONTENT" id="unispectionTabPane" role="tabpanel" aria-labelledby="unispectionTab" tabindex="0"></div>
    </div>
</main>

<%-- modal popup --%>
<c:import url="/common/modalPopup.do"/>

<script>
    $(document).ready(function () {
        // 탭 인덱스 (기본 0)
        var rawIdx = '${empty preventionVO.tabIdx ? 0 : preventionVO.tabIdx}';
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