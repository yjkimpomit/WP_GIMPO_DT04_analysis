<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="listCount" value="${fn:length(list)}"/>

<%-- 예방점검현황 > 점검종류 리스트 --%>
<div class="result-header">
	<h2 class="result-header__title panel-split-layout__title">점검종류 <span class="result-header__count">(전체 <fmt:formatNumber value="${listCount}" type="number"/>건)</span></h2>
</div>

<div class="result-panel__body panel-split-layout__body">
		
	<div class="table-responsive">
		<table class="table table-sm" id="tblInspectorTypeList" aria-label="점검종류(Chart)-리스트">
			<thead>
			<tr>
				<th scope="col" data-field="점검종류">점검종류</th>
				<th scope="col" data-field="점검주기">점검주기</th>
				<th scope="col" data-field="점검항목">점검항목</th>
				<th scope="col" data-field="점검부위">점검부위</th>
				<th scope="col" data-field="하한값">하한값</th>
				<th scope="col" data-field="상한값">상한값</th>
				<th scope="col" data-field="기준값">기준값</th>
			</tr>
			</thead>
			<tbody>
			<%-- 데이터가 없을 경우 --%>
			<c:if test="${fn:length(list) == 0}">
				<tr>
					<td colspan="7">
						<div class="no-data">
							조회된 데이터가 없습니다.
						</div>
					</td>
				</tr>
			</c:if>

			<c:forEach var="data" items="${list}" varStatus="status">
				<tr class="_TR_RESULT_KIND" data-request-no="${data.checkDetailNo}" onclick="fnChartDetailView($(this))">
					<td data-field="점검종류">${data.checkGbnNm}</td>
					<td data-field="점검주기">${data.periodTypeNm}</td>
					<td data-field="점검항목">${data.checkCode}</td>
					<td data-field="점검부위">${data.checkPosition}</td>
					<td data-field="하한값">${data.checkMin}</td>
					<td data-field="상한값">${data.checkMax}</td>
					<td data-field="기준값">${data.checkBasisVal}</td>
				</tr>
			</c:forEach>

			</tbody>
		</table>
	</div>

</div>