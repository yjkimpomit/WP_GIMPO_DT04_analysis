<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<main class="winbox-layout page-content">
	<div class="page-content__placeholder">
		<div class="splitview">
			<aside class="splitview__pane splitview__pane--sidebar" aria-label="정보 검색">

				<!-- 검색영역 -->
				<form class="filter-panel" id="form_search_result_chart" method="post" autocomplete="off">
					<div class="filter-panel__header">
						<span class="filter-panel__title">검색</span>
						<button class="filter-panel__toggle" 
								type="button"
								aria-label="정보 검색 접기" 
								aria-expanded="true" 
								aria-controls="filter-panel-fields"></button>
					</div>
					<div class="filter-panel__fields" id="filter-panel-fields">

						<!-- form-field 단위로 반복 -->
						<input type="hidden" id="ColList" name="ColList" value=""/>

						<div class="form-field">
							<label class="form-label" for="checkNo1">점검번호</label>
							<input class="form-control" type="text" id="checkNo1" name="checkListNo"/>
						</div>

						<div class="form-field">
							<label class="form-label" for="equipNoOption">설비번호</label>
							<input class="form-control search-icon" id="equipNoOption" name="equipNo" onclick="searchFacilityPopup($(this));">
							<input class="form-control" type="text" value="" id="equipNoInput" disabled="" aria-label="선택된 설비번호">
						</div>
						
						<!-- <fieldset class="form-field">
							<legend class="form-label">이상점검결과</legend>
							<div class="form-field__content">
								<label class="form-choice">
									<input type="checkbox" name="abnormal-inspection-result" value="true">
								</label>
							</div>
						</fieldset> -->

						<div class="form-field">
							<legend class="form-label">이상점검결과</legend>
							<div class="form-field__content">
								<label class="form-choice">
									<input type="checkbox" value="" id="chkAbnormalResult" value="1"/>
									<span>이상점검결과 선택</span>
								</label>
							</div>
						</div>

						<div class="form-field">
							<label class="form-label" for="maintDeptOption">*정비부서</label>
							<input class="form-control search-icon" id="maintDeptOption" name="workDeptNo" onclick="searchmainDeptTreePopup($(this));">
							<input class="form-control" type="text" value="" id="maintDeptInput" disabled="" aria-label="선택된 정비부서">
						</div>

						<div class="form-field">
							<label class="form-label" for="designDeptOption">설계부서</label>
							<input class="form-control search-icon" id="designDeptOption" name="planDeptNo" onclick="searchdesignDeptTreePopup($(this));">
							<input class="form-control" type="text" value="" id="designDeptInput" disabled="" aria-label="선택된 설계부서">
						</div>

						<fieldset class="form-field">
							<legend class="form-label">점검기간</legend>

							<div class="form-control-group">
								<label>
									<span class="visually-hidden">점검 시작일</span>
									<input type="date" class="form-control" id="inspectorPeriodStart" name="searchPeriodStart">
								</label>

								<label>
									<span class="visually-hidden">점검 종료일</span>
									<input type="date" class="form-control" id="inspectorPeriodEnd" name="searchPeriodEnd">
								</label>
							</div>
						</fieldset>

						<div class="form-field">
							<label class="form-label" for="inspectorOption">점검자</label>
							<input class="form-control search-icon" id="inspectorOption" name="checkBy" onclick="searchItemPopup($(this));">
							<input class="form-control" type="text" value="" id="inspectorInput" disabled="" aria-label="선택된 점검자">
						</div>

						<div class="form-field">
							<label class="form-label" for="inspectorTypeOption">점검종류</label>
							<input class="form-control search-icon" id="inspectorTypeOption" name="checkGbn" onclick="searchResultPopup($(this));">
							<input class="form-control" type="text" value="" id="inspectorTypeInput" disabled="" aria-label="선택된 점검종류">
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

					<!-- 검색버튼 -->
					<div class="filter-panel__actions">
						<button type="button" class="button button--primary" onclick="fnResultChartSearch()">검색</button>
					</div>
				</form>
			
			</aside>
			<section class="splitview__pane splitview__pane--content result-panel" aria-label="검색 결과">
				<h1 class="page-content__heading">점검 결과(chart)</h1>
				
				<%-- data-grid : 결과 리스트 뷰 --%>
				<div class="result-panel__body">
					<div class="splitview panel-split-layout panel-split-layout--two-to-one">
						<aside class="splitview__pane splitview__pane--sidebar panel-split-layout__sidebar" aria-label="조회리스트">

							<section class="panel-split-layout__group panel-split-layout__group--primary" id="_VIEW_RESULT_CHART_LIST" aria-label="점검결과 리스트">
								<%-- 조회 리스트 : /detail/result_chart_list.jsp --%>
							</section>

							<section class="panel-split-layout__group panel-split-layout__group--secondary" id="_VIEW_RESULT_CHART_KIND_LIST" aria-label="점검종류 리스트">
								<%-- 조회결과의 점검종류 리스트 : /detail/result_chart_kind_list.jsp --%>

							</section>

						</aside>

						<div class="splitview__pane splitview__pane--content panel-split-layout__content" role="region" aria-label="점검내용">
							<section class="panel-split-layout__group panel-split-layout__group--primary" id="_VIEW_RESULT_CHART_DETAIL_LIST" aria-label="점검내용 리스트">
								<%-- 조회결과의 점검내용 리스트 : /detail/result_chart_detail_list.jsp --%>

							</section>

						</section>

					</div>
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

    function fnResultChartSearch() {
        var stval = "";
        var endval = "";

        //조회 시작일
        stval = document.getElementById("inspectorPeriodStart").value;
        //조회 종료일
        endval = document.getElementById("inspectorPeriodEnd").value;

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

        $("#_VIEW_RESULT_CHART_KIND_LIST").html('');
        $("#_VIEW_RESULT_CHART_DETAIL_LIST").html('');

        $.ajax({
            type: "post"
            , url: "/prevention/resultChartList.do"
            , data: $("#form_search_result_chart").serialize()
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#_VIEW_RESULT_CHART_LIST").html(data);
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

    <%-- 상세내용 리스트 --%>

    function fnResultDetailView(row) {
        var requestNo = $(row).attr('data-request-no');

        $("._TR_RESULT_DATA").removeClass("active");
        $(row).addClass("active");

        <%-- 점검종류 리스트 --%>
        $.ajax({
            type: "post"
            , url: "/prevention/resultChartKindList.do"
            , data: {requestNo: requestNo}
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#_VIEW_RESULT_CHART_KIND_LIST").html(data);
                $("#_VIEW_RESULT_CHART_DETAIL_LIST").html('');
            }
            , error: function (request, status, error) {
                console.log("code:" + request.status + "\n error:" + error);
            }
            , complete: function () {
                $("#loadingBar").css("display", "none");
            }
        });
    }

    function fnChartDetailView(row) {
        var requestNo = $(row).attr('data-request-no');

        $("._TR_RESULT_KIND").removeClass("active");
        $(row).addClass("active");

        <%-- 점검내용 리스트 --%>
        $.ajax({
            type: "post"
            , url: "/prevention/resultChartDetailList.do"
            , data: {requestNo: requestNo}
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#_VIEW_RESULT_CHART_DETAIL_LIST").html(data);
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
            , url: "/prevention/resultChartList.do?pageIndex=" + currentPage
            , data: $("#form_search_result_chart").serialize()
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#_VIEW_RESULT_CHART_LIST").html(data);
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
        fnResultChartSearch();
    });
</script>