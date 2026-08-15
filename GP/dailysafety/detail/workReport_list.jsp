<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 일일안전현황 > 일일안전작업현황 조회 결과 리스트 --%>
<script>
    <%-- 상단 Summary 부분 : 위험작업(건수) --%>
    <%-- 상단 Summary 부분 : 위험작업(건수) 초기화 --%>
    $("._WR_HAZARD").text(0);

    <c:forEach var="item" items="${sumHazard}" varStatus="status">
    <fmt:formatNumber var="value" value="${item.cnt}" type="number"/>

    <c:if test="${item.hazardWorkCode eq 'G'}">$("#_WR_G").text('${value}')</c:if>
    <c:if test="${item.hazardWorkCode eq 'HW'}">$("#_WR_HW").text('${value}')</c:if>
    <c:if test="${item.hazardWorkCode eq 'C'}">$("#_WR_C").text('${value}')</c:if>
    <c:if test="${item.hazardWorkCode eq 'H'}">$("#_WR_H").text('${value}')</c:if>
    <c:if test="${item.hazardWorkCode eq 'HO'}">$("#_WR_HO").text('${value}')</c:if>
    <c:if test="${item.hazardWorkCode eq 'PO'}">$("#_WR_PO").text('${value}')</c:if>
    <c:if test="${item.hazardWorkCode eq 'E'}">$("#_WR_E").text('${value}')</c:if>
    <c:if test="${item.hazardWorkCode eq 'D'}">$("#_WR_D").text('${value}')</c:if>
    <c:if test="${item.hazardWorkCode eq 'R'}">$("#_WR_R").text('${value}')</c:if>
    <c:if test="${item.hazardWorkCode eq 'CS'}">$("#_WR_CS").text('${value}')</c:if>
    <c:if test="${item.hazardWorkCode eq 'O'}">$("#_WR_O").text('${value}')</c:if>
    <c:if test="${item.hazardWorkCode eq 'TOT'}">
    <c:choose>
    <c:when test="${not empty value}">$("#_WR_TOT").text('${value}')</c:when>
    <c:otherwise>$("#_WR_TOT").text('0')</c:otherwise>
    </c:choose>
    </c:if>
    </c:forEach>

    <%-- 상단 Summary 부분 : 인력현황(명) --%>
    $("#_WR_SUM_NUMBER_ONSITE").text('0');
    $("#_WR_SUM_NUMBER_OUTSIDE").text('0');
    $("#_WR_SUM_NUMBER").text('0');

    <fmt:formatNumber var="sumWorkNumberOnsite" value="${sumWorkNumber.worksNumberOnsite}" type="number"/>
    <fmt:formatNumber var="sumWorkNumberOutside" value="${sumWorkNumber.worksNumberOutside}" type="number"/>
    <fmt:formatNumber var="sumWorkNumberTot" value="${sumWorkNumberOnsite + sumWorkNumberOutside}" type="number"/>

    <c:if test="${not empty sumWorkNumber.worksNumberOnsite}">$("#_WR_SUM_NUMBER_ONSITE").text(${sumWorkNumberOnsite});</c:if>
    <c:if test="${not empty sumWorkNumber.worksNumberOutside}">$("#_WR_SUM_NUMBER_OUTSIDE").text(${sumWorkNumberOutside});</c:if>
    <c:if test="${not empty sumWorkNumberTot}">$("#_WR_SUM_NUMBER").text(${sumWorkNumberTot});</c:if>

    <%-- 상단 Summary 부분 : 전체작업(건) --%>
    <c:set var="sumCount"><fmt:formatNumber value="${sumCount}" type="number"/></c:set>
    $("#_WR_SUM_WORK").text('${sumCount}');

    <%-- 상단 Summary 부분 : 등록현황(건) --%>
    <c:set var="cnt" value="0"/>
    $("#_WR_STATUS_P").text('0');
    $("#_WR_STATUS_D").text('0');
    $("#_WR_STATUS_C").text('0');

    <c:forEach var="item" items="${sumStatus}" varStatus="status">
        <c:set var="cnt"><fmt:formatNumber value="${item.cnt}" type="number"/></c:set>

        <c:if test="${item.workStateCode eq 'P'}">$("#_WR_STATUS_P").text('${cnt}')</c:if>
        <c:if test="${item.workStateCode eq 'D'}">$("#_WR_STATUS_D").text('${cnt}')</c:if>
        <c:if test="${item.workStateCode eq 'C'}">$("#_WR_STATUS_C").text('${cnt}')</c:if>
    </c:forEach>

    var totalPage = ${paginationInfo.totalPageCount};
