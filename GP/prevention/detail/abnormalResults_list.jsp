<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 예방점검현황 > 이상점검결과 조회 리스트 --%>

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
                <button type="button" class="btn btn-primary btn-file-download" onclick="reportExcelDownload5()">엑셀 다운로드</button>
            </c:if>
        </div>
    </div>
</div>
<%-- data-grid --%>
<div class="table-responsive flex-fill-rest">
    <table class="table table-sm" aria-label="이상점검결과-리스트">
        <thead>
        <tr>
            <th scope="col" name="excelCol" data-field="조치유무">조치유무</th>
            <th scope="col" name="excelCol" data-field="설비번호">설비번호</th>
            <th scope="col" name="excelCol" data-field="설비명">설비명</th>
            <th scope="col" name="excelCol" data-field="점검일자">점검일자</th>
            <th scope="col" name="excelCol" data-field="점검시간">점검시간</th>
            <th scope="col" name="excelCol" data-field="점검구분">점검구분</th>
            <th scope="col" name="excelCol" data-field="점검번호">점검번호</th>
            <th scope="col" name="excelCol" data-field="점검명">점검명</th>
            <th scope="col" name="excelCol" data-field="점검항목">점검항목</th>
            <th scope="col" name="excelCol" data-field="점검부위">점검부위</th>
            <th scope="col" name="excelCol" data-field="점검결과">점검결과</th>
            <th scope="col" name="excelCol" data-field="점검값">점검값</th>
            <th scope="col" name="excelCol" data-field="하한값">하한값</th>
            <th scope="col" name="excelCol" data-field="상한값">상한값</th>
            <th scope="col" name="excelCol" data-field="기준값">기준값</th>
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
                <td data-field="조치유무">${data.isRepair}</td>
                <td data-field="설비번호">${data.equipNo}</td>
                <td data-field="설비명">${data.equipNm}</td>
                <td data-field="점검일자"><c:out value='${fn:substring(data.checkDate, 0, 4)}-'/><c:out value='${fn:substring(data.checkDate, 4, 6)}-'/><c:out value='${fn:substring(data.checkDate, 6, 8)}'/></td>
                <td data-field="점검시간"><c:out value='${fn:substring(data.checkTime, 0, 2)}:'/><c:out value='${fn:substring(data.checkTime, 2, 4)}'/></td>
                <td data-field="점검구분">${data.checkTypeNm}</td>
                <td data-field="점검번호">${data.checkListNo}</td>
                <td data-field="점검명">${data.description}</td>
                <td data-field="점검항목">${data.checkCode}</td>
                <td data-field="점검부위">${data.checkPosition}</td>
                <td data-field="점검결과">${data.checkStatus}</td>
                <td data-field="점검값">${data.checkValue}</td>
                <td data-field="하한값">${data.checkMin}</td>
                <td data-field="상한값">${data.checkMax}</td>
                <td data-field="기준값">${data.checkBasisVal}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    //이상 점검 결과 엑셀 다운로드
    function reportExcelDownload5() {
        var excelColList = [];

        $("th[name='excelCol']").each(function () {
            var fieldValue = $(this).data("field");
            excelColList.push(fieldValue);
        });
        $("#ColList").val(excelColList);

        $.ajax({
            type: "POST"
            , url: "/prevention/abnormalResultsListexcelDownload.do"
            , data: $("#form_search_abnormal_results").serialize()
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
                link.download = "이상점검결과_" + formattedDate + ".xlsx";
                link.click();  // 다운로드 트리거
                $("#loadingBar").css("display", "none");
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

