<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="title-box">
    <h3 class="title02">Red Tag 발행</h3>
</div>
<!-- 검색영역 -->
<div class="search-box">
    <form id="form_search_issus_request" method="post" autocomplete="off">

        <input type="hidden" id="ColList" name="ColList" value=""/>

        <div class="row">
            <fieldset class="col-md-12">
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

            <fieldset class="col-md-6 col-lg-4 col-xxl-3">
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

            <fieldset class="col-md-6 col-lg-4 col-xxl-3">
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

            <fieldset class="col-md-6 col-lg-4 col-xxl-3">
                <legend class="form-label" id="opDept">운전부서</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="opDeptOption">운전부서 검색</label>
                        <input class="form-control search-icon" id="opDeptOption" name="operDeptNo" onclick="searchopDeptTreePopup($(this));">
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="opDeptInput">운전부서명</label>
                        <input class="form-control" type="text" value="" id="opDeptInput" disabled="">
                    </div>
                </div>
            </fieldset>

            <fieldset id="formMainDept" class="col-md-6 col-lg-4 col-xxl-3">
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

            <div class="col-md-6 col-lg-4 col-xxl-3" id="orderTypeArea">
                <label class="form-label" for="orderType">오더유형</label>
                <select class="form-select" id="orderType" name="woCategoryNm">
                    <option value="" selected>오더유형 선택</option>
                    <option value="경상오더">경상오더</option>
                    <option value="공사오더">공사오더</option>
                </select>
            </div>

            <div class="col-md-6 col-lg-4 col-xxl-3">
                <label class="form-label" for="orderNo">오더 번호</label>
                <input class="form-control" type="text" id="orderNo" value="" name="woNo" placeholder="오더번호 입력">
            </div>

            <div class="col-md-12 col-lg col-xxl-3">
                <label class="form-label" for="orderName">오더명</label>
                <input class="form-control" type="text" id="orderName" value="" name="woDesc" placeholder="오더명 입력">
            </div>

            <div class="col-md col-lg-auto col-xxl" id="redTagInc" style="display:none">
                <label class="form-label" for="redtagIncludeOrder">Red Tag 포함</label>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" onclick="toggleCheckboxValue()" id="redtagIncludeOrder" name="isRedTag" value="0">
                    <label class="form-check-label" for="redtagIncludeOrder">Red Tag가 포함된 작업오더</label>
                </div>
            </div>

            <div class="col col-md-auto">
                <button type="button" class="btn btn-primary" onclick="fnIssusRequestSearch()">
                    <span class="icon icon-search"></span>
                    <span>검색</span>
                </button>
            </div>
        </div>
    </form>
</div>

<div class="row" id="issusList">
    <div class="col-12" id="issusOrderList">
    </div>

    <div class="col-xl-8" id="issusWorkOrderList">
    </div>

    <div class="col-xl-4" id="issusWorkOrderOutputList">
    </div>
</div>

<script>
    function toggleCheckboxValue() {
        var checkbox = document.getElementById("redtagIncludeOrder");

        // 체크박스가 선택되면 value를 1로, 해제되면 0으로 변경
        if (checkbox.checked) {
            checkbox.value = "1";
        } else {
            checkbox.value = "0";
        }
    }

    function fnIssusRequestSearch() {
        //active 클래스 제거
        $(".table-responsive > table > tbody > tr").removeClass("active");
        $.ajax({
            type: "post"
            , url: "/redtag/issusRequestList.do"
            , data: $("#form_search_issus_request").serialize()
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#issusOrderList").html(data);
                $('#issusWorkOrderList').css("display", "none");
                $('#issusWorkOrderOutputList').css("display", "none");
                $('.alert').css("display", "none");
            }
            , error: function (request, status, error) {
                console.log("code:" + request.status + "\n error:" + error);
            },
            complete: function () {
                $("#loadingBar").css("display", "none");
            }
        });
    }

    function redtagOrderDetail(row) {
        //active 클래스 제거
        $("#tblWorkingOrder > tbody > tr").removeClass("active");
        var requestNo = $(row).attr("data-request-no");

        $(row).addClass("active");

        $.ajax({
            type: "post"
            , url: "/redtag/orderRequestDetail.do"
            , data: {requestNo: requestNo}
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#issusWorkOrderList").html(data);
                $('#issusWorkOrderList').css("display", "block");
                $('#issusWorkOrderOutputList').css("display", "none");
            }
            , error: function (request, status, error) {
                console.log("code:" + request.status + "\n error:" + error);
            },
            complete: function () {
                $("#loadingBar").css("display", "none");
            }
        });
    }

    function redtagWorkOrderDetail(row) {
        //active 클래스 제거
        $("#tblWorkOrderDesign > tbody > tr").removeClass("active");
        var requestNo = $(row).attr("data-request-no");

        $(row).addClass("active");

        $.ajax({
            type: "post"
            , url: "/redtag/workOrderRequestDetail.do"
            , data: {requestNo: requestNo}
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#issusWorkOrderOutputList").html(data);
                $('#issusWorkOrderOutputList').css("display", "block");
            }
            , error: function (request, status, error) {
                console.log("code:" + request.status + "\n error:" + error);
            },
            complete: function () {
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
            , url: "/redtag/issusRequestList.do?pageIndex=" + currentPage
            , data: $("#form_search_issus_request").serialize()
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#issusOrderList").html(data);
                $('#issusWorkOrderOutputList').css("display", "none");
                $('.alert').css("display", "none");
            }
            , error: function (request, status, error) {
                console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
            },
            complete: function () {
                $("#loadingBar").css("display", "none");
            }
        });
    }

    $(function () {
        $("#form_search_issus_request input:radio[name=searchType]").change(function () {
            var searchTypeVal = $(this).val();

            var redtagForm = $('#form_search_issus_request');
            var formInput = redtagForm.find('input:not([type="radio"])');
            var redTagInc = $('#form_search_issus_request #redTagInc');
            var orderTypeArea = $('#form_search_issus_request #orderTypeArea');
            var mainDiv = $('#form_search_issus_request #formMainDept');   //정비부서

            if (searchTypeVal === '2') {
                formInput.val('');

                //정비부서 안보이게 설정
                mainDiv.hide();
                orderTypeArea.hide();
                redTagInc.show();

                var checkbox = $("#redtagIncludeOrder");
                checkbox.prop("checked", false);  // 체크박스를 해제
                checkbox.val("0");
            } else {
                formInput.val('');

                redTagInc.hide();
                mainDiv.show();
                orderTypeArea.show();
            }
        });
    });
</script>