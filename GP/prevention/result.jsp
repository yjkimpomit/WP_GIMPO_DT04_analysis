<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<main class="winbox-layout page-content">
	<div class="page-content__placeholder">
		<div class="splitview">
			<aside class="splitview__pane splitview__pane--sidebar" aria-label="정보 검색">

				<!-- 검색영역 -->
				<form class="filter-panel" id="form_search_result" method="post" autocomplete="off">

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
						<input type="hidden" id="ColList" name="ColList" value="">

						<div class="form-field">
							<label class="form-label" for="checkNo1">점검번호</label>
							<input class="form-control" type="text" id="checkNo1" name="checkListNo">
						</div>

						<div class="form-field">
							<label class="form-label" for="equipNoOption">설비번호</label>
							<input class="form-control search-icon" id="equipNoOption" name="equipNo" onclick="searchFacilityPopup($(this));">
							<input class="form-control" type="text" value="" id="equipNoInput" disabled="">
						</div>

						<fieldset class="form-field">
							<legend class="form-label">이상점검결과</legend>
							<div class="form-field__content form-choice-list">
								<label class="form-choice">
									<input type="checkbox" value="" id="chkAbnormalResult">
									<span>이상점검결과 선택</span>
								</label>
							</div>
						</fieldset>

						<div class="form-field">
							<label class="form-label" for="maintDeptOption">*정비부서</label>
							<input class="form-control search-icon" id="maintDeptOption" name="workDeptNo" onclick="searchmainDeptTreePopup($(this));">
							<input class="form-control" type="text" value="" id="maintDeptInput" disabled="" aria-label="선택된 정비부서명">
						</div>

						<div class="form-field">
							<label class="form-label" id="designDeptOption">설계부서</label>
							<input class="form-control search-icon" id="designDeptOption" name="planDeptNo" onclick="searchdesignDeptTreePopup($(this));">
							<input class="form-control" type="text" value="" id="designDeptInput" disabled="" aria-label="선택된 설계부서명">
						</div>

						<fieldset class="form-field">
							<legend class="form-label">점검기간</legend>

							<div class="form-control-group">
								<label>
									<span class="visually-hidden">점검 시작일</span>
									<input type="date" class="form-control" name="searchPeriodStart" id="inspectorPeriodStart">
								</label>

								<label>
									<span class="visually-hidden">점검 종료일</span>
									<input type="date" class="form-control" name="searchPeriodEnd" id="inspectorPeriodEnd">
								</label>
							</div>
						</fieldset>

						<div class="form-field">
							<label class="form-label" for="inspectorOption">점검자</label>
							<!-- 2025.01.16 yjkim - 콤보박스 > 검색팝업으로 변경 -->
							<!-- list="supvDeptOptions" 부분 삭제하고 onclick="searchItemPopup();" 으로 대체함 -->
							<!-- 팝업스크립트는 common.js 참고, 관련팝업은 /home/index.jsp 에 있음 -->
							<input class="form-control search-icon" id="inspectorOption" name="checkBy" onclick="searchItemPopup($(this));">
							<input class="form-control" type="text" value="" id="inspectorInput" disabled="" aria-label="선택된 점검자명">
						</div>

						<div class="form-field">
							<label class="form-label" for="inspectorTypeOption">점검종류</label>
							<input class="form-control search-icon" id="inspectorTypeOption" name="checkGbn" onclick="searchResultPopup($(this));">
							<input class="form-control" type="text" value="" id="inspectorTypeInput" disabled="" aria-label="선택된 점검종류명">
						</div>

						<div class="form-field">
							<label class="form-label" for="inspectorClass">점검구분</label>
							<select class="form-select" id="inspectorClass" name="checkTypeNm">
								<option value="">----------------------------------</option>
								<option value="일반예방점검">일반예방점검</option>
								<option value="오일점검">오일점검</option>
								<option value="오일분석">오일분석</option>
								<option value="상태기반예방점검">상태기반예방점검</option>
							</select>
						</div>
						
					</div>

					<div class="filter-panel__actions">
						<button type="button" class="button button--primary" onclick="fnResultSearch()">검색</button>
					</div>
					
				</form>
			
			</aside>
			<section class="splitview__pane splitview__pane--content result-panel" aria-label="검색 결과">
				<h1 class="page-content__heading">점검 결과</h1>
				
				<%-- data-grid : 조회결과 리스트 뷰 --%>
				<div class="result-panel__body" id="_VIEW_RESULT_LIST">
					<%-- 조회결과 리스트 : /detail/result_list.jsp --%>
				</div>

				<%-- data-grid : 점검종류 리스트 뷰 --%>
				<div class="result-panel__body" id="_VIEW_RESULT_KIND_LIST">
					<%-- 조회결과의 점검종류 리스트 : /detail/result_kind_list.jsp --%>
				</div>

				<%-- data-grid : 점검내용 리스트 뷰 --%>
				<div class="result-panel__body" id="_VIEW_RESULT_DETAIL_LIST">
					<%-- 조회결과의 점검내용 리스트 : /detail/result_detail_list.jsp --%>
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
		$('#inspectorPeriodEnd').val(currentDate); // 첫 번째 input에 오늘 날짜 설정

		// 두 번째 input 태그 (한 달 전 날짜로 설정)
		today.setMonth(today.getMonth() - 1); // 현재 날짜 기준 한 달 전으로 설정
		var lastMonthDate = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + ("0" + today.getDate()).slice(-2);
		$('#inspectorPeriodStart').val(lastMonthDate); // 두 번째 input에 한 달 전 날짜 설정
	}

	<%-- 검색 결과 리스트 --%>

	function fnResultSearch() {
		var stval = "";
		var endval = "";

		//조회 시작일
		stval = document.getElementById("inspectorPeriodStart").value;
		//조회 종료일
		endval = document.getElementById("inspectorPeriodEnd").value;

		if (stval != "" && endval === "") {
			alert("조회 종료일을 선택해주세요");
			return false;
		} else if (stval === "" && endval !== "") {
			alert("조회 시작일을 선택해주세요");
			return false;
		} else if (stval > endval) {
			alert("조회 종료일을 시작일 이전으로 설정할 수 없습니다.\n조회 종료일을 다시 선택해주세요.");
			return false;
		}

		$("#_VIEW_RESULT_KIND_LIST").html('');
		$("#_VIEW_RESULT_DETAIL_LIST").html('');

		$.ajax({
			type: "post"
			, url: "/prevention/resultList.do"
			, data: $("#form_search_result").serialize()
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#_VIEW_RESULT_LIST").html(data);
				$("#loadingBar").css("display", "none");
			}
			, error: function (request, status, error) {
				console.log("code:" + request.status + "\n error:" + error);
			}
			, complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}

	<%-- 점검종류 리스트 --%>

	function fnResultKindView(row) {
		var requestNo = $(row).attr('data-request-no');
		console.log("### fnResultKindView : " + requestNo);

		$("._TR_RESULT_DATA").removeClass("active");
		$(row).addClass("active");

		$.ajax({
			type: "post"
			, url: "/prevention/resultKindList.do"
			, data: {requestNo: requestNo}
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#_VIEW_RESULT_KIND_LIST").html(data);
				$("#_VIEW_RESULT_DETAIL_LIST").html('');
			}
			, error: function (request, status, error) {
				console.log("code:" + request.status + "\n error:" + error);
			}
			, complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}

	<%-- 점검내용 리스트 --%>

	function fnResultDetailView(row) {
		var requestNo = $(row).attr('data-request-no');

		$("._TR_KIND_DATA").removeClass("active");
		$(row).addClass("active");

		$.ajax({
			type: "post"
			, url: "/prevention/resultDetailList.do"
			, data: {requestNo: requestNo}
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#_VIEW_RESULT_DETAIL_LIST").html(data);
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
			if (currentPage == 1) {
				alert("처음 페이지입니다.");
				return false;
			}
			currentPage = currentPage - 1;
		} else if (f === 'N') {
			if (currentPage == totalPage) {
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
			, url: "/prevention/resultList.do?pageIndex=" + currentPage
			, data: $("#form_search_result").serialize()
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#_VIEW_RESULT_LIST").html(data);
			}
			, error: function (request, status, error) {
				console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
			}
			, complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}

	$(function () {
		setDate();
		fnResultSearch();
	});
</script>