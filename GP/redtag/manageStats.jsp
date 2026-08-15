<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<main class="winbox-layout page-content">
	<div class="page-content__placeholder">
		<div class="splitview">
			<aside class="splitview__pane splitview__pane--sidebar" aria-label="정보 검색">

				<!-- 검색영역 -->
				<form class="filter-panel" id="form_search_manage_request" method="post" autocomplete="off">

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
							<label class="form-label" for="redtagStatus">Tag상태</label>
							<select class="form-select" id="redtagStatus" name="redtagStatus">
								<option value="미회수" selected>미회수</option>
								<option value="회수">회수</option>
								<option value="미발행">미발행</option>
							</select>
						</div>

						<fieldset class="form-field">
							<legend class="form-label">구분</legend>
							<div class="form-field__content form-choice-list">
								<label class="form-choice">
									<input type="radio" id="workType_1" name="searchType" value="1" checked>
									<span>W/O</span>
								</label>
								<label class="form-choice">
									<input type="radio" id="workType_2" name="searchType" value="2">
									<span>기타</span>
								</label>
							</div>
						</fieldset>

						<div class="form-field">
							<label class="form-label" for="issuerOption">발행자</label>
							<input class="form-control search-icon" id="issuerOption" name="printBy" onclick="searchItemPopup($(this));">
							<input class="form-control" type="text" value="" id="issuerInput" disabled="" aria-label="선택된 발행자명">
						</div>

						<div class="form-field">
							<label class="form-label" for="retrieverOption">회수자</label>
							<input class="form-control search-icon" id="retrieverOption" name="returnBy" onclick="searchItemPopup($(this));">
							<input class="form-control" type="text" value="" id="retrieverInput" disabled="" aria-label="선택된 회수자명">
						</div>

						<div class="form-field">
							<label class="form-label" for="opDeptOption">운전부서</label>
							<input class="form-control search-icon" id="opDeptOption" name="operDeptNo" onclick="searchopDeptTreePopup($(this));">
							<input class="form-control" type="text" value="" id="opDeptInput" disabled="" aria-label="선택된 운전부서명">
						</div>

						<fieldset class="form-field">
							<legend class="form-label">Tag 작성일</legend>

							<div class="form-control-group">
								<label>
									<span class="visually-hidden">작성 시작일</span>
									<input type="date" class="form-control" id="tagCreatedDateStart" name="searchPeriodStart">
								</label>

								<label>
									<span class="visually-hidden">작성 종료일</span>
									<input type="date" class="form-control" id="tagCreatedDateEnd" name="searchPeriodEnd">
								</label>
							</div>
						</fieldset>

						<div class="form-field">
							<label class="form-label" for="supvorOption">감독자</label>
							<input class="form-control search-icon" id="supvorOption" name="planBy" onclick="searchItemPopup($(this));">
							<input class="form-control" type="text" value="" id="supvorInput" disabled="" aria-label="선택된 감독자명">
						</div>

						<div class="form-field">
							<label class="form-label" for="supvDeptOption">감독부서</label>
							<input class="form-control search-icon" id="supvDeptOption" name="deptNo" onclick="searchReqTreePopup($(this));">
							<input class="form-control" type="text" value="" id="supvDeptInput" disabled="" aria-label="선택된 감독부서명">
						</div>

						<div class="form-field">
							<label class="form-label" for="maintDeptOption">정비부서</label>
							<input class="form-control search-icon" id="maintDeptOption" name="workDeptNo" onclick="searchmainDeptTreePopup($(this));">
							<input class="form-control" type="text" value="" id="maintDeptInput" disabled="" aria-label="선택된 정비부서명">
						</div>

						<div class="form-field">
							<label class="form-label" for="tagNumber">Tag 번호</label>
							<input class="form-control" type="text" id="tagNumber" name="barcodeNo" placeholder="Tag 번호 입력">
						</div>
					</div>

					<div class="filter-panel__actions">
						<button type="button" class="button button--primary" onclick="fnManageRequestSearch()">검색</button>
					</div>
					
				</form>
			
			</aside>
			<section class="splitview__pane splitview__pane--content result-panel" aria-label="검색 결과">
				<h1 class="page-content__heading">Red Tag 관리대장</h1>
				
				<%-- data-grid : 결과 리스트 뷰 --%>
				<div class="result-panel__body" id="manageList">
					
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
		$('#tagCreatedDateEnd').val(currentDate); // 첫 번째 input에 오늘 날짜 설정

		// 두 번째 input 태그 (한 달 전 날짜로 설정)
		today.setMonth(today.getMonth() - 1); // 현재 날짜 기준 한 달 전으로 설정
		var lastMonthDate = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + ("0" + today.getDate()).slice(-2);
		$('#tagCreatedDateStart').val(lastMonthDate); // 두 번째 input에 한 달 전 날짜 설정
	}

	$(document).ready(function () {
		//초기 화면 표시시
		setDate();

		$("#form_search_manage_request input:radio[name=searchType]").change(function () {
			var redtagForm = $('#form_search_manage_request');
			var formInput = redtagForm.find('input:not([type="radio"])');
			var mainDiv = $('#manageMainDept');    //정비부서

			if (this.value === '2') {
				formInput.val('');

				//정비부서 안보이게 설정
				setDate();
				mainDiv.hide();
			} else {
				formInput.val('');
				setDate();
				mainDiv.show();
			}
		});
	});

	function fnManageRequestSearch() {
		var stval = "";
		var endval = "";

		//조회 시작일
		stval = document.getElementById("tagCreatedDateStart").value;
		//조회 종료일
		endval = document.getElementById("tagCreatedDateEnd").value;

		if (stval !== "" && endval === "") {
			alert("조회 종료일을 선택해주세요");
			return false;
		} else if (stval === "" && endval !== "") {
			alert("조회 시작일을 선택해주세요");
			return false;
		} else if (stval > endval) {
			alert("조회 종료일을 시작일 이전으로 설정할 수 없습니다.\n조회 종료일을 다시 선택해주세요.");
			return false;
		}

		$.ajax({
			type: "post"
			, url: "/redtag/manageRequestList.do"
			, data: $("#form_search_manage_request").serialize()
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#manageList").html(data);
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
			, url: "/redtag/manageRequestList.do?pageIndex=" + currentPage
			, data: $("#form_search_manage_request").serialize()
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#manageList").html(data);
			}
			, error: function (request, status, error) {
				console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
			}
			, complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}
</script>