<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 일일안전현황 > 공사오더 팝업 > 조회결과 리스트 --%>

<script>
    var totalPage = ${paginationInfo.totalPageCount};
</script>

<%--<div id="_VIEW_RESULT_">--%>
<!-- data title -->
<div class="title-box">
    <h4 class="title03">조회결과<small>(전체 <fmt:formatNumber value="${listCount}" type="number"/>건)</small></h4>

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
            <%-- 앱 로그인 체크 --%>
            <c:if test="${sessionScope.loginInfo.iui_isadmin ne '999'}">
                <button type="button" class="btn btn-primary btn-file-download" onclick="fnExcelDownloadWorkOrder()">엑셀 다운로드</button>
            </c:if>
        </div>
    </div>
</div>

<!-- data-grid -->
<div class="table-responsive">
    <table class="table table-sm" aria-label="공사오더-조회결과">
        <thead>
        <%--<tr>
            <th scope="col" name="excelCol" data-field="첨부" class="sort icon-up">첨부</th>
            <th scope="col" name="excelCol" data-field="표준작업" class="sort icon-up">표준작업</th>
            <th scope="col" name="excelCol" data-field="오더타입" class="sort icon-up">오더타입</th>
            <th scope="col" name="excelCol" data-field="변경구분" class="sort icon-up">변경구분</th>
            <th scope="col" name="excelCol" data-field="진행상태" class="sort icon-up">진행상태</th>
            <th scope="col" name="excelCol" data-field="작업오더" class="sort icon-up">작업오더</th>
            <th scope="col" name="excelCol" data-field="오더명" class="sort icon-up">오더명</th>
            <th scope="col" name="excelCol" data-field="설계일" class="sort icon-up">설계일</th>
            <th scope="col" name="excelCol" data-field="설계시간" class="sort icon-up">설계시간</th>
            <th scope="col" name="excelCol" data-field="설계자" class="sort icon-up">설계자</th>
            <th scope="col" name="excelCol" data-field="설계부서" class="sort icon-up">설계부서</th>
            <th scope="col" name="excelCol" data-field="감독자" class="sort icon-up">감독자</th>
            <th scope="col" name="excelCol" data-field="감독부서" class="sort icon-up">감독부서</th>
            <th scope="col" name="excelCol" data-field="운전부서" class="sort icon-up">운전부서</th>
            <th scope="col" name="excelCol" data-field="정비부서" class="sort icon-up">정비부서</th>
            <th scope="col" name="excelCol" data-field="승인일" class="sort icon-up">승인일</th>
            <th scope="col" name="excelCol" data-field="허가일-발전차장" class="sort icon-up">허가일(발전차장)</th>
            <th scope="col" name="excelCol" data-field="작업중요도" class="sort icon-up">작업중요도</th>
            <th scope="col" name="excelCol" data-field="작업허가" class="sort icon-up">작업허가</th>
            <th scope="col" name="excelCol" data-field="정비조건" class="sort icon-up">정비조건</th>
            <th scope="col" name="excelCol" data-field="작업형태" class="sort icon-up">작업형태</th>
            <th scope="col" name="excelCol" data-field="설계일정-시작" class="sort icon-up">설계일정(시작)</th>
            <th scope="col" name="excelCol" data-field="설계일정-종료" class="sort icon-up">설계일정(종료)</th>
            <th scope="col" name="excelCol" data-field="설계일정-시작" class="sort icon-up">실제일정(시작)</th>
            <th scope="col" name="excelCol" data-field="설계일정-종료" class="sort icon-up">실제일정(종료)</th>
            <th scope="col" name="excelCol" data-field="잔여공기" class="sort icon-up">잔여공기</th>
            <th scope="col" name="excelCol" data-field="설계재료비" class="sort icon-up">설계재료비</th>
            <th scope="col" name="excelCol" data-field="설계노무비" class="sort icon-up">설계노무비</th>
            <th scope="col" name="excelCol" data-field="설계경비" class="sort icon-up">설계경비</th>
            <th scope="col" name="excelCol" data-field="설계금액계" class="sort icon-up">설계금액계</th>
            <th scope="col" name="excelCol" data-field="실적재료비" class="sort icon-up">실적재료비</th>
            <th scope="col" name="excelCol" data-field="실적노무비" class="sort icon-up">실적노무비</th>
            <th scope="col" name="excelCol" data-field="실적경비" class="sort icon-up">실적경비</th>
            <th scope="col" name="excelCol" data-field="실적금액계" class="sort icon-up">실적금액계</th>
            <th scope="col" name="excelCol" data-field="공사종류" class="sort icon-up">공사종류</th>
            <th scope="col" name="excelCol" data-field="공사번호" class="sort icon-up">공사번호</th>
            <th scope="col" name="excelCol" data-field="공사명" class="sort icon-up">공사명</th>
            <th scope="col" name="excelCol" data-field="JOB번호" class="sort icon-up">JOB번호</th>
            <th scope="col" name="excelCol" data-field="JOB명" class="sort icon-up">JOB명</th>
            <th scope="col" name="excelCol" data-field="설비번호" class="sort icon-up">설비번호</th>
            <th scope="col" name="excelCol" data-field="설비명" class="sort icon-up">설비명</th>
            <th scope="col" name="excelCol" data-field="설비등급" class="sort icon-up">설비등급</th>
            <th scope="col" name="excelCol" data-field="결재올리기" class="sort icon-up">결재올리기</th>
            <th scope="col" name="excelCol" data-field="WBS코드" class="sort icon-up">WBS코드</th>
            <th scope="col" name="excelCol" data-field="WBS" class="sort icon-up">WBS</th>
            <th scope="col" name="excelCol" data-field="RMB검사" class="sort icon-up">RMB검사</th>
            <th scope="col" name="excelCol" data-field="계층정보" class="sort icon-up">계층정보</th>
        </tr>--%>
        <tr>
            <th scope="col" name="excelCol" data-field="첨부">첨부</th>
            <th scope="col" name="excelCol" data-field="표준작업">표준작업</th>
            <th scope="col" name="excelCol" data-field="오더타입">오더타입</th>
            <th scope="col" name="excelCol" data-field="변경구분">변경구분</th>
            <th scope="col" name="excelCol" data-field="변경구분">변경구분</th>
            <th scope="col" name="excelCol" data-field="진행상태">진행상태</th>
            <th scope="col" name="excelCol" data-field="작업오더">작업오더</th>
            <th scope="col" name="excelCol" data-field="오더명">오더명</th>
            <th scope="col" name="excelCol" data-field="설계일">설계일</th>
            <th scope="col" name="excelCol" data-field="설계시간">설계시간</th>
            <th scope="col" name="excelCol" data-field="설계자">설계자</th>
            <th scope="col" name="excelCol" data-field="설계부서">설계부서</th>
            <th scope="col" name="excelCol" data-field="감독자">감독자</th>
            <th scope="col" name="excelCol" data-field="감독부서">감독부서</th>
            <th scope="col" name="excelCol" data-field="운전부서">운전부서</th>
            <th scope="col" name="excelCol" data-field="정비부서">정비부서</th>
            <th scope="col" name="excelCol" data-field="승인일">승인일</th>
            <th scope="col" name="excelCol" data-field="허가일(발전차장)">허가일(발전차장)</th>
            <th scope="col" name="excelCol" data-field="작업중요도">작업중요도</th>
            <th scope="col" name="excelCol" data-field="작업허가">작업허가</th>
            <th scope="col" name="excelCol" data-field="정비조건">정비조건</th>
            <th scope="col" name="excelCol" data-field="작업형태">작업형태</th>
            <th scope="col" name="excelCol" data-field="설계일정(시작)">설계일정(시작)</th>
            <th scope="col" name="excelCol" data-field="설계일정(종료)">설계일정(종료)</th>
            <th scope="col" name="excelCol" data-field="설계일정(시작)">실제일정(시작)</th>
            <th scope="col" name="excelCol" data-field="설계일정(종료)">실제일정(종료)</th>
            <th scope="col" name="excelCol" data-field="잔여공기">잔여공기</th>
            <th scope="col" name="excelCol" data-field="설계재료비">설계재료비</th>
            <th scope="col" name="excelCol" data-field="설계노무비">설계노무비</th>
            <th scope="col" name="excelCol" data-field="설계경비">설계경비</th>
            <th scope="col" name="excelCol" data-field="설계금액계">설계금액계</th>
            <th scope="col" name="excelCol" data-field="실적재료비">실적재료비</th>
            <th scope="col" name="excelCol" data-field="실적노무비">실적노무비</th>
            <th scope="col" name="excelCol" data-field="실적경비">실적경비</th>
            <th scope="col" name="excelCol" data-field="실적금액계">실적금액계</th>
            <th scope="col" name="excelCol" data-field="공사종류">공사종류</th>
            <th scope="col" name="excelCol" data-field="공사번호">공사번호</th>
            <th scope="col" name="excelCol" data-field="공사명">공사명</th>
            <th scope="col" name="excelCol" data-field="JOB번호">JOB번호</th>
            <th scope="col" name="excelCol" data-field="JOB명">JOB명</th>
            <th scope="col" name="excelCol" data-field="설비번호">설비번호</th>
            <th scope="col" name="excelCol" data-field="설비명">설비명</th>
            <th scope="col" name="excelCol" data-field="설비등급">설비등급</th>
            <th scope="col" name="excelCol" data-field="결재올리기">결재올리기</th>
            <th scope="col" name="excelCol" data-field="WBS코드">WBS코드</th>
            <th scope="col" name="excelCol" data-field="WBS">WBS</th>
            <th scope="col" name="excelCol" data-field="RMB검사">RMB검사</th>
            <th scope="col" name="excelCol" data-field="계층정보">계층정보</th>
        </tr>
        </thead>
        <tbody>
        <%-- 데이터가 없을 경우 --%>
        <c:if test="${empty list}">
            <tr>
                <td colspan="48">
                    <div class="no-data">
                        조회된 데이터가 없습니다.
                    </div>
                </td>
            </tr>
        </c:if>

        <c:forEach var="data" items="${list}" varStatus="status">
            <tr class="_TR_RESULT_DATA" data-no="${data.woNo}" onclick="fnWorkOrderResultDetailView($(this))">
                <c:choose>
                    <c:when test="${data.isImg == 'Y'}">
                        <th data-field="첨부" scope="row">
                            <!-- 첨부파일 있는 경우 -->
                            <span class="icon-attach"> attach_file </span>
                        </th>
                    </c:when>
                    <c:when test="${data.isImg != 'Y'}">
                        <th data-field="첨부" scope="row">
                            <!-- 첨부파일 없는 경우 -->
                            <span class="icon-attach disabled"> attach_file_off </span>
                        </th>
                    </c:when>
                </c:choose>
                <td data-field="표준작업">
                    <div class="me-0 form-check-inline">
                        <label class="visually-hidden" for="chkValue12">표준작업 상태</label>
                        <input type="checkbox" value="${data.isStandard}" id="chkValue12"
                               <c:if test="${data.isStandard eq 'Y'}">checked</c:if> disabled>
                    </div>
                </td>
                <td data-field="오더타입">${data.woCategory}</td>
                <td data-field="변경구분">
                    <div class="me-0 form-check-inline">
                        <label class="visually-hidden" for="chkValue13">변경구분 상태</label>
                        <input type="checkbox" value="${data.isProjectChanged}" id="chkValue13"
                               <c:if test="${data.isProjectChanged eq 'Y'}">checked</c:if> disabled>
                    </div>
                </td>
                <td data-field="변경구분">${data.projectChangeTypeDesc}</td>
                <td data-field="진행상태">${data.woStatus}</td>
                <td data-field="작업오더">${data.woNo}</td>
                <td data-field="오더명">${data.woDesc}</td>
                <td data-field="설계일">${data.requestDate}</td>
                <td data-field="설계시간">${data.requestTime}</td>
                <td data-field="설계자">${data.designName}</td>
                <td data-field="설계부서">${data.designDeptName}</td>
                <td data-field="감독자">${data.planName}</td>
                <td data-field="감독부서">${data.deptName}</td>
                <td data-field="운전부서">${data.operDeptName}</td>
                <td data-field="정비부서">${data.workDeptName}</td>
                <td data-field="승인일">${data.authoDate}</td>
                <td data-field="허가일(발전차장)">${data.permitDate}</td>
                <td data-field="작업중요도">${data.woGrade}</td>
                <td data-field="작업허가">${data.worklocation}</td>
                <td data-field="정비조건">${data.workableCondition}</td>
                <td data-field="작업형태">${data.woType}</td>
                <td data-field="설계일정(시작)">${data.planStartDate}</td>
                <td data-field="설계일정(종료)">${data.planEndDate}</td>
                <td data-field="실제일정(시작)">${data.workStartDate}</td>
                <td data-field="실제일정(종료)">${data.workEndDate}</td>
                <td data-field="잔여공기">${data.remainDay}</td>
                <td data-field="설계재료비"><fmt:formatNumber value="${data.planPartCost}" type="number"/></td>
                <td data-field="설계노무비"><fmt:formatNumber value="${data.planCraftCost}" type="number"/></td>
                <td data-field="설계경비"><fmt:formatNumber value="${data.planExpenseCost}" type="number"/></td>
                <td data-field="설계금액계"><fmt:formatNumber value="${data.planPartCost + data.planCraftCost + data.planExpenseCost}" type="number"/></td>
                <td data-field="실적재료비"><fmt:formatNumber value="${data.resultPartCost}" type="number"/></td>
                <td data-field="실적노무비"><fmt:formatNumber value="${data.resultCraftCost}" type="number"/></td>
                <td data-field="실적경비"><fmt:formatNumber value="${data.resultExpenseCost}" type="number"/></td>
                <td data-field="실적금액계"><fmt:formatNumber value="${data.resultPartCost + data.resultCraftCost + data.resultExpenseCost}" type="number"/></td>
                <td data-field="공사종류">${data.projectTypeDesc}</td>
                <td data-field="공사번호">${data.projectNo}</td>
                <td data-field="공사명">${data.projectDesc}</td>
                <td data-field="JOB번호">${data.projectJobNo}</td>
                <td data-field="JOB명">${data.jobDesc}</td>
                <td data-field="설비번호">${data.itemNo}</td>
                <td data-field="설비명">${data.itemDesc}</td>
                <td data-field="설비등급">${data.qualityGrade}</td>
                <td data-field="결재올리기">
                    <div class="me-0 form-check-inline">
                        <label class="visually-hidden" for="chkValue14">결재올리기상태</label>
                        <input type="checkbox" value="" id="chkValue14"
                               <c:if test="${data.confirmCount eq 'Y'}">checked</c:if> disabled>
                    </div>
                </td>
                <td data-field="WBS코드">${data.budgetNo}</td>
                <td data-field="WBS">${data.budgetNm}</td>
                <td data-field="RBM검사">
                    <div class="me-0 form-check-inline">
                        <label class="visually-hidden" for="chkValue15">RBM검사 상태</label>
                        <input type="checkbox" value="" id="chkValue15"
                               <c:if test="${data.isRbm eq 'Y'}">checked</c:if> disabled>
                    </div>
                </td>
                <td data-field="계층정보">${data.fnEquipDesc}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%--</div>--%>
