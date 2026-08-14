<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="title-box">
    <h3 class="title02">정비비용 고장경향 분석</h3>
</div>

<!-- 검색영역 -->
<div class="search-box">
    <form id="form_search_cost_failure_trends" method="post" autocomplete="off">
        <input type="hidden" id="chkDate" name="chkDate" value="1"/>
        <div class="row">
            <fieldset class="col-md-6 col-lg-3 col-xxl-2 col-xxxl-2">
                <legend class="form-label" id="serachPeriod">검색 기간</legend>
                <div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" onclick="toggleDateSelection()" name="serachPeriod" id="rbSerachPeriod_1" checked>
                        <label class="form-check-label" for="rbSerachPeriod_1">
                            연도별
                        </label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" onclick="toggleDateSelection()" name="serachPeriod" id="rbSerachPeriod_2">
                        <label class="form-check-label" for="rbSerachPeriod_2">
                            월별
                        </label>
                    </div>
                </div>
            </fieldset>

            <fieldset class="col-md-6 col-lg-auto col-xxl-3 col-xxxl-3">
                <legend class="form-label" id="dateRangePicker">기간선택</legend>
                <div class="row g-2 period-box" id="setYear">
                    <div class="col">
                        <label class="visually-hidden" for="startPeriod">시작일</label>
                        <select class="form-select" id="startPeriod" name="searchPeriodStart" required>
                            <!-- JavaScript로 동적으로 옵션이 추가됨 -->
                        </select>
                        <input type="month" class="form-control" id="startMonthPeriod" name="searchMonthPeriodStart">
                    </div>
                    <div class="col-auto">
                        <span class="form-control-plaintext text-center">~</span>
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="endPeriod">종료일</label>
                        <select class="form-select" id="endPeriod" name="searchPeriodEnd" required>
                            <!-- JavaScript로 동적으로 옵션이 추가됨 -->
                        </select>
                        <input type="month" class="form-control" id="endMonthPeriod" name="searchMonthPeriodEnd">
                    </div>
                </div>
            </fieldset>

            <!-- 감독부서 유형 -->
            <fieldset class="col-md-6 col-lg-4 col-xxl-3">
                <legend class="form-label" id="supvDept">부서별(감독부서)</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="supvDeptOption">부서 검색</label>
                        <input class="form-control search-icon" id="supvDeptOption" value="" name="deptNo" onclick="searchReqTreePopup($(this));"/>
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="supvDeptInput">감독부서명</label>
                        <input class="form-control" type="text" value="" id="supvDeptInput" disabled="">
                    </div>
                </div>
            </fieldset>

            <div class="col col-md-auto">
                <button type="button" class="btn btn-primary" onclick="fnCostFailureTrendsSearch()">
                    <span class="icon icon-search"></span>
                    <span>검색</span>
                </button>
            </div>
        </div>
    </form>
</div>

<div id="_VIEW_RESULT_SHOW" class="flex-fill-rest d-none">
    <div id="_VIEW_RESULT_DATAS">
        <%-- 조회 리스트 부분 : /detail/costFailureTrends_list.jsp --%>
    </div>

    <!-- data title -->
    <h4 class="title03">조회결과 <small class="chart-info">* 그래프의 포인트에 마우스를 올리면 Raw Data가 나타납니다.</small></h4>

    <div class="chart-box" role="img" aria-label="정비비용-고장경향분석-차트">

    </div>
</div>

