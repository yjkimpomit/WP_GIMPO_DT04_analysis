<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 일일안전현황 > 경상오더 팝업 >  품질안전설계 시작 --%>

<c:set var="data" value="${list[0]}"/>

<div id="_VIEW_RESULT_LIST">
    <div class="title-box mt-2 mb-1">
        <h5 class="title04">품질안전설계</h5>
    </div>
    <div>
        <div class="table-responsive mb-2">
            <table class="table table-sm view-table" aria-label="품질안전설계">
                <colgroup>
                    <col style="width: 128px;">
                    <col style="width: 200px;">
                    <col>
                    <col style="width: 128px;">
                    <col>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row">작업오더</th>
                    <td data-field="작업오더">${data.woNo}</td>
                    <td data-field="작업상세">${data.woDesc}</td>
                    <th scope="row">진행상태</th>
                    <td data-field="진행상태">${data.woStatus}</td>
                </tr>
                <tr>
                    <th scope="row">설비번호</th>
                    <td data-field="설비번호">${data.equipNo}</td>
                    <td data-field="설비번호상세">${data.description}</td>
                    <th scope="row">설비등급</th>
                    <td data-field="설비등급">${data.qualityGrade}</td>
                </tr>
                <tr>
                    <th scope="row">계층정보</th>
                    <td data-field="계층정보" colspan="4">${data.fnEquipDesc}</td>
                </tr>
                </tbody>
            </table>
        </div>
    
        <div class="table-responsive">
            <table class="table table-sm" id="tblInspectorTypeList" aria-label="품질안전설계-리스트">
                <thead>
                <tr>
                    <th scope="col" data-field="결재번호">결재번호</th>
                    <th scope="col" data-field="발행상태">발행상태</th>
                    <th scope="col" data-field="주요작업">주요작업</th>
                    <th scope="col" data-field="추가작업">추가(보충)작업</th>
                    <th scope="col" data-field="작업일자-시작">작업일자(시작)</th>
                    <th scope="col" data-field="작업일자-종료">작업일자(종료)</th>
                    <th scope="col" data-field="작업허가시간">작업허가시간</th>
                    <th scope="col" data-field="총작업시간">총작업시간</th>
                    <th scope="col" data-field="작업위치">작업위치</th>
                </tr>
                </thead>
                <tbody>
                <%-- 데이터가 없을 경우 --%>
                <c:if test="${empty list}">
                    <tr>
                        <th colspan="9">
                            <div class="no-data">
                                조회된 데이터가 없습니다.
                            </div>
                        </th>
                    </tr>
                </c:if>
    
                <c:forEach var="data" items="${list}" varStatus="status">
                    <tr class="_TR_SAFETY_DATA" data-no="${data.woNo}" data-ano="${data.authoNo}" data-type="R" onclick="fnShowSafetyWorkPermitPop($(this))">
                        <th data-field="결재번호">${data.authoNo}</th>
                        <td data-field="발행상태">${data.printStatus}</td>
                        <td data-field="주요작업">${data.mainType}</td>
                        <td data-field="추가작업">${data.entryType}</td>
                        <td data-field="작업일자-시작">${data.printSdate}</td>
                        <td data-field="작업일자-종료">${data.printEdate}</td>
                        <td data-field="작업허가시간">${data.permitTime}</td>
                        <td data-field="총작업시간">${data.spendTime}</td>
                        <td data-field="작업위치">${data.workLocation}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    
    </div>
</div>
