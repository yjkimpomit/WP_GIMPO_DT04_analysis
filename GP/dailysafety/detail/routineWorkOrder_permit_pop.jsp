<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 일일안전현황 > 경상오더 팝업 >  품질안전설계 > 안전작업허가서 --%>

<%--<div class="modal fade detail-box" tabindex="-1" id="safetyWorkPermitPop">--%>
<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-fullscreen-lg-down modal-lg modal-xl">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="title04">
                안전작업허가서
            </h5>
            <button type="button" class="btn close">
                <span class="icon icon-close"></span><span>닫기</span>
            </button>
        </div>
        <div class="modal-body">
            <c:set var="data" value="${list[0]}"/>

            <div class="table-responsive">
                <table class="table table-sm view-table" aria-label="안전작업허가서-기본정보">
                    <colgroup>
                        <col style="width: 128px;">
                        <col>
                        <col style="width: 128px;">
                        <col>
                    </colgroup>
                    <tbody>
                    <tr>
                        <th scope="row">오더번호</th>
                        <td colspan="3">
                            <c:if test="${empty list}"><span class="text-danger">정보가 없습니다</span></c:if>
                            ${data.woNo}
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">감독부서</th>
                        <td>${data.deptName}</td>
                        <th scope="row">공사구분</th>
                        <td>${data.projectTypeDesc}</td>
                    </tr>
                    <tr>
                        <th scope="row">공사명/작업명</th>
                        <td colspan="3">${data.woDesc}</td>
                    </tr>
                    <tr>
                        <th scope="row">작업장소</th>
                        <td colspan="3">${data.workLocation}</td>
                    </tr>
                    <tr>
                        <th scope="row">공사업체명</th>
                        <td colspan="3">${data.workDeptName}</td>
                    </tr>

                    <tr>
                        <th scope="row">위험작업</th>
                        <td colspan="3">
                            <c:set var="isQsCount" value="0"/>

                            <c:if test="${data.isQsFire eq 'Y'}">화기 <c:set var="isQsCount" value="${isQsCount + 1}"/></c:if>
                            <c:if test="${data.isQsDanger eq 'Y'}"><c:if test="${isQsCount > 0}">,</c:if> 일반 <c:set var="isQsCount" value="${isQsCount + 1}"/></c:if>
                            <c:if test="${data.isQsNarrow eq 'Y'}"><c:if test="${isQsCount > 0}">,</c:if> 밀폐 <c:set var="isQsCount" value="${isQsCount + 1}"/></c:if>
                            <c:if test="${data.isQsHigh eq 'Y'}"><c:if test="${isQsCount > 0}">,</c:if> 고소 <c:set var="isQsCount" value="${isQsCount + 1}"/></c:if>
                            <c:if test="${data.isQsHeavy eq 'Y'}"><c:if test="${isQsCount > 0}">,</c:if> 중량물 <c:set var="isQsCount" value="${isQsCount + 1}"/></c:if>
                            <c:if test="${data.isQsElectricity eq 'Y'}"><c:if test="${isQsCount > 0}">,</c:if> 정전 <c:set var="isQsCount" value="${isQsCount + 1}"/></c:if>
                            <c:if test="${data.isQsExcavation eq 'Y'}"><c:if test="${isQsCount > 0}">,</c:if> 굴착 <c:set var="isQsCount" value="${isQsCount + 1}"/></c:if>
                            <c:if test="${data.isQsDive eq 'Y'}"><c:if test="${isQsCount > 0}">,</c:if> 잠수 <c:set var="isQsCount" value="${isQsCount + 1}"/></c:if>
                            <c:if test="${data.isQsRadiation eq 'Y'}"><c:if test="${isQsCount > 0}">,</c:if> 방사선 <c:set var="isQsCount" value="${isQsCount + 1}"/></c:if>
                            <c:if test="${data.isQsChemical eq 'Y'}"><c:if test="${isQsCount > 0}">,</c:if> 화학물질 <c:set var="isQsCount" value="${isQsCount + 1}"/></c:if>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">작업시간</th>
                        <td colspan="3">
                            <c:set var="requestDate" value="${fn:split(data.requestDate, '~')}"/>
                            <c:set var="requestTime" value="${fn:split(data.requestTime, '~')}"/>
                            ${requestDate[0]} ${requestTime[0]} ~ ${requestDate[1]} ${requestTime[1]}
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">작업인원</th>
                        <td class="text-nowrap">
                            <c:set var="headCount" value="${fn:split(data.headCount, '/')}"/>
                            경상(명): <strong><fmt:formatNumber value="${headCount[0]}" type="number"/></strong>명, 외부(명): <strong><fmt:formatNumber value="${headCount[1]}" type="number"/></strong>명
                        </td>
                        <th scope="row">위험도</th>
                        <td>
                            <c:choose>
                                <c:when test="${data.isQsDanger eq 'Y' and isQsCount == 1}">하</c:when>
                                <c:when test="${isQsCount == 1}">중</c:when>
                                <c:when test="${isQsCount >= 2}">상</c:when>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">공사감독</th>
                        <td colspan="3">
                            ${sessionScope.loginInfo.iui_user_name}
                        </td>
                    <tr>
                        <th scope="row">작업단계</th>
                        <td>
                            <c:forEach var="data" items="${list}" varStatus="status">
                                ${data.keysteps} <c:if test="${not status.last}"><br></c:if>
                            </c:forEach>
                        </td>
                        <th scope="row">유해/위험요인</th>
                        <td>
                            <c:forEach var="data" items="${list}" varStatus="status">
                                ${data.hazards} <c:if test="${not status.last}"><br></c:if>
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">감소대책</th>
                        <td colspan="3">
                            <c:forEach var="data" items="${list}" varStatus="status">
                                ${data.controls} <c:if test="${not status.last}"><br></c:if>
                            </c:forEach>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%--</div>--%>
