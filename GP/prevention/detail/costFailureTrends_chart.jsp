<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 예방점검현황 > 정비비용 고장경향 분석 차트 --%>
<%-- 데이터가 없을 경우 --%>
<c:if test="${empty list}">
    <!-- 빈차트로 표시 -->
</c:if>
<div class="chart-area">
<canvas class="chart-item" id="trend_chart" style="width: 100%; height: 320px;"></canvas>
</div>
<div class="label-box">
    <label class="chart-label01" for="dataset1"><input class="form-check-input" type="checkbox" id="dataset1"/>발전량(Mwh)</label>
    <label class="chart-label02" for="dataset2"><input class="form-check-input" type="checkbox" id="dataset2"/>&#8361;/Mwh</label>
    <label class="chart-label03" for="dataset3"><input class="form-check-input" type="checkbox" id="dataset3" checked/>비용(억원)</label>
    <label class="chart-label04" for="dataset4"><input class="form-check-input" type="checkbox" id="dataset4"/>이용률(%)</label>
    <label class="chart-label05" for="dataset5"><input class="form-check-input" type="checkbox" id="dataset5"/>PM(건)</label>
    <label class="chart-label06" for="dataset6"><input class="form-check-input" type="checkbox" id="dataset6"/>작업오더(건)</label>
    <label class="chart-label07" for="dataset7"><input class="form-check-input" type="checkbox" id="dataset7"/>TM(건)</label>
    <label class="chart-label08" for="dataset8"><input class="form-check-input" type="checkbox" id="dataset8"/>Failure Tendency</label>
    <label class="chart-label09" for="dataset9"><input class="form-check-input" type="checkbox" id="dataset9"/>Factor(F.T./$)</label>
    <label class="chart-label10" for="dataset10"><input class="form-check-input" type="checkbox" id="dataset10"/>Trip(건)</label>
</div>

<%-- 차트 뷰 --%>
<script>
    var costList = [
        <c:forEach var="data" items="${list}">
        {
            "labels": "${data.nmtype}",
            "mwh": ${data.mwh},
            "mwc": ${data.mwc},
            "cost": ${data.cost},
            "use_rate": ${data.useRate},
            "pm": ${data.pm},
            "wo": ${data.wo},
            "tm": ${data.tm},
            "failureTendency": ${data.failureTendency},
            "factor": ${data.factor},
            "trip": ${data.trip}
        }
        <c:if test="${not empty list and data != list[list.size()-1]}">, </c:if>
        </c:forEach>
    ];
</script>
<script src="${pageContext.request.contextPath}/resources/js/prevention/prevention-chart-custom.js"></script>