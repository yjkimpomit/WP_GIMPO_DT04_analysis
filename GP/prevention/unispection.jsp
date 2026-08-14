<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="title-box">
    <h3 class="title02">미점검 일정</h3>
</div>

<!-- 검색영역 -->
<div class="search-box">
    <form id="form_search_unispection" method="post" autocomplete="off">

        <input type="hidden" id="ColList" name="ColList" value=""/>

        <div class="row">
            <div class="col-md-4 col-lg-3 col-xxl-3">
                <label class="form-label" for="checkNo1">점검번호</label>
                <input class="form-control" type="text" name="checkListNo" id="checkNo1"/>
            </div>

            <div class="col-md col-lg-3 col-xxl-3">
                <label class="form-label" for="inspectorClass">점검구분</label>
                <select class="form-select" id="inspectorClass" name="checkTypeNm">
                    <option value="">----------------------------------</option>
                    <option value="일반예방점검">일반예방점검</option>
                    <option value="오일점검">오일점검</option>
                    <option value="오일분석">오일분석</option>
                    <option value="상태기반예방점검">상태기반예방점검</option>
                </select>
            </div>

            <fieldset class="col-md-6 col-lg-6 col-xxl-3">
                <legend class="form-label" id="inspectorPlanDate">점검계획일자</legend>
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

            <fieldset class="col-md-6 col-lg-6 col-xxl-3">
                <legend class="form-label" id="maintDept">정비부서</legend>
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

            <fieldset class="col-md-6 col-lg-6 col-xxl-3">
                <legend class="form-label" id="designDept">설계부서</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="designDeptOption">설계부서 검색</label>
                        <input class="form-control search-icon" id="designDeptOption" name="planDeptNo" onclick="searchdesignDeptTreePopup($(this));">
                        <datalist id="designDeptOpt">
                            <option value="부서1"></option>
                            <option value="부서2"></option>
                            <option value="부서3"></option>
                        </datalist>
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="designDeptInput">설계부서</label>
                        <input class="form-control" type="text" value="" id="designDeptInput" disabled="">
                    </div>
                </div>
            </fieldset>

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

            <div class="col-md col-lg">
                <label class="form-label" for="inspectorInterval">점검주기</label>
                <select class="form-select" id="inspectorInterval" name="periodNm">
                    <option value="">----------------------------------</option>
                    <option value="일간">일간</option>
                    <option value="주간">주간</option>
                    <option value="격주">격주</option>
                    <option value="월간">월간</option>
                    <option value="격월">격월</option>
                    <option value="분기">분기</option>
                    <option value="반기">반기</option>
                    <option value="년간">년간</option>
                </select>
            </div>

            <div class="col col-md-auto">
                <button type="button" class="btn btn-primary" onclick="fnUnispectionSearch()">
                    <span class="icon icon-search"></span>
                    <span>검색</span>
                </button>
            </div>
        </div>
    </form>
</div>

<%-- data-grid : 결과 리스트 뷰 --%>
<div id="_VIEW_UNISPECTION_LIST">
    <%-- 조회 리스트 부분 : /detail/unispection_list.jsp --%>
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

    function fnUnispectionSearch() {
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
            , url: "/prevention/unispectionList.do"
            , data: $("#form_search_unispection").serialize()
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#_VIEW_UNISPECTION_LIST").html(data);
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
            , url: "/prevention/unispectionList.do?pageIndex=" + currentPage
            , data: $("#form_search_unispection").serialize()
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#_VIEW_UNISPECTION_LIST").html(data);
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
        fnUnispectionSearch();
    });
</script>