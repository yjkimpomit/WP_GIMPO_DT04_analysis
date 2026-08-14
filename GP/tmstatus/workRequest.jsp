<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- TM현황 > 작업요청확정 탭 메뉴 --%>
<main class="winbox-layout page-content tm-confirmation-page">
    <div class="page-content__placeholder">
        <div class="splitview">
            <aside class="splitview__pane splitview__pane--sidebar" aria-label="정보 검색">

                <!-- 검색영역 -->
                <form class="filter-panel" id="form_search_work_request" method="post" autocomplete="off">
                    <div class="filter-panel__header">
                        <span class="filter-panel__title">검색</span>
                        <button class="filter-panel__toggle" type="button"
                                aria-label="정보 검색 접기" aria-expanded="true"></button>
                    </div>
                    <div class="filter-panel__fields">
                        <input type="hidden" id="ColList" name="ColList" value=""/>
                        
                        <label class="form-field">
                            <span class="form-label">요청유형</span>
                            <select class="form-select" id="reqType" name="noticeType">
                                <option value="">----------------------------------</option>
                                <option value="TM">TM</option>
                                <option value="설비개선">설비개선</option>
                                <option value="NCR">NCR</option>
                                <option value="CAR">CAR</option>
                                <option value="유사사고방지">유사사고방지</option>
                            </select>
                        </label>
                        
                        <!-- 감독부서 유형 -->
                        <div class="form-field">
                            <label class="form-label" for="supvDeptOption">감독부서</label>
                            <input class="form-control search-icon" id="supvDeptOption" name="dept" onclick="searchReqTreePopup($(this));"/>
                            <input class="form-control" type="text" value="" id="supvDeptInput" disabled="" aria-label="선택된 감독부서명" readonly>
                        </div>
                        
                        <div class="form-field">
                            <span class="form-label">요청기간</span>
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
                        </div>
                        
                        <div class="form-field">
                            <label class="form-label" for="reqDeptOption">요청부서</label>
                            <input class="form-control" id="reqDeptOption" name="reqDept" onclick="searchReqDeptTreePopup($(this));"/>
                            <input class="form-control" type="text" value="" id="reqDeptInput" disabled="" aria-label="선택된 요청부서명" readonly>
                        </div>
                        
                    </div>
                    <div class="filter-panel__actions">
                        <button type="button" class="button button--primary" onclick="fnWorkRequestSearch();">검색</button>
                    </div>
                </form>

            
            </aside>
            <section class="splitview__pane splitview__pane--content result-panel" aria-label="검색 결과">
                <h1 class="page-content__heading">작업요청확정</h1>
                
                <%-- data-grid : 결과 리스트 뷰 --%>
                <div class="result-panel__body" id="_VIEW_WORK_REQUEST_LIST">
                    <%-- 조회 리스트 부분 : /detail/workRequest_list.jsp --%>
                </div>
            </section>
        </div>
    </div>

<%-- 리스트의 상세보기 팝업 --%>
<div class="modal fade" tabindex="-1" id="requestDetailBox">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
        <div class="modal-content" id="requestDetail"></div>
    </div>
</div>
</main>

<script>
	var stval = "";
	var endval = "";

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

	function fnWorkRequestSearch() {
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

		$.ajax({
			type: "post"
			, url: "/tmStatus/workRequestList.do"
			, data: $("#form_search_work_request").serialize()
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#_VIEW_WORK_REQUEST_LIST").html(data);
				$("#_VIEW_RESULT_SHOW").removeClass('d-none');
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

		$.ajax({
			type: "get"
			, url: "/tmStatus/workRequestList.do?pageIndex=" + currentPage
			, data: $("#form_search_work_request").serialize()
			, dataType: "html"
			, beforeSend: function () {
				$("#loadingBar").css("display", "");
			}
			, success: function (data) {
				$("#_VIEW_WORK_REQUEST_LIST").html(data);
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

	<%-- 리스트의 요청확정 상세정보 팝업 --%>

	function showDetail(row, reqNo, deptNo) {
		// active class
		$("._TR_WORK_REQUEST").removeClass("active");
		$(row).addClass("active");

		var requestNo = $(row).attr("data-request-no");
		var reqNo = reqNo;
		var deptNo = deptNo;

		//ajax detail deptNo
		var setData = "";
		$.ajax({
			url: "/tmStatus/workRequestDetail.do",
			type: "POST",
			data: {requestNo: requestNo, reqNo: reqNo, deptNo: deptNo},
			dataType: "html",
			beforeSend: function () {
				$("#loadingBar").css("display", "");
			},
			success: function (data) {
				setData = data;
			},
			complete: function () {
				$("#requestDetail").html(setData);

				$("#requestDetailBox").bPopup({
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
				console.log("code:" + request.status + "\n error:" + error);
			}
		});
	}

	$(function () {
		setDate();
		fnWorkRequestSearch();
	});

</script>