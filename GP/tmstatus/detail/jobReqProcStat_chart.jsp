<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- TM현황 > 작업요청처리현황 차트 --%>
<%-- 데이터가 없을 경우 --%>
<%-- <c:if test="${empty list}">
	 <!-- 빈차트로 표시 -->
</c:if> --%>

<%--  <c:forEach var="data" items="${list}" varStatus="status"> --%>
<%-- </c:forEach> --%>
<div id="procstat_chart" class="tui-chart-box">

</div>

<script>
    //검색조건에 따라 차트 타이틀 변경 값
    var searchVal = "${searchVal}";

    var chartList = [
        <c:forEach var="data" items="${chartList}">
        {
            <c:if test="${searchVal == 1}">
            "labels": "${data.hokiNm}",
            </c:if>
            <c:if test="${searchVal == 2}">
            "labels": "${data.reqDeptNm}",
            </c:if>
            <c:if test="${searchVal == 3}">
            "labels": "${data.deptNm}",
            </c:if>
            <c:if test="${searchVal == 4}">
            "labels": "${data.reqByNm}",
            </c:if>
            <c:if test="${searchVal == 5}">
            "labels": "${data.equipNm}",
            </c:if>
            <c:if test="${searchVal == 6}">
            "labels": "${data.bothDeptNm}",
            </c:if>
            "pubCnt": ${data.acnt} +${data.bcnt} + ${data.ccnt},
            "cancelCnt": ${data.dcnt},
            "susCnt": ${data.ecnt} +${data.fcnt} +${data.gcnt} +${data.hcnt} +${data.icnt} +${data.jcnt} + ${data.kcnt},
            "comCnt": ${data.lcnt}
        }
        <c:if test="${not empty chartList and data != chartList[chartList.size()-1]}">, </c:if>
        </c:forEach>
    ];

</script>
<%-- 차트 뷰 --%>
<script src="${pageContext.request.contextPath}/resources/js/tmstatus/jobReqProcStat_chart.js"></script>