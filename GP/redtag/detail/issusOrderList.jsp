<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--<!-- data-grid -->--%>
<div class="title-box">
    <h4 class="title03">작업오더<small>(전체 <fmt:formatNumber value="${listCount}" type="number"/>건)</small></h4>
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
                <button type="button" class="btn btn-primary btn-file-download" onclick="redtagExcelDownload1()">엑셀 다운로드</button>
            </c:if>
        </div>
    </div>
</div>

<div class="table-responsive">
    <table class="table table-sm" id="tblWorkingOrder" aria-label="작업오더">
        <thead>
        <tr>
            <th scope="col" name="excelCol" data-field="오더타입">오더타입</th>
            <th scope="col" name="excelCol" data-field="진행상태">진행상태</th>
            <th scope="col" name="excelCol" data-field="작업오더">작업오더</th>
            <th scope="col" name="excelCol" data-field="오더명">오더명</th>
            <th scope="col" name="excelCol" data-field="감독자">감독자</th>
            <th scope="col" name="excelCol" data-field="설계일">설계일</th>
            <th scope="col" name="excelCol" data-field="감독부서">감독부서</th>
            <th scope="col" name="excelCol" data-field="운전부서">운전부서</th>
            <th scope="col" name="excelCol" data-field="정비부서">정비부서</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${fn:length(list) == 0}">
            <tr>
                <td colspan="12">
                    <div class="no-data">
                        조회된 데이터가 없습니다.
                    </div>
                </td>
            </tr>
        </c:if>
        <c:forEach items="${list}" var="data" varStatus="status">
            <tr data-request-no="${data.woNo}" onclick="redtagOrderDetail($(this))">
                <td data-field="오더타입">${data.woCategoryNm}</td>
                <td data-field="진행상태">${data.woStatus}</td>
                <td data-field="작업오더">${data.woNo}</td>
                <td data-field="오더명">${data.woDesc}</td>
                <td data-field="감독자">${data.planByNm}</td>
                <td data-field="설계일">
                    <c:choose>
                        <c:when test="${fn:length(data.requestDate) == 0}">
                            ${data.requestDate}
                        </c:when>
                        <c:when test="${fn:length(data.requestDate) != 0}">
                            <c:out value='${fn:substring(data.requestDate, 0, 4)}-'/><c:out value='${fn:substring(data.requestDate, 4, 6)}-'/><c:out value='${fn:substring(data.requestDate, 6, 8)}'/>
                        </c:when>
                    </c:choose>
                </td>
                <td data-field="감독부서">${data.deptNm}</td>
                <td data-field="운전부서">${data.operDeptNm}</td>
                <td data-field="정비부서">${data.workDeptNm}</td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
</div>

<script>
    var totalPage = ${paginationInfo.totalPageCount};

    function redtagExcelDownload1() {
        var excelColList = [];

        $("th[name='excelCol']").each(function () {
            var fieldValue = $(this).data("field");
            excelColList.push(fieldValue);
        });
        $("#ColList").val(excelColList);

        $.ajax({
            type: "POST"
            , url: "/redtag/issusRequestListexcelDownload.do"
            , data: $("#form_search_issus_request").serialize()
            , xhrFields: {
                responseType: 'blob'  // 응답을 Blob 형식으로 받기
            }
            , beforeSend: function () {
                $("loadingBar").css("display", "");
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
                link.download = "RedTag발행_" + formattedDate + ".xlsx";
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