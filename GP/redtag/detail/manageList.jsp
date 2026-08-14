<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
    var totalPage = ${paginationInfo.totalPageCount};
</script>

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
                <button type="button" class="btn btn-primary btn-file-download" onclick="redtagExcelDownload2()">엑셀 다운로드</button>
            </c:if>
        </div>
    </div>
</div>

<!-- data-grid -->
<div class="table-responsive flex-fill-rest">
    <table class="table table-sm" id="tblRedTagManage" aria-label="ReaTag관리대장">
        <thead>
        <tr>
            <th scope="col" name="excelCol" data-field="Tag상태">Tag상태</th>
            <th scope="col" name="excelCol" data-field="Tag번호">Tag번호</th>
            <th scope="col" name="excelCol" data-field="발행일시">발행일시</th>
            <th scope="col" name="excelCol" data-field="발행시간">발행시간</th>
            <th scope="col" name="excelCol" data-field="대상기기-번호">대상기기 번호</th>
            <th scope="col" name="excelCol" data-field="대상기기명">대상기기명</th>
            <th scope="col" name="excelCol" data-field="조작요청-내용">조작요청 내용</th>
            <th scope="col" name="excelCol" data-field="감독자">감독자</th>
            <th scope="col" name="excelCol" data-field="감독부서">감독부서</th>
            <th scope="col" name="excelCol" data-field="운전부서">운전부서</th>
            <th scope="col" name="excelCol" data-field="정비부서">정비부서</th>
            <th scope="col" name="excelCol" data-field="발행자">발행자</th>
            <th scope="col" name="excelCol" data-field="회수자">회수자</th>
            <th scope="col" name="excelCol" data-field="회수일시">회수일시</th>
            <th scope="col" name="excelCol" data-field="회수시간">회수시간</th>
        </tr>
        </thead>
        <tbody>
        <%-- 데이터가 없을 경우 --%>
        <c:if test="${fn:length(list) == 0}">
            <tr>
                <th colspan="15">
                    <div class="no-data">
                        조회된 데이터가 없습니다.
                    </div>
                </th>
            </tr>
        </c:if>

        <c:forEach var="data" items="${list}" varStatus="status">
            <tr>
                <td data-field="Tag상태">${data.redtagStatus}</td>
                <td data-field="Tag번호">${data.barcodeNo}</td>
                <td data-field="발행일시">
                    <c:choose>
                        <c:when test="${fn:length(data.printDate) == 0}">
                            ${data.printDate}
                        </c:when>
                        <c:when test="${fn:length(data.printDate) != 0}">
                            <c:out value='${fn:substring(data.printDate, 0, 4)}-'/><c:out value='${fn:substring(data.printDate, 4, 6)}-'/><c:out value='${fn:substring(data.printDate, 6, 8)}'/>
                        </c:when>
                    </c:choose>
                </td>
                <td data-field="발행시간">
                    <c:choose>
                        <c:when test="${fn:length(data.printTime) == 0}">
                            ${data.printTime}
                        </c:when>
                        <c:when test="${fn:length(data.printTime) != 0}">
                            <c:out value='${fn:substring(data.printTime, 0, 2)}:'/><c:out value='${fn:substring(data.printTime, 2, 4)}'/>
                        </c:when>
                    </c:choose>
                </td>
                <td data-field="대상기기-번호">${data.redtagNo}</td>
                <td data-field="대상기기명">${data.redtagName}</td>
                <td data-field="조작요청-내용">${data.tagStat}</td>
                <td data-field="감독자">${data.planByNm}</td>
                <td data-field="감독부서">${data.deptNm}</td>
                <td data-field="운전부서">${data.operDeptNm}</td>
                <td data-field="정비부서">${data.workDeptNm}</td>
                <td data-field="발행자">${data.printByNm}</td>
                <td data-field="회수자">${data.returnByNm}</td>
                <td data-field="회수일시">
                    <c:choose>
                        <c:when test="${fn:length(data.returnDate) == 0}">
                            ${data.returnDate}
                        </c:when>
                        <c:when test="${fn:length(data.returnDate) != 0}">
                            <c:out value='${fn:substring(data.returnDate, 0, 4)}-'/><c:out value='${fn:substring(data.returnDate, 4, 6)}-'/><c:out value='${fn:substring(data.returnDate, 6, 8)}'/>
                        </c:when>
                    </c:choose>
                </td>
                <td data-field="회수시간">
                    <c:choose>
                        <c:when test="${fn:length(data.returnTime) == 0}">
                            ${data.returnTime}
                        </c:when>
                        <c:when test="${fn:length(data.returnTime) != 0}">
                            <c:out value='${fn:substring(data.returnTime, 0, 2)}:'/><c:out value='${fn:substring(data.returnTime, 2, 4)}'/>
                        </c:when>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    function redtagExcelDownload2() {
        $("#loadingBar").css("display", "");

        var excelColList = [];

        $("th[name='excelCol']").each(function () {
            var fieldValue = $(this).data("field");
            excelColList.push(fieldValue);
        });

        $("#ColList").val(excelColList);

        $.ajax({
            type: "POST"
            , url: "/redtag/manageRequestListexcelDownload.do"
            , data: $("#form_search_manage_request").serialize()
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
                link.download = "RedTag관리대장_" + formattedDate + ".xlsx";
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