<script>
    function populateYearSelect() {
        const currentYear = new Date().getFullYear(); // 현재 연도 가져오기
        const startPeriodSelect = document.getElementById('startPeriod');
        const endPeriodSelect = document.getElementById('endPeriod');

        // 첫 번째 select (현재부터 50년 전까지)
        for (let i = currentYear; i >= currentYear - 50; i--) {
            const option = document.createElement("option");
            option.value = i;
            option.textContent = i;
            startPeriodSelect.appendChild(option);
        }

        // 두 번째 select (현재부터 50년 전까지)
        for (let i = currentYear; i >= currentYear - 50; i--) {
            const option = document.createElement("option");
            option.value = i;
            option.textContent = i;
            endPeriodSelect.appendChild(option);
        }
        // 첫 번쨰 select 현재 년도 기준 10년전 세팅
        var startSelect = document.getElementById("startPeriod");
        for (var i = 0; i < startSelect.options.length; i++) {
            if (startSelect.options[i].text == currentYear - 10) {
                startSelect.selectedIndex = i;
                break;
            }
        }
    }

    function setDate() {
        //날짜 현재날짜 기준 한 달 전 세팅
        var today = new Date();
        var yyyy = today.getFullYear();
        var mm = ("0" + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
        var dd = ("0" + today.getDate()).slice(-2);
        var currentDate = yyyy + "-" + mm + "-" + dd;
        $('#endPeriod').val(currentDate); // 첫 번째 input에 오늘 날짜 설정

        // 두 번째 input 태그 (한 달 전 날짜로 설정)
        today.setMonth(today.getMonth() - 1); // 현재 날짜 기준 한 달 전으로 설정
        var lastMonthDate = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + ("0" + today.getDate()).slice(-2);
        $('#startPeriod').val(lastMonthDate); // 두 번째 input에 한 달 전 날짜 설정
    }

    function setMonth() {
        //날짜 현재날짜 기준 한 달 전 세팅
        var today = new Date();
        var yyyy = today.getFullYear();
        var mm = ("0" + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
        var currentDate = yyyy + "-" + mm;
        $('#endMonthPeriod').val(currentDate); // 첫 번째 input에 오늘 날짜 설정

        // 두 번째 input 태그 (한 달 전 날짜로 설정)
        today.setMonth(today.getMonth() - 12); // 현재 날짜 기준 한 달 전으로 설정
        var lastMonthDate = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2);
        $('#startMonthPeriod').val(lastMonthDate); // 두 번째 input에 한 달 전 날짜 설정
    }

    function toggleDateSelection() {
        // 월별 날짜 선택 (라디오 버튼 id: month)
        if (document.getElementById("rbSerachPeriod_2").checked) {
            $("#startMonthPeriod").css("display", "");
            $("#endMonthPeriod").css("display", "");
            $("#startPeriod").css("display", "none");
            $("#endPeriod").css("display", "none");
            $('#chkDate').val("2");
        }
        // 년도별 날짜 선택 (라디오 버튼 id: year)
        else if (document.getElementById("rbSerachPeriod_1").checked) {
            $("#startMonthPeriod").css("display", "none");
            $("#endMonthPeriod").css("display", "none");
            $("#startPeriod").css("display", "");
            $("#endPeriod").css("display", "");
            $('#chkDate').val("1")
        }
    }

    function fnCostFailureTrendsSearch() {
        var startYear = $('#startPeriod').val();
        var endYear = $('#endPeriod').val();

        if (startYear > endYear) {
            alert("기간을 다시 지정해주세요.");
        } else {
            <%-- 검색 차트 --%>
            $.ajax({
                type: "post"
                , url: "/prevention/costFailureTrendsChart.do"
                , data: $("#form_search_cost_failure_trends").serialize()
                , dataType: "html"
                , beforeSend: function () {
                    $("#loadingBar").css("display", "");
                }
                , success: function (data) {
                    $(".chart-box").html(data);
                }
                , error: function (request, status, error) {
                    console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
                }
                , complete: function () {
                    $("#loadingBar").css("display", "none");
                }
            });

            <%-- 검색 리스트 --%>
            $.ajax({
                type: "post"
                , url: "/prevention/costFailureTrendsList.do"
                , data: $("#form_search_cost_failure_trends").serialize()
                , dataType: "html"
                , success: function (data) {
                    $("#_VIEW_RESULT_DATAS").html(data);
                }
                , error: function (request, status, error) {
                    console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
                }
            });

            $("#_VIEW_RESULT_SHOW").removeClass('d-none');
        }
    }

    $(function () {
        setMonth();
        $("#startMonthPeriod").css("display", "none");
        $("#endMonthPeriod").css("display", "none");
        populateYearSelect();
        fnCostFailureTrendsSearch();
    });
</script>
