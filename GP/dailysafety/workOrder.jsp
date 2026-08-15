<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 일일안전현황 > 공사오더 팝업 --%>
<main class="winbox-layout page-content">
	<div class="page-content__placeholder">
		<div class="splitview">
			<aside class="splitview__pane splitview__pane--sidebar" aria-label="정보 검색">

				<!-- 검색영역 -->
				<form class="filter-panel" id="searchWorkOrderForm" method="post" autocomplete="off">

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
						<input type="hidden" name="pageIndex" id="pageIndex" value="${workOrderVO.pageIndex}">
						
						<div class="form-field">
							<label class="form-label" for="designerOption">설계자</label>
							<input class="form-control search-icon" id="designerOption" name="designBy" onclick="searchItemPopup($(this));">
							<input class="form-control" type="text" value="" id="designerInput" name="designName" disabled="" aria-label="선택된 설계자명">
						</div>
						
						<div class="form-field">
							<label class="form-label" for="designDeptOption">설계부서</label>
							<input class="form-control search-icon" id="designDeptOption" name="designDeptNo" onclick="searchdesignDeptTreePopup($(this));">
							<input class="form-control" type="text" value="" id="designDeptInput" name="designDeptName" disabled="" aria-label="선택된 설계부서명">
						</div>

						<div class="form-field">
							<label class="form-label" for="supvorOption">감독자</label>
							<input class="form-control search-icon" id="supvorOption" name="planBy" onclick="searchItemPopup($(this));">
							<input class="form-control" type="text" value="" id="supvorInput" name="planName" disabled="" aria-label="선택된 감독자명">
						</div>

						<div class="form-field">
							<label class="form-label" for="supvDeptOption">감독부서</label>
							<input class="form-control search-icon" id="supvDeptOption" name="deptNo" onclick="searchReqTreePopup($(this));">
							<input class="form-control" type="text" value="" id="supvDeptInput" name="deptName" disabled="" aria-label="선택된 감독부서명">
						</div>

						<fieldset class="form-field">
							<legend class="form-label">설계일</legend>

							<div class="form-control-group">
								<label>
									<span class="visually-hidden">설계 시작일</span>
									<input type="date" class="form-control" id="requestDateStart" name="requestDateStart">
								</label>

								<label>
									<span class="visually-hidden">설계 종료일</span>
									<input type="date" class="form-control" id="requestDateEnd" name="requestDateEnd">
								</label>
							</div>
						</fieldset>

						<div class="form-field">
							<label class="form-label" for="constCodeInput">공사번호</label>
							<!-- <%--<input class="form-control search-icon" id="constCodeOption" name="projectNo" onclick="searchmainDeptTreePopup($(this));">--%> -->
							<input class="form-control" type="text" value="" id="constCodeInput" name="projectNo" aria-label="선택된 공사번호명">
						</div>

						<div class="form-field">
							<label class="form-label" for="projectType">공사종류</label>
							<select class="form-select" id="projectType" name="projectType">
								<option value="" selected>----------------------------------</option>
								<option value="GENERAL">일반공사</option>
								<option value="SIMPLE">간이공사</option>
								<option value="O/H">OVERHAUL</option>
								<option value="SERVICE">용역공사</option>
								<option value="CONTRACT">단가공사</option>
								<option value="INSTALL">설치조건부구매</option>
							</select>
						</div>

						<div class="form-field">
							<label class="form-label" for="orderNo">오더번호</label>
							<input class="form-control" type="text" id="orderNo" name="woNo" placeholder="오더번호 입력">
						</div>

						<fieldset class="form-field">
							<legend class="form-label">변경구분</legend>
							<div class="form-field__content form-choice-list">
								<label class="form-choice">
									<input type="radio" name="isProjectChanged" id="isProjectChanged_1" value="" checked>
									<span>전체</span>
								</label>
								<label class="form-choice">
									<input type="radio" name="isProjectChanged" id="isProjectChanged_2" value="N">
									<span>최초설계분</span>
								</label>
								<label class="form-choice">
									<input type="radio" name="isProjectChanged" id="isProjectChanged_3" value="Y">
									<span>설계변경분</span>
								</label>
							</div>
							<div class="form-field__content">
								<label class="form-label" for="projectChangeType">변경구분명</label>
								<select class="form-select" id="projectChangeType" name="projectChangeType" disabled>
									<option value="" selected>----------------------------------</option>
									<option value="PLUS">증가분</option>
									<option value="MINUS">감소분</option>
								</select>
							</div>
						</fieldset>

						<div class="form-field">
							<label class="form-label" for="equipNoOption">설비번호</label>
							<input class="form-control search-icon" id="equipNoOption" name="equipNo" onclick="searchFacilityPopup($(this));">
							<input class="form-control" type="text" value="" id="equipNoInput" disabled="" aria-label="선택된 설비번호명">
						</div>

						<div class="form-field">
							<label class="form-label" for="isStandard">표준작업</label>
							<select class="form-select" id="isStandard" name="isStandard">
								<option value="" selected>----------------------------------</option>
								<option value="Y">표준작업</option>
								<option value="N">비표준작업</option>
							</select>
						</div>
					</div>

					<div class="filter-panel__actions">
						<button type="button" class="button button--primary" onclick="fnSearchForm();">검색</button>
					</div>

					<div class="side-panel left">
						<%-- tree list view : 기능위치/계통/종류 --%>
						<c:import url="/common/facilityPackageTreeList.do"/>
					</div>
				</form>
			
			</aside>
			<section class="splitview__pane splitview__pane--content result-panel" aria-label="검색 결과">
				<h1 class="page-content__heading">공사오더</h1>
				
				<%-- data-grid : 결과 리스트 뷰 --%>
				<div class="result-panel__body" id="_VIEW_RESULT_LIST">
					<%-- 조회결과 리스트 뷰 : /detail/workOrder_list.jsp --%>
					
				</div>

				<%-- 품질안전설계 시작 --%>
				<div class="result-panel__body" id="_VIEW_RESULT_SAFETY_QUALITY">
					<%-- 품질안전설계 뷰 : /detail/routineWorkOrder_safety_quality.jsp --%>
				</div>
				<%-- 품질안전설계 끝 --%>
				
			</section>
		</div>
	</div>
