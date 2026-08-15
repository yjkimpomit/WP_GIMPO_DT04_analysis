<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- TM현황 > 다발 TM 현황 탭 메뉴 --%>
<main class="winbox-layout page-content tm-confirmation-page">
	<div class="page-content__placeholder">
		<section class="splitview">
			<aside class="splitview__pane splitview__pane--sidebar" aria-label="정보 검색">
				<!-- 검색영역 -->
				<form class="filter-panel" id="form_search_multiple_tms" method="post" autocomplete="off">

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
							<legend class="form-label">검색기간(확정일)</legend>

							<div class="form-control-group">
								<label>
									<span class="visually-hidden">검색 시작일</span>
									<input type="date" class="form-control" id="confirmedDtStart" name="searchPeriodStart">
								</label>

								<label>
									<span class="visually-hidden">검색 종료일</span>
									<input type="date" class="form-control" id="confirmedDtEnd" name="searchPeriodEnd">
								</label>
							</div>
						</fieldset>
						
						<div class="form-field">
							<label class="form-label" for="multiple-request-department-code">요청부서</label>
							<input class="form-control" id="reqDeptOption" name="reqDeptNo" onclick="searchReqDeptTreePopup($(this));">
							<input class="form-control" type="text" value="" id="reqDeptInput" disabled="">
						</div>
						
						<div class="form-field">
							<label class="form-label" for="multiple-request-department-code">감독부서</label>
							<input class="form-control" id="supvDeptOption" name="deptNo" onclick="searchReqTreePopup($(this));">
							<input class="form-control" type="text" value="" id="supvDeptInput" disabled="">
						</div>
					</div>
					
					<div class="filter-panel__actions">
						<button type="button" class="button button--primary" onclick="fnMultipleTmsSearch()">검색</button>
					</div>
					
					<section class="filter-panel__section" aria-labelledby="tm-equipment-classification-title">
						<h2 class="filter-panel__section-title visually-hidden" id="tm-equipment-classification-title">
							설비분류체계
						</h2>
						<%-- tree list view : 기능위치/계통/종류 --%>
						<c:import url="/common/facilityPackageTreeList.do"/>
					</section>
				</form>
			</aside>
			
			<section class="splitview__pane splitview__pane--content result-panel" aria-label="검색 결과">
				<h1 class="page-content__heading">다발TM현황</h1>
				<%-- data-grid : 결과 리스트 뷰 --%>
				<div class="result-panel__body" id="_VIEW_MULTIPLE_TMS_LIST">
					<%-- 조회 리스트 부분 : /detail/multipleTMStats_list.jsp --%>
				</div>
			</section>
		</section>
	</div>
</main>

