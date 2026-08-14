<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%-- 예방점검현황 > 정비비용 고장경향 분석 조회 리스트 --%>
<div class="table-responsive">
    <table class="table table-sm" id="tblCostFailureList" aria-label="정비비용-고장-경향정보">
        <thead>
        <tr>
            <th scope="col" data-field="총비용(억원)">총비용(억원)</th>
            <th scope="col" data-field="재료비(억원)">재료비(억원)</th>
            <th scope="col" data-field="노무비(억원)">노무비(억원)</th>
            <th scope="col" data-field="경비(억원)">경비(억원)</th>
            <th scope="col" data-field="Max Hours(시간)">Max Hours(시간)</th>
        </tr>
        </thead>
        <tbody>
        <%-- 데이터가 없을 경우 --%>
        <c:if test="${empty list}">
            <tr>
                <th colspan="5">
                    <div class="no-data">
                        조회된 데이터가 없습니다.
                    </div>
                </th>
            </tr>
        </c:if>

        <c:if test="${not empty list}">
            <tr>
                <td data-field="총비용(억원)"><fmt:formatNumber value="${totalcost}" pattern="#,###"/></td>
                <td data-field="재료비(억원)"><fmt:formatNumber value="${materialcost}" pattern="#,###"/></td>
                <td data-field="노무비(억원)"><fmt:formatNumber value="${laborcost}" pattern="#,###"/></td>
                <td data-field="경비(억원)"><fmt:formatNumber value="${expensecost}" pattern="#,###"/></td>
                <td data-field="Max Hours(시간)"><fmt:formatNumber value="${manHour}" pattern="#,###"/></td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
