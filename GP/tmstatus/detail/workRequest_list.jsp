<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
    var totalPage = ${paginationInfo.totalPageCount};
</script>

<%-- 조회결과 --%>
<div class="result-header" id="_VIEW_RESULT_SHOW">
    <h4 class="result-header__title">조회결과<small class="result-header__count">(전체 <fmt:formatNumber value="${listCount}" type="number"/>건)</small></h4>
    <div class="result-header__actions">
        <nav class="pagination" aria-label="페이지 이동">
            <input type="number" id="currentPage" class="form-control form-control--page" aria-label="현재 페이지" value="<c:out value='${paginationInfo.currentPageNo}'/>">
            <span aria-hidden="true">/</span>
            <span class="total"><fmt:formatNumber value="${paginationInfo.totalPageCount}" type="number"/></span>
            <button type="button" class="btn btn-secondary" onclick="fnPageMove('M')">이동</button>
            <button type="button" class="button button--neutral" onclick="fnPageMove('P')">이전</button>
            <button type="button" class="button button--neutral" onclick="fnPageMove('N')">다음</button>
            <%-- 앱 로그인 체크 --%>
            <c:if test="${sessionScope.loginInfo.iui_isadmin ne '999'}">
                <button type="button" class="button button--secondary" onclick="TMExcelDownload1()">엑셀 다운로드</button>
            </c:if>
        </nav>
    </div>
</div>

<%-- TM현황 > 작업요청확정 조회 리스트 --%>
<div class="responsive-table responsive-table--list" tabindex="0">
    <table id="tblWorkRequest" class="data-table data-table--list" aria-label="작업요청확정">
        <thead>
        <tr>
            <th scope="col" data-field="첨부">첨부</th>
            <th scope="col" name="excelCol" data-field="요청유형">요청유형</th>
            <th scope="col" name="excelCol" data-field="호기">호기</th>
            <th scope="col" name="excelCol" data-field="승인일자">승인일자</th>
            <th scope="col" name="excelCol" data-field="진행상태">진행상태</th>
            <th scope="col" name="excelCol" data-field="요청번호">요청번호</th>
            <th scope="col" name="excelCol" data-field="요청명">요청명</th>
            <th scope="col" name="excelCol" data-field="요청자">요청자</th>
            <th scope="col" name="excelCol" data-field="요청부서">요청부서</th>
            <th scope="col" name="excelCol" data-field="감독부서">감독부서</th>
            <th scope="col" name="excelCol" data-field="작업중요도">작업중요도</th>
            <th scope="col" name="excelCol" data-field="우선순위">우선순위</th>
            <th scope="col" name="excelCol" data-field="Red-TAG-필요">Red TAG 필요</th>
            <th scope="col" name="excelCol" data-field="증상">증상</th>
            <th scope="col" name="excelCol" data-field="설비번호">설비번호</th>
            <th scope="col" name="excelCol" data-field="설비명">설비명</th>
        </tr>
        </thead>
        <tbody>
        <%-- 데이터가 없을 경우 --%>
        <c:if test="${fn:length(list) == 0}">
            <tr>
                <td colspan="16">
                    <div class="no-data">
                    조회된 데이터가 없습니다.
                    </div>
                </td>
            </tr>
        </c:if>


        <c:forEach var="data" items="${list}" varStatus="status">
            <tr class="_TR_WORK_REQUEST" data-request-no="${data.noticeNo}" onclick="showDetail($(this),'${data.reqDept}','${data.dept}')">
                <c:choose>
                    <c:when test="${data.isImg == 'Y'}">
                        <th data-field="첨부" scope="row">
                            <!-- 첨부파일 있는 경우 -->
                            <span class="icon-attach"></span>
                        </th>
                    </c:when>
                    <c:when test="${data.isImg != 'Y'}">
                        <th data-field="첨부" scope="row">
                            <!-- 첨부파일 없는 경우 -->
                            <span class="icon-attach disabled"> attach_file_off </span>
                        </th>
                    </c:when>
                </c:choose>
                <td data-field="요청유형">${data.noticeType}</td>
                <td data-field="호기">${data.hoki}</td>
                <td data-field="승인일자">${data.authoDate}</td>
                <td data-field="진행상태">${data.noticeStatus}</td>
                <td data-field="요청번호">${data.noticeNo}</td>
                <td data-field="요청명">${data.description}</td>
                <td data-field="요청자">${data.reqByNm}</td>
                <td data-field="요청부서">${data.reqDeptNm}</td>
                <td data-field="감독부서">${data.deptNm}</td>
                <td data-field="작업중요도">${data.woGrade}</td>
                <td data-field="우선순위">${data.woPriority}</td>
                <td data-field="Red-TAG-필요">${data.isWorkConfirm}</td>
                <td data-field="증상">${data.symptom}</td>
                <td data-field="설비번호">${data.equipNo}</td>
                <td data-field="설비명">${data.equipNm}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    //작업요청확정 엑셀 다운로드
    function TMExcelDownload1() {
        $("#loadingBar").css("display", "");

        var excelColList = [];

        $("th[name='excelCol']").each(function () {
            var fieldValue = $(this).data("field");
            excelColList.push(fieldValue);
        });
        $("#ColList").val(excelColList);

        $.ajax({
            type: "POST"
            , url: "/tmStatus/workRequestListExcelDownload.do"
            , data: $("#form_search_work_request").serialize()
            , xhrFields: {
                responseType: 'blob'  // 응답을 Blob 형식으로 받기
            }
            , beforeSend: function () {
                $("#loadingBar").css("display", "");
            }
            , success: function (response, status, xhr) {
                //현재 날짜 가져오기
                var currentDate = new Date();
                var formattedDate = currentDate.getFullYear() + '-' +
                    (currentDate.getMonth() + 1).toString().padStart(2, '0') + '-' +
                    currentDate.getDate().toString().padStart(2, '0');

                // Blob을 사용하여 파일 다운로드 처리
                var blob = response;
                var link = document.createElement('a');
                link.href = URL.createObjectURL(blob);
                link.download = "작업요청확정_" + formattedDate + ".xlsx";
                link.click();  // 다운로드 트리거
            }
            , error: function (request, status, error) {
                console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
            }
            , complete: function () {
                $("#loadingBar").css("display", "none");
            }
        });
    }

</script>
