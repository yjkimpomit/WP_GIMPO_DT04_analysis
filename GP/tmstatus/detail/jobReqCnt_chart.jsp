<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- TM현황 > 작업요청건수 차트 --%>
<%-- 데이터가 없을 경우 --%>
<%-- <c:if test="${empty list}">
	 <!-- 빈차트로 표시 -->
</c:if> --%>

<div id="jobreqcnt_chart" class="tui-chart-box">
    <%-- chart --%>
</div>

<script>
    //검색조건에 따라 차트 타이틀 변경 값
    var chartOpt = "${chartOpt}";
    var chartType = "${chartType}";

    //요청유형에 따른 차트
    if (chartType === "1") {
        var chartList = [
            <c:forEach var="data" items="${chartList}">
            {
                <c:if test="${chartOpt == 1}">
                "labels": "${data.hokiNm}",
                </c:if>
                <c:if test="${chartOpt == 2}">
                "labels": "${data.reqDeptNm}",
                </c:if>
                <c:if test="${chartOpt == 3}">
                "labels": "${data.deptNm}",
                </c:if>
                <c:if test="${chartOpt == 4}">
                "labels": "${data.reqByNm}",
                </c:if>
                <c:if test="${chartOpt == 5}">
                "labels": "${data.equipNm}",
                </c:if>
                <c:if test="${chartOpt == 6}">
                "labels": "${data.bothDeptNm}",
                </c:if>
                "tmCnt": ${data.tmCnt},
                "reCnt": ${data.reCnt},
                "ncrCnt": ${data.ncrCnt},
                "carCnt": ${data.carCnt},
                "evCnt": ${data.evCnt},
                "etcCnt": ${data.etcCnt}
            }
            <c:if test="${not empty chartList and data != chartList[chartList.size()-1]}">, </c:if>
            </c:forEach>
        ];
//중요도에 따른 차트
    } else {
        var chartList = [
            <c:forEach var="data" items="${chartList}">
            {
                <c:if test="${chartOpt == 1}">
                "labels": "${data.hokiNm}",
                </c:if>
                <c:if test="${chartOpt == 2}">
                "labels": "${data.reqDeptNm}",
                </c:if>
                <c:if test="${chartOpt == 3}">
                "labels": "${data.deptNm}",
                </c:if>
                <c:if test="${chartOpt == 4}">
                "labels": "${data.reqByNm}",
                </c:if>
                <c:if test="${chartOpt == 5}">
                "labels": "${data.equipNm}",
                </c:if>
                <c:if test="${chartOpt == 6}">
                "labels": "${data.bothDeptNm}",
                </c:if>
                "aCnt": ${data.aCnt},
                "bCnt": ${data.bCnt},
                "cCnt": ${data.cCnt},
                "etcCnt": ${data.etcCnt}
            }
            <c:if test="${not empty chartList and data != chartList[chartList.size()-1]}">, </c:if>
            </c:forEach>
        ];
    }
</script>

<%-- 차트 뷰 --%>
<script src="${pageContext.request.contextPath}/resources/js/tmstatus/jobReqCnt_chart.js"></script>