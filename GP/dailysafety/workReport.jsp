<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 일일안전현황 > 일일안전작업현황 리스트 팝업 --%>
<%--<div class="tab-pane fade show active" id="tab01-pane" role="tabpanel" aria-labelledby="tab01" tabindex="0">--%>
<div class="safety-main">
    <h3 class="visually-hidden">일일안전작업현황</h3>
    <h4 class="title02">종합현황</h4>
    <div class="row g-2">
        <div class="col-lg-12 col-xxl-12 col-xxxl-7">

            <%--<!-- data-grid -->--%>
            <div class="table-responsive">
                <table class="table table-sm" aria-label="종합현황-위험작업">
                    <thead>
                    <tr>
                        <th scope="colgroup" colspan="13">안전작업허가서 주요 위험작업(건수)</th>
                    </tr>
                    <tr>
                        <th scope="col" data-field="구분">구분</th>
                        <th scope="col" data-field="일반">일반</th>
                        <th scope="col" data-field="화기">화기</th>
                        <th scope="col" data-field="밀폐">밀폐</th>
                        <th scope="col" data-field="고소">고소</th>
                        <th scope="col" data-field="중량물">중량물</th>
                        <th scope="col" data-field="정전">정전</th>
                        <th scope="col" data-field="굴착">굴착</th>
                        <th scope="col" data-field="잠수">잠수</th>
                        <th scope="col" data-field="방사선">방사선</th>
                        <th scope="col" data-field="화학물질">화학물질</th>
                        <th scope="col" data-field="기타">기타</th>
                        <th scope="col" data-field="합계">합계</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row" data-field="구분">(건)</th>
                        <td data-field="일반" class="_WR_HAZARD" id="_WR_G">0</td>
                        <td data-field="화기" class="_WR_HAZARD" id="_WR_HW">0</td>
                        <td data-field="밀폐" class="_WR_HAZARD" id="_WR_C">0</td>
                        <td data-field="고소" class="_WR_HAZARD" id="_WR_H">0</td>
                        <td data-field="중량물" class="_WR_HAZARD" id="_WR_HO">0</td>
                        <td data-field="정전" class="_WR_HAZARD" id="_WR_PO">0</td>
                        <td data-field="굴착" class="_WR_HAZARD" id="_WR_E">0</td>
                        <td data-field="잠수" class="_WR_HAZARD" id="_WR_D">0</td>
                        <td data-field="방사선" class="_WR_HAZARD" id="_WR_R">0</td>
                        <td data-field="화학물질" class="_WR_HAZARD" id="_WR_CS">0</td>
                        <td data-field="기타" class="_WR_HAZARD" id="_WR_O">0</td>
                        <td data-field="합계" class="text-bg-light _WR_HAZARD" id="_WR_TOT">0</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="col-sm col-md-5 col-xxl-5 col-xxxl-2">
            <%--<!-- data-grid -->--%>
            <div class="table-responsive">
                <table class="table table-sm" aria-label="종합현황-인력현황">
                    <thead>
                    <tr>
                        <th scope="colgroup" colspan="3">인력현황(명)</th>
                    </tr>
                    <tr>
                        <th scope="col" data-field="경상">경상</th>
                        <th scope="col" data-field="외부">외부</th>
                        <th scope="col" data-field="합계">합계</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td data-field="경상" id="_WR_SUM_NUMBER_ONSITE">0</td>
                        <td data-field="외부" id="_WR_SUM_NUMBER_OUTSIDE">0</td>
                        <td data-field="합계" class="text-bg-light" id="_WR_SUM_NUMBER">0</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="col-sm col-md-2 col-xxl col-xxxl-1">
            <%--<!-- data-grid -->--%>
            <div class="table-responsive">
                <table class="table table-sm" aria-label="종합현황-전체작업">
                    <thead>
                    <tr>
                        <th scope="col" style="height: 80px;">전체작업(건)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td data-field="전체작업" id="_WR_SUM_WORK">0</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="col-sm col-md-5 col-xxl-5 col-xxxl-2">
            <%--<!-- data-grid -->--%>
            <div class="table-responsive">
                <table class="table table-sm" aria-label="종합현황-등록현황">
                    <thead>
                    <tr>
                        <th scope="colgroup" colspan="3">등록현황(건)</th>
                    </tr>
                    <tr>
                        <th scope="col" data-field="등록작업">등록작업</th>
                        <th scope="col" data-field="GENi 작업">GENi 작업</th>
                        <th scope="col" data-field="미등록">미등록</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td data-field="등록작업" id="_WR_STATUS_P">0</td>
                        <td data-field="GENi 작업" id="_WR_STATUS_D">0</td>
                        <td data-field="미등록" id="_WR_STATUS_C">0</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="panel-box safety-calendar">
        <div class="side-panel left">
            <div class="calendar-box">
                <div class="calendar-header">
                    <div class="row g-2">
                        <div class="col-auto">
                            <label class="visually-hidden" for="selectYear">연도 선택</label>
                            <select class="form-select form-select-sm" aria-label="연도 선택" id="selectYear">
                                <option selected>연도 선택</option>
                            </select>
                        </div>
                        <div class="col-auto">
                            <label class="visually-hidden" for="selectMonth">월 선택</label>
                            <select class="form-select form-select-sm" aria-label="월 선택" id="selectMonth">
                                <option selected>월 선택</option>
                            </select>
                        </div>
                    </div>
                    <button type="button" class="btn btn-sm btn-primary" onclick="fnDailyRiskEntryPop('', 0, '')">현황 등록하기</button>
                </div>

                <div class="calendar-body">
                    <div class="calendar-list date" id="calendar-list"></div>
                </div>
            </div>
            <%--<!-- 달력 라이브러리 End -->--%>
        </div>

        <div class="contents-panel">
            <%--<!-- data list -->--%>
            <div id="_SAFETY_WORK_REPORT_LIST">
                <%-- 검색결과 리스트 : /detail/workReport_list.jsp --%>
            </div>
            <%--<!-- data list End -->--%>
        </div>
    </div>

