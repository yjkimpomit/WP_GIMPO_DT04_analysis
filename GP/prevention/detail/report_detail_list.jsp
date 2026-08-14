<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="listCount" value="${fn:length(list)}"/>

<%-- 예방점검현황 > 점검보고서 조회 상세내용 리스트 --%>
<h5 class="title04">점검보고서 상세 내용<small>(전체 <fmt:formatNumber value="${listCount}" type="number"/>건)</small></h5>
<div class="table-responsive">
    <table class="table table-sm" id="tblReportDetailList" aria-label="점검보고서-상세내용">
        <thead>
        <tr>
            <th scope="col" data-field="점검일">점검일</th>
            <th scope="col" data-field="점검구분">점검구분</th>
            <th scope="col" data-field="점검부서">점검부서</th>
            <th scope="col" data-field="설비번호">설비번호</th>
            <th scope="col" data-field="설비명">설비명</th>
            <th scope="col" data-field="점검결과">점검결과</th>
            <th scope="col" data-field="점검시간">점검시간</th>
            <th scope="col" data-field="점검자(코드)">점검자(코드)</th>
            <th scope="col" data-field="점검자">점검자</th>
        </tr>
        </thead>
        <tbody>
        <%-- 데이터가 없을 경우 --%>
        <c:if test="${fn:length(list) == 0}">
            <tr>
                <th colspan="10">
                    <div class="no-data">
                        조회된 데이터가 없습니다.
                    </div>
                </th>
            </tr>
        </c:if>

        <c:forEach var="data" items="${list}" varStatus="status">
            <tr class="_TR_LIST_DETAIL" data-request-no="${data.checkListNo}" onclick="fnReportDetailResultView($(this),${data.checkListNo},${data.authoNo},${data.checkDate},${data.equipNo})">
                <td data-field="점검일"><c:out value='${fn:substring(data.checkDate, 0, 4)}-'/><c:out value='${fn:substring(data.checkDate, 4, 6)}-'/><c:out value='${fn:substring(data.checkDate, 6, 8)}'/></td>
                <td data-field="점검구분">${data.checkType}</td>
                <td data-field="점검부서">${data.deptNo}</td>
                <td data-field="설비번호">${data.equipNo}</td>
                <td data-field="설비명">${data.equipNm}</td>
                <td data-field="점검결과">${data.checkStatus}</td>
                <td data-field="점검시간"><c:out value='${fn:substring(data.checkTime, 0, 2)}:'/><c:out value='${fn:substring(data.checkTime, 2, 4)}'/></td>
                <td data-field="점검자(코드)">${data.checkBy}</td>
                <td data-field="점검자">${data.checkByNm}</td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
</div>