</script>

<%-- 조회결과 --%>
<div class="title-box">
    <h4 class="title03">조회결과<small>(전체 <fmt:formatNumber value="${listCount}" type="number"/>건)</small></h4>
    
    <div>
        <div>
            <label class="visually-hidden" for="selectSearchCondition">검색옵션선택</label>
            <select class="form-select w-auto" aria-label="검색옵션 선택" id="selectSearchCondition">
                <option value="all" selected="selected">전체</option>
                <option value="model_type_name">구분</option>
                <option value="sv_dept_name">감독부서</option>
                <option value="work_location">작업장소</option>
                <option value="work_name">공사/작업명</option>
                <option value="work_sv_name">공사감독</option>
            </select>
            <label class="visually-hidden" for="txtSearchKeyword">검색어 입력</label>
            <input class="form-control keyword icon-return" type="text" id="txtSearchKeyword" placeholder="검색어 입력" onkeydown="fnSearchKeyword(event)">
        </div>
        
        <div>
            <label for="currentPage" class="visually-hidden">이동할 페이지</label>
            <input type="number" id="currentPage" class="form-control page" value="<c:out value='${paginationInfo.currentPageNo}'/>">
            <span class="px-1">/</span>
            <span class="total"><fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number"/></span>
            <button type="button" class="btn btn-secondary" onclick="fnPageMove('M')">이동</button>
            <button type="button" class="btn btn-outline-primary" onclick="fnPageMove('P')">이전</button>
            <button type="button" class="btn btn-outline-primary" onclick="fnPageMove('N')">다음</button>
        
            <%-- 앱 로그인 체크 --%>
            <c:if test="${sessionScope.loginInfo.iui_isadmin ne '999'}">
                <button type="button" class="btn btn-primary btn-file-download" onclick="fnExcelDownloadWorkReport()">엑셀 다운로드</button>
            </c:if>
            <button type="button" class="btn btn-primary" onclick="fnWorkReportUnRegistPop()">등록현황 관리</button>
        </div>
    </div>
</div>

