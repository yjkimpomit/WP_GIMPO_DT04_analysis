<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 예방점검현황 > 점검결과 조회 리스트 --%>

<script>
    var totalPage = ${paginationInfo.totalPageCount};
</script>

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
                <button type="button" class="btn btn-primary btn-file-download" onclick="reportExcelDownload3()">엑셀 다운로드</button>
            </c:if>
        </div>
    </div>
</div>

<!-- data-grid -->
<div class="table-responsive">
    <table class="table table-sm" id="tblInspectorList" aria-label="점검결과-리스트">
        <thead>
        <tr>
            <th scope="col" name="excelCol" data-field="점검구분">점검구분</th>
            <th scope="col" name="excelCol" data-field="점검번호">점검번호</th>
            <th scope="col" name="excelCol" data-field="점검명">점검명</th>
            <th scope="col" name="excelCol" data-field="설비번호">설비번호</th>
            <th scope="col" name="excelCol" data-field="설비명">설비명</th>
            <th scope="col" name="excelCol" data-field="정비부서명">정비부서명</th>
            <th scope="col" name="excelCol" data-field="설계부서명">설계부서명</th>
        </tr>
        </thead>
        <tbody>
        <%-- 데이터가 없을 경우 --%>
        <c:if test="${fn:length(list) == 0}">
            <tr>
                <th colspan="7">
                    <div class="no-data">
                        조회된 데이터가 없습니다.
                    </div>
                </th>
            </tr>
        </c:if>

        <c:forEach var="data" items="${list}" varStatus="status">
            <tr class="_TR_RESULT_DATA" data-request-no="${data.checkListNo}" onclick="fnResultKindView($(this))">
                <th scope="col" data-field="점검구분" scope="row">${data.checkTypeNm}</th>
                <td data-field="점검번호">${data.checkListNo}</td>
                <td data-field="점검명">${data.description}</td>
                <td data-field="설비번호">${data.equipNo}</td>
                <td data-field="설비명">${data.equipNm}</td>
                <td data-field="정비부서명">${data.workDeptNm}</td>
                <td data-field="설계부서명">${data.planDeptNm}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    //점검 결과 엑셀 다운로드
    function reportExcelDownload3() {
        var excelColList = [];

        $("th[name='excelCol']").each(function () {
            var fieldValue = $(this).data("field");
            excelColList.push(fieldValue);
        });
        $("#ColList").val(excelColList);

        $.ajax({
            type: "POST"
            , url: "/prevention/selectResultListexcelDownload.do"
            , data: $("#form_search_result").serialize()
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
                link.download = "점검결과_" + formattedDate + ".xlsx";
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
