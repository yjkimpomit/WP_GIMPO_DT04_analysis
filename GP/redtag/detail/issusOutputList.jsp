<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
    $('#chkPrintAll').click(function () {
        var checked = $('#chkPrintAll').is(':checked');
        if (checked) {
            $('input[name=chk]').prop('checked', true);
        } else {
            $('input[name=chk]').prop('checked', false);
        }
    });
</script>

<!-- data-grid -->
<div class="result-header">
	<h4 class="result-header__title">Red Tag 출력 리스트</h4>
</div>

<div class="table-responsive">
    <table class="table table-sm" id="tblWorkOrderOutput" aria-label="Red-Tag-출력-리스트">
        <thead>
        <tr>
            <th scope="col" data-field="작업오더">작업오더</th>
            <th scope="col" data-field="Barcode">Barcode</th>
            <th scope="col" data-field="대상기기번호">대상기기번호</th>
            <th scope="col" data-field="대상기기명">대상기기명</th>
            <th scope="col" data-field="조작요청내용">조작요청내용</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${fn:length(list) == 0}">
            <tr>
                <td colspan="5">
                    <div class="no-data">
                        조회된 데이터가 없습니다.
                    </div>
                </td>
            </tr>
        </c:if>
        <c:forEach items="${list}" var="data" varStatus="status">
            <tr>
                <td data-field="작업오더">${data.woNo}</td>
                <td data-field="Barcode">${data.barcodeNo}</td>
                <td data-field="대상기기번호">${data.redtagNo}</td>
                <td data-field="대상기기명">${data.redtagName}</td>
                <td data-field="조작요청내용">${data.redtagStatus}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