<!-- data-grid -->
<div class="table-responsive">
    <table class="table table-sm" aria-label="종합현황-일별조회결과">
        <thead>
        <tr>
            <th scope="col" data-field="순번">순번</th>
            <th scope="col" data-field="구분" class="sort icon-down _WORK_ORDER_CLASS" data-order-column="model_type_name" data-order-type="asc" onclick="fnWorkReportOrder($(this))">구분</th>
            <th scope="col" data-field="감독부서" class="sort icon-down _WORK_ORDER_CLASS" data-order-column="sv_dept_name" data-order_type="asc" onclick="fnWorkReportOrder($(this))">감독부서</th>
            <th scope="col" data-field="작업장소">작업장소</th>
            <th scope="col" data-field="공사/작업명">공사/작업명</th>
            <th scope="col" data-field="위험작업 (허가서)">위험작업 (허가서)</th>
            <th scope="col" data-field="위험도">위험도</th>
            <th scope="col" data-field="공사업체명">공사업체명</th>
            <th scope="col" data-field="공사구분">공사구분</th>
            <th scope="col" data-field="오더번호">오더번호</th>
            <th scope="colgroup" colspan="2" data-field="작업인원">작업인원</th>
            <th scope="colgroup" colspan="2" data-field="작업시간/진행현황">작업시간/진행현황</th>
            <th scope="colgroup" colspan="2" data-field="연락처">연락처</th>
        </tr>
        </thead>
        <tbody>
        <%-- 데이터가 없을 경우 --%>
        <c:if test="${empty list}">
            <tr>
                <td colspan="16">
                    <div class="no-data">
                        조회된 데이터가 없습니다.
                    </div>
                </td>
            </tr>
        </c:if>

        <c:forEach var="data" items="${list}" varStatus="status">
            <c:set var="dataHazard" value=""/>
            <c:forEach var="hazard" items="${data.workReportHazards}" varStatus="status_hazard">
                <c:set var="dataHazard">${dataHazard}${hazard.hazardWorkName}<c:if test="${!status_hazard.last}">,</c:if></c:set>
            </c:forEach>

            <tr class="_TR_WORK_REPORT" onclick="fnShowDetail($(this), ${data.isrIdx})">
                <th rowspan="3" scope="row" data-field="순번">${paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.index)}</th>
                <td rowspan="3" data-field="구분">${data.modelTypeName}</td>
                <td rowspan="3" data-field="감독부서">${data.svDeptName}</td>
                <td rowspan="3" data-field="작업장소" class="ws-reset ws-start">${data.workLocation}</td>
                <td rowspan="3" data-field="공사/작업명" class="ws-reset ws-start">${data.workName}</td>
                <td rowspan="3" data-field="위험작업 (허가서)" class="ws-reset ws-start">${dataHazard}</td>
                <td rowspan="3" data-field="위험도">${data.riskLevel}</td>
                <td rowspan="3" data-field="공사업체명" class="ws-reset ws-start">${data.workCompanyName}</td>
                <td rowspan="3" data-field="공사구분">${data.workTypeName}</td>
                <td rowspan="3" data-field="오더번호">${data.workOrderNo}</td>
                <th scope="row" data-field="경상">경상</th>
                <td data-field="경상값"><fmt:formatNumber value="${data.worksNumberOnsite}" type="number"/></td>
                <th scope="col" data-field="시작">시작</th>
                <th scope="col" data-field="종료">종료</th>
                <th scope="col" data-field="공사감독">공사감독</th>
                <th scope="col" data-field="책임자">(현장)책임자</th>
            </tr>
            <tr>
                <th scope="row" data-field="외부">외부</th>
                <td data-field="외부값"><fmt:formatNumber value="${data.worksNumberOutside}" type="number"/></td>
                <td data-field="시작">
                    <c:choose>
                        <c:when test="${data.workTimeViewType eq 'A'}">${data.workTimeStart}</c:when>
                        <c:otherwise>${data.workTimeHourStart}:${data.workTimeMinuteStart}</c:otherwise>
                    </c:choose>
                </td>
                <td data-field="종료">
                    <c:choose>
                        <c:when test="${data.workTimeViewType eq 'A'}">${data.workTimeEnd}</c:when>
                        <c:otherwise>${data.workTimeHourEnd}:${data.workTimeMinuteEnd}</c:otherwise>
                    </c:choose>
                </td>
                <td data-field="공사감독">${data.workSvName}</td>
                <td data-field="책임자">${data.workSmName}</td>
            </tr>
            <tr>
                <th scope="row" data-field="합계">합계</th>
                <td data-field="합계값"><fmt:formatNumber value="${data.worksNumberOnsite + data.worksNumberOutside}" type="number"/></td>
                <td colspan="2" data-field="진행현황">${data.workState}</td>
                <td data-field="공사감독">${data.workSvTel}</td>
                <td data-field="책임자">${data.workSmTel}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div class="btn-box mb-0">
    <button type="button" class="btn btn-primary" onclick="fnPageMove('P')">이전</button>
    <button type="button" class="btn btn-primary" onclick="fnPageMove('N')">다음</button>
</div>
