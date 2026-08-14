<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/header.do"/>

<body>
<%-- <!-- 로딩박스 --> --%>
<div class="loading-box" id="loadingBar" style="display: none;">
    <div class="loader"></div>
</div>

<main class="winbox-layout tabs tabs--scrollable" data-tabs>
    <!-- tab-menu -->
    <ul class="nav nav-tabs" id="tmTab" role="tablist" aria-label="TM 현황 메뉴">
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="workReqTab" data-bs-toggle="tab" data-bs-target="#workReqPane" type="button" role="tab" aria-controls="workReqPane" aria-selected="false" data-page="/tmStatus/workRequest.do">작업요청확정</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="multTmTab" data-bs-toggle="tab" data-bs-target="#multTmTabPane" type="button" role="tab" aria-controls="multTmTabPane" aria-selected="false" data-page="/tmStatus/multipleTMStats.do">다발 TM현황</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="outstandingTmTab" data-bs-toggle="tab" data-bs-target="#outstandingTmTabPane" type="button" role="tab" aria-controls="outstandingTmTabPane" aria-selected="false" data-page="/tmStatus/outstandingTM.do">미결 TM현황</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="jobReqCntTab" data-bs-toggle="tab" data-bs-target="#jobReqCntTabPane" type="button" role="tab" aria-controls="jobReqCntTabPane" aria-selected="false" data-page="/tmStatus/jobReqCnt.do">작업요청 건수</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link _TAB_PAGE" id="jobReqProcStatTab" data-bs-toggle="tab" data-bs-target="#jobReqProcStatTabPane" type="button" role="tab" aria-controls="jobReqProcStatTabPane" aria-selected="false" data-page="/tmStatus/jobReqProcStat.do">작업요청 처리현황</button>
        </li>
    </ul>
    
    <!-- tab content -->
    <div class="tab-content" id="tmTabContent">
        <div class="tab-pane fade _TAB_CONTENT" id="workReqPane" role="tabpanel" aria-labelledby="workReqTab" tabindex="0"></div>
        <div class="tab-pane fade _TAB_CONTENT" id="multTmTabPane" role="tabpanel" aria-labelledby="multTmTab" tabindex="0"></div>
        <div class="tab-pane fade _TAB_CONTENT" id="outstandingTmTabPane" role="tabpanel" aria-labelledby="outstandingTmTab" tabindex="0"></div>
        <div class="tab-pane fade _TAB_CONTENT" id="jobReqCntTabPane" role="tabpanel" aria-labelledby="jobReqCntTab" tabindex="0"></div>
        <div class="tab-pane fade _TAB_CONTENT" id="jobReqProcStatTabPane" role="tabpanel" aria-labelledby="jobReqProcStatTab" tabindex="0"></div>
    </div>
</main>

<%-- modal popup --%>
<c:import url="/common/modalPopup.do"/>

<script>
	$(document).ready(function () {
		// 탭 인덱스 (기본 0)
		var rawIdx = '${empty tmStatusWorkRequestVO.tabIdx ? 0 : tmStatusWorkRequestVO.tabIdx}';
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
					// 내부에서 로딩 닫음
				},
				error: function (request, status, error) {
					$("#loadingBar").css("display", "none");
					console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
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