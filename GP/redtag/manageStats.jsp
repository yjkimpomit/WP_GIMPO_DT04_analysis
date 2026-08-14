<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="title-box">
    <h3 class="title02">Red Tag 관리대장</h3>
</div>

<!-- 검색영역 -->
<div class="search-box">
    <form id="form_search_manage_request" method="post" autocomplete="off">

        <input type="hidden" id="ColList" name="ColList" value=""/>

        <div class="row">
            <div class="col-md-6 col-lg-4 col-xxl-3 col-xxxl-1" id="redtagStatusArea">
                <label class="form-label" for="redtagStatus">Tag상태</label>
                <select class="form-select" id="redtagStatus" name="redtagStatus">
                    <option value="미회수" selected>미회수</option>
                    <option value="회수">회수</option>
                    <option value="미발행">미발행</option>
                </select>
            </div>
            <fieldset class="col-md-6 col-lg-4 col-xxl-3 col-xxxl-2">
                <legend class="form-label" id="workType">구분</legend>
                <div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="workType_1" name="searchType" value="1" checked>
                        <label class="form-check-label" for="workType_1">
                            W/O
                        </label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="workType_2" name="searchType" value="2">
                        <label class="form-check-label" for="workType_2">
                            기타
                        </label>
                    </div>
                </div>
            </fieldset>

            <fieldset class="col-md-6 col-lg-4 col-xxl-3 col-xxxl-2">
                <legend class="form-label" id="issuer">발행자</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="issuerOption">발행자 검색</label>
                        <input class="form-control search-icon" id="issuerOption" name="printBy" onclick="searchItemPopup($(this));">
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="issuerInput">발행자</label>
                        <input class="form-control" type="text" value="" id="issuerInput" disabled="">
                    </div>
                </div>
            </fieldset>
            <fieldset class="col-md-6 col-lg-4 col-xxl-3 col-xxxl-2">
                <legend class="form-label" id="retriever">회수자</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="retrieverOption">회수자 검색</label>
                        <input class="form-control search-icon" id="retrieverOption" name="returnBy" onclick="searchItemPopup($(this));">
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="retrieverInput">회수자</label>
                        <input class="form-control" type="text" value="" id="retrieverInput" disabled="">
                    </div>
                </div>
            </fieldset>
            <fieldset class="col-md-6 col-lg-4 col-xxl-3 col-xxxl-2">
                <legend class="form-label" id="opDept">운전부서</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="opDeptOption">운전부서 검색</label>
                        <input class="form-control search-icon" id="opDeptOption" name="operDeptNo" onclick="searchopDeptTreePopup($(this));">
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="opDeptInput">운전부서</label>
                        <input class="form-control" type="text" value="" id="opDeptInput" disabled="">
                    </div>
                </div>
            </fieldset>

            <fieldset class="col-md-6 col-lg col-xxl-3 col-xxxl-3">
                <legend class="form-label" id="tagCreatedDate">Tag 작성일</legend>
                <div class="row g-2 period-box">
                    <div class="col">
                        <label class="visually-hidden" for="tagCreatedDateEnd">시작일</label>
                        <input type="date" class="form-control" id="tagCreatedDateStart" name="searchPeriodStart">
                    </div>
                    <div class="col-auto">
                        <span class="form-control-plaintext text-center">~</span>
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="tagCreatedDateEnd">종료일</label>
                        <input type="date" class="form-control" id="tagCreatedDateEnd" name="searchPeriodEnd">
                    </div>
                </div>
            </fieldset>

            <fieldset class="col-md-6 col-lg-4 col-xxl-3 col-xxxl-2">
                <legend class="form-label" id="supervisor">감독자</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="supvorOption">감독자 검색</label>
                        <input class="form-control search-icon" id="supvorOption" name="planBy" onclick="searchItemPopup($(this));">
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="supvorInput">감독자</label>
                        <input class="form-control" type="text" value="" id="supvorInput" disabled="">
                    </div>
                </div>
            </fieldset>
            <fieldset class="col-md-6 col-lg-4 col-xxl-3 col-xxxl-2">
                <legend class="form-label" id="supvDept">감독부서</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="supvDeptOption">감독부서 검색</label>
                        <input class="form-control search-icon" id="supvDeptOption" name="deptNo" onclick="searchReqTreePopup($(this));">
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="supvDeptInput">감독부서명</label>
                        <input class="form-control" type="text" value="" id="supvDeptInput" disabled="">
                    </div>
                </div>
            </fieldset>
            <fieldset id="manageMainDept" class="col-md-6 col-lg-4 col-xxl-3 col-xxxl-2">
                <legend class="form-label" id="maintDept">정비부서</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="maintDeptOption">정비부서 검색</label>
                        <input class="form-control search-icon" id="maintDeptOption" name="workDeptNo" onclick="searchmainDeptTreePopup($(this));">
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="maintDeptInput">정비부서명</label>
                        <input class="form-control" type="text" value="" id="maintDeptInput" disabled="">
                    </div>
                </div>
            </fieldset>
            <div class="col-md col-lg col-xxl">
                <label class="form-label" for="tagNumber">Tag 번호</label>
                <input class="form-control" type="text" id="tagNumber" name="barcodeNo" placeholder="Tag 번호 입력">
            </div>

            <div class="col col-md-auto">
                <button type="button" class="btn btn-primary" onclick="fnManageRequestSearch()">
                    <span class="icon icon-search"></span>
                    <span>검색</span>
                </button>
            </div>
        </div>
    </form>
</div>

<div id="manageList" class="flex-fill-rest">

</div>

<script>
    function setDate() {
        //날짜 현재날짜 기준 한 달 전 세팅
        var today = new Date();
        var yyyy = today.getFullYear();
        var mm = ("0" + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
        var dd = ("0" + today.getDate()).slice(-2);
        var currentDate = yyyy + "-" + mm + "-" + dd;
        $('#tagCreatedDateEnd').val(currentDate); // 첫 번째 input에 오늘 날짜 설정

        // 두 번째 input 태그 (한 달 전 날짜로 설정)
        today.setMonth(today.getMonth() - 1); // 현재 날짜 기준 한 달 전으로 설정
        var lastMonthDate = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + ("0" + today.getDate()).slice(-2);
        $('#tagCreatedDateStart').val(lastMonthDate); // 두 번째 input에 한 달 전 날짜 설정
    }

    $(document).ready(function () {
        //초기 화면 표시시
        setDate();

        $("#form_search_manage_request input:radio[name=searchType]").change(function () {
            var redtagForm = $('#form_search_manage_request');
            var formInput = redtagForm.find('input:not([type="radio"])');
            var mainDiv = $('#manageMainDept');    //정비부서

            if (this.value === '2') {
                formInput.val('');

                //정비부서 안보이게 설정
                setDate();
                mainDiv.hide();
            } else {
                formInput.val('');
                setDate();
                mainDiv.show();
            }
        });
    });

    function fnManageRequestSearch() {
        var stval = "";
        var endval = "";

        //조회 시작일
        stval = document.getElementById("tagCreatedDateStart").value;
        //조회 종료일
        endval = document.getElementById("tagCreatedDateEnd").value;

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
            type: "post"
            , url: "/redtag/manageRequestList.do"
            , data: $("#form_search_manage_request").serialize()
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#manageList").html(data);
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
            , url: "/redtag/manageRequestList.do?pageIndex=" + currentPage
            , data: $("#form_search_manage_request").serialize()
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#manageList").html(data);
            }
            , error: function (request, status, error) {
                console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
            }
            , complete: function () {
                $("#loadingBar").css("display", "none");
            }
        });
    }
</script>