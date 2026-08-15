<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- 예방점검현황 > 점검보고서 -->
<main class="winbox-layout page-content">
	<div class="page-content__placeholder">
		<div class="splitview">
			<aside class="splitview__pane splitview__pane--sidebar" aria-label="정보 검색">

				<!-- 검색영역 -->
				<form class="filter-panel" id="form_search_report" method="post" autocomplete="off">

					<div class="filter-panel__header">
						<span class="filter-panel__title">검색</span>
						<button class="filter-panel__toggle" 
								type="button"
								aria-label="정보 검색 접기" 
								aria-expanded="true" 
								aria-controls="filter-panel-fields"></button>
					</div>

					<!-- filter-panel__fields 안에서 form-field 단위로 반복 -->
					<div class="filter-panel__fields" id="filter-panel-fields">
						<input type="hidden" id="ColList" name="ColList" value=""/>
						
						<div class="form-field">
							<label class="form-label" for="issuerOption">요청자</label>
							<input class="form-control search-icon" id="issuerOption" name="requestBy" onclick="searchItemPopup($(this));">
							<input class="form-control" type="text" value="" id="issuerInput" disabled="" aria-label="선택된 요청자명">
						</div>

						<fieldset class="form-field">
							<legend class="form-label">요청기간</legend>

							<div class="form-control-group">
								<label>
									<span class="visually-hidden">요청 시작일</span>
									<input type="date" class="form-control" id="reqPeriodStart" name="searchPeriodStart">
								</label>

								<label>
									<span class="visually-hidden">요청 종료일</span>
									<input type="date" class="form-control" id="reqPeriodEnd" name="searchPeriodEnd">
								</label>
							</div>
						</fieldset>
						
						<div class="form-field">
							<label class="form-label" for="reqNo">요청번호</label>
							<input class="form-control" type="text" id="reqNo" name="authoNo" placeholder="요청 번호 입력">
						</div>
						
						<div class="form-field">
							<label class="form-label" for="supvorOption">감독자</label>
							<input class="form-control search-icon" id="supvorOption" name="authoBy" onclick="searchItemPopup($(this));">
							<input class="form-control" type="text" value="" id="supvorInput" disabled="" aria-label="선택된 감독자명">
						</div>
						
						<div class="form-field">
							<label class="form-label" for="generalOpinion">종합의견</label>
							<input class="form-control" type="text" id="generalOpinion" name="checkDesc" placeholder="종합의견 입력">
						</div>
						
						<div class="form-field">
							<label class="form-label" for="searchTitle">제목</label>
							<input class="form-control" type="text" id="searchTitle" name="checkTitle" placeholder="제목 입력">
						</div>
					</div>
						
					<!-- 검색버튼 -->
					<div class="filter-panel__actions">
						<button type="button" class="button button--primary"onclick="fnReportSearch()">검색</button>
					</div>
				</form>
			
			</aside>
			<section class="splitview__pane splitview__pane--content result-panel" aria-label="검색 결과">
				<h1 class="page-content__heading">점검 보고서</h1>
				
				<%-- data-grid : 결과 리스트 뷰 --%>
				<div class="result-panel__body" id="_VIEW_REPORT_LIST">
					<%-- 조회 리스트 부분 : /detail/report_list.jsp --%>
				</div>

				<%-- data-grid : 상세내용 리스트 뷰 --%>
				<div class="result-panel__body" id="_VIEW_REPORT_DETAIL_LIST">
					<%-- 리스트 : /detail/reportDetail_list.jsp --%>
				</div>

				<%-- data-grid : 상세내용 리스트 뷰 --%>
				<div class="result-panel__body" id="_VIEW_REPORT_DETAIL_RESULT_LIST">
					<%-- 리스트 : /detail/reportDetailResult_list.jsp --%>
				</div>

			</section>
		</div>
	</div>
</main>



