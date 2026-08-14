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
    <h4 class="title04">작업요청 처리 현황 목록</h4>
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
            <input type="hidden" id="hokiNo" value="<c:out value='${hoki}'/>">
            <input type="hidden" id="jobNo" value="<c:out value='${requestType}'/>">
        </div>
    </div>
    <div class="table-responsive">
        <table class="table table-sm" id="tblJobReqProcStatsDetail" aria-label="작업요청처리현황상세">
            <thead>
            <tr>
                <th scope="col" data-field="RBM-검사">RBM 검사</th>
                <th scope="col" data-field="호기">호기</th>
                <th scope="col" data-field="요청번호">요청번호</th>
                <th scope="col" data-field="확정요청일자">확정요청일자</th>
                <th scope="col" data-field="진행상태">진행상태</th>
                <th scope="col" data-field="요청명">요청명</th>
                <th scope="col" data-field="확정요청시간">확정요청시간</th>
                <th scope="col" data-field="설비번호">설비번호</th>
                <th scope="col" data-field="설비명">설비명</th>
                <th scope="col" data-field="요청자">요청자</th>
                <th scope="col" data-field="요청부서">요청부서</th>
                <th scope="col" data-field="요청일자">요청일자</th>
                <th scope="col" data-field="감독자">감독자</th>
                <th scope="col" data-field="감독부서">감독부서</th>
                <th scope="col" data-field="설계일자">설계일자</th>
                <th scope="col" data-field="오더타입">오더타입</th>
                <th scope="col" data-field="작업오더">작업오더</th>
                <th scope="col" data-field="오더명">오더명</th>
                <th scope="col" data-field="운전부서">운전부서</th>
                <th scope="col" data-field="정비부서">정비부서</th>
                <th scope="col" data-field="허가일(발전차장)">허가일(발전차장)</th>
                <th scope="col" data-field="중요도">중요도</th>
                <th scope="col" data-field="작업허가">작업허가</th>
                <th scope="col" data-field="정비조건">정비조건</th>
                <th scope="col" data-field="작업형태">작업형태</th>
                <th scope="col" data-field="설계일정(시작)">설계일정(시작)</th>
                <th scope="col" data-field="설계일정(종료)">설계일정(종료)</th>
                <th scope="col" data-field="실제일정(시작)">실제일정(시작)</th>
                <th scope="col" data-field="실제일정(종료)">실제일정(종료)</th>
                <!-- <th scope="col" data-field="설계재료비">설계재료비</th>
                <th scope="col" data-field="설계노무비">설계노무비</th>
                <th scope="col" data-field="설계경비">설계경비</th>
                <th scope="col" data-field="설계금액계">설계금액계</th>
                <th scope="col" data-field="실적재료비">실적재료비</th>
                <th scope="col" data-field="실적노무비">실적노무비</th>
                <th scope="col" data-field="설적경비">설적경비</th>
                <th scope="col" data-field="실적금액계">실적금액계</th> -->
                <th scope="col" data-field="작업중요도">작업중요도</th>
                <th scope="col" data-field="우선순위">우선순위</th>
                <th scope="col" data-field="증상">증상</th>
            </tr>
            </thead>
            <tbody>
            <%-- 데이터가 없을 경우 --%>
            <c:if test="${fn:length(list) == 0}">
                <tr>
                    <th colspan="32">
                        <div class="no-data">
                            조회된 데이터가 없습니다.
                        </div>
                    </th>
                </tr>
            </c:if>

            <c:forEach var="data" items="${list}" varStatus="status">
                <tr>
                    <th scope="row" data-field="RBM-검사">${data.isRbm}</th>
                    <th scope="col" data-field="호기">${data.hokiNm}</th>
                    <th scope="col" data-field="요청번호">${data.noticeNo}</th>
                    <td data-field="확정요청일자">
                        <c:choose>
                            <c:when test="${fn:length(data.confirmDate) == 0}">
                                ${data.confirmDate}
                            </c:when>
                            <c:when test="${fn:length(data.confirmDate) != 0}">
                                <c:out value='${fn:substring(data.confirmDate, 0, 4)}-'/><c:out value='${fn:substring(data.confirmDate, 4, 6)}-'/><c:out value='${fn:substring(data.confirmDate, 6, 8)}'/>
                            </c:when>
                        </c:choose>
                    </td>
                    <td data-field="진행상태">${data.noticeStatus}</td>
                    <td data-field="요청명">${data.noticeNm}</td>
                    <td data-field="확정요청시간">
                        <c:choose>
                            <c:when test="${fn:length(data.confirmTime) == 0}">
                                ${data.confirmTime}
                            </c:when>
                            <c:when test="${fn:length(data.confirmTime) != 0}">
                                <c:out value='${fn:substring(data.confirmTime, 0, 2)}:'/><c:out value='${fn:substring(data.confirmTime, 2, 4)}'/>
                            </c:when>
                        </c:choose>
                    </td>
                    <td data-field="설비번호">${data.equipNo}</td>
                    <td data-field="설비명">${data.equipNm}</td>
                    <td data-field="요청자">${data.reqByNm}</td>
                    <td data-field="요청부서">${data.reqDeptNm}</td>
                    <td data-field="요청일자">${data.reqDate}</td>
                    <td data-field="감독자">${data.planByNm}</td>
                    <td data-field="감독부서">${data.deptNm}</td>
                    <td data-field="설계일자">
                        <c:choose>
                            <c:when test="${fn:length(data.planDate) == 0}">
                                ${data.planDate}
                            </c:when>
                            <c:when test="${fn:length(data.planDate) != 0}">
                                <c:out value='${fn:substring(data.planDate, 0, 4)}-'/><c:out value='${fn:substring(data.planDate, 4, 6)}-'/><c:out value='${fn:substring(data.planDate, 6, 8)}'/>
                            </c:when>
                        </c:choose>
                    </td>
                    <td data-field="오더타입">${data.woCategory}</td>
                    <td data-field="작업오더">${data.woNo}</td>
                    <td data-field="오더명">${data.woDesc}</td>
                    <td data-field="운전부서">${data.operDeptNm}</td>
                    <td data-field="정비부서">${data.workDeptNm}</td>
                    <td data-field="허가일(발전차장)">
                        <c:choose>
                            <c:when test="${fn:length(data.permitDate) == 0}">
                                ${data.permitDate}
                            </c:when>
                            <c:when test="${fn:length(data.permitDate) != 0}">
                                <c:out value='${fn:substring(data.permitDate, 0, 4)}-'/><c:out value='${fn:substring(data.permitDate, 4, 6)}-'/><c:out value='${fn:substring(data.permitDate, 6, 8)}'/>
                            </c:when>
                        </c:choose>
                    </td>
                    <td data-field="중요도">${data.woGrade}</td>
                    <td data-field="작업허가">${data.workLocation}</td>
                    <td data-field="정비조건">${data.workCondition}</td>
                    <td data-field="작업형태">${data.woType}</td>
                    <td data-field="설계일정(시작)">
                        <c:choose>
                            <c:when test="${fn:length(data.planStartDate) == 0}">
                                ${data.planStartDate}
                            </c:when>
                            <c:when test="${fn:length(data.planStartDate) != 0}">
                                <c:out value='${fn:substring(data.planStartDate, 0, 4)}-'/><c:out value='${fn:substring(data.planStartDate, 4, 6)}-'/><c:out value='${fn:substring(data.planStartDate, 6, 8)}'/>
                            </c:when>
                        </c:choose>
                    </td>
                    <td data-field="설계일정(종료)">
                        <c:choose>
                            <c:when test="${fn:length(data.planEndDate) == 0}">
                                ${data.planEndDate}
                            </c:when>
                            <c:when test="${fn:length(data.planEndDate) != 0}">
                                <c:out value='${fn:substring(data.planEndDate, 0, 4)}-'/><c:out value='${fn:substring(data.planEndDate, 4, 6)}-'/><c:out value='${fn:substring(data.planEndDate, 6, 8)}'/>
                            </c:when>
                        </c:choose>
                    </td>
                    <td data-field="실제일정(시작)">
                        <c:choose>
                            <c:when test="${fn:length(data.workStartDate) == 0}">
                                ${data.workStartDate}
                            </c:when>
                            <c:when test="${fn:length(data.workStartDate) != 0}">
                                <c:out value='${fn:substring(data.workStartDate, 0, 4)}-'/><c:out value='${fn:substring(data.workStartDate, 4, 6)}-'/><c:out value='${fn:substring(data.workStartDate, 6, 8)}'/>
                            </c:when>
                        </c:choose>
                    </td>
                    <td data-field="실제일정(종료)">
                        <c:choose>
                            <c:when test="${fn:length(data.workEndDate) == 0}">
                                ${data.workEndDate}
                            </c:when>
                            <c:when test="${fn:length(data.workEndDate) != 0}">
                                <c:out value='${fn:substring(data.workEndDate, 0, 4)}-'/><c:out value='${fn:substring(data.workEndDate, 4, 6)}-'/><c:out value='${fn:substring(data.workEndDate, 6, 8)}'/>
                            </c:when>
                        </c:choose>
                    </td>
                    <!-- <td data-field="설계재료비">2,000,000</td>
                    <td data-field="설계노무비">1,000,000</td>
                    <td data-field="설계경비">500,000</td>
                    <td data-field="설계금액계">3,500,000</td>
                    <td data-field="실적재료비">3,000,000</td>
                    <td data-field="실적노무비">1,000,000</td>
                    <td data-field="설적경비">25,000,000</td>
                    <td data-field="실적금액계">28,000,000</td> -->
                    <td data-field="작업중요도">${data.tmWoGrade}</td>
                    <td data-field="우선순위">${data.priority}</td>
                    <td data-field="증상">${data.symptom}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>