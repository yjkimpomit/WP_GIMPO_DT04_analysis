<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- data-grid -->
<div class="title-box">
    <div>
        <h4 class="title04 my-0">작업오더(Red Tag) 설계 내용</h4>
    </div>
    <!-- <div>
        <button type="button" class="btn btn-xs btn-primary">출력으로 보내기</button>
    </div> -->
</div>

<div class="table-responsive">
    <table class="table table-sm" id="tblWorkOrderDesign" aria-label="작업오더-설계-내용">
        <thead>
        <tr>
            <th scope="col" data-field="대상기기번호">대상기기번호</th>
            <th scope="col" data-field="대상기기명">대상기기명</th>
            <th scope="col" data-field="조작요청내용">조작요청내용</th>
            <th scope="col" data-field="출력자">출력자</th>
            <th scope="col" data-field="출력일자">출력일자 (년-월-일 시: 분)</th>
            <th scope="col" data-field="회수자">회수자</th>
            <th scope="col" data-field="회수일자">회수일자</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${fn:length(list) == 0}">
            <tr>
                <td colspan="7">
                    <div class="no-data">
                        조회된 데이터가 없습니다.
                    </div>
                </td>
            </tr>
        </c:if>
        <c:forEach items="${list}" var="data" varStatus="status">
            <tr data-request-no="${data.barcodeNo}" onclick="redtagWorkOrderDetail($(this))">
                <td scope="col" data-field="대상기기번호">${data.redtagNo}</td>
                <td scope="col" data-field="대상기기명">${data.redtagName}</td>
                <td scope="col" data-field="조작요청내용">${data.redtagStatus}</td>
                <td scope="col" data-field="출력자">${data.printBy}</td>
                <td scope="col" data-field="출력일자">
                    <c:choose>
                        <c:when test="${fn:length(data.printDate) == 0}">
                            ${data.printDate}
                        </c:when>
                        <c:when test="${fn:length(data.printDate) != 0}">
                            <c:out value='${fn:substring(data.printDate, 0, 4)}-'/><c:out value='${fn:substring(data.printDate, 4, 6)}-'/><c:out value='${fn:substring(data.printDate, 6, 8)}'/>
                            <c:out value='${fn:substring(data.printTime, 0, 2)}:'/><c:out value='${fn:substring(data.printTime, 2, 4)}'/>
                        </c:when>
                    </c:choose>
                </td>
                <td scope="col" data-field="회수자">${data.returnBy}</td>
                <td scope="col" data-field="회수일자">
                    <c:choose>
                        <c:when test="${fn:length(data.returnDate) == 0}">
                            ${data.returnDate}
                        </c:when>
                        <c:when test="${fn:length(data.returnDate) != 0}">
                            <c:out value='${fn:substring(data.returnDate, 0, 4)}-'/><c:out value='${fn:substring(data.returnDate, 4, 6)}-'/><c:out value='${fn:substring(data.returnDate, 6, 8)}'/>
                        </c:when>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
