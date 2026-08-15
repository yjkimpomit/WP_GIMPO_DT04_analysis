<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 일일안전작업현황 > 오더번호 검색 결과 리스트 --%>

<script>
    var totalPage = ${paginationInfo.totalPageCount};
</script>

<script>
    function fnPopSearchWorkOrderSelect(workOrderType, code, desc) {
        $('#orderNoOption').val(code);
        $('#orderNoInput').val(desc);

        $("[id=searchWorkOrderPopup] .close").trigger('click');

        // 오더코드 넘기기
        fnPopCallBackWorkOrder(workOrderType, code);
    }
</script>

<%--<!-- 일일안전현황 > 일일안전작업현황 > 오더번호 팝업 리스트 -->--%>
<form id="searchWorkOrderPopForm" name="searchWorkOrderPopForm" method="post">
    <div class="title-box">
        <h4 class="title03">조회결과<small>(전체 <fmt:formatNumber value="${listCount}" type="number"/>건)</small></h4>

        <div>
            <div class="page-move">
                <label for="currentPage" class="visually-hidden">이동할 페이지</label>
                <input type="number" id="currentPage" class="form-control page" value="<c:out value='${paginationInfo.currentPageNo}'/>">
                <span class="px-1">/</span>
                <span class="total"><fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number"/></span>
                <button type="button" class="btn btn-secondary" onclick="fnPageMovePop('M')">이동</button>
            </div>

            <div class="btn-box">
                <button type="button" class="btn btn-outline-primary" onclick="fnPageMovePop('P')">이전</button>
                <button type="button" class="btn btn-outline-primary" onclick="fnPageMovePop('N')">다음</button>
            </div>
        </div>
    </div>
</form>

<%--<!-- data-grid -->--%>
<div class="table-responsive">
    <table class="table table-sm sticky" aria-label="오더번호-결과">
        <thead>
        <tr>
            <%--<th scope="col" data-field="NO">순번</th>--%>
            <%--<th scope="col" data-field="JOIN_TYPE">등록여부</th>--%>
            <th scope="col" data-field="WORK_TYPE">구분</th>
            <th scope="col" data-field="CODE">오더번호</th>
            <th scope="col" data-field="DESC">오더명</th>
            <th scope="col" data-field="REQUEST_DATE">설계일</th>
            <th scope="col" data-field="PLAN_NAME">감독자</th>
        </tr>
        </thead>
        <tbody>
        <%-- 데이터가 없을 경우 --%>
        <c:if test="${fn:length(list) == 0}">
            <tr>
                <td colspan="6">
                    <div class="no-data">
                        조회된 데이터가 없습니다.
                    </div>
                </td>
            </tr>
        </c:if>

        <c:set var="listCount" value="${fn:length(list)}"/>

        <c:forEach var="data" items="${list}" varStatus="status">
            <tr onclick="fnPopSearchWorkOrderSelect('${data.workOrderType}','${data.woNo}','${data.woDesc}')">
                    <%--<th data-field="NO" scope="row">${listCount - status.index}</th>--%>
                    <%--<th data-field="JOIN_TYPE">${data.joinType}</th>--%>
                <th data-field="WORK_TYPE">${data.woCategory}</th>
                <th data-field="CODE">${data.woNo}</th>
                <td data-field="DESC" class="text-start ws-reset">${data.woDesc}</td>
                <td data-field="REQUEST_DATE">${data.requestDate}</td>
                <td data-field="PLAN_NAME">${data.planName}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>