<%-- 리스트의 상세보기 팝업 --%>
<div class="modal fade" tabindex="-1" id="multTMDetailBox">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
		<div class="modal-content" id="multTMDetail"></div>
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

	<%-- 검색 결과 리스트 --%>

	function fnMultipleTmsSearch() {
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

		$.ajax({
			type: "post",
			url: "/tmStatus/multipleTMStatsList.do",
			data: $("#form_search_multiple_tms").serialize(),
			dataType: "html",
			beforeSend: function () {
				$("#loadingBar").css("display", "");
			},
			success: function (data) {
				$("#_VIEW_MULTIPLE_TMS_LIST").html(data);
				$("#_VIEW_RESULT_SHOW").removeClass('d-none');
				$("#loadingBar").css("display", "none");
			},
			error: function (request, status, error) {
				console.log("code:" + request.status + "\n error:" + error);
			},
			complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}

	function sortTable(colNum, columnId) {
		var currentPage = parseInt($("#currentPage").val());
		var element = document.getElementById(colNum);
		var sortCheck = element.className;

		if (sortCheck === "sort icon-up") {
			$.ajax({
				type: "get",
				url: "/tmStatus/multipleTMStatsList.do?pageIndex=" + currentPage + "&listOrderVal=" + columnId + "&listOrder=ASC"
				, data: $("#form_search_multiple_tms").serialize()
				, dataType: "html"
				, beforeSend: function () {
					$("#loadingBar").css("display", "");
				}
				, success: function (data) {
					$("#_VIEW_MULTIPLE_TMS_LIST").html(data);
					$("#_VIEW_RESULT_SHOW").removeClass('d-none');

					var element = document.getElementById(colNum);
					var sortCheck = element.className;

					$(".icon-down").removeClass("active");
					$(".icon-up").removeClass("active");
					$(".sort").removeClass("icon-down");
					$(".sort").addClass("icon-up");
					element.className = "sort icon-down active";
				},
				error: function (request, status, error) {
					console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
				},
				complete: function () {
					$("#loadingBar").css("display", "none");
				}
			});
		} else {
			$.ajax({
				type: "get",
				url: "/tmStatus/multipleTMStatsList.do?pageIndex=" + currentPage + "&listOrderVal=" + columnId + "&listOrder=DESC"
				, data: $("#form_search_multiple_tms").serialize()
				, dataType: "html"
				, beforeSend: function () {
					$("#loadingBar").css("display", "");
				}
				, success: function (data) {
					$("#_VIEW_MULTIPLE_TMS_LIST").html(data);
					$("#_VIEW_RESULT_SHOW").removeClass('d-none');
					$(".icon-down").removeClass("active");
					$(".icon-up").removeClass("active");
					$(".sort").removeClass("icon-down");
					$(".sort").addClass("icon-up");
					element.className = "sort icon-up";
				},
				error: function (request, status, error) {
					console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
				},
				complete: function () {
					$("#loadingBar").css("display", "none");
				}
			});
		}
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

		$.ajax({
			type: "get",
			url: "/tmStatus/multipleTMStatsList.do?pageIndex=" + currentPage
			, data: $("#form_search_multiple_tms").serialize()
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#_VIEW_MULTIPLE_TMS_LIST").html(data);
				$("#_VIEW_RESULT_SHOW").removeClass('d-none');
			},
			error: function (request, status, error) {
				console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
			},
			complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}

	<%-- 리스트의 다발 TM현황 상세정보 팝업 --%>

	function showDetail(row) {
		// active class
		$("._TR_MULTIPLE_TMS").removeClass("active");
		$(row).addClass("active");

		var requestNo = $(row).attr("data-facility-no");

		$.ajax({
			url: "/tmStatus/multipleTMStatsDetail.do",
			type: "POST",
			data: {requestNo: requestNo},
			dataType: "html",
			beforeSend: function () {
				$("#loadingBar").css("display", "");
			},
			success: function (data) {
				$("#multTMDetail").html(data);
			},
			complete: function () {
				$('#multTMDetailBox').bPopup({
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

	function fnDetailPageMove(f) {
		var detailCurrentPage = parseInt($("#detailCurrentPage").val());
		var requestNo = $("#itemNo").val();

		if (f === 'P') {
			if (detailCurrentPage === 1) {
				alert("처음 페이지입니다.");
				return false;
			}

			detailCurrentPage = detailCurrentPage - 1;
		} else if (f === 'N') {
			if (detailCurrentPage === totalPages) {
				alert("마지막 페이지입니다.");
				return false;
			}

			detailCurrentPage = detailCurrentPage + 1;
		} else if (f === 'M') {
			if (detailCurrentPage > totalPages) {
				alert("마지막 페이지는 " + totalPages + "입니다. 이 페이지를 초과할 수 없습니다.");
				$("#detailCurrentPage").val(totalPages);
				return false;
			}
		}

		$("#detailCurrentPage").val(detailCurrentPage);

		$.ajax({
			type: "get",
			url: "/tmStatus/multipleTMStatsDetail.do?pageIndex=" + detailCurrentPage
			, data: {requestNo: requestNo}
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#multTMDetail").html(data);
			},
			error: function (request, status, error) {
				console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
			},
			complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}

	$(function () {
		setDate();
		fnMultipleTmsSearch();
	});
</script>