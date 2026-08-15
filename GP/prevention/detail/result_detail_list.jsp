<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="listCount" value="${fn:length(list)}"/>

<%-- 예방점검현황 > 점검내용 리스트 --%>
<div class="result-header">
	<h4 class="result-header__title">점검내용 리스트<span class="result-header__count">(전체 <fmt:formatNumber value="${listCount}" type="number"/>건)</span></h4>
</div>

<div class="table-responsive">
    <table class="table table-sm" id="tblInspectorResultList" aria-label="점검내용-리스트">
        <thead>
        <tr>
            <th scope="col" data-field="계획일자">계획일자</th>
            <th scope="col" data-field="점검일자(일자)">점검일자(일자)</th>
            <th scope="col" data-field="점검일자(시간)">점검일자(시간)</th>
            <th scope="col" data-field="점검자">점검자</th>
            <th scope="col" data-field="점검값">점검값</th>
            <th scope="col" data-field="점검결과">점검결과</th>
            <th scope="col" data-field="W/O-No">W/O NO</th>
            <th scope="col" data-field="비고">비고</th>
            <th scope="col" data-field="설비특이사항-및-기타사항">설비특이사항 및 기타사항</th>
        </tr>
        </thead>
        <tbody>
        <%-- 데이터가 없을 경우 --%>
        <c:if test="${fn:length(list) == 0}">
            <tr>
                <td colspan="10">
                    <div class="no-data">
                        조회된 데이터가 없습니다.
                    </div>
                </td>
            </tr>
        </c:if>

        <c:forEach var="data" items="${list}" varStatus="status">
            <tr>
                <td data-field="계획일자"><c:out value='${fn:substring(data.actualDate, 0, 4)}-'/><c:out value='${fn:substring(data.actualDate, 4, 6)}-'/><c:out value='${fn:substring(data.actualDate, 6, 8)}'/></td>
                <td data-field="점검일자(일자)"><c:out value='${fn:substring(data.checkDate, 0, 4)}-'/><c:out value='${fn:substring(data.checkDate, 4, 6)}-'/><c:out value='${fn:substring(data.checkDate, 6, 8)}'/></td>
                <td data-field="점검일자(시간)"><c:out value='${fn:substring(data.checkTime, 0, 2)}:'/><c:out value='${fn:substring(data.checkTime, 2, 4)}'/></td>
                <td data-field="점검자">${data.checkByNm}</td>
                <td data-field="점검값">${data.checkValue}</td>
                <td data-field="점검결과">${data.checkStatus}</td>
                <td data-field="W/O-No">${data.woNo}</td>
                <td data-field="비고">${data.remark}</td>
                <td data-field="설비특이사항-및-기타사항">${data.equipRemark}</td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
</div>
