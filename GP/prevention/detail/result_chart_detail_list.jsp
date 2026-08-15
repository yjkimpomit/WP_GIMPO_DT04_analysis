<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 예방점검현황 > 점검내용 리스트 --%>
<c:set var="listCount" value="${fn:length(list)}"/>

<div class="result-header">
	<h2 class="result-header__title panel-split-layout__title">점검내용 <span class="result-header__count">(전체 <fmt:formatNumber value="${listCount}" type="number"/>건)</span></h2>
</div>

<!-- <%-- data-grid : 결과 리스트 뷰 --%> -->
<div class="result-panel__body panel-split-layout__body">

	<div class="table-responsive">
		<table class="table table-sm" id="tblInspectorResultList" aria-label="점검내용(Chart)-리스트">
			<thead>
			<tr>
				<th scope="col" data-field="점검일자(일자)">점검일자(일자)</th>
				<th scope="col" data-field="점검값">점검값</th>
			</tr>
			</thead>
			<tbody>
			<%-- 데이터가 없을 경우 --%>
			<c:if test="${fn:length(list) == 0}">
				<tr>
					<td colspan="2">
						<div class="no-data">
							조회된 데이터가 없습니다.
						</div>
					</td>
				</tr>
			</c:if>

			<c:forEach var="data" items="${list}" varStatus="status">
				<tr>
					<td data-field="점검일자(일자)">${data.checkDate}</td>
					<td data-field="점검값">${data.checkValue}</td>
				</tr>
			</c:forEach>

			</tbody>
		</table>
	</div>

</div>
