<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 일일안전현황 > 일일안전작업현황 등록화면 팝업 --%>

<%--<!-- 현황등록 Start -->--%>
<%--<div class="modal fade" id="dailyRiskEntryPopup" tabindex="-1">--%>
<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-fullscreen-xl-down modal-xl">
    <div class="modal-content">

        <div class="modal-header">
            <h5 class="title04" id="dailyRiskEntryLabel">일일안전작업 신청</h5>
            <button type="button" class="btn close">
                <span class="icon icon-close"></span><span>닫기</span>
            </button>
        </div>

        <div class="modal-body" id="dailyRiskEntryContent">
            <div class="alert alert-primary required">
                <p class="text-primary">
                    <strong class="text-danger">*</strong> 표시는 필수입력 항목입니다.
                </p>
            </div>
            <form method="post" id="dailyRiskEntryForm" name="dailyRiskEntryForm" autocomplete="off" action="javascript:fnSaveWorkReport()">
                <input type="hidden" id="dataType" name="dataType" value="I"/>
                <input type="hidden" id="mode" name="mode" value="${workReportVO.mode}"/>
                <input type="hidden" id="isrIdx" name="isrIdx" value="${workReportVO.isrIdx}"/>

                <div class="table-responsive">
                    <table class="table table-sm form-table" aria-label="안전작업-신청">
                        <colgroup>
                            <col style="width: 8rem;">
                            <col style="min-width: 16rem;">
                            <col style="width: 8rem;">
                            <col style="min-width: 16rem;">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th scope="row">* 구분</th>
                            <td colspan="3">
                                <div class="form-check form-check-inline">
                                    <input type="radio" id="radio_1_mt" name="modelTypeCode" value="TA">
                                    <label class="form-check-label _MODEL_TYPE_NAME" for="radio_1_mt">태안</label>
                                </div>
                                <%--<div class="form-check form-check-inline">
                                    <input type="radio" id="radio_1_mt" name="modelTypeCode" value="TA09">
                                    <label class="form-check-label _MODEL_TYPE_NAME" for="radio_1_mt">태안 9호기</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input type="radio" id="radio_2_mt" name="modelTypeCode" value="TA10">
                                    <label class="form-check-label _MODEL_TYPE_NAME" for="radio_2_mt">태안 10호기</label>
                                </div>--%>
                                <input type="hidden" id="modelTypeName" name="modelTypeName"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="bg-warning">* 오더번호</th>
                            <td colspan="3" class="bg-warning">
                                <div class="row g-2">
                                    <div class="col">
                                        <label class="visually-hidden" for="orderNoOption">오더번호 검색</label>
                                        <input type="number" class="form-control" id="orderNoOption" name="workOrderNo" value="${data.workOrderNo}" required maxlength="10">
                                        <input class="form-control" type="hidden" id="orderNoInput" name="workOrderDescription" value="${data.workOrderDescription}" disabled>
                                        <button type="button" class="btn search-icon" id="btnSearchWorkOrder"><span class="visually-hidden">검색</span></button>
                                    </div>

                                    <div class="col">
                                        <c:if test="${workReportVO.mode eq 'I'}">
                                            <div class="form-check">
                                                <input type="checkbox" id="withoutOrder">
                                                <label class="form-label" for="withoutOrder">오더없이 작성</label>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="bg-warning-subtle">* 공사감독</th>
                            <td class="bg-warning-subtle">
                                <div class="row g-2">
                                    <div class="col col-12 col-md-6">
                                        <label class="visually-hidden" for="supvorOption">감독자 검색</label>
                                        <input type="text" list="workSvListOptions" class="form-control" id="supvorOption" name="workSvCode" value="${data.workSvCode}" required maxlength="10">
                                        <button type="button" class="btn search-icon" onclick="searchItemPopup($(this))"><span class="visually-hidden">검색</span></button>
                                    </div>
                                    <div class="col col-md-6">
                                        <label class="visually-hidden" for="supvorInput">공사감독자명</label>
                                        <input class="form-control" type="text" id="supvorInput" name="workSvName" value="${data.workSvName}" disabled="">
                                    </div>
                                </div>

                                <datalist id="workSvListOptions"><%-- 공사감독이 동명이인인 경우 보여줌 --%></datalist>
                            </td>
                            <th scope="row" class="bg-warning-subtle">* 감독자 연락처</th>
                            <td class="bg-warning-subtle">
                                <label class="visually-hidden" for="siteSupvorPhone">감독자 연락처</label>
                                <input class="form-control" type="tel" id="siteSupvorPhone" name="workSvTel" value="${data.workSvTel}" maxlength="20" placeholder="예)010-1234-5678" required>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="bg-warning-subtle">* (현장)책임자</th>
                            <td class="bg-warning-subtle">
                                <label class="visually-hidden" for="siteManagerOption">현장책임자명 입력</label>
                                <input class="form-control" type="text" id="siteManagerOption" name="workSmName" value="${data.workSmName}" maxlength="20" required>
                            </td>
                            <th scope="row" class="bg-warning-subtle">* 책임자 연락처</th>
                            <td class="bg-warning-subtle">
                                <label class="visually-hidden" for="siteManagerPhone">현장책임자 연락처</label>
                                <input class="form-control" type="tel" id="siteManagerPhone" name="workSmTel" value="${data.workSmTel}" maxlength="20" placeholder="예)010-1234-5678" required>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="bg-warning-subtle">* 작업시간</th>
                            <td colspan="3" class="bg-warning-subtle">
                                <div class="row g-2">
                                    <div class="col-3 col-md-3 col-xl-2">
                                        <label class="visually-hidden" for="workStartDate">시작일</label>
                                        <input type="text" class="form-control icon-calendar has-dateRangePicker" id="workStartDate" name="workTimeDateStart" value="${data.workTimeDateStart}" required>
                                    </div>
                                    <div class="col-2 col-md-2 col-xl-2">
                                        <c:set var="workTimeStart" value=""/>
                                        <c:if test="${not empty data.workTimeMinuteStart}"><c:set var="workTimeStart">${data.workTimeHourStart}:${data.workTimeMinuteStart}</c:set></c:if>
                                        <input type="text" class="form-control" id="workTimeStart" name="workTimeStart" value="${workTimeStart}" required>
                                        <label class="visually-hidden" for="workTimeStart">시</label>
                                        <input type="hidden" id="workTimeHourStart" name="workTimeHourStart"/>
                                        <input type="hidden" id="workTimeMinuteStart" name="workTimeMinuteStart"/>
                                    </div>
                                    <div class="col-1 col-md-auto">
                                        <span class="form-control-plaintext text-center">~</span>
                                    </div>
                                    <div class="col-6 d-md-none"></div>
                                    <div class="col-3 col-md-3 col-xl-2">
                                        <label class="visually-hidden" for="workEndDate">종료일</label>
                                        <input type="text" class="form-control icon-calendar" id="workEndDate" name="workTimeDateEnd" value="${data.workTimeDateEnd}" required>
                                    </div>
                                    <div class="col-2 col-md-2 col-xl-2">
                                        <c:set var="workTimeEnd" value=""/>
                                        <c:if test="${not empty data.workTimeMinuteStart}"><c:set var="workTimeEnd">${data.workTimeHourEnd}:${data.workTimeMinuteEnd}</c:set></c:if>
                                        <input type="text" class="form-control" id="workTimeEnd" name="workTimeEnd" value="${workTimeEnd}" required>
                                        <label class="visually-hidden" for="workTimeEnd">시</label>
                                        <input type="hidden" id="workTimeHourEnd" name="workTimeHourEnd"/>
                                        <input type="hidden" id="workTimeMinuteEnd" name="workTimeMinuteEnd"/>
                                    </div>
                                </div>
                                <script>
									if ('ontouchstart' in window) {
										$('#workStartDate.has-dateRangePicker')
											.attr('readonly', true)
											.on('focus click', function () {
												$(this).blur();
												$(this).data('daterangepicker')?.show();
											});
									}
                                </script>

                                <c:if test="${workReportVO.mode eq 'I'}">
                                    <div class="row g-2">
                                        <div class="col">
                                            <div id="selected-days-wrap">
                                                <div>선택한 일자(클릭하여 제외/포함):</div>
                                                <div id="selected-days"></div>
                                            </div>
                                            <input type="hidden" id="workDates" name="workDates" required>
                                        </div>
                                    </div>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">* 감독부서</th>
                            <td>
                                <div class="row g-2">
                                    <div class="col">
                                        <label class="visually-hidden" for="supvDeptOption">감독부서 검색</label>
                                        <input type="text" list="workSvDeptListOptions" class="form-control" id="supvDeptOption" name="svDeptCode" value="${data.svDeptCode}" maxlength="20" required>
                                        <button type="button" class="btn search-icon" onclick="searchReqTreePopup($(this))"><span class="visually-hidden">검색</span></button>
                                    </div>
                                    <div class="col">
                                        <label class="visually-hidden" for="supvDeptInput">감독부서명</label>
                                        <input class="form-control" type="text" id="supvDeptInput" name="svDeptName" value="${data.svDeptName}" disabled="">
                                    </div>
                                </div>

                                <datalist id="workSvDeptListOptions"><%-- 감독부서가 2개 이상인 경우 보여줌 --%></datalist>
                            </td>
                            <th scope="row">* 공사구분</th>
                            <td>
                                <label for="workTypeCode" class="visually-hidden">* 공사구분</label>
                                <select class="form-select" id="workTypeCode" name="workTypeCode" required>
                                    <option value="">선택</option>
                                    <option value="P">계획예방정비</option>
                                    <option value="R">경상정비</option>
                                    <option value="S">별도공사</option>
                                    <option value="O">위탁용역</option>
                                    <option value="GENERAL">일반공사</option>
                                    <option value="SIMPLE">간이공사</option>
                                    <option value="O/H">OVERHAUL</option>
                                    <option value="SERVICE">용역공사</option>
                                    <option value="CONTRACT">단가공사</option>
                                    <option value="INSTALL">설치조건부구매</option>
                                </select>
                                <input type="hidden" id="workTypeName" name="workTypeName" value="${data.workTypeName}"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">* 공사/작업명</th>
                            <td colspan="3">
                                <label for="workName" class="visually-hidden">공사/작업명</label>
                                <textarea class="form-control" placeholder="" id="workName" name="workName" required maxlength="150">${data.workName}</textarea>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">* 작업장소</th>
                            <td colspan="3">
                                <label class="visually-hidden" for="workLocation">작업장소</label>
                                <input class="form-control" type="text" id="workLocation" name="workLocation" value="${data.workLocation}" maxlength="50" required>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">* 공사업체명</th>
                            <td colspan="3">
                                <label class="visually-hidden" for="workCompanyName">공사업체명</label>
                                <input class="form-control" type="text" id="workCompanyName" name="workCompanyName" value="${data.workCompanyName}" maxlength="150" required>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">* 위험작업</th>
                            <td colspan="3">
                                <div class="d-flex flex-wrap">
                                    <div class="form-check form-check-inline">
                                        <input type="checkbox" value="G" id="chkValue1" name="hazardWorkCode">
                                        <label class="form-check-label _HAZARD_WORK_NAME" for="chkValue1">일반</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input type="checkbox" value="HW" id="chkValue2" name="hazardWorkCode">
                                        <label class="form-check-label _HAZARD_WORK_NAME" for="chkValue2">화기</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input type="checkbox" value="C" id="chkValue3" name="hazardWorkCode">
                                        <label class="form-check-label _HAZARD_WORK_NAME" for="chkValue3">밀폐</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input type="checkbox" value="H" id="chkValue4" name="hazardWorkCode">
                                        <label class="form-check-label _HAZARD_WORK_NAME" for="chkValue4">고소</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input type="checkbox" value="HO" id="chkValue5" name="hazardWorkCode">
                                        <label class="form-check-label _HAZARD_WORK_NAME" for="chkValue5">중량물</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input type="checkbox" value="PO" id="chkValue6" name="hazardWorkCode">
                                        <label class="form-check-label _HAZARD_WORK_NAME" for="chkValue6">정전</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input type="checkbox" value="E" id="chkValue7" name="hazardWorkCode">
                                        <label class="form-check-label _HAZARD_WORK_NAME" for="chkValue7">굴착</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input type="checkbox" value="D" id="chkValue8" name="hazardWorkCode">
                                        <label class="form-check-label _HAZARD_WORK_NAME" for="chkValue8">잠수</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input type="checkbox" value="R" id="chkValue9" name="hazardWorkCode">
                                        <label class="form-check-label _HAZARD_WORK_NAME" for="chkValue9">방사선</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input type="checkbox" value="CS" id="chkValue10" name="hazardWorkCode">
                                        <label class="form-check-label _HAZARD_WORK_NAME" for="chkValue10">화학물질</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input type="checkbox" value="O" id="chkValue11" name="hazardWorkCode">
                                        <label class="form-check-label _HAZARD_WORK_NAME" for="chkValue11">기타</label>
                                    </div>
                                    <input type="hidden" id="hazardWorkName" name="hazardWorkName"/>
                                </div>
                            </td>
                        </tr>
                        <tr class="d-none _HAZARD_WORK_OTHER">
                            <th scope="row">* 기타내용</th>
                            <td colspan="3">
                                <c:forEach items="${hazardList}" var="data" varStatus="status">
                                    <c:if test="${data.hazardWorkCode eq 'O'}"><c:set var="hazardWorkOther" value="${data.hazardWorkOther}"/></c:if>
                                </c:forEach>
                                <label for="hazardWorkOther" class="visually-hidden">기타내용</label>
                                <textarea class="form-control" placeholder="" id="hazardWorkOther" name="hazardWorkOther">${hazardWorkOther}</textarea>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">* 작업인원(명)</th>
                            <td>
                                <div class="row row-cols-4 row-cols-md-4">
                                    <div class="col">
                                        <label class="col-form-label text-end" for="worksNumberOnsite">경상: </label>
                                    </div>
                                    <div class="col">
                                        <input class="form-control" type="number" id="worksNumberOnsite" name="worksNumberOnsite" value="${data.worksNumberOnsite}" required>
                                    </div>
                                    <div class="col">
                                        <label class="col-form-label text-end" for="worksNumberOutside">외부: </label>
                                    </div>
                                    <div class="col">
                                        <input class="form-control" type="number" id="worksNumberOutside" name="worksNumberOutside" value="${data.worksNumberOutside}" required>
                                    </div>
                                </div>
                            </td>
                            <th scope="row">* 위험도</th>
                            <td>
                                <label for="hazardousWork" class="visually-hidden">* 위험도</label>
                                <select class="form-select" id="hazardousWork" name="riskLevel" required>
                                    <option value="">선택</option>
                                    <option value="상">상</option>
                                    <option value="중">중</option>
                                    <option value="하">하</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">* 작업단계</th>
                            <td>
                                <label for="keySteps" class="visually-hidden">작업단계</label>
                                <textarea class="form-control" placeholder="" id="keySteps" name="keySteps" required>${data.keySteps}</textarea>
                            </td>
                            <th scope="row">* 유해 · 위험요인</th>
                            <td>
                                <label for="hazards" class="visually-hidden">유해 · 위험요인</label>
                                <textarea class="form-control" placeholder="" id="hazards" name="hazards" required>${data.hazards}</textarea>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">* 감소대책</th>
                            <td colspan="3">
                                <label for="controls" class="visually-hidden">감소대책</label>
                                <textarea class="form-control" placeholder="" id="controls" name="controls" required>${data.controls}</textarea>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <div class="btn-box">
                    <button class="btn btn-primary" type="submit" id="btnSubmit">저장</button>
                    <c:if test="${data.isrIdx > 0}">
                        <button class="btn btn-secondary" type="button" onclick="fnPopWorkReportRemove('${data.isrIdx}','D')">삭제</button>
                        <c:if test="${not empty data.createIdx}">
                            <button class="btn btn-danger" type="button" onclick="fnPopWorkReportRemove('${data.isrIdx}','DA')">일괄 삭제</button>
                        </c:if>
                    </c:if>
                </div>
            </form>
        </div>
    </div>