</main>

<%-- 안전작업허가서 팝업 --%>
<div class="modal fade detail-box" tabindex="-1" id="safetyWorkPermitPop">
	<%-- 안전작업허가서 뷰 : /detail/routineWorkOrder_permit_pop.jsp --%>
</div>
<%-- 안전작업허가서 팝업 끝 --%>

<%--</div>--%>

<script>
	function setDate() {
		//날짜 현재날짜 기준 한 달 전 세팅
		var today = new Date();
		var yyyy = today.getFullYear();
		var mm = ("0" + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
		var dd = ("0" + today.getDate()).slice(-2);
		var currentDate = yyyy + "-" + mm + "-" + dd;
		$('#requestDateEnd').val(currentDate); // 첫 번째 input에 오늘 날짜 설정

		// 두 번째 input 태그 (한 달 전 날짜로 설정)
		today.setMonth(today.getMonth() - 1); // 현재 날짜 기준 한 달 전으로 설정
		var lastMonthDate = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + ("0" + today.getDate()).slice(-2);
		$('#requestDateStart').val(lastMonthDate); // 두 번째 input에 한 달 전 날짜 설정
	}

	setDate();

	/* 검색조회 리스트 */
	var orderColumn;
	var orderType;

	function fnSearchWorkOrderList() {
		$.ajax({
			type: "POST"
			, url: "/dailySafety/workOrderList.do"
			, data: $("#searchWorkOrderForm").serialize()
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#_VIEW_RESULT_SAFETY_QUALITY").html("");
				$("#_VIEW_RESULT_LIST").html(data);
			}
			, error: function () {
				alert("오류가 발생했습니다.\n잠시 후 다시 시도해 주시기 바랍니다.");
			}
			, complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}

	/* load list page */
	fnSearchWorkOrderList();

	function fnSearchForm() {
		$("#searchWorkOrderForm #pageIndex").val(1);
		fnSearchWorkOrderList();
	}

	<%-- 페이지 이동 부분 --%>

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

		$("#searchWorkOrderForm #pageIndex").val(currentPage);
		fnSearchWorkOrderList();
	}

	/* 품질안전설계 정보 */
	function fnWorkOrderResultDetailView(row) {
		var no = $(row).attr('data-no');

		$("._TR_RESULT_DATA").removeClass("active");
		$(row).addClass("active");

		/* 점검종류 리스트 */
		$.ajax({
			type: "POST"
			, url: "/dailySafety/routineWorkOrderSafetyQuality.do"
			, data: {woNo: no, workOrderType: 'O'}
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#_VIEW_RESULT_SAFETY_QUALITY").html(data);
			}
			, error: function () {
				alert("오류가 발생했습니다.\n잠시 후 다시 시도해 주시기 바랍니다.");
			}
			, complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}

	//클릭된 행 클래스 설정
	var setActiveRow = null;

	function fnShowSafetyWorkPermitPop(row) {
		var no = $(row).attr('data-no');
		var aNo = $(row).attr('data-ano');
		var workOrderType = $(row).attr('data-type');

		setActiveRow = row;

		//클릭된 행 클래스 추가 및 다른 행의 클래스 제거
		var $table = $(row).closest('table');

		if (setActiveRow) {
			$table.find('tr.active').not(this).removeClass("active");
			$(setActiveRow).addClass('active');
		}

		$("#safetyWorkPermitPop").bPopup({
			modalClose: false,
			position: [0, 0],
			opacity: .4,
			speed: 450,
			closeClass: "close",
			onOpen: function () {
				$(this).addClass('show detail-box');
			},
			onClose: function () {
				$(this).removeClass('show');
			}
		}, function () {
			$.ajax({
				url: "/dailySafety/routineWorkOrderPermitPop.do"
				, type: "POST"
				, data: {woNo: no, authoNo: aNo, workOrderType: workOrderType}
				, dataType: "html"
				, beforeSend: function () {
					$("#loadingBar").css("display", "");
				},
				success: function (data) {
					$("#safetyWorkPermitPop").html(data);
				},
				complete: function () {
					$("#loadingBar").css("display", "none");
				},
				error: function (request, status, error) {
					console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
				}
			});
		});
	}

	/* 엑셀 다운로드 */
	function fnExcelDownloadWorkOrder() {
		var excelColList = [];

		$("th[name='excelCol']").each(function () {
			var fieldValue = $(this).data("field");
			excelColList.push(fieldValue);
		});

		var $form = $("#searchWorkOrderForm");
		$form.append(
			$('<input>', {
				type: "hidden",
				name: "colList",
				value: excelColList.join()
			})
		);

		$.ajax({
			type: "POST"
			, url: "/dailySafety/workOrderExcelDownload.do"
			, data: $("#searchWorkOrderForm").serialize()
			, xhrFields: {
				responseType: 'blob'  // 응답을 Blob 형식으로 받기
			}
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (response, status, xhr) {
				try {
					//현재 날짜 가져오기
					var currentDate = new Date();
					var formattedDate = currentDate.getFullYear() + '-' +
						(currentDate.getMonth() + 1).toString().padStart(2, '0') + '-' +
						currentDate.getDate().toString().padStart(2, '0');

					// Blob을 사용하여 파일 다운로드 처리
					var blob = response;
					var link = document.createElement('a');
					link.href = URL.createObjectURL(blob);
					link.download = "공사오더_" + formattedDate + ".xlsx";
					link.click();  // 다운로드 트리거
				} catch (e) {
					console.log(e);
					$("#loadingBar").css("display", "none");
				}
			}
			, error: function (request, status, error) {
				console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
			}
			, complete: function () {
				$form.find('input[name=colList]').remove();
				$("#loadingBar").css("display", "none");
			}
		});
	}

	$(function () {
		$("[name=isProjectChanged]").change(function () {
			if ($(this).val() === 'Y') {
				$("#projectChangeType").prop("disabled", false);
			} else {
				$("#projectChangeType").prop("disabled", true);
			}
		});
	})
</script>
