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
				<form class="filter-panel" id="form_search_job_req_proc" method="post" autocomplete="off">

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

						<!-- 사업소 영역 추후에 사용할 수 있음 -->
						<!-- <div class="col-md-6 col-lg-4 col-xxl-3">
							<label for="bizOfcSel" class="form-label">사업소</label>
							<select class="form-select" aria-label="사업소 선택" id="bizOfcSel" disabled>
								<option>사업소 선택</option>
								<option value="1" selected>평택2복합</option>
							</select>
						</div> -->
						
						<fieldset class="form-field">
							<legend class="form-label" id="dateRangePicker">검색기간(확정일)</legend>

							<div class="form-control-group">
								<label>
									<span class="visually-hidden">시작일</span>
									<input type="date" class="form-control" id="confirmedDtStart" name="searchPeriodStart">
								</label>

								<label>
									<span class="visually-hidden">종료일</span>
									<input type="date" class="form-control" id="confirmedDtEnd" name="searchPeriodEnd">
								</label>
							</div>
						</fieldset>

						<fieldset class="form-field">
							<legend class="form-label">검색조건</legend>
							<div class="form-field__content form-choice-list">
								<label class="form-choice">
									<input type="radio" id="rbSearchCondition05" name="searchCondition" value="5" data-label="설비" checked>
									<span>설비별</span>
								</label>
								<label class="form-choice">
									<input type="radio" id="rbSearchCondition02" name="searchCondition" value="2" data-label="요청부서">
									<span>요청부서별</span>
								</label>
								<label class="form-choice">
									<input type="radio" id="rbSearchCondition03" name="searchCondition" value="3" data-label="감독부서">
									<span>감독부서별</span>
								</label>
								<label class="form-choice">
									<input type="radio" id="rbSearchCondition04" name="searchCondition" value="4" data-label="요청자">
									<span>요청자별</span>
								</label>
								<label class="form-choice">
									<input type="radio" id="rbSearchCondition01" name="searchCondition" value="1" data-label="호기">
									<span>호기별</span>
								</label>
								<label class="form-choice">
									<input type="radio" id="rbSearchCondition06" name="searchCondition" value="6" data-label="요청부서/감독부서">
									<span>요청부서별 & 감독부서별</span>
								</label>
							</div>
						</fieldset>

						<div class="form-field">
							<label class="form-label" for="reqDeptOption">요청부서</label>
							<input class="form-control search-icon" id="reqDeptOption" name="reqDeptNo" disabled onclick="searchReqDeptTreePopup($(this));">
							<input class="form-control" type="text" value="" id="reqDeptInput" disabled="" aria-label="선택된 요청부서명">
						</div>

						<div class="form-field">
							<label class="form-label" for="supvDeptOption">감독부서</label>
							<input class="form-control search-icon" id="supvDeptOption" name="deptNo" disabled onclick="searchReqTreePopup($(this));">
							<input class="form-control" type="text" value="" id="supvDeptInput" disabled="" aria-label="선택된 감독부서명">
						</div>

					</div>

					<div class="filter-panel__actions">
						<button type="button" class="button button--primary" onclick="fnJobRequestProcStatSearch()">검색</button>
					</div>

				</form>
			
			</aside>
			<section class="splitview__pane splitview__pane--content result-panel" aria-label="검색 결과">
				<h1 class="page-content__heading">작업요청 처리현황</h1>
				
				<%-- data-grid : 결과 리스트 뷰 --%>
				<div class="d-none" id="_VIEW_RESULT_SHOW">

					<div class="chart-placeholder" role="img" aria-label="작업요청-처리현황-차트" id="divResultChart">
						<!-- <div class="chart-box" role="img" aria-label="작업요청-처리현황-차트"> -->
							<div class="chart-item">
								<%-- 차트 : /detail/jobReqProcStat_chart.jsp --%>
							</div>
						<!-- </div> -->

					</div>

					<div class="result-panel__body" id="_VIEW_JOB_REQ_PROC">
						<%-- 조회 리스트 부분 : /detail/jobReqProcStat_list.jsp --%>
					</div>
					
				</div>
			</section>
		</div>
	</div>
</main>

<%-- 상세보기 팝업 --%>
<div class="modal fade" tabindex="-1" id="jobReqProcStatDetailBox">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
		<div class="modal-content" id="jobReqProcStatDetailList">
		</div>
	</div>
</div>

