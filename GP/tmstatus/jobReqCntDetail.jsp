<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
    var totalPage = ${paginationInfo.totalPageCount};
</script>

<div class="modal-header">
    <h4 class="title04">작업요청 건수 상세 목록</h4>
    <button type="button" class="btn close">
        <span class="icon icon-close"></span><span>닫기</span>
    </button>
</div>
<div class="modal-body">
    <%-- 페이징 --%>
    <div class="title-box">
        <div>
            <h6 class="title05">상세정보</h6>
            <small>(전체 <fmt:formatNumber value="${listCount}" type="number"/>건)</small>
        </div>

        <div>
            <div class="page-move">
                <label for="currentPage" class="visually-hidden">이동할 페이지</label>
                <input type="number" id="currentPage" class="form-control page" value="<c:out value='${paginationInfo.currentPageNo}'/>">
                <span class="px-1">/</span>
                <span class="total"><fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number"/></span>
                <button type="button" class="btn btn-secondary" onclick="fnPageMove('M')">이동</button>
            </div>

            <div class="btn-box">
                <button type="button" class="btn btn-outline-primary" onclick="fnPageMove('P')">이전</button>
                <button type="button" class="btn btn-outline-primary" onclick="fnPageMove('N')">다음</button>
            </div>
            <input type="hidden" id="jobReqNo" value="<c:out value='${hoki}'/>">
            <input type="hidden" id="jobNo" value="<c:out value='${requestType}'/>">
        </div>
    </div>

    <div class="table-responsive">
        <table id="jobReqCntListDetail" class="table table-sm" aria-label="작업요청건수상세">
            <thead>
            <tr>
                <th scope="col" data-field="호기">호기</th>
                <th scope="col" data-field="요청번호">요청번호</th>
                <th scope="col" data-field="진행상태">진행상태</th>
                <th scope="col" data-field="요청명">요청명</th>
                <th scope="col" data-field="설비번호">설비번호</th>
                <th scope="col" data-field="설비명">설비명</th>
                <th scope="col" data-field="요청자">요청자</th>
                <th scope="col" data-field="요청부서">요청부서</th>
                <th scope="col" data-field="요청일자">요청일자</th>
                <th scope="col" data-field="감독부서">감독부서</th>
                <th scope="col" data-field="작업중요도">작업중요도</th>
                <th scope="col" data-field="우선순위">우선순위</th>
                <th scope="col" data-field="증상">증상</th>
            </tr>
            </thead>
            <tbody>
            <%-- 데이터가 없을 경우 --%>
            <c:if test="${fn:length(list) == 0}">
                <tr>
                    <td colspan="13">
                        <div class="no-data">
                            조회된 데이터가 없습니다.
                        </div>
                    </td>
                </tr>
            </c:if>
            <c:forEach var="data" items="${list}" varStatus="status">
                <tr>
                    <th scope="row" data-field="호기">${data.hokiDesc}</th>
                    <th scope="col" data-field="요청번호">${data.noticeNo}</th>
                    <td data-field="진행상태">${data.noticeStatus}</td>
                    <td data-field="요청명">${data.description}</td>
                    <td data-field="설비번호">${data.equipNo}</td>
                    <td data-field="설비명">${data.equipNm}</td>
                    <td data-field="요청자">${data.reqByNm}</td>
                    <td data-field="요청부서">${data.reqDeptNm}</td>
                    <td data-field="요청일자">${data.reqDate}</td>
                    <td data-field="감독부서">${data.deptNm}</td>
                    <td data-field="작업중요도">${data.woGrade}</td>
                    <td data-field="우선순위">${data.priority}</td>
                    <td data-field="증상">${data.symptomNm}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>