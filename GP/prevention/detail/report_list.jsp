<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
    var totalPage = ${paginationInfo.totalPageCount};
</script>

<div class="title-box d-none" id="_VIEW_RESULT_SHOW">
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
                <button type="button" class="btn btn-primary btn-file-download" onclick="reportExcelDownload2()">엑셀 다운로드</button>
            </c:if>
        </div>
    </div>
</div>
<%-- 예방점검현황 > 점검보고서 조회 리스트 --%>
<div class="table-responsive">
    <table class="table table-sm" id="tblReportList" aria-label="점검보고서-리스트">
        <thead>
        <tr>
            <th scope="col" data-field="첨부">첨부</th>
            <th scope="col" name="excelCol" data-field="사업소">사업소</th>
            <th scope="col" name="excelCol" data-field="제목">제목</th>
            <th scope="col" name="excelCol" data-field="종합의견">종합의견</th>
            <th scope="col" name="excelCol" data-field="상태">상태</th>
            <th scope="col" name="excelCol" data-field="요청일자">요청일자</th>
            <th scope="col" name="excelCol" data-field="요청자">요청자</th>
            <th scope="col" name="excelCol" data-field="승인일자">승인일자</th>
            <th scope="col" name="excelCol" data-field="감독자">감독자</th>
            <th scope="col" name="excelCol" data-field="요청번호">요청번호</th>
        </tr>
        </thead>
        <tbody>
        <%-- 데이터가 없을 경우 --%>
        <c:if test="${fn:length(list) == 0}">
            <tr>
                <td colspan="10">
                    <div class="no-data">
                        조회된 데이터가 없습니다.
                    </div>
                </td>
            </tr>
        </c:if>

        <c:forEach var="data" items="${list}" varStatus="status">
            <tr class="_TR_LIST_DATA" data-request-no="${data.authoNo}" onclick="fnReportDetailView($(this))">
                <td data-field="첨부">${data.isImg}</td>
                <td data-field="사업소">${data.eqOrgNm}</td>
                <td data-field="제목">${data.checkTitle}</td>
                <td data-field="종합의견">${data.checkDesc}</td>
                <td data-field="상태">${data.caStatus}</td>
                <td data-field="요청일자"><c:out value='${fn:substring(data.enterDate, 0, 4)}-'/><c:out value='${fn:substring(data.enterDate, 4, 6)}-'/><c:out value='${fn:substring(data.enterDate, 6, 8)}'/></td>
                <td data-field="요청자">${data.requestByNm}</td>
                <td data-field="승인일자">
                    <c:choose>
                        <c:when test="${fn:length(data.recDate) == 0}">
                            ${data.recDate}
                        </c:when>
                        <c:when test="${fn:length(data.recDate) != 0}">
                            <c:out value='${fn:substring(data.recDate, 0, 4)}-'/><c:out value='${fn:substring(data.recDate, 4, 6)}-'/><c:out value='${fn:substring(data.recDate, 6, 8)}'/>
                        </c:when>
                    </c:choose>
                </td>
                <td data-field="감독자">${data.authoByNm}</td>
                <td data-field="요청번호">${data.authoNo}</td>
            </tr>
        </c:forEach>


        </tbody>
    </table>
</div>

<script>
    //점검 보고서 엑셀 다운로드
    function reportExcelDownload2() {
        var excelColList = [];

        $("th[name='excelCol']").each(function () {
            var fieldValue = $(this).data("field");
            excelColList.push(fieldValue);
        });
        $("#ColList").val(excelColList);

        $.ajax({
            type: "POST"
            , url: "/prevention/selectReportListexcelDownload.do"
            , data: $("#form_search_report").serialize()
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
                link.download = "점검보고서_" + formattedDate + ".xlsx";
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
