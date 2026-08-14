<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 일일안전현황 > 경상오더 팝업 --%>
<%--<div class="tab-pane fade _TAB_CONTENT" id="tab02-pane-safety" role="tabpanel" aria-labelledby="tab02_safety" tabindex="0">--%>

<div class="panel-box safety">
    <div class="side-panel left">
        <%-- tree list view : 기능위치/계통/종류 --%>
        <c:import url="/common/facilityPackageTreeList.do"/>
    </div>

    <div class="contents-panel">
        <h3 class="title02">경상오더</h3>
        <!-- 검색영역 -->
        <div class="search-box">
            <form id="searchWorkOrderForm" method="post" autocomplete="off">
                <input type="hidden" name="pageIndex" id="pageIndex" value="${workOrderVO.pageIndex}">
                <div class="row">
                    <fieldset class="col-md-6 col-xxl-4">
                        <legend class="form-label" id="supvor">감독자</legend>
                        <div class="row g-2">
                            <div class="col-6">
                                <label class="visually-hidden" for="supvorOption">감독자 검색</label>
                                <input class="form-control search-icon" id="supvorOption" name="planBy" onclick="searchItemPopup($(this));">
                            </div>
                            <div class="col-6">
                                <label class="visually-hidden" for="supvorInput">감독자</label>
                                <input class="form-control" type="text" id="supvorInput" name="planByName" disabled="">
                            </div>
                        </div>
                    </fieldset>

                    <!-- 감독부서 유형 -->
                    <fieldset class="col-md-6 col-xxl-4">
                        <legend class="form-label" id="supvDept">감독부서</legend>
                        <div class="row g-2">
                            <div class="col">
                                <label class="visually-hidden" for="supvDeptOption">감독부서 검색</label>
                                <input class="form-control search-icon" id="supvDeptOption" name="deptNo" onclick="searchReqTreePopup($(this));"/>
                            </div>
                            <div class="col">
                                <label class="visually-hidden" for="supvDeptInput">감독부서명</label>
                                <input class="form-control" type="text" id="supvDeptInput" name="deptName" disabled="">
                            </div>
                        </div>
                    </fieldset>

                    <!-- 정비부서 유형 -->
                    <fieldset id="formMainDept" class="col-md-6 col-xxl-4">
                        <legend class="form-label" id="maintDept">정비부서</legend>
                        <div class="row g-2">
                            <div class="col">
                                <label class="visually-hidden" for="maintDeptOption">정비부서 검색</label>
                                <input class="form-control search-icon" id="maintDeptOption" name="workDeptNo" onclick="searchmainDeptTreePopup($(this));">
                            </div>
                            <div class="col">
                                <label class="visually-hidden" for="maintDeptInput">정비부서명</label>
                                <input class="form-control" type="text" id="maintDeptInput" name="workdeptName" disabled="">
                            </div>
                        </div>
                    </fieldset>

                    <div class="col-md-6 col-xxl-3 col-xxxl-4">
                        <label class="form-label" for="orderNo">오더 번호</label>
                        <input class="form-control" type="text" id="orderNo" value="" name="woNo" placeholder="오더번호 입력">
                    </div>

                    <div class="col-md col-xxl-3 col-xxxl-4">
                        <label class="form-label" for="orderName">오더명</label>
                        <input class="form-control" type="text" id="orderName" name="description" placeholder="오더명 입력">
                    </div>

                    <fieldset class="col-md-6 col-xxl">
                        <legend class="form-label" id="planCreatedDate">설계일</legend>
                        <div class="row g-2 period-box">
                            <div class="col">
                                <label class="visually-hidden" for="requestDateStart">시작일</label>
                                <input type="date" class="form-control" id="requestDateStart" name="requestDateStart">
                            </div>
                            <div class="col-auto">
                                <span class="form-control-plaintext text-center">~</span>
                            </div>
                            <div class="col">
                                <label class="visually-hidden" for="requestDateEnd">종료일</label>
                                <input type="date" class="form-control" id="requestDateEnd" name="requestDateEnd">
                            </div>
                        </div>
                    </fieldset>

                    <div class="col-md-auto">
                        <button type="button" class="btn btn-primary" onclick="fnSearchForm()">
                            <span class="icon icon-search"></span>
                            <span>검색</span>
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <%-- 조회결과 리스트 시작 --%>
        <div id="_VIEW_RESULT_LIST">
            <%-- 조회결과 리스트 뷰 : /detail/routineWorkOrder_list.jsp --%>
        </div>
        <%-- 조회결과 리스트 끝 --%>

        <%-- 품질안전설계 시작 --%>
        <div id="_VIEW_RESULT_SAFETY_QUALITY">
            <%-- 품질안전설계 뷰 : /detail/routineWorkOrder_safety_quality.jsp --%>
        </div>
        <%-- 품질안전설계 끝 --%>
    </div>
</div>

<%-- 안전작업허가서 팝업 --%>
<div class="modal fade detail-box" tabindex="-1" id="safetyWorkPermitPop">
    <%-- 안전작업허가서 뷰 : /detail/routineWorkOrder_permit_pop.jsp --%>
</div>
<%-- 안전작업허가서 팝업 끝 --%>

<%--</div>--%>

