<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="winbox-layout page-content">
	<div class="page-content__placeholder">
		<div class="splitview">
			<aside class="splitview__pane splitview__pane--sidebar" aria-label="정보 검색">

				<!-- 검색영역 -->
				<form class="filter-panel" id="form_search_issus_request" method="post" autocomplete="off">

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
							<label class="form-label" for="supvorOption">감독자</label>
							<input class="form-control search-icon" id="supvorOption" name="planBy" onclick="searchItemPopup($(this));">
							<input class="form-control" type="text" value="" id="supvorInput" disabled="" aria-label="선택된 감독자명">
						</div>

						<div class="form-field">
							<legend class="form-label" for="supvDeptOption">감독부서</legend>
							<input class="form-control search-icon" id="supvDeptOption" name="deptNo" onclick="searchReqTreePopup($(this));">
							<input class="form-control" type="text" value="" id="supvDeptInput" disabled="" aria-label="선택된 감독부서명">
						</div>

						<div class="form-field">
							<legend class="form-label" for="operDeptNo">운전부서</legend>
							<input class="form-control search-icon" id="opDeptOption" name="operDeptNo" onclick="searchopDeptTreePopup($(this));">
							<input class="form-control" type="text" value="" id="opDeptInput" disabled="" aria-label="선택된 운전부서명">
						</div>
						
						<div class="form-field">
							<legend class="form-label" for="maintDeptOption">정비부서</legend>
							<input class="form-control search-icon" id="maintDeptOption" name="workDeptNo" onclick="searchmainDeptTreePopup($(this));">
							<input class="form-control" type="text" value="" id="maintDeptInput" disabled="" aria-label="선택된 정비부서명">
						</div>

						<div class="form-field">
							<label class="form-label" for="orderType">오더유형</label>
							<select class="form-select" id="orderType" name="woCategoryNm">
								<option value="" selected>오더유형 선택</option>
								<option value="경상오더">경상오더</option>
								<option value="공사오더">공사오더</option>
							</select>
						</div>

						<div class="form-field">
							<label class="form-label" for="orderNo">오더 번호</label>
							<input class="form-control" type="text" id="orderNo" value="" name="woNo" placeholder="오더번호 입력">
						</div>

						<div class="form-field">
							<label class="form-label" for="orderName">오더명</label>
							<input class="form-control" type="text" id="orderName" value="" name="woDesc" placeholder="오더명 입력">
						</div>

						<fieldset class="form-field">
							<legend class="form-label">Red Tag 포함</legend>
							<div class="form-field__content form-choice-list">
								<label class="form-choice">
									<input type="checkbox" onclick="toggleCheckboxValue()" id="redtagIncludeOrder" name="isRedTag" value="0">
									<span>Red Tag가 포함된 작업오더</span>
								</label>
							</div>
						</fieldset>

					</div>
					
					<div class="filter-panel__actions">
						<button type="button" class="button button--primary" onclick="fnIssusRequestSearch()">검색</button>
					</div>

				</form>
			
			</aside>
			<section class="splitview__pane splitview__pane--content result-panel" aria-label="검색 결과">
				<h1 class="page-content__heading">Red Tag 발행</h1>
				
				<%-- data-grid : 결과 리스트 뷰 --%>
				<!-- <div class="result-panel__body" id="issusList"> -->
					<div class="result-panel__body" id="issusOrderList"></div>

					<div class="splitview panel-split-layout panel-split-layout--two-to-one">
						<aside class="splitview__pane splitview__pane--sidebar panel-split-layout__sidebar" aria-label="조회리스트">
							<section class="panel-split-layout__group panel-split-layout__group--primary" id="issusWorkOrderList" aria-label="작업오더 설계 리스트">
								<!-- 작업오더 설계내용 리스트 -->

							</section>

						</aside>
						<div class="splitview__pane splitview__pane--content panel-split-layout__content" role="region" aria-label="점검내용">
							<section class="panel-split-layout__group panel-split-layout__group--primary" id="issusWorkOrderOutputList" aria-label="작업오더 설계내용 상세">
								<!-- 작업오더 설계내용 상세 -->

							</section>

						</div>
					</div>
					

				<!-- </div> -->
			</section>
		</div>
	</div>
</main>

<script>
	function toggleCheckboxValue() {
		var checkbox = document.getElementById("redtagIncludeOrder");

		// 체크박스가 선택되면 value를 1로, 해제되면 0으로 변경
		if (checkbox.checked) {
			checkbox.value = "1";
		} else {
			checkbox.value = "0";
		}
	}

	function fnIssusRequestSearch() {
		//active 클래스 제거
		$(".table-responsive > table > tbody > tr").removeClass("active");
		$.ajax({
			type: "post"
			, url: "/redtag/issusRequestList.do"
			, data: $("#form_search_issus_request").serialize()
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#issusOrderList").html(data);
				$('#issusWorkOrderList').css("display", "none");
				$('#issusWorkOrderOutputList').css("display", "none");
				$('.alert').css("display", "none");
			}
			, error: function (request, status, error) {
				console.log("code:" + request.status + "\n error:" + error);
			},
			complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}

	function redtagOrderDetail(row) {
		//active 클래스 제거
		$("#tblWorkingOrder > tbody > tr").removeClass("active");
		var requestNo = $(row).attr("data-request-no");

		$(row).addClass("active");

		$.ajax({
			type: "post"
			, url: "/redtag/orderRequestDetail.do"
			, data: {requestNo: requestNo}
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#issusWorkOrderList").html(data);
				$('#issusWorkOrderList').css("display", "block");
				$('#issusWorkOrderOutputList').css("display", "none");
			}
			, error: function (request, status, error) {
				console.log("code:" + request.status + "\n error:" + error);
			},
			complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}

	function redtagWorkOrderDetail(row) {
		//active 클래스 제거
		$("#tblWorkOrderDesign > tbody > tr").removeClass("active");
		var requestNo = $(row).attr("data-request-no");

		$(row).addClass("active");

		$.ajax({
			type: "post"
			, url: "/redtag/workOrderRequestDetail.do"
			, data: {requestNo: requestNo}
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#issusWorkOrderOutputList").html(data);
				$('#issusWorkOrderOutputList').css("display", "block");
			}
			, error: function (request, status, error) {
				console.log("code:" + request.status + "\n error:" + error);
			},
			complete: function () {
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
			, url: "/redtag/issusRequestList.do?pageIndex=" + currentPage
			, data: $("#form_search_issus_request").serialize()
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#issusOrderList").html(data);
				$('#issusWorkOrderOutputList').css("display", "none");
				$('.alert').css("display", "none");
			}
			, error: function (request, status, error) {
				console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
			},
			complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}

	$(function () {
		$("#form_search_issus_request input:radio[name=searchType]").change(function () {
			var searchTypeVal = $(this).val();

			var redtagForm = $('#form_search_issus_request');
			var formInput = redtagForm.find('input:not([type="radio"])');
			var redTagInc = $('#form_search_issus_request #redTagInc');
			var orderTypeArea = $('#form_search_issus_request #orderTypeArea');
			var mainDiv = $('#form_search_issus_request #formMainDept');   //정비부서

			if (searchTypeVal === '2') {
				formInput.val('');

				//정비부서 안보이게 설정
				mainDiv.hide();
				orderTypeArea.hide();
				redTagInc.show();

				var checkbox = $("#redtagIncludeOrder");
				checkbox.prop("checked", false);  // 체크박스를 해제
				checkbox.val("0");
			} else {
				formInput.val('');

				redTagInc.hide();
				mainDiv.show();
				orderTypeArea.show();
			}
		});
	});
</script>