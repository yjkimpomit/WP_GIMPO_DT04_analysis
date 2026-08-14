<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="title-box">
    <h3 class="title02">이상점검 결과</h3>
</div>

<!-- 검색영역 -->
<div class="search-box">

    <form id="form_search_abnormal_results" method="post" autocomplete="off">

        <input type="hidden" id="ColList" name="ColList" value=""/>

        <div class="row">
            <fieldset class="col-md-6 col-lg-6 col-xxl-3">
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

            <fieldset class="col-md-6 col-lg-6 col-xxl-3">
                <legend class="form-label" id="dateRangePicker">점검일자</legend>
                <div class="row g-2 period-box">
                    <div class="col">
                        <label class="visually-hidden" for="inspectorPeriodStart">시작일</label>
                        <input type="date" class="form-control" name="searchPeriodStart" id="inspectorPeriodStart">
                    </div>
                    <div class="col">
                        <span class="form-control-plaintext">~</span>
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="inspectorPeriodEnd">종료일</label>
                        <input type="date" class="form-control" name="searchPeriodEnd" id="inspectorPeriodEnd">
                    </div>
                </div>
            </fieldset>

            <fieldset class="col-md-6 col-lg-auto col-xl-3 col-xxl-3">
                <legend class="form-label" id="result">점검결과</legend>
                <div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="checkStatus" value="X(불량)" id="category01" checked>
                        <label class="form-check-label" for="category01">
                            불량
                        </label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="checkStatus" value="" id="category02">
                        <label class="form-check-label" for="category02">
                            전체
                        </label>
                    </div>
                </div>
            </fieldset>

            <fieldset class="col-md-6 col-lg-4 col-xl-3 col-xxl-3">
                <legend class="form-label" id="maintenanceDept">정비부서</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="maintDeptOption">정비부서 검색</label>
                        <input class="form-control search-icon" id="maintDeptOption" name="deptNo" onclick="searchmainDeptTreePopup($(this));">
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="maintDeptInput">정비부서</label>
                        <input class="form-control" type="text" value="" id="maintDeptInput" disabled="">
                    </div>
                </div>
            </fieldset>

            <fieldset class="col-md-6 col-lg-4 col-xl-3 col-xxl-3">
                <legend class="form-label" id="woNo">W/O No</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="woNoOption">W/O No 검색</label>
                        <input class="form-control search-icon" id="woNoOption" name="woNO" onclick="searchWoTreePopup($(this));">
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="woNoInput">W/O No</label>
                        <input class="form-control" type="text" value="" id="woNoInput" disabled="">
                    </div>
                </div>
            </fieldset>

            <div class="col-md col-lg col-xl-3 col-xxl-3">
                <label class="form-label" for="inspectorClass">점검구분</label>
                <select class="form-select" id="inspectorClass" name="checkTypeNm">
                    <option value="">----------------------------------</option>
                    <option value="일반예방점검">일반예방점검</option>
                    <option value="오일점검">오일점검</option>
                    <option value="오일분석">오일분석</option>
                    <option value="상태기반예방점검">상태기반예방점검</option>
                </select>
            </div>

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

            <fieldset class="col-md-6 col-lg col-xxl">
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

            <div class="col col-md-auto">
                <button type="button" class="btn btn-primary" onclick="fnAbnormalResultsSearch()">
                    <span class="icon icon-search"></span>
                    <span>검색</span>
                </button>
            </div>
        </div>
    </form>

</div>

<%-- data-grid : 결과 리스트 뷰 --%>
<div id="_VIEW_ABNORMAL_RESULTS_LIST" class="flex-fill-rest">
    <%-- 조회 리스트 부분 : /detail/abnormalResults_list.jsp --%>
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

    function fnAbnormalResultsSearch() {
        var stval = "";
        var endval = "";

        //조회 시작일
        stval = document.getElementById("inspectorPeriodStart").value;
        //조회 종료일
        endval = document.getElementById("inspectorPeriodEnd").value;

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
            , url: "/prevention/abnormalResultsList.do"
            , data: $("#form_search_abnormal_results").serialize()
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#_VIEW_ABNORMAL_RESULTS_LIST").html(data);
            }
            , error: function (request, status, error) {
                console.log("code:" + request.status + "\n error:" + error);
            }, complete: function () {
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
            , url: "/prevention/abnormalResultsList.do?pageIndex=" + currentPage
            , data: $("#form_search_abnormal_results").serialize()
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#_VIEW_ABNORMAL_RESULTS_LIST").html(data);
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
        fnAbnormalResultsSearch();
    });
</script>