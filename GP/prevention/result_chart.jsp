<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="title-box">
    <h3 class="title02">점검 결과(chart)</h3>
</div>

<!-- 검색영역 -->
<div class="search-box">
    <form id="form_search_result_chart" method="post" autocomplete="off">

        <input type="hidden" id="ColList" name="ColList" value=""/>

        <div class="row">
            <div class="col-md-6 col-lg-4 col-xxl-2">
                <label class="form-label" for="checkNo1">점검번호</label>
                <input class="form-control" type="text" id="checkNo1" name="checkListNo"/>
            </div>

            <fieldset class="col-md-6 col-lg-4 col-xxl-2">
                <legend class="form-label" id="equipNo">설비번호</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="equipNoOption">설비번호 검색</label>
                        <input class="form-control search-icon" id="equipNoOption" name="equipNo" onclick="searchFacilityPopup($(this));">
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="equipNoInput">설비번호</label>
                        <input class="form-control" type="text" value="" id="equipNoInput" disabled="">
                    </div>
                </div>
            </fieldset>

            <div class="col-md-6 col-lg-4 col-xxl-2">
                <span class="form-label">이상점검결과</span>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="" id="chkAbnormalResult" value="1"/>
                    <label class="form-check-label" for="chkAbnormalResult">이상점검결과 선택</label>
                </div>
            </div>

            <fieldset class="col-md-6 col-lg-4 col-xxl-3">
                <legend class="form-label" id="maintDept">*정비부서</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="maintDeptOption">정비부서 검색</label>
                        <input class="form-control search-icon" id="maintDeptOption" name="workDeptNo" onclick="searchmainDeptTreePopup($(this));">
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="maintDeptInput">정비부서</label>
                        <input class="form-control" type="text" value="" id="maintDeptInput" disabled="">
                    </div>
                </div>
            </fieldset>

            <fieldset class="col-md-6 col-lg-4 col-xxl-3">
                <legend class="form-label" id="designDept">설계부서</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="designDeptOption">설계부서 검색</label>
                        <input class="form-control search-icon" id="designDeptOption" name="planDeptNo" onclick="searchdesignDeptTreePopup($(this));">
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="designDeptInput">설계부서</label>
                        <input class="form-control" type="text" value="" id="designDeptInput" disabled="">
                    </div>
                </div>
            </fieldset>

            <fieldset class="col-md-6 col-lg-4 col-xxl-3">
                <legend class="form-label" id="inspectorPeriod">점검기간</legend>
                <div class="row g-2 period-box">
                    <div class="col">
                        <label class="visually-hidden" for="inspectorPeriodStart">시작일</label>
                        <input type="date" class="form-control" name="searchPeriodStart" id="inspectorPeriodStart">
                    </div>
                    <div class="col-auto">
                        <span class="form-control-plaintext text-center">~</span>
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="inspectorPeriodEnd">종료일</label>
                        <input type="date" class="form-control" name="searchPeriodEnd" id="inspectorPeriodEnd">
                    </div>
                </div>
            </fieldset>

            <fieldset class="col-md-6 col-lg-4 col-xxl-3">
                <legend class="form-label" id="inspector">점검자</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="inspectorOption">점검자 검색</label>
                        <input class="form-control search-icon" id="inspectorOption" name="checkBy" onclick="searchItemPopup($(this));">
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="inspectorInput">점검자</label>
                        <input class="form-control" type="text" value="" id="inspectorInput" disabled="">
                    </div>
                </div>
            </fieldset>

            <fieldset class="col-md-6 col-lg-4 col-xxl-3">
                <legend class="form-label" id="inspectorType">점검종류</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="inspectorTypeOption">점검종류 검색</label>
                        <input class="form-control search-icon" id="inspectorTypeOption" name="checkGbn" onclick="searchResultPopup($(this));">
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="inspectorTypeInput">점검종류</label>
                        <input class="form-control" type="text" value="" id="inspectorTypeInput" disabled="">
                    </div>
                </div>
            </fieldset>

            <div class="col-md col-lg col-xxl">
                <label class="form-label" for="inspectorClass">점검구분</label>
                <select class="form-select" id="inspectorClass" name="checkTypeNm">
                    <option value="">----------------------------------</option>
                    <option value="일반예방점검">일반예방점검</option>
                    <option value="오일점검">오일점검</option>
                    <option value="오일분석">오일분석</option>
                    <option value="상태기반예방점검">상태기반예방점검</option>
                </select>
            </div>

            <div class="col col-md-auto">
                <button type="button" class="btn btn-primary" onclick="fnResultChartSearch()">
                    <span class="icon icon-search"></span>
                    <span>검색</span>
                </button>
            </div>
        </div>
    </form>
</div>

<%-- data-grid : 조회결과 리스트 뷰 --%>
<div class="row">
    <div class="col-xl-9">
        <div id="_VIEW_RESULT_CHART_LIST">
            <%-- 조회 리스트 : /detail/result_chart_list.jsp --%>
        </div>

        <div id="_VIEW_RESULT_CHART_KIND_LIST">
            <%-- 조회결과의 점검종류 리스트 : /detail/result_chart_kind_list.jsp --%>
        </div>
    </div>
    <div class="col-xl-3">
        <div id="_VIEW_RESULT_CHART_DETAIL_LIST" class="h-100">
            <%-- 조회결과의 점검내용 리스트 : /detail/result_chart_detail_list.jsp --%>
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