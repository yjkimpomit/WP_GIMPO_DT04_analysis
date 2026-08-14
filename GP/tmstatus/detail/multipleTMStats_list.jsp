<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
    var totalPage = ${paginationInfo.totalPageCount};
</script>

<!-- 페이징 처리 -->
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
                <button type="button" class="btn btn-primary btn-file-download" onclick="TMExcelDownload2()">엑셀 다운로드</button>
            </c:if>
        </div>
    </div>
</div>

<%-- TM현황 > 다발 TM현황의 조회 리스트 --%>
<div class="table-responsive">
    <table class="table table-sm" id="tblMultiTMStats" aria-label="다발-TM현황">
        <thead>
        <tr>
            <th scope="col" name="excelCol" data-field="설비번호">설비번호</th>
            <th scope="col" name="excelCol" data-field="설비명">설비명</th>
            <!--
            1. 오름차순일 경우, class="sort icon-up" 으로 변경 하고,
            2. title="****() 오름차순" 으로 바뀌게,
            3. 최근 클릭한 요소 하나에만 class="sort icon-up active" 되도록 요청
             -->
            <input type="hidden" id="" name="" value=""/>
            <th scope="col" name="excelCol" data-field="계" class="sort icon-up" title="내림차순" id="0" onclick="sortTable('0','TOTAL_COUNT')">계</th>
            <th scope="col" name="excelCol" data-field="누설" class="sort icon-up" title="누설(Leakage)" id="1" onclick="sortTable('1','s010')">누설(Leakage)</th>
            <th scope="col" name="excelCol" data-field="오지시" class="sort icon-up" title="오지시(Indication Error)" id="2" onclick="sortTable('2','s020')">오지시(Indication Error)</th>
            <th scope="col" name="excelCol" data-field="오염" class="sort icon-up" title="오염(Contamination)" id="3" onclick="sortTable('3','s030')">오염(Contamination)</th>
            <th scope="col" name="excelCol" data-field="손상-파손" class="sort icon-up" title="손상/파손(Breakdown)" id="4" onclick="sortTable('4','s040')">손상/파손(Breakdown)</th>
            <th scope="col" name="excelCol" data-field="변형" class="sort icon-up" title="변형(Deformation)" id="5" onclick="sortTable('5','s050')">변형(Deformation)</th>
            <th scope="col" name="excelCol" data-field="파열" class="sort icon-up" title="파열(Rupture)" id="6" onclick="sortTable('6','s060')">파열(Rupture)</th>
            <th scope="col" name="excelCol" data-field="부식-침식" class="sort icon-up" title="부식/침식(Corrosion/Erosion)" id="7" onclick="sortTable('7','s070')">부식/침식(Corrosion/Erosion)</th>
            <th scope="col" name="excelCol" data-field="진동이상" class="sort icon-up" title="진동이상(Vibration)" id="8" onclick="sortTable('8','s080')">진동이상(Vibration)</th>
            <th scope="col" name="excelCol" data-field="이음-소음" class="sort icon-up" title="이음(소음)(Noise)" id="9" onclick="sortTable('9','s090')">이음(소음)(Noise)</th>
            <th scope="col" name="excelCol" data-field="단선-단락" class="sort icon-up" title="단선/단락(Disconnection/Short-circuit)" id="10" onclick="sortTable('10','s100')">단선/단락(Disconnection/Short-circuit)</th>
            <th scope="col" name="excelCol" data-field="동결" class="sort icon-up" title="동결(Freezing)" id="11" onclick="sortTable('11','s110')">동결(Freezing)</th>
            <th scope="col" name="excelCol" data-field="과부하" class="sort icon-up" title="과부하(Over Load)" id="12" onclick="sortTable('12','s120')">과부하(Over Load)</th>
        </tr>
        </thead>
        <tbody id="trBody">
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
            <tr class="_TR_MULTIPLE_TMS" data-facility-no="${data.equipNo}" onclick="showDetail($(this))">
                <th data-field="설비번호" scope="row">${data.equipNo}</th>
                <td data-field="설비명">${data.equipDesc}</td>
                <td data-field="계" id="totalCount">${data.totalCount}</td>
                <td data-field="누설" id="s010">${data.s010}</td>
                <td data-field="오지시" id="s020">${data.s020}</td>
                <td data-field="오염" id="s030">${data.s030}</td>
                <td data-field="손상/파손" id="s040">${data.s040}</td>
                <td data-field="변형" id="s050">${data.s050}</td>
                <td data-field="파열" id="s060">${data.s060}</td>
                <td data-field="부식/침식" id="s070">${data.s070}</td>
                <td data-field="진동이상" id="s080">${data.s080}</td>
                <td data-field="이음(소음)" id="s090">${data.s090}</td>
                <td data-field="단선/단락" id="s100">${data.s100}</td>
                <td data-field="동결" id="s110">${data.s110}</td>
                <td data-field="과부하" id="s120">${data.s120}</td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
</div>

<script>
    //다발TM현황 엑셀 다운로드
    function TMExcelDownload2() {
        var excelColList = [];

        $("th[name='excelCol']").each(function () {
            var fieldValue = $(this).data("field");
            excelColList.push(fieldValue);
        });
        $("#ColList").val(excelColList);

        $.ajax({
            type: "POST"
            , url: "/tmStatus/tmStatusMultipleExcelList.do"
            , data: $("#form_search_multiple_tms").serialize()
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
                link.download = "다발TM현황_" + formattedDate + ".xlsx";
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