<script>
    function setDate() {
        //날짜 현재날짜 기준 한 달 전 세팅
        var today = new Date();
        var yyyy = today.getFullYear();
        var mm = ("0" + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
        var dd = ("0" + today.getDate()).slice(-2);
        var currentDate = yyyy + "-" + mm + "-" + dd;
        $('#requestDateEnd').val(currentDate); // 첫 번째 input에 오늘 날짜 설정

        // 두 번째 input 태그 (한 달 전 날짜로 설정)
        today.setMonth(today.getMonth() - 1); // 현재 날짜 기준 한 달 전으로 설정
        var lastMonthDate = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + ("0" + today.getDate()).slice(-2);
        $('#requestDateStart').val(lastMonthDate); // 두 번째 input에 한 달 전 날짜 설정
    }

    setDate();

    /* 검색조회 리스트 */
    var orderColumn;
    var orderType;

    function fnSearchWorkOrderList() {
        $.ajax({
            type: "POST"
            , url: "/dailySafety/routineWorkOrderList.do"
            , data: $("#searchWorkOrderForm").serialize()
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#_VIEW_RESULT_SAFETY_QUALITY").html("");
                $("#_VIEW_RESULT_LIST").html(data);
            }
            , error: function () {
                alert("오류가 발생했습니다.\n잠시 후 다시 시도해 주시기 바랍니다.");
            }
            , complete: function () {
                $("#loadingBar").css("display", "none");
            }
        });
    }

    /* load list page */
    fnSearchWorkOrderList();

    function fnSearchForm() {
        $("#searchWorkOrderForm #pageIndex").val(1);
        fnSearchWorkOrderList();
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

        $("#searchWorkOrderForm #pageIndex").val(currentPage);
        fnSearchWorkOrderList();
    }

    /* 품질안전설계 정보 */
    function fnRoutineWorkOrderResultDetailView(row) {
        var no = $(row).attr('data-no');

        $("._TR_RESULT_DATA").removeClass("active");
        $(row).addClass("active");

        /* 점검종류 리스트 */
        $.ajax({
            type: "POST"
            , url: "/dailySafety/routineWorkOrderSafetyQuality.do"
            , data: {woNo: no, workOrderType: 'R'}
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#_VIEW_RESULT_SAFETY_QUALITY").html(data);
            }
            , error: function () {
                alert("오류가 발생했습니다.\n잠시 후 다시 시도해 주시기 바랍니다.");
            }
            , complete: function () {
                $("#loadingBar").css("display", "none");
            }
        });
    }

    //클릭된 행 클래스 설정
    var setActiveRow = null;

    function fnShowSafetyWorkPermitPop(row) {
        var no = $(row).attr('data-no');
        var aNo = $(row).attr('data-ano');
        var workOrderType = $(row).attr('data-type');

        setActiveRow = row;

        //클릭된 행 클래스 추가 및 다른 행의 클래스 제거
        var $table = $(row).closest('table');

        if (setActiveRow) {
            $table.find('tr.active').not(this).removeClass("active");
            $(setActiveRow).addClass('active');
        }

        $("#safetyWorkPermitPop").bPopup({
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
        }, function () {
            $.ajax({
                url: "/dailySafety/routineWorkOrderPermitPop.do"
                , type: "POST"
                , data: {woNo: no, authoNo: aNo, workOrderType: workOrderType}
                , dataType: "html"
                , beforeSend: function () {
                    $("#loadingBar").css("display", "");
                },
                success: function (data) {
                    $("#safetyWorkPermitPop").html(data);
                },
                complete: function () {
                    $("#loadingBar").css("display", "none");
                },
                error: function (request, status, error) {
                    console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
                }
            });
        });
    }

    /* 엑셀 다운로드 */
    function fnExcelDownloadWorkOrder() {
        var excelColList = [];

        $("th[name='excelCol']").each(function () {
            var fieldValue = $(this).data("field");
            excelColList.push(fieldValue);
        });

        var $form = $("#searchWorkOrderForm");
        $form.append(
            $('<input>', {
                type: "hidden",
                name: "colList",
                value: excelColList.join()
            })
        );

        $.ajax({
            type: "POST"
            , url: "/dailySafety/routineWorkOrderExcelDownload.do"
            , data: $("#searchWorkOrderForm").serialize()
            , xhrFields: {
                responseType: 'blob'  // 응답을 Blob 형식으로 받기
            }
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (response, status, xhr) {
                try {
                    //현재 날짜 가져오기
                    var currentDate = new Date();
                    var formattedDate = currentDate.getFullYear() + '-' +
                        (currentDate.getMonth() + 1).toString().padStart(2, '0') + '-' +
                        currentDate.getDate().toString().padStart(2, '0');

                    // Blob을 사용하여 파일 다운로드 처리
                    var blob = response;
                    var link = document.createElement('a');
                    link.href = URL.createObjectURL(blob);
                    link.download = "경상오더_" + formattedDate + ".xlsx";
                    link.click();  // 다운로드 트리거
                } catch (e) {
                    console.log(e);
                    $("#loadingBar").css("display", "none");
                }
            }
            , error: function (request, status, error) {
                console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
            }
            , complete: function () {
                $form.find('input[name=colList]').remove();
                $("#loadingBar").css("display", "none");
            }
        });
    }
</script>