<script>
	function setDate() {
		//날짜 현재날짜 기준 한 달 전 세팅
		var today = new Date();
		var yyyy = today.getFullYear();
		var mm = ("0" + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
		var dd = ("0" + today.getDate()).slice(-2);
		var currentDate = yyyy + "-" + mm + "-" + dd;
		$('#confirmedDtEnd').val(currentDate); // 첫 번째 input에 오늘 날짜 설정

		// 두 번째 input 태그 (한 달 전 날짜로 설정)
		today.setMonth(today.getMonth() - 1); // 현재 날짜 기준 한 달 전으로 설정
		var lastMonthDate = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + ("0" + today.getDate()).slice(-2);
		$('#confirmedDtStart').val(lastMonthDate); // 두 번째 input에 한 달 전 날짜 설정
	}

	//요청부서별 , 감독부서별, 요청자별, 요청부서별&감독부서별
	document.querySelectorAll('input[type="radio"][name="searchCondition"]').forEach(radio => {
		radio.addEventListener('change', function () {
			//요청부서
			var reqDeptInput = document.getElementById('reqDeptOption');
			//요청부서명
			var reqDeptName = document.getElementById('reqDeptInput');
			//감독부서별
			var supDeptInput = document.getElementById('supvDeptOption');
			//감독부서명
			var supDeptName = document.getElementById('supvDeptInput');

			//요청부서별 or 요청자별
			if (this.value == 2 || this.value == 4) {
				supDeptInput.disabled = true;
				supDeptInput.value = '';
				supDeptName.value = '';
				reqDeptInput.disabled = false;
				//감독부서별
			} else if (this.value == 3) {
				supDeptInput.disabled = false;
				reqDeptInput.disabled = true;
				reqDeptInput.value = '';
				reqDeptName.value = '';
				//요청부서별 and 감독부서별
			} else if (this.value == 6) {
				supDeptInput.disabled = false;
				reqDeptInput.disabled = false;
			} else {
				supDeptInput.disabled = true;
				reqDeptInput.disabled = true;
				supDeptInput.value = '';
				supDeptName.value = '';
				reqDeptInput.value = '';
				reqDeptName.value = '';
			}
		});
	});

	function fnChangeLabel() {
		var dataFieldName = $("[name=rbSearchCondition]:checked").attr('data-label');
		$("#tblJobReqProcStats").find('[data-field="호기"]').eq(0).text(dataFieldName);
	}

	<%-- 검색 차트/리스트 --%>

	function fnJobRequestProcStatSearch() {
		var stval = "";
		var endval = "";

		//조회 시작일
		stval = document.getElementById("confirmedDtStart").value;
		//조회 종료일
		endval = document.getElementById("confirmedDtEnd").value;

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

		<%-- 검색 차트 --%>
		$.ajax({
			type: "post"
			, url: "/tmStatus/jobReqProcStatChart.do"
			, data: $("#form_search_job_req_proc").serialize()
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$(".chart-item").html(data);
			}
			, error: function (request, status, error) {
				console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
			}
		});

		<%-- 검색 리스트 --%>
		$.ajax({
			type: "post"
			, url: "/tmStatus/jobReqProcStatList.do"
			, data: $("#form_search_job_req_proc").serialize()
			, dataType: "html"
			, success: function (data) {
				$("#_VIEW_JOB_REQ_PROC").html(data);
				fnChangeLabel();
			}
			, error: function (request, status, error) {
				console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
			}
			, complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});

		$("#_VIEW_RESULT_SHOW").removeClass('d-none');
	}

	<%-- 상세정보 팝업 --%>

	function showDetail(row, r) {
		$("._TR_JOB_REQ_PROC").removeClass("active");
		$(row).addClass("active");
		var requestNo = $(row).attr("data-request-no");
		var requestType = r;

		if (requestType == 6) {
			requestNo = document.getElementById("rnd").value;
		}

		var startDate = $("#confirmedDtStart").val();
		var endDate = $("#confirmedDtEnd").val();
		var setData = "";

		$.ajax({
			url: "/tmStatus/jobReqProcStatDetail.do",
			data: {requestNo: requestNo, requestType: requestType, startDate: startDate, endDate: endDate},
			dataType: "html",
			beforeSend: function () {
				$("#loadingBar").css("display", "");
			},
			success: function (data) {
				if (data !== "") {
					setData = data;
				}
			},
			complete: function () {
				$("#jobReqProcStatDetailList").html(setData);

				$('#jobReqProcStatDetailBox').bPopup({
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
				});

				$("#loadingBar").css("display", "none");
			},
			error: function (request, status, error) {
				console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
			}
		});
	}

	<%-- 페이지 이동 부분 --%>

	function fnPageMove(f) {
		var currentPage = parseInt($("#currentPage").val());
		var requestNo = $("#hokiNo").val();
		var requestType = $("#jobNo").val();
		var startDate = $("#confirmedDtStart").val();
		var endDate = $("#confirmedDtEnd").val();

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
			, url: "/tmStatus/jobReqProcStatDetail.do?pageIndex=" + currentPage
			, data: {requestNo: requestNo, requestType: requestType, startDate: startDate, endDate: endDate}
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#jobReqProcStatDetailList").html(data);
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
		fnJobRequestProcStatSearch();
	});
</script>


