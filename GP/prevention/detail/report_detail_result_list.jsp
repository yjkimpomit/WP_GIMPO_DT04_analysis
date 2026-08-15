<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="listCount" value="${fn:length(list)}"/>

<%-- 예방점검현황 > 점검보고서 조회 상세내용 점검결과 리스트 --%>
<h6 class="title05">점검보고서 상세 내용 점검결과<small>(전체 <fmt:formatNumber value="${listCount}" type="number"/>건)</small></h6>
<div class="table-responsive">
    <table class="table table-sm" id="tblReportDetailResultList" aria-label="점검보고서-상세내용-점검결과">
        <thead>
        <tr>
            <th scope="col" data-field="조치유무">조치유무</th>
            <th scope="col" data-field="점검일">점검일</th>
            <th scope="col" data-field="점검시간">점검시간</th>
            <th scope="col" data-field="설비명">설비명</th>
            <th scope="col" data-field="점검항목">점검항목</th>
            <th scope="col" data-field="점검부위">점검부위</th>
            <th scope="col" data-field="점검결과">점검결과</th>
            <th scope="col" data-field="점검값">점검값</th>
            <th scope="col" data-field="하한값">하한값</th>
            <th scope="col" data-field="상한값">상한값</th>
            <th scope="col" data-field="기준값">기준값</th>
            <th scope="col" data-field="단위">단위</th>
            <th scope="col" data-field="비고">비고</th>
            <th scope="col" data-field="설비특이사항">설비특이사항</th>
        </tr>
        </thead>
        <tbody>
        <%-- 데이터가 없을 경우 --%>
        <c:if test="${fn:length(list) == 0}">
            <tr>
                <td colspan="14">
                    <div class="no-data">
                        조회된 데이터가 없습니다.
                    </div>
                </td>
            </tr>
        </c:if>

        <c:forEach var="data" items="${list}" varStatus="status">
            <tr>
                <td data-field="조치유무">조치완료</td>
                <td data-field="점검일"><c:out value='${fn:substring(data.checkDate, 0, 4)}-'/><c:out value='${fn:substring(data.checkDate, 4, 6)}-'/><c:out value='${fn:substring(data.checkDate, 6, 8)}'/></td>
                <td data-field="점검시간"><c:out value='${fn:substring(data.checkTime, 0, 2)}:'/><c:out value='${fn:substring(data.checkTime, 2, 4)}'/></td>
                <td data-field="설비명">${data.equipNm}</td>
                <td data-field="점검항목">${data.checkCode}</td>
                <td data-field="점검부위">${data.checkPosition}</td>
                <td data-field="점검결과">${data.checkStatus}</td>
                <td data-field="점검값">${data.checkValue}</td>
                <td data-field="하한값">${data.checkMin}</td>
                <td data-field="상한값">${data.checkMax}</td>
                <td data-field="기준값">${data.checkBasisVal}</td>
                <td data-field="단위">${data.uomNm}</td>
                <td data-field="비고">${data.checkDesc}</td>
                <td data-field="설비특이사항">${data.equipRemark}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