</div>

<%--<!-- 현황등록 Start -->--%>
<div class="modal fade" id="dailyRiskEntryPopup" tabindex="-1">
    <%-- 등록 팝업창 위치 : /workReportForm.jsp --%>
</div>
<%--<!-- 현황등록 End -->--%>

<%--</div>--%>

<!-- 미등록 팝업 -->
<div class="modal fade search-popup" id="workReportUnRegistPopup" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-fullscreen-lg-down modal-lg modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="title04" id="searchResultTitle">등록현황</h5>
                <button type="button" class="btn close">
                    <span class="icon icon-close"></span><span>닫기</span>
                </button>
            </div>

            <div class="modal-body" id="workReportUnRegistPopupContentPop">
                <!-- 검색결과 리스트 -->
                <div class="search-box">
                    <form id="form_pop_search_work_report_unregist" method="post" autocomplete="off">
                        <input type="hidden" name="pageIndex" id="pageIndex" value="1">
                        <input type="hidden" name="searchDate" id="unregistSearchDate">
                        <div class="row">
                            <div class="col-md-3">
                                <label class="form-label" for="searchWorkOrderNo">오더번호</label>
                                <input class="form-control" type="number" id="searchWorkOrderNo" name="searchWorkOrderNo">
                            </div>
                            <div class="col-md mb-3">
                                <label class="form-label" for="searchWorkOrderDescription">오더명</label>
                                <input class="form-control" id="searchWorkOrderDescription" name="searchWorkOrderDescription">
                            </div>
                            <div class="col-md mb-3">
                                <label class="form-label" for="searchPlanName">감독자</label>
                                <input class="form-control" id="searchPlanName" name="searchPlanName">
                            </div>
                            <div class="col-md-auto">
                                <button type="button" class="btn btn-primary" onclick="fnBtnPopSearchWorkReportUnregist()">
                                    <span class="icon icon-search"></span>
                                    <span>검색</span>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

                <div id="_POP_SEARCH_WORK_UNREGIST_LIST">
                    <%-- 미등록 검색 리스트 --%>
                </div>
            </div>
        </div>
    </div>
</div>