<script>
	function setDate() {
		//날짜 현재날짜 기준 한 달 전 세팅
		var today = new Date();
		var yyyy = today.getFullYear();
		var mm = ("0" + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
		var dd = ("0" + today.getDate()).slice(-2);
		var currentDate = yyyy + "-" + mm + "-" + dd;
		$('#reqPeriodEnd').val(currentDate); // 첫 번째 input에 오늘 날짜 설정

		// 두 번째 input 태그 (한 달 전 날짜로 설정)
		today.setMonth(today.getMonth() - 1); // 현재 날짜 기준 한 달 전으로 설정
		var lastMonthDate = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + ("0" + today.getDate()).slice(-2);
		$('#reqPeriodStart').val(lastMonthDate); // 두 번째 input에 한 달 전 날짜 설정
	}

	<%-- 검색 결과 리스트 --%>

	function fnReportSearch() {
		var stval = "";
		var endval = "";

		//조회 시작일
		stval = document.getElementById("reqPeriodStart").value;
		//조회 종료일
		endval = document.getElementById("reqPeriodEnd").value;

		if (stval != "" && endval === "") {
			alert("조회 종료일을 선택해주세요");
			return false;
		} else if (stval === "" && endval != "") {
			alert("조회 시작일을 선택해주세요");
			return false;
		} else if (stval > endval) {
			alert("조회 종료일을 시작일 이전으로 설정할 수 없습니다.\n조회 종료일을 다시 선택해주세요.");
			return false;
		}

		$("#_VIEW_REPORT_DETAIL_LIST").html('');
		$("#_VIEW_REPORT_DETAIL_RESULT_LIST").html('');

		$.ajax({
			type: "post"
			, url: "/prevention/reportList.do"
			, data: $("#form_search_report").serialize()
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#_VIEW_REPORT_LIST").html(data);
				$("#_VIEW_RESULT_SHOW").removeClass('d-none');
			}
			, error: function (request, status, error) {
				console.log("code:" + request.status + "\n error:" + error);
			}
			, complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}

	<%-- 상세내용 리스트 --%>

	function fnReportDetailView(row) {
		var requestNo = $(row).attr('data-request-no');

		$("._TR_LIST_DATA").removeClass("active");
		$(row).addClass("active");

		$.ajax({
			type: "post"
			, url: "/prevention/reportDetailList.do"
			, data: {requestNo: requestNo}
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#_VIEW_REPORT_DETAIL_LIST").html(data);
				$("#_VIEW_REPORT_DETAIL_RESULT_LIST").html('');
			}
			, error: function (request, status, error) {
				console.log("code:" + request.status + "\n error:" + error);
			}
			, complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}

	<%-- 검색 상세내용 결과 리스트 --%>

	function fnReportDetailResultView(row, checkListNo, authoNo, checkDate, equipNo) {
		var checkListNo = checkListNo;
		var authoNo = authoNo;
		var checkDate = checkDate;
		var equipNo = equipNo;

		$("._TR_LIST_DETAIL").removeClass("active");
		$(row).addClass("active");

		$.ajax({
			type: "post"
			, url: "/prevention/reportDetailResultList.do"
			, data: {checkListNo: checkListNo, authoNo: authoNo, checkDate: checkDate, equipNo: equipNo}
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#_VIEW_REPORT_DETAIL_RESULT_LIST").html(data);
			}
			, error: function (request, status, error) {
				console.log("code:" + request.status + "\n error:" + error);
			}
			, complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}

	<%-- 검색 결과 리스트 페이징 처리 --%>

	function fnPageMove(f) {
		var currentPage = parseInt($("#currentPage").val());

		if (f === 'P') {
			if (currentPage === 1) {
				alert("처음 페이지입니다.");
				return false;
			}
			currentPage = currentPage - 1;
		} else if (f === 'N') {
			if (currentPage === totalPage) {
				alert("마지막 페이지입니다.");
				return false;
			}
			currentPage = currentPage + 1;
		} else if (f === 'M') {
			if (currentPage > totalPage) {
				alert("마지막 페이지는 " + totalPage + "입니다. 이 페이지를 초과할 수 없습니다.");
				$("#currentPage").val(totalPage);
				return false;
			}
		}

		$("#currentPage").val(currentPage);

		$.ajax({
			type: "get"
			, url: "/prevention/reportList.do?pageIndex=" + currentPage
			, data: $("#form_search_report").serialize()
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#_VIEW_REPORT_LIST").html(data);
				$("#_VIEW_RESULT_SHOW").removeClass('d-none');
			}
			, error: function (request, status, error) {
				console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
			}
			, complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}

	$(function() {
		setDate();
		fnReportSearch();
	});
</script>