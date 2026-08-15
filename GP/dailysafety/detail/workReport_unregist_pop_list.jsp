<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--<!-- 일일안전현황 > 일일안전작업현황 > 미등록 작업보기 팝업 리스트 -->--%>
<script>
    var totalPage = ${paginationInfo.totalPageCount};
</script>

<form id="searchWorkReportUnregistPopForm" name="searchWorkReportUnregistPopForm" method="post">
    <div class="title-box">
        <h4 class="title03">조회결과<small>(전체 <fmt:formatNumber value="${listCount}" type="number"/>건)</small></h4>

        <div>
            <div class="page-move">
                <label for="currentPage" class="visually-hidden">이동할 페이지</label>
                <input type="number" id="currentPage" class="form-control page" value="<c:out value='${paginationInfo.currentPageNo}'/>">
                <span class="px-1">/</span>
                <span class="total"><fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number"/></span>
                <button type="button" class="btn btn-secondary" onclick="fnPageMovePopUnregist('M')">이동</button>
            </div>

            <div class="btn-box">
                <button type="button" class="btn btn-outline-primary" onclick="fnPageMovePopUnregist('P')">이전</button>
                <button type="button" class="btn btn-outline-primary" onclick="fnPageMovePopUnregist('N')">다음</button>
            </div>
        </div>
    </div>
</form>

<div class="table-responsive">
    <table class="table table-sm sticky" aria-label="오더번호-결과">
        <thead>
        <tr>
            <th scope="col" data-field="NO">순번</th>
            <th scope="col" data-field="WORK_ORDER_TYPE">구분</th>
            <th scope="col" data-field="WO_NO">오더번호</th>
            <th scope="col" data-field="WO_DESC">오더명</th>
            <th scope="col" data-field="WORK_SDATE">작업일자(시작)</th>
            <th scope="col" data-field="WORK_EDATE">작업일자(종료)</th>
            <th scope="col" data-field="SV_DEPT">감독부서</th>
            <th scope="col" data-field="SV_NAME">감독자</th>
            <th scope="col" data-field="JOIN_TYPE">등록여부</th>
            <th scope="col" data-field="ISSUE_TYPE">허가서 발행여부</th>
            <th scope="col" data-field="MANAGE_TYPE">판정</th>
        </tr>
        </thead>
        <tbody>
        <%-- 데이터가 없을 경우 --%>
        <c:if test="${fn:length(list) == 0}">
            <tr>
                <td colspan="11">
                    <div class="no-data">
                        조회된 데이터가 없습니다.
                    </div>
                </td>
            </tr>
        </c:if>

        <c:set var="listCount" value="${fn:length(list)}"/>

        <c:forEach var="data" items="${list}" varStatus="status">
            <tr class="_TR_WORK_UNREGIST" onclick="fnDailyRiskEntryPop($(this), 0, '${data.workOrderType}|${data.woNo}|${data.authoNo}')">
                <th data-field="NO" scope="row">${listCount - status.index}</th>
                <th data-field="WORK_ORDER_TYPE" scope="row">${data.workOrderTypeName}</th>
                <td data-field="WO_NO">${data.woNo}</td>
                <td data-field="WO_DESC" class="text-start ws-reset">${data.woDesc}</td>
                <td data-field="WORK_SDATE">${data.planStartDate}</td>
                <td data-field="WORK_EDATE">${data.planEndDate}</td>
                <td data-field="SV_DEPT">${data.deptName}</td>
                <td data-field="SV_NAME">${data.planName}</td>
                <td data-field="JOIN_TYPE">미등록</td>
                <c:choose>
                    <c:when test="${not empty data.workDate}">
                        <td data-field="ISSUE_TYPE" class="text-danger">발행</td>
                        <td data-field="MANAGE_TYPE" class="text-danger">관리필요</td>
                    </c:when>
                    <c:otherwise>
                        <td data-field="ISSUE_TYPE">미발행</td>
                        <td data-field="MANAGE_TYPE">작업없음</td>
                    </c:otherwise>
                </c:choose>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
