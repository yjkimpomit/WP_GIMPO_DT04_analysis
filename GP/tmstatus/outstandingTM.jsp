<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="title-box">
    <h3 class="title02">미결 TM현황</h3>
</div>

<!-- 검색영역 -->
<div class="search-box">
    <form id="form_search_outstanding_tm" method="post" autocomplete="off">

        <input type="hidden" id="ColList" name="ColList" value=""/>

        <div class="row">
            <!-- 요청 유형 -->
            <div class="col-md-6 col-lg-6 col-xl-5 col-xxl-2">
                <label class="form-label" for="reqType">요청유형</label>
                <select class="form-select" id="reqType" name="noticeType">
                    <option value="">----------------------------------</option>
                    <option value="TM">TM</option>
                    <option value="설비개선">설비개선</option>
                    <option value="NCR">NCR</option>
                    <option value="CAR">CAR</option>
                    <option value="유사사고방지">유사사고방지</option>
                </select>
            </div>
            
            <!-- 감독부서 유형 -->
            <fieldset class="col-md-6 col-lg-6 col-xl-7 col-xxl-3">
                <legend class="form-label" id="supvDept">감독부서</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="supvDeptOption">감독부서 검색</label>
                        <input class="form-control search-icon" id="supvDeptOption" name="dept" onclick="searchReqTreePopup($(this));"/>
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="supvDeptInput">감독부서명</label>
                        <input class="form-control" type="text" value="" id="supvDeptInput" disabled="">
                    </div>
                </div>
            </fieldset>
            
            <!-- 상위 폼 요소 (연관된 인풋 두 개 세트) -->
            <fieldset class="col-md-6 col-lg-6 col-xl-5 col-xxl-4">
                <legend class="form-label" id="reqPeriod">요청기간</legend>
                <div class="row g-2 period-box">
                    <div class="col">
                        <label class="visually-hidden" for="reqPeriodStart">시작일</label>
                        <input type="date" class="form-control" id="reqPeriodStart" name="searchPeriodStart">
                    </div>
                    <div class="col-auto">
                        <span class="form-control-plaintext text-center">~</span>
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="reqPeriodEnd">종료일</label>
                        <input type="date" class="form-control" id="reqPeriodEnd" name="searchPeriodEnd">
                    </div>
                </div>
            </fieldset>

            <fieldset class="col-md col-lg">
                <legend class="form-label" id="reqDept">요청부서</legend>
                <div class="row g-2">
                    <div class="col">
                        <label class="visually-hidden" for="reqDeptOption">요청부서</label>
                        <input class="form-control search-icon" id="reqDeptOption" name="reqDept" onclick="searchReqDeptTreePopup($(this));">
                    </div>
                    <div class="col">
                        <label class="visually-hidden" for="reqDeptInput">요청부서명</label>
                        <input class="form-control" type="text" value="" id="reqDeptInput" disabled="">
                    </div>
                </div>
            </fieldset>

            <div class="col-md-auto col-lg-auto">
                <button type="button" class="btn btn-primary" onclick="fnOutstandingTMSearch()">
                    <span class="icon icon-search"></span>
                    <span>검색</span>
                </button>
            </div>

        </div>
    </form>
</div>

<%-- data-grid : 결과 리스트 뷰 --%>
<div id="_VIEW_OUTSTANDING_LIST" class="flex-fill-rest">
    <%-- 조회 리스트 부분 : /detail/outstandingTM_list.jsp --%>
</div>

<%-- 리스트의 상세보기 팝업 --%>
<div class="modal fade" tabindex="-1" id="outstandingTMDetailBox">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
        <div class="modal-content" id="outstandingTMDetail">
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
        $('#reqPeriodEnd').val(currentDate); // 첫 번째 input에 오늘 날짜 설정

        // 두 번째 input 태그 (한 달 전 날짜로 설정)
        today.setMonth(today.getMonth() - 1); // 현재 날짜 기준 한 달 전으로 설정
        var lastMonthDate = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + ("0" + today.getDate()).slice(-2);
        $('#reqPeriodStart').val(lastMonthDate); // 두 번째 input에 한 달 전 날짜 설정
    }

    <%-- 검색 결과 리스트 --%>

    function fnOutstandingTMSearch() {
        var stval = "";
        var endval = "";

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
            , url: "/tmStatus/outstandingTMList.do"
            , data: $("#form_search_outstanding_tm").serialize()
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#_VIEW_OUTSTANDING_LIST").html(data);
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
            , url: "/tmStatus/outstandingTMList.do?pageIndex=" + currentPage
            , data: $("#form_search_outstanding_tm").serialize()
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#_VIEW_OUTSTANDING_LIST").html(data);
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

    <%-- 상세정보 팝업 --%>

    function showDetail(row, reqNo, deptNo) {
        // active class
        $("._TR_OUTSTANDING_TM").removeClass("active");
        $(row).addClass("active");

        var requestNo = $(row).attr("data-request-no");
        var reqNo = reqNo;
        var deptNo = deptNo;

        //ajax detail load
        var setData = "";
        $.ajax({
            url: "/tmStatus/outstandingTMDetail.do",
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
                $("#outstandingTMDetail").html(setData);

                $('#outstandingTMDetailBox').bPopup({
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

                        $(this).find('.title04').empty();
                        $(this).find('.modal-body').empty();
                    }
                });

                $("#loadingBar").css("display", "none");
            },
            error: function (request, status, error) {
                console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
            }
        });
    }

    $(function () {
        setDate();
        fnOutstandingTMSearch();
    });
</script>