<form id="searchWorkReportForm" name="searchWorkReportForm" method="get">
    <input type="hidden" name="searchDate" id="searchDate" value="${workReportVO.searchDate}">
    <input type="hidden" name="pageIndex" id="pageIndex" value="${workReportVO.pageIndex}">
    <input type="hidden" name="orderColumn" id="orderColumn" value="${workReportVO.orderColumn}">
    <input type="hidden" name="orderType" id="orderType" value="${workReportVO.orderType}">
    <input type="hidden" name="searchCondition" id="searchCondition" value="${workReportVO.searchCondition}">
    <input type="hidden" name="searchKeyword" id="searchKeyword" value="${workReportVO.searchKeyword}">
</form>

<script src="${pageContext.request.contextPath}/resources/js/dailysafety/calendar.js"></script>
<script>
    <%-- /* SORT */ --%>

    function fnWorkReportOrder(o) {
        orderColumn = o.attr("data-order-column");
        orderType = o.attr("data-order-type");

        if (orderType === "asc") {
            orderType = "desc";
        } else {
            orderType = "asc";
        }

        $("#searchWorkReportForm #orderColumn").val(orderColumn);
        $("#searchWorkReportForm #orderType").val(orderType);

        fnSearchWorkReportList(paramSearchDate);
    }

    <%-- /* 등록/수정 팝업 */ --%>

    function fnDailyRiskEntryPop(row, idx, paramUnregistData) {
        var mode = "I";

        if (idx > 0) {
            mode = "U";
        }

        // active class
        $("._TR_WORK_REPORT").removeClass("active");
        $(row).addClass("active");

        $("#dailyRiskEntryPopup").html('');

        $("#dailyRiskEntryPopup").bPopup({
            modalClose: false,
            position: [0, 0],
            opacity: .4,
            speed: 450,
            closeClass: "close",
            onOpen: function () {
                $(this).addClass('show detail-box');
            },
            onClose: function () {
                $("#dailyRiskEntryPopup").html('');

                // 내부에 사용한 modal 다 지움
                $("[id=searchWorkOrderPopup]").remove();
                $(this).removeClass('show');
            }
        }, function () {
            $.ajax({
                type: "POST"
                , url: "/dailySafety/workReportForm.do"
                , data: {isrIdx: idx, mode: mode}
                , dataType: "html"
                , beforeSend: function () {
                    $("#loadingBar").css("display", "");
                }
                , success: function (data) {
                    $("#dailyRiskEntryPopup").html(data);

                    /* UNREGIST DATA */
                    if (paramUnregistData !== '') {
                        // active class
                        $("._TR_WORK_UNREGIST").removeClass("active");
                        $(row).addClass("active");

                        /* type : wono : authoNo */
                        var data = paramUnregistData.split('|');

                        $("#orderNoOption").val(data[1]);
                        fnPopCallBackWorkOrder(data[0], data[1], '');
                    }
                }
                , error: function () {
                    alert("오류가 발생했습니다.\n잠시 후 다시 시도해 주시기 바랍니다.");
                }
                , complete: function () {
                    $("#loadingBar").css("display", "none");
                }
            });
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

        $("#currentPage").val(currentPage);

        $("#searchWorkReportForm #pageIndex").val(currentPage);
        fnSearchWorkReportList(paramSearchDate);
    }

    /* 오더번호 검색 팝업창의 페이지 처리 */
    function fnPageMovePop(f) {
        var currentPage = parseInt($("#searchWorkOrderPopForm #currentPage").val());

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
                $("#searchWorkOrderPopForm #currentPage").val(totalPage);
                return false;
            }
        }

        $("#searchWorkOrderPopForm #currentPage").val(currentPage);
        $("#form_pop_search_work_order #pageIndex").val(currentPage);

        fnPopSearchWorkOrder();
    }

    /* 등록현황관리 팝업창의 페이지 처리 */
    function fnPageMovePopUnregist(f) {
        var currentPage = parseInt($("#searchWorkReportUnregistPopForm #currentPage").val());

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
                $("#searchWorkReportUnregistPopForm #currentPage").val(totalPage);
                return false;
            }
        }

        $("#searchWorkReportUnregistPopForm #currentPage").val(currentPage);
        $("#form_pop_search_work_report_unregist #pageIndex").val(currentPage);

        fnPopSearchWorkReportUnregist();
    }

    <%-- /* 리스트에서 상세 팝업 */ --%>

    function fnShowDetail(row, idx) {
        fnDailyRiskEntryPop(row, idx, '');
    }

    <%-- /* 엑셀 다운로드 */ --%>

    function fnExcelDownloadWorkReport() {
        $.ajax({
            type: "POST"
            , url: "/dailySafety/workReportExcelDownload.do"
            , data: $("#searchWorkReportForm").serialize()
            , xhrFields: {
                responseType: 'blob'  // 응답을 Blob 형식으로 받기
            }
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (response, status, xhr) {
                //현재 날짜 가져오기
                var currentDate = new Date();
                var formattedDate = currentDate.getFullYear() + '-' +
                    (currentDate.getMonth() + 1).toString().padStart(2, '0') + '-' +
                    currentDate.getDate().toString().padStart(2, '0');

                // Blob을 사용하여 파일 다운로드 처리
                var blob = response;
                var link = document.createElement('a');
                link.href = URL.createObjectURL(blob);
                link.download = "일일안전작업현황_" + formattedDate + ".xlsx";
                link.click();  // 다운로드 트리거
            }
            , error: function (request, status, error) {
                alert("오류가 발생했습니다.\n잠시 후 다시 시도해 주시기 바랍니다.");
            }
            , complete: function () {
                $("#loadingBar").css("display", "none");
            }
        });
    }

    <%-- /* 일일안전현황 > 등록/수정 처리 */ --%>

    function fnSaveWorkReport() {
        /* 구분 */
        var isModelTypeCode = true;
        $("[name=modelTypeCode]").each(function (idx) {
            if ($(this).is(':checked')) {
                $("#modelTypeName").val($("._MODEL_TYPE_NAME").eq(idx).text());
                isModelTypeCode = false;
            }
        });

        if (isModelTypeCode) {
            alert("구분을 선택하십시오.");
            return false;
        }

        /* 위험작업 */
        var hazardWorkNames = [];
        var isHazardWorkCode = false;
        $("[name=hazardWorkCode]").each(function (idx) {
            if ($(this).is(':checked')) {
                hazardWorkNames.push($("._HAZARD_WORK_NAME").eq(idx).text());
                isHazardWorkCode = true;
            }
        });

        if (isHazardWorkCode) {
            $("#hazardWorkName").val(hazardWorkNames.join());
        } else {
            alert("위험작업을 선택하십시오.");
            return false;
        }

        /* 연락처 체크 (숫자/-) */
        var isCheckFormat = false;
        $("input[type=tel]").each(function () {
            if ($(this).val().replace(/[0-9\-]/g, '') !== '') {
                $(this).val('');
                alert("연락처를 정확하게 입력해 주시기 바랍니다.");
                $(this).focus();
                isCheckFormat = true;
                return false;
            }
        });

        if (isCheckFormat) {
            return false;
        }

        try {
            /* 작업시간(시/분) */
            var workTimeStart = $("#workTimeStart").val();
            var workStartTimes = workTimeStart.split(":");
            var workTimeEnd = $("#workTimeEnd").val();
            var workEndTimes = workTimeEnd.split(":");

            $("#workTimeHourStart").val(workStartTimes[0]);
            $("#workTimeMinuteStart").val(workStartTimes[1]);

            $("#workTimeHourEnd").val(workEndTimes[0]);
            $("#workTimeMinuteEnd").val(workEndTimes[1]);

            isCheckFormat = false;
            $('#dailyRiskEntryForm input[required]').each(function () {
                var $input = $(this);
                var name = $input.attr('name');
                var value = $input.val();

                if (!name) return; // name 속성이 없으면 건너뜀

                if (value === '') {
                    isCheckFormat = true;
                    return false;
                } else {
                    isCheckFormat = false;
                }
            });

            if (isCheckFormat) {
                alert("필수항목을 확인해 주시기 바랍니다.");
                return false;
            }
        } catch (e) {
            alert("필수항목을 확인해 주시기 바랍니다.");
            return false;
        }

        $('#dailyRiskEntryForm :input').prop('disabled', false);

        if (confirm("저장하시겠습니까?")) {
            $.ajax({
                type: "post"
                , url: "/dailySafety/workReportSave.do"
                , data: $("#dailyRiskEntryForm").serialize()
                , dataType: "json"
                , beforeSend: function () {
                    $("#loadingBar").css("display", "");
                }
                , success: function (data) {
                    if (data.result > 0) {
                        $("#dailyRiskEntryPopup .close").click();
                        fnSearchWorkReportList(paramSearchDate);
                    } else {
                        if (!isWithoutOrder && modelTypeCodeSelectedVal !== 'NPT') {
                            fnToggleOnOffInput('A');
                        }

                        alert("오류가 발생했습니다.\n잠시 후 다시 시도해 주십시오.");
                    }
                }
                , error: function (request, status, error) {
                    if (!isWithoutOrder && modelTypeCodeSelectedVal !== 'NPT') {
                        fnToggleOnOffInput('A');
                    }

                    alert("오류가 발생했습니다.\n잠시 후 다시 시도해 주십시오.");
                }
                , complete: function () {
                    $("#loadingBar").css("display", "none");
                }
            });
        }
    }

    <%-- /* 일일안전현황 > 삭제 처리 */ --%>

    function fnPopWorkReportRemove(idx, mode) {
        var msg = "삭제하시겠습니까?\n삭제한 데이터는 복구할 수 없습니다.";
        if (mode === 'DA') {
            msg = "일괄 삭제하시겠습니까?\n삭제한 데이터는 복구할 수 없습니다.";
        }

        if (confirm(msg)) {
            $.ajax({
                type: "post"
                , url: "/dailySafety/workReportSave.do"
                , data: {mode: mode, isrIdx: idx}
                , dataType: "json"
                , beforeSend: function () {
                    $("#loadingBar").css("display", "");
                }
                , success: function (data) {
                    if (data.result > 0) {
                        $("#dailyRiskEntryPopup .close").click();
                        fnSearchWorkReportList(paramSearchDate);
                    } else {
                        alert("오류가 발생했습니다.\n잠시 후 다시 시도하시기 바랍니다.");
                    }
                }
                , error: function (request, status, error) {
                    alert("오류가 발생했습니다.\n잠시 후 다시 시도해 주시기 바랍니다.");
                }
                , complete: function (data) {
                    $("#loadingBar").css("display", "none");
                }
            });
        }
    }

    <%-- // 미등록 팝업 창 > 검색 처리 --%>

    function fnPopSearchWorkReportUnregist() {
        $.ajax({
            type: "post"
            , url: "/dailySafety/popSearchWorkOrderUnregistList.do"
            , data: $("#form_pop_search_work_report_unregist").serialize()
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#_POP_SEARCH_WORK_UNREGIST_LIST").html(data);
            }
            , error: function (request, status, error) {
                alert("오류가 발생했습니다.\n잠시 후 다시 시도해 주시기 바랍니다.");
            }
            , complete: function (data) {
                $("#loadingBar").css("display", "none");
            }
        });
    }

    /* 미등록 팝업창 검색 버튼 처리 */
    function fnBtnPopSearchWorkReportUnregist() {
        $("#form_pop_search_work_report_unregist #pageIndex").val(1);
        fnPopSearchWorkReportUnregist();
    }

    <%-- /* 미등록 작업보기 팝업 */ --%>

    function fnWorkReportUnRegistPop() {
        $("#_POP_SEARCH_WORK_UNREGIST_LIST").html('');

        $("#workReportUnRegistPopup").bPopup({
            modalClose: false,
            position: [0, 0],
            opacity: .4,
            speed: 450,
            closeClass: "close",
            onOpen: function () {
                $(this).addClass('show detail-box');
            },
            onClose: function () {
                $("#_POP_SEARCH_WORK_UNREGIST_LIST").html('');
                // input data remove
                $('#workReportUnRegistPopup :input').val('');
                $(this).removeClass('show');
            }
        }, function () {
            $("#form_pop_search_work_report_unregist #pageIndex").val(1);
            $("#form_pop_search_work_report_unregist #unregistSearchDate").val(paramSearchDate);
            fnPopSearchWorkReportUnregist();
        });
    }

    function fnSearchKeyword(e) {
        if (e.key === "Enter" || e.keyCode === 13) {
            $("#searchWorkReportForm #pageIndex").val(1);
            $("#searchWorkReportForm #searchCondition").val($("#selectSearchCondition option:selected").val());
            $("#searchWorkReportForm #searchKeyword").val($("#txtSearchKeyword").val());

            fnSearchWorkReportList(paramSearchDate);
        }
    }
</script>