</div>
<%--</div>--%>

<!-- 사번의 오더정보 팝업 -->
<div class="modal fade search-popup" id="searchWorkOrderPopup" tabindex="-1">
    <%--    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable"> --%>
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-fullscreen-lg-down modal-lg modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="title04" id="searchResultTitle">오더번호 검색</h5>
                <button type="button" class="btn close">
                    <span class="icon icon-close"></span><span>닫기</span>
                </button>
            </div>

            <div class="modal-body" id="searchResultWorkOrderContentPop">
                <!-- 검색결과 리스트 -->
                <div class="search-box">
                    <form id="form_pop_search_work_order" name="form_pop_search_work_order" method="post" autocomplete="off">
                        <input type="hidden" id="pageIndex" name="pageIndex" value="1">
                        <input type="hidden" id="paramOrderSearchDate" name="searchDate">
                        <input type="hidden" id="parampPlanBy" name="planBy">
                        <div class="row">
                            <div class="col-md-3 ">
                                <label class="form-label" for="searchWorkOrderNo">오더번호</label>
                                <input type="text" class="form-control" id="searchWorkOrderNo" name="searchWorkOrderNo">
                            </div>
                            <div class="col-md mb-3">
                                <label class="form-label" for="searchWorkOrderDescription">오더명</label>
                                <input type="text" class="form-control" id="searchWorkOrderDescription" name="searchWorkOrderDescription">
                            </div>
                            <div class="col-md mb-3">
                                <label class="form-label" for="searchPlanName">감독자</label>
                                <input type="text" class="form-control" id="searchPlanName" name="searchPlanName">
                            </div>
                            <div class="col-md-auto mb-3">
                                <div class="form-check form-check-inline">
                                    <input type="checkbox" value="1" id="check_searchType" name="searchType">
                                    <label class="form-label" for="check_searchType">전체</label>
                                </div>
                            </div>
                            <div class="col-md-auto mb-3">
                                <button type="button" class="btn btn-primary" onclick="fnBtnPopSearchWorkOrder()">
                                    <span class="icon icon-search"></span>
                                    <span>검색</span>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

                <div id="_POP_SEARCH_WORK_ORDER_LIST">
                    <%-- 오더 검색 리스트 --%>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $(".daterangepicker ").remove();
    });

    /* INIT FORM */
    function fnPopSetInitReportForm() {
        $("#dataType").val("G");

        // 초기화
        var dataType = $("#dataType").val();
        var mode = $("#mode").val();
        var isrIdx = $("#isrIdx").val();
        var modelTypeCode = $("#dailyRiskEntryForm [name=modelTypeCode]:checked").val();
        var orderNoOption = $("#dailyRiskEntryForm #orderNoOption").val();
        var withoutOrder = $("#dailyRiskEntryForm #withoutOrder").is(":checked");
        var supvorOption = $("#dailyRiskEntryForm #supvorOption").val();
        var supvorInput = $("#dailyRiskEntryForm #supvorInput").val();
        var siteSupvorPhone = $("#dailyRiskEntryForm #siteSupvorPhone").val();
        var siteManagerOption = $("#dailyRiskEntryForm #siteManagerOption").val();
        var siteManagerPhone = $("#dailyRiskEntryForm #siteManagerPhone").val();

        // clear
        $('#dailyRiskEntryForm input').each(function () {
            if (this.name !== 'modelTypeCode' && this.id !== 'withoutOrder' && this.type !== 'checkbox') {
                $(this).val('');
            }
        });
        $('#dailyRiskEntryForm select').prop('selectedIndex', 0);
        $('#dailyRiskEntryForm input[type="checkbox"]').prop('checked', false);
        $('#dailyRiskEntryForm textarea').val('');

        // init set value
        $("#dailyRiskEntryForm #dataType").val(dataType);
        $("#dailyRiskEntryForm #mode").val(mode);
        $("#dailyRiskEntryForm #isrIdx").val(isrIdx);
        if (typeof modelTypeCode !== 'undefined' && modelTypeCode !== '') {
            $("#dailyRiskEntryForm [name=modelTypeCode]").val(modelTypeCode);
        }
        $("#dailyRiskEntryForm #orderNoOption").val(orderNoOption);

        if (withoutOrder) {
            $("#dailyRiskEntryForm #withoutOrder").prop('checked', true);
        }

        $("#dailyRiskEntryForm #supvorOption").val(supvorOption);
        $("#dailyRiskEntryForm #supvorInput").val(supvorInput);
        $("#dailyRiskEntryForm #siteSupvorPhone").val(siteSupvorPhone);
        $("#dailyRiskEntryForm #siteManagerOption").val(siteManagerOption);
        $("#dailyRiskEntryForm #siteManagerPhone").val(siteManagerPhone);
    }

    /* 선택한 오더 정보를 폼에 등록 */
    function fnPopCallBackWorkOrder(workOrderType, code, authoNo) {
        fnPopSetInitReportForm();

        $.ajax({
            url: "/dailySafety/popSearchWorkOrder.do"
            , type: "POST"
            , data: {workOrderType: workOrderType, woNo: code, authoNo: authoNo}
            , dataType: "json"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            },
            success: function (data) {
                /* 검색오더번호가 1개 이상 검출되면 리스트로 보여주기 */
                if (typeof data.count !== 'undefined') {
                    if (data.count > 0) {
                        fnSearchWorkOrderPopup();
                        return false;
                    } else {
                        alert("조회한 오더번호가 없습니다.");
                        return false;
                    }
                }

                var dataLen = data.length;

                if (dataLen > 0) {
                    var item = data[0];

                    $("#supvDeptOption").val(item.deptNo);
                    $("#supvDeptInput").val(item.deptName);

                    $("#workTypeCode option").filter(function () {
                        return $(this).text() === item.projectTypeDesc;
                    }).prop("selected", true);  // 공사구분

                    $("#workName").val(item.woDesc);
                    $("#workLocation").val(item.workLocation);
                    $("#workCompanyName").val(item.workDeptName);

                    var isQsCount = 0;
                    if (item.isQsDanger === 'Y') {
                        $('[name=hazardWorkCode]').eq(0).prop('checked', true);
                        isQsCount++;
                    }
                    if (item.isQsFire === 'Y') {
                        $('[name=hazardWorkCode]').eq(1).prop('checked', true);
                        isQsCount++;
                    }
                    if (item.isQsNarrow === 'Y') {
                        $('[name=hazardWorkCode]').eq(2).prop('checked', true);
                        isQsCount++;
                    }
                    if (item.isQsHigh === 'Y') {
                        $('[name=hazardWorkCode]').eq(3).prop('checked', true);
                        isQsCount++;
                    }
                    if (item.isQsHeavy === 'Y') {
                        $('[name=hazardWorkCode]').eq(4).prop('checked', true);
                        isQsCount++;
                    }
                    if (item.isQsElectricity === 'Y') {
                        $('[name=hazardWorkCode]').eq(5).prop('checked', true);
                        isQsCount++;
                    }
                    if (item.isQsExcavation === 'Y') {
                        $('[name=hazardWorkCode]').eq(6).prop('checked', true);
                        isQsCount++;
                    }
                    if (item.isQsDive === 'Y') {
                        $('[name=hazardWorkCode]').eq(7).prop('checked', true);
                        isQsCount++;
                    }
                    if (item.isQsRadiation === 'Y') {
                        $('[name=hazardWorkCode]').eq(8).prop('checked', true);
                        isQsCount++;
                    }
                    if (item.isQsChemical === 'Y') {
                        $('[name=hazardWorkCode]').eq(9).prop('checked', true);
                        isQsCount++;
                    }

                    if ((item.isQsDanger === 'Y') && (isQsCount === 1)) {
                        $("#hazardousWork").val('하');
                    } else if (isQsCount === 1) {
                        $("#hazardousWork").val('중');
                    } else if (isQsCount >= 2) {
                        $("#hazardousWork").val('상');
                    }

                    var requestDate = item.requestDate.split('~');
                    var requestTime = item.requestTime.split('~');
                    $("#workStartDate").val(requestDate[0]);
                    $("#workTimeStart").val(requestTime[0]);
                    $("#workEndDate").val(requestDate[1]);
                    $("#workTimeEnd").val(requestTime[1]);

                    var headCount = item.headCount.split('/');
                    $("#worksNumberOnsite").val(headCount[0]);
                    $("#worksNumberOutside").val(headCount[1]);

                    if (dataLen > 1) {
                        var keysteps = $.map(data, function (item) {
                            return item.keysteps;
                        });

                        var hazards = $.map(data, function (item) {
                            return item.hazards;
                        });

                        var controls = $.map(data, function (item) {
                            return item.controls;
                        });

                        $("#keySteps").val(keysteps.join('\n'));
                        $("#hazards").val(hazards.join('\n'));
                        $("#controls").val(controls.join('\n'));
                    } else {
                        $("#keySteps").val(item.keysteps);
                        $("#hazards").val(item.hazards);
                        $("#controls").val(item.controls);
                    }

                    // get name
                    $("#workTypeCode").change();
                    $("[name=hazardWorkCode]").click();

                    // 선택 일 설정
                    fnSetTimePicker();
                } else {
                    alert("조회한 오더번호가 없습니다.");
                }
            },
            error: function (request, status, error) {
                alert("오류가 발생했습니다.\n잠시 후 다시 시도해 주시기 바랍니다.");
                console.log("code:" + request.status + "\n error:" + error);
            },
            complete: function () {
                $("#loadingBar").css("display", "none");
            }
        });
    }

    <%-- 공사감독 정보 --%>

    function fnSearchWorkSv(userId) {
        $.ajax({
            url: "/common/searchUserList.do"
            , type: "POST"
            , data: {userId: userId}
            , dataType: "json"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            },
            success: function (data) {
                $("#supvorInput").val('');

                // return array
                if (data !== null && data.length > 0) {
                    var len = data.length;

                    if (len > 1) {
                        const $list = $('#workSvListOptions');
                        $list.empty(); // 기존 옵션 제거

                        let val;
                        $.each(data, function (i, item) {
                            val = val + "<option value='" + item.userId + "'>" + item.userName + " | " + item.userDeptName + "</option>";
                        });
                        $list.html(val);
                    } else {
                        $("#supvorOption").val(data[0].userId);
                        $("#supvorInput").val(data[0].userName);
                    }
                } else {
                    alert("정보가 없습니다.");
                }
            },
            error: function (request, status, error) {
                alert("오류가 발생했습니다.\n잠시 후 다시 시도해 주시기 바랍니다.");
                console.log("code:" + request.status + "\n error:" + error);
            },
            complete: function () {
                $("#loadingBar").css("display", "none");
            }
        });
    }

    <%-- 감독부서 정보 --%>

    function fnSearchWorkSvDept(paramDept) {
        $.ajax({
            url: "/common/searchDeptList.do"
            , type: "POST"
            , data: {deptNo: paramDept}
            , dataType: "json"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            },
            success: function (data) {
                $("#supvDeptInput").val('');

                // return array
                if (data !== null && data.length > 0) {
                    var len = data.length;

                    if (len > 1) {
                        const $list = $('#workSvDeptListOptions');
                        $list.empty(); // 기존 옵션 제거

                        let val;
                        $.each(data, function (i, item) {
                            val = val + "<option value='" + item.deptNo + "'>" + item.description + "</option>";
                        });
                        $list.html(val);
                    } else {
                        $("#supvDeptOption").val(data[0].deptNo);
                        $("#supvDeptInput").val(data[0].description);
                    }
                } else {
                    alert("정보가 없습니다.");
                }
            },
            error: function (request, status, error) {
                alert("오류가 발생했습니다.\n잠시 후 다시 시도해 주시기 바랍니다.");
                console.log("code:" + request.status + "\n error:" + error);
            },
            complete: function () {
                $("#loadingBar").css("display", "none");
            }
        });
    }

    <%-- // 오더번호 검색 팝업 > 오더 검색기능 --%>

    function fnPopSearchWorkOrder() {
        var workSvCode = $("#supvorOption").val();

        $("#_POP_SEARCH_WORK_ORDER_LIST").html('');

        $("#form_pop_search_work_order #paramOrderSearchDate").val(paramSearchDate);
        $("#form_pop_search_work_order #parampPlanBy").val(workSvCode);

        $.ajax({
            type: "post"
            , url: "/dailySafety/popSearchWorkOrderList.do"
            , data: $("#form_pop_search_work_order").serialize()
            , dataType: "html"
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (data) {
                $("#_POP_SEARCH_WORK_ORDER_LIST").html(data);
            }
            , error: function (request, status, error) {
                console.log("code:" + request.status + "\n error:" + error);
            }
            , complete: function (data) {
                $("#loadingBar").css("display", "none");
            }
        });
    }

    /* 검색 버튼 클릭 */
    function fnBtnPopSearchWorkOrder() {
        $("#form_pop_search_work_order #pageIndex").val(1);
        fnPopSearchWorkOrder();
    }

    // 오더번호 검색 팝업
    function fnSearchWorkOrderPopup() {
        var val = $("#orderNoOption").val();
        var workSvCode = $("#supvorOption").val();
        var workSvName = $("#supvorInput").val();

        /* 오더번호가 있는 경우 : 오더번호로만 검색 */
        if (val !== '') {
            workSvName = '';
            $("#form_pop_search_work_order #check_searchType").prop('checked', true);
        } else {
            $("#form_pop_search_work_order #check_searchType").prop('checked', false);
        }

        // set orderNo
        $("#form_pop_search_work_order #searchWorkOrderNo").val(val);
        $("#form_pop_search_work_order #parampPlanBy").val(workSvCode);
        $('#form_pop_search_work_order #searchPlanName').val(workSvName);
        $("#form_pop_search_work_order #paramOrderSearchDate").val(paramSearchDate);

        $('#searchWorkOrderPopup').bPopup({
            modalClose: false,
            position: [0, 0],
            opacity: 0.2,
            speed: 450,
            closeClass: "close",
            onOpen: function () {
                $(this).addClass('show');
            },
            onClose: function () {
                $("#_POP_SEARCH_WORK_ORDER_LIST").html('');

                $('#form_pop_search_work_order #searchWorkOrderNo').val('');
                $('#form_pop_search_work_order #searchWorkOrderDescription').val('');
                $('#form_pop_search_work_order #searchPlanName').val('');

                $(this).removeClass('show');
            }
        }, function () {
            $.ajax({
                url: "/dailySafety/popSearchWorkOrderList.do"
                , type: "POST"
                , data: $("#form_pop_search_work_order").serialize()
                , dataType: "html"
                , beforeSend: function () {
                    $("#loadingBar").css("display", "");
                },
                success: function (data) {
                    $("#_POP_SEARCH_WORK_ORDER_LIST").html(data);
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

    /* set disabled flag */
    var isWithoutOrder = false;
    var modelTypeCodeSelectedVal;

    /* SET INPUT DISABLED */
    function fnToggleOnOffInput() {
        if (modelTypeCodeSelectedVal !== 'HM' && modelTypeCodeSelectedVal !== 'NPT' && modelTypeCodeSelectedVal !== 'TA' && modelTypeCodeSelectedVal !== 'TA09' && modelTypeCodeSelectedVal !== 'TA10' && isWithoutOrder !== true) {
            $('#dailyRiskEntryForm :input').prop('disabled', true);
            $('#dailyRiskEntryForm [name=modelTypeCode]').prop('disabled', false);
            $('#dailyRiskEntryForm #supvorOption').prop('disabled', false);
            $('#dailyRiskEntryForm #supvorInput').prop('disabled', false);
            $('#dailyRiskEntryForm #orderNoOption').prop('disabled', false);
            $('#dailyRiskEntryForm #withoutOrder').prop('disabled', false);
            $('#dailyRiskEntryForm #siteManagerOption').prop('disabled', false);
            $('#dailyRiskEntryForm #siteSupvorPhone').prop('disabled', false);
            $('#dailyRiskEntryForm #siteManagerPhone').prop('disabled', false);
            $('#dailyRiskEntryForm button').prop('disabled', false);
            $('#dailyRiskEntryForm #workStartDate').prop('disabled', false);
        } else {
            $('#dailyRiskEntryForm :input').prop('disabled', false);
        }

        if (modelTypeCodeSelectedVal === "NPT" || modelTypeCodeSelectedVal !== 'TA'|| modelTypeCodeSelectedVal === "TA09" || modelTypeCodeSelectedVal === "TA10" || isWithoutOrder === true) {
            $('#dailyRiskEntryForm #orderNoOption').prop('required', false);
        } else {
            $('#dailyRiskEntryForm #orderNoOption').prop('required', true);
        }

        // 작업종료시간 일은 비활성화 유지
        $("#workEndDate").prop("readonly", true);
        $("#workDates").prop("disabled", false);
    }

    function setDate() {
        //날짜 현재날짜 기준 한 달 전 세팅
        var today = new Date();
        var yyyy = today.getFullYear();
        var mm = ("0" + (today.getMonth() + 1)).slice(-2);
        var dd = ("0" + today.getDate()).slice(-2);
        var currentDate = yyyy + "-" + mm + "-" + dd;
        $('#workStartDate').val(currentDate);
        $('#workEndDate').val(currentDate);
    }

    <c:if test="${workReportVO.mode eq 'I'}">
    /* set datepicker */
    // 선택한 날짜 설정
    var selectedDatesSet = new Set(); // 'YYYY-MM-DD'

    function updateInputFromSet() {
        if (selectedDatesSet.size === 0) {
            $('#workDates').val('');
            $("#btnSubmit").prop("disabled", true);
            alert("모든 작업시간이 제외되었습니다.\n최소 1일은 선택되어야 합니다.");
            return;
        } else {
            $("#btnSubmit").prop("disabled", false);

            // 등록할 날짜를 정렬해서 저장
            var arr = Array.from(selectedDatesSet);
            arr.sort();
            $("#workEndDate").val(arr[arr.length - 1]);
            $('#workDates').val(arr.join(','));
        }
    }

    /* Set date */
    function fnSetDate(t, dateStr) {
        if (selectedDatesSet.has(dateStr)) {
            selectedDatesSet.delete(dateStr);
            t.css({opacity: 0.4, textDecoration: 'line-through'});
        } else {
            selectedDatesSet.add(dateStr);
            t.css({opacity: 1, textDecoration: 'none'});
        }
        updateInputFromSet();
    }

    /* 선택한 날짜를 일 생성, 리스트 뷰 */
    function renderSelectedDays(start, end) {
        selectedDatesSet.clear();

        // 날짜 생성
        var cur = start.clone().startOf('day');
        var last = end.clone().startOf('day');
        while (cur.isSameOrBefore(last, 'day')) {
            selectedDatesSet.add(cur.format('YYYY-MM-DD'));
            cur.add(1, 'day');
        }

        var $wrap = $('#selected-days-wrap');
        var $box = $('#selected-days');
        $box.empty();

        /* 날짜 뷰 리스트 */
        Array.from(selectedDatesSet).sort().forEach(function (d) {
            // 칩(label)에는 요일을 함께 표시하되, data-date와 내부 Set 값은 날짜만 유지하여
            var dow = moment(d, 'YYYY-MM-DD').format('ddd'); // 예: 일, 월, 화 ... (ko 로케일)
            var label = d + ' (' + dow + ')';
            var $chip = $('<button type="button" class="chip-on" data-date="' + d + '">' + label + '</button>');

            $chip.on('click', function () {
                var dateStr = $(this).attr('data-date');
                fnSetDate($(this), dateStr);
            });
            $box.append($chip);

            // 토,일 삭제
            if (dow === '토' || dow === '일') {
                fnSetDate($chip, d);
            }
        });

        $wrap.show();
        updateInputFromSet();
    }

    // 선택일 생성
    function fnSetTimePicker() {
        var drp = $('#workStartDate').data('daterangepicker');
        drp.setStartDate($("#workStartDate").val());
        drp.setEndDate($("#workEndDate").val());

        if (drp && drp.startDate && drp.endDate) {
            renderSelectedDays(drp.startDate, drp.endDate);
        }
    }
    </c:if>

    $(function () {
        var timepickerOptions = {timeFormat: 'H:i', step: 30, minTime: '00:00', maxTime: '23:30'};
        $('#workTimeStart').timepicker(timepickerOptions);
        $('#workTimeEnd').timepicker(timepickerOptions);

        // set init
        isWithoutOrder = false;
        modelTypeCodeSelectedVal = '';

        <%-- toggle disabled or not --%>
        <c:if test="${workReportVO.mode eq 'I'}">
        setDate();
        $('#workTimeStart').val('09:00');
        $('#workTimeEnd').val('18:00');

        fnToggleOnOffInput();

        /* START : 내용 수정 플래그 - 구분:신평택/오더없이 */
        $("[name=modelTypeCode]").click(function () {
            $("[name=modelTypeCode]").each(function (idx) {
                if ($(this).is(':checked')) {
                    modelTypeCodeSelectedVal = this.value;
                    fnToggleOnOffInput();
                }
            });
        });

        $("#withoutOrder").click(function () {
            isWithoutOrder = $(this).is(':checked');
            fnToggleOnOffInput();
        });
        /* 내용 수정 플래그 - 구분:신평택/오더없이 END */
        </c:if>

        <c:if test="${workReportVO.mode eq 'U'}">
        $("[name=modelTypeCode]").click(function () {
            $("[name=modelTypeCode]").each(function (idx) {
                if ($(this).is(':checked')) {
                    modelTypeCodeSelectedVal = this.value;
                    fnToggleOnOffInput();
                }
            });
        });
        </c:if>

        /* Get 공사구분 명 */
        $("#workTypeCode").change(function () {
            $("#workTypeName").val($("#workTypeCode option:selected").text());
        });

        /* 위험작업 기타 - 기타내용 표시 */
        $("[name=hazardWorkCode]").click(function () {
            if ($(this).val() === 'O') {
                if ($(this).is(':checked')) {
                    $("._HAZARD_WORK_OTHER").removeClass('d-none').find('textarea').focus();
                } else {
                    $("._HAZARD_WORK_OTHER").addClass('d-none').find('textarea').val('');
                }
            }
        });

        /* set data : update */
        if ("${workReportVO.mode}" === "U") {
            <c:if test="${not empty data.modelTypeCode}">
            $("[name=modelTypeCode][value=${data.modelTypeCode}]").prop("checked", true);

            <c:if test="${data.modelTypeCode eq 'NPT'}">
            $('#dailyRiskEntryForm #orderNoOption').prop('required', false);
            </c:if>
            </c:if>

            // 비활성화
            $("#orderNoOption").prop("readonly", true);
            $("#btnSearchWorkOrder").prop("disabled", true);
            $("#workStartDate").prop("readonly", true);
            $("#workEndDate").prop("readonly", true);
            //$("#workTimeStart").prop("readonly", true);
            //$("#workTimeEnd").prop("readonly", true);

            $("#workTypeCode").val("${data.workTypeCode}");
            $("#hazardousWork").val("${data.riskLevel}");

            // 위험작업 리스트
            <c:forEach items="${hazardList}" var="data" varStatus="status">
            $("[name=hazardWorkCode][value=${data.hazardWorkCode}").prop("checked", true);
            <c:if test="${data.hazardWorkCode eq 'O'}">
            $("._HAZARD_WORK_OTHER").removeClass('d-none');
            </c:if>
            </c:forEach>
        }

        /* 오더번호 INPUT 검색 시 */
        $("#orderNoOption").on("keypress change", function (event) {
            var checkLen = $(this).val().trim().length;

            if (event.keyCode === 13 && checkLen > 0) {
                event.preventDefault();
                fnPopSetInitReportForm();
                fnSearchWorkOrderPopup();
                return false;
            }
        });

        /* 오더번호 검색 아이콘 클릭 */
        $("#btnSearchWorkOrder").click(function () {
            var workSvName = $("#supvorInput").val();

           /* if (workSvName === '') {
                alert("공사감독자가 없습니다.");
                return false;
            }*/

            fnSearchWorkOrderPopup();
        });

        /* 공사감독 검색 시 */
        $("#supvorOption").on("keypress change", function (e) {
            var checkLen = $(this).val().trim().length;
            var isEnter = (e.key === 'Enter' || e.keyCode === 13);

            if (isEnter || checkLen >= 8) {
                e.preventDefault();

                var $list = $('#workSvListOptions');
                $list.empty(); // 기존 옵션 제거

                var userId = $(this).val().trim();
                if (typeof userId === "undefined" || userId === "") {
                    $("#supvorInput").val('');
                    return false;
                }

                fnSearchWorkSv(userId);
            }
        });

        /* 감독부서 검색 시 */
        $("#supvDeptOption").on("keypress change", function (e) {
            var checkLen = $(this).val().trim().length;
            var isEnter = (e.key === 'Enter' || e.keyCode === 13);

            if (isEnter || checkLen >= 4) {
                e.preventDefault();

                var $list = $('#workSvDeptListOptions');
                $list.empty(); // 기존 옵션 제거

                var paramDept = $(this).val().trim();
                if (typeof paramDept === "undefined" || paramDept === "") {
                    $("#supvDeptInput").val('');
                    return false;
                }

                fnSearchWorkSvDept(paramDept);
            }
        });

        <c:if test="${workReportVO.mode eq 'I'}">
        /* daterangepicker */
        if (moment && typeof moment.locale === 'function') {
            moment.locale('ko');
        }

        $('#workStartDate').daterangepicker({
            linkedCalendars: false,
            autoUpdateInput: false,
            showCustomRangeLabel: false,
            startDate: moment(),
            endDate: moment(),
            locale: {
                format: 'YYYY-MM-DD',
                separator: ' ~ ',
                applyLabel: '적용',
                cancelLabel: '닫기',
                fromLabel: '시작',
                toLabel: '종료',
                customRangeLabel: 'Custom',
                weekLabel: '주',
                daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
                monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                firstDay: 0
            }
        }, function (start, end, label) {
            // 선택한 모든 일자를 생성
            renderSelectedDays(start, end);

            $("#workStartDate").val(start.format('YYYY-MM-DD'));
            $("#workEndDate").val(end.format('YYYY-MM-DD'));
            console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
        });

        $('#workStartDate').on('show.daterangepicker', function (ev, picker) {
            var $container = picker.container;
            var $buttons = $container.find('.drp-buttons');
            var $cancel = $buttons.find('.cancelBtn');

            // 버튼이 없으면 생성
            if (!$buttons.find('.btn-today').length) {
                var $today = $('<button type="button" class="btn btn-sm btn-default btn-today">오늘</button>')
                    .on('click', function () {
                        picker.setStartDate(moment());
                        picker.setEndDate(moment());
                        // 선택 적용까지 수행하려면 아래 한 줄 중 하나 사용
                        if (typeof picker.clickApply === 'function') picker.clickApply();
                        else $buttons.find('.applyBtn').trigger('click');
                    });

                // 닫기 버튼 앞에 삽입 (없으면 버튼 영역 끝에 추가)
                if ($cancel.length) $today.insertBefore($cancel);
                else $today.appendTo($buttons);
            } else {
                // 이미 존재하는 경우에도 항상 닫기 버튼 앞에 위치시키기(재정렬)
                var $today = $buttons.find('.btn-today');
                if ($cancel.length) $today.insertBefore($cancel);
            }
        });

        // 취소 시 초기화
        $('#workStartDate').on('cancel.daterangepicker', function () {
            // no action
        });

        fnSetTimePicker();
        </c:if>
    });
</script>
<%--<!-- 현황등록 End -->--%>
