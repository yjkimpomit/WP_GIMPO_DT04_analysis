<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/header.do"/>

<body class="sub">
<!-- 로딩박스 -->
<div class="loading-box" id="loadingBar" style="display: none;">
    <div class="loader"></div>
</div>

<%--  timepicker --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/timepicker/jquery.timepicker.min.css">
<script src="${pageContext.request.contextPath}/resources/js/timepicker/jquery.timepicker.min.js"></script>

<%-- 일일안전현황 > 일일안전작업현황 메인 팝업 --%>
<main class="winbox-layout tabs tabs--scrollable" data-tabs>
    <!-- tab-menu -->
    <ul class="nav nav-tabs" id="safetyTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="tab01_safety" data-bs-toggle="tab" data-bs-target="#tab01-pane-safety" type="button" role="tab" aria-controls="tab01-pane-safety" aria-selected="false" data-page="/workReport.do">일일안전작업현황</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="tab02_safety" data-bs-toggle="tab" data-bs-target="#tab02-pane-safety" type="button" role="tab" aria-controls="tab02-pane-safety" aria-selected="false" data-page="/routineWorkOrder.do">경상오더</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="tab03_safety" data-bs-toggle="tab" data-bs-target="#tab03-pane-safety" type="button" role="tab" aria-controls="tab03-pane-safety" aria-selected="false" data-page="/workOrder.do">공사오더</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="tab04_safety" data-bs-toggle="tab" data-bs-target="#tab04-pane-safety" type="button" role="tab" aria-controls="tab04-pane-safety" aria-selected="false" data-page="/maintenanceOrder.do">공사오더(OH)</button>
        </li>
    </ul>

    <!-- tab content -->
    <div class="tab-content" id="safetyTabContent">
        <div class="tab-pane fade _TAB_CONTENT" id="tab01-pane-safety" role="tabpanel" aria-labelledby="tab01_safety" tabindex="0">
            <%--<c:import url="/dailySafety/workReport.do"/>--%>
        </div>
        <div class="tab-pane fade _TAB_CONTENT" id="tab02-pane-safety" role="tabpanel" aria-labelledby="tab02_safety" tabindex="0">
            <%-- /routineWorkOrder.jsp --%>
        </div>
        <div class="tab-pane fade _TAB_CONTENT" id="tab03-pane-safety" role="tabpanel" aria-labelledby="tab03_safety" tabindex="0">
            <%-- /workOrder.jsp --%>
        </div>
        <div class="tab-pane fade _TAB_CONTENT" id="tab04-pane-safety" role="tabpanel" aria-labelledby="tab04_safety" tabindex="0">
            <%-- /maintenanceOrder.jsp --%>
        </div>
    </div>
</main>

<script>
    $(document).ready(function () {
        // 탭 인덱스 (기본 0)
        var rawIdx = '${empty workReportVO.tabIdx ? 0 : workReportVO.tabIdx}';
        var tabIdx = parseInt(rawIdx);
        var $tabs = $('._TAB_PAGE');

        // view content
        function fnLoadTabContent($btn) {
            // 대상 탭 버튼/패널
            var targetContentId = $btn.attr('data-bs-target');
            var targetUrl = $btn.attr('data-page');
            if (!targetContentId || !targetUrl) return;

            var url = '/dailySafety' + targetUrl;
            var data = [];

            // 기존 팝업/콘텐츠 정리
            $('._TAB_CONTENT').empty();
            closeOtherPopups();

            $.ajax({
                type: 'post',
                url: url,
                data: data,
                dataType: 'html',
                beforeSend: function () {
                    $('#loadingBar').css('display', '');
                },
                success: function (data) {
                    $(targetContentId).html(data);
                    // 내부에서 로딩 닫음
                },
                error: function (request, status, error) {
                    $('#loadingBar').css('display', 'none');
                    console.log('code:' + request.status + '\n message:' + request.responseText + '\n error:' + error);
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

<c:import url="/common/modalPopup.do"/>

</body>
<c:import url="/footer.do"/>