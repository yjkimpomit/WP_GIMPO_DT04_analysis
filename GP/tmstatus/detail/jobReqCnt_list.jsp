<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- TM현황 > 작업요청건수 조회 리스트 --%>
<div class="table-responsive">
    <table id="jobReqCntList" class="table table-sm" aria-label="작업요청건수">
        <thead>
        <tr>
            <c:if test="${listOptVal == 1}">
                <c:if test="${listType == 1}">
                    <th scope="rowgroup" rowspan="2" data-field="호기">호기</th>
                    <th scope="colgroup" colspan="2">TM</th>
                    <th scope="colgroup" colspan="2">설비개선</th>
                    <th scope="colgroup" colspan="2">NCR</th>
                    <th scope="colgroup" colspan="2">푸른신호등</th>
                    <th scope="colgroup" colspan="2">유사고장</th>
                    <th scope="colgroup" colspan="2">기타</th>
                    <th scope="rowgroup" rowspan="2" data-field="계">계</th>
                </c:if>
                <c:if test="${listType == 2}">
                    <th scope="rowgroup" rowspan="2" data-field="호기">호기</th>
                    <th scope="colgroup" colspan="2">A등급</th>
                    <th scope="colgroup" colspan="2">B등급</th>
                    <th scope="colgroup" colspan="2">C등급</th>
                    <th scope="colgroup" colspan="2">기타등급</th>
                    <th scope="colgroup" colspan="2"></th>
                    <th scope="colgroup" colspan="2"></th>
                    <th scope="rowgroup" rowspan="2" data-field="계">계</th>
                </c:if>
            </c:if>
            <c:if test="${listOptVal == 2}">
                <c:if test="${listType == 1}">
                    <th scope="rowgroup" rowspan="2" data-field="호기">요청부서</th>
                    <th scope="colgroup" colspan="2">TM</th>
                    <th scope="colgroup" colspan="2">설비개선</th>
                    <th scope="colgroup" colspan="2">NCR</th>
                    <th scope="colgroup" colspan="2">푸른신호등</th>
                    <th scope="colgroup" colspan="2">유사고장</th>
                    <th scope="colgroup" colspan="2">기타</th>
                    <th scope="rowgroup" rowspan="2" data-field="계">계</th>
                </c:if>
                <c:if test="${listType == 2}">
                    <th scope="rowgroup" rowspan="2" data-field="호기">요청부서</th>
                    <th scope="colgroup" colspan="2">A등급</th>
                    <th scope="colgroup" colspan="2">B등급</th>
                    <th scope="colgroup" colspan="2">C등급</th>
                    <th scope="colgroup" colspan="2">기타등급</th>
                    <th scope="colgroup" colspan="2"></th>
                    <th scope="colgroup" colspan="2"></th>
                    <th scope="rowgroup" rowspan="2" data-field="계">계</th>
                </c:if>
            </c:if>
            <c:if test="${listOptVal == 3}">
                <c:if test="${listType == 1}">
                    <th scope="rowgroup" rowspan="2" data-field="호기">감독부서</th>
                    <th scope="colgroup" colspan="2">TM</th>
                    <th scope="colgroup" colspan="2">설비개선</th>
                    <th scope="colgroup" colspan="2">NCR</th>
                    <th scope="colgroup" colspan="2">푸른신호등</th>
                    <th scope="colgroup" colspan="2">유사고장</th>
                    <th scope="colgroup" colspan="2">기타</th>
                    <th scope="rowgroup" rowspan="2" data-field="계">계</th>
                </c:if>
                <c:if test="${listType == 2}">
                    <th scope="rowgroup" rowspan="2" data-field="호기">감독부서</th>
                    <th scope="colgroup" colspan="2">A등급</th>
                    <th scope="colgroup" colspan="2">B등급</th>
                    <th scope="colgroup" colspan="2">C등급</th>
                    <th scope="colgroup" colspan="2">기타등급</th>
                    <th scope="colgroup" colspan="2"></th>
                    <th scope="colgroup" colspan="2"></th>
                    <th scope="rowgroup" rowspan="2" data-field="계">계</th>
                </c:if>
            </c:if>
            <c:if test="${listOptVal == 4}">
                <c:if test="${listType == 1}">
                    <th scope="rowgroup" rowspan="2" data-field="호기">요청자</th>
                    <th scope="colgroup" colspan="2">TM</th>
                    <th scope="colgroup" colspan="2">설비개선</th>
                    <th scope="colgroup" colspan="2">NCR</th>
                    <th scope="colgroup" colspan="2">푸른신호등</th>
                    <th scope="colgroup" colspan="2">유사고장</th>
                    <th scope="colgroup" colspan="2">기타</th>
                    <th scope="rowgroup" rowspan="2" data-field="계">계</th>
                </c:if>
                <c:if test="${listType == 2}">
                    <th scope="rowgroup" rowspan="2" data-field="호기">요청자</th>
                    <th scope="colgroup" colspan="2">A등급</th>
                    <th scope="colgroup" colspan="2">B등급</th>
                    <th scope="colgroup" colspan="2">C등급</th>
                    <th scope="colgroup" colspan="2">기타등급</th>
                    <th scope="colgroup" colspan="2"></th>
                    <th scope="colgroup" colspan="2"></th>
                    <th scope="rowgroup" rowspan="2" data-field="계">계</th>
                </c:if>
            </c:if>
            <c:if test="${listOptVal == 5}">
                <c:if test="${listType == 1}">
                    <th scope="rowgroup" rowspan="2" data-field="호기">설비</th>
                    <th scope="colgroup" colspan="2">TM</th>
                    <th scope="colgroup" colspan="2">설비개선</th>
                    <th scope="colgroup" colspan="2">NCR</th>
                    <th scope="colgroup" colspan="2">푸른신호등</th>
                    <th scope="colgroup" colspan="2">유사고장</th>
                    <th scope="colgroup" colspan="2">기타</th>
                    <th scope="rowgroup" rowspan="2" data-field="계">계</th>
                </c:if>
                <c:if test="${listType == 2}">
                    <th scope="rowgroup" rowspan="2" data-field="호기">설비</th>
                    <th scope="colgroup" colspan="2">A등급</th>
                    <th scope="colgroup" colspan="2">B등급</th>
                    <th scope="colgroup" colspan="2">C등급</th>
                    <th scope="colgroup" colspan="2">기타등급</th>
                    <th scope="colgroup" colspan="2"></th>
                    <th scope="colgroup" colspan="2"></th>
                    <th scope="rowgroup" rowspan="2" data-field="계">계</th>
                </c:if>
            </c:if>
            <c:if test="${listOptVal == 6}">
                <c:if test="${listType == 1}">
                    <th scope="rowgroup" rowspan="2" data-field="호기">요청자&감독부서</th>
                    <th scope="colgroup" colspan="2">TM</th>
                    <th scope="colgroup" colspan="2">설비개선</th>
                    <th scope="colgroup" colspan="2">NCR</th>
                    <th scope="colgroup" colspan="2">푸른신호등</th>
                    <th scope="colgroup" colspan="2">유사고장</th>
                    <th scope="colgroup" colspan="2">기타</th>
                    <th scope="rowgroup" rowspan="2" data-field="계">계</th>
                </c:if>
                <c:if test="${listType == 2}">
                    <th scope="rowgroup" rowspan="2" data-field="호기">요청자&감독부서</th>
                    <th scope="colgroup" colspan="2">A등급</th>
                    <th scope="colgroup" colspan="2">B등급</th>
                    <th scope="colgroup" colspan="2">C등급</th>
                    <th scope="colgroup" colspan="2">기타등급</th>
                    <th scope="colgroup" colspan="2"></th>
                    <th scope="colgroup" colspan="2"></th>
                    <th scope="rowgroup" rowspan="2" data-field="계">계</th>
                </c:if>
            </c:if>
        </tr>
        <tr>
            <th scope="col" data-field="TM-비율">건수</th>
            <th scope="col" data-field="TM-비율">비율(%)</th>
            <th scope="col" data-field="설비개선-비율">건수</th>
            <th scope="col" data-field="설비개선-비율">비율(%)</th>
            <th scope="col" data-field="NCR-건수">건수</th>
            <th scope="col" data-field="NCR-비율">비율(%)</th>
            <th scope="col" data-field="푸른신호등-건수">건수</th>
            <th scope="col" data-field="푸른신호등-비율">비율(%)</th>
            <th scope="col" data-field="유사고장-건수">건수</th>
            <th scope="col" data-field="유사고장-비율">비율(%)</th>
            <th scope="col" data-field="기타-건수">건수</th>
            <th scope="col" data-field="기타-비율">비율(%)</th>
        </tr>
        </thead>
        <tbody>
        <%-- 데이터가 없을 경우 --%>
        <c:if test="${fn:length(list) == 0}">
            <tr>
                <td colspan="14">
                    <div class="no-data">
                        조회된 데이터가 없습니다.
                    </div>
                </td>
            </tr>
        </c:if>


        <c:forEach var="data" items="${list}" varStatus="status">
            <c:if test="${listOptVal == 1}">
                <tr class="_TR_JOB_RC" data-request-no="${data.hoki}" onclick="showDetail($(this),1)">
                <th data-field="호기" scope="row">${data.hokiNm}</th>
            </c:if>
            <c:if test="${listOptVal == 2}">
                <tr class="_TR_JOB_RC" data-request-no="${data.reqDeptNo}" onclick="showDetail($(this),2)">
                <th data-field="호기" scope="row">${data.reqDeptNm}</th>
            </c:if>
            <c:if test="${listOptVal == 3}">
                <tr class="_TR_JOB_RC" data-request-no="${data.deptNo}" onclick="showDetail($(this),3)">
                <th data-field="호기" scope="row">${data.deptNm}</th>
            </c:if>
            <c:if test="${listOptVal == 4}">
                <tr class="_TR_JOB_RC" data-request-no="${data.reqBy}" onclick="showDetail($(this),4)">
                <th data-field="호기" scope="row">${data.reqByNm}</th>
            </c:if>
            <c:if test="${listOptVal == 5}">
                <tr class="_TR_JOB_RC" data-request-no="${data.equipNo}" onclick="showDetail($(this),5)">
                <th data-field="호기" scope="row">${data.equipNm}</th>
            </c:if>
            <c:if test="${listOptVal == 6}">
                <tr class="_TR_JOB_RC" data-request-no="${data.reqDeptNo},${data.deptNo}" onclick="showDetail($(this),6)">
                <th data-field="호기" scope="row">${data.bothDeptNm}</th>
                <input type="hidden" id="rnd" value="${data.reqDeptNo},${data.deptNo}"/>

            </c:if>
            <c:if test="${listType == 1}">
                <td data-field="TM-건수">${data.tmCnt}</td>
                <td data-field="TM-비율">${data.tmRate}</td>
                <td data-field="설비개선-건수">${data.reCnt}</td>
                <td data-field="설비개선-비율">${data.reRate}</td>
                <td data-field="NCR-건수">${data.ncrCnt}</td>
                <td data-field="NCR-비율">${data.ncrRate}</td>
                <td data-field="푸른신호등건수">${data.carCnt}</td>
                <td data-field="푸른신호등-비율">${data.carRate}</td>
                <td data-field="유사고장-건수">${data.evCnt}</td>
                <td data-field="유사고장-비율">${data.evRate}</td>
                <td data-field="기타-건수">${data.etcCnt}</td>
                <td data-field="기타-비율">${data.etcRATE}</td>
                <td data-field="계">${data.totalCnt}</td>
            </c:if>
            <c:if test="${listType == 2}">
                <td data-field="TM-건수">${data.aCnt}</td>
                <td data-field="TM-비율">${data.aRate}</td>
                <td data-field="설비개선-건수">${data.bCnt}</td>
                <td data-field="설비개선-비율">${data.bRate}</td>
                <td data-field="NCR-건수">${data.cCnt}</td>
                <td data-field="NCR-비율">${data.cRate}</td>
                <td data-field="푸른신호등건수">${data.etcCnt}</td>
                <td data-field="푸른신호등-비율">${data.etcRATE}</td>
                <td data-field="유사고장-건수">${data.evCnt}</td>
                <td data-field="유사고장-비율">${data.evRate}</td>
                <td data-field="기타-건수">${data.carCnt}</td>
                <td data-field="기타-비율">${data.carRate}</td>
                <td data-field="계">${data.totalCnt}</td>
            </c:if>
            </tr>
        </c:forEach>

        <%-- 합계 TM(건수) --%>
        <c:set var="tmTotal" value="0"/>
        <%-- 합계 TM(비율) --%>
        <c:set var="tmRateTotal" value="0"/>
        <%-- 합계 설비개선(건수) --%>
        <c:set var="reTotal" value="0"/>
        <%-- 합계 설비개선(비율) --%>
        <c:set var="reRateTotal" value="0"/>
        <%-- 합계 NCR(건수) --%>
        <c:set var="ncrTotal" value="0"/>
        <%-- 합계 NCR(비율) --%>
        <c:set var="ncrRateTotal" value="0"/>
        <%-- 합계 푸른신호등(건수) --%>
        <c:set var="carTotal" value="0"/>
        <%-- 합계 푸른신호등(비율) --%>
        <c:set var="carRateTotal" value="0"/>
        <%-- 합계 유사고장(건수) --%>
        <c:set var="evTotal" value="0"/>
        <%-- 합계 유사고장(비율) --%>
        <c:set var="evRateTotal" value="0"/>
        <%-- 합계 기타(건수) --%>
        <c:set var="etcTotal" value="0"/>
        <%-- 합계 기타(비율) --%>
        <c:set var="etcRateTotal" value="0"/>
        <%-- 합계 (계) --%>
        <c:set var="total" value="0"/>

        <%-- 중요도 --%>
        <%-- 합계 A등급(건수) --%>
        <c:set var="aTotal" value="0"/>
        <%-- 합계 A등급(비율) --%>
        <c:set var="aRateTotal" value="0"/>
        <%-- 합계 B등급(건수) --%>
        <c:set var="bTotal" value="0"/>
        <%-- 합계 B등급(비율) --%>
        <c:set var="bRateTotal" value="0"/>
        <%-- 합계 C등급(건수) --%>
        <c:set var="cTotal" value="0"/>
        <%-- 합계 C등급(비율) --%>
        <c:set var="cRateTotal" value="0"/>

        <c:if test="${listType == 1}">
            <c:forEach var="data" items="${list}" varStatus="status">
                <c:set var="tmTotal" value="${tmTotal + data.tmCnt}"/>
                <%-- <c:set var="tmRateTotal" value="${tmRateTotal + data.tmRate}" /> --%>
                <c:set var="reTotal" value="${reTotal + data.reCnt}"/>
                <%-- <c:set var="reRateTotal" value="${reRateTotal + data.reRate}" /> --%>
                <c:set var="ncrTotal" value="${ncrTotal + data.ncrCnt}"/>
                <%-- <c:set var="ncrRateTotal" value="${ncrRateTotal + data.ncrRate}" /> --%>
                <c:set var="carTotal" value="${carTotal + data.carCnt}"/>
                <%-- <c:set var="carRateTotal" value="${carRateTotal + data.carRate}" /> --%>
                <c:set var="evTotal" value="${evTotal + data.evCnt}"/>
                <%-- <c:set var="evRateTotal" value="${evRateTotal + data.evRate}" /> --%>
                <c:set var="etcTotal" value="${etcTotal + data.etcCnt}"/>
                <%-- <c:set var="etcRateTotal" value="${etcRateTotal + data.etcRATE}" /> --%>
                <c:set var="total" value="${total + data.totalCnt}"/>
            </c:forEach>
        </c:if>
        <c:if test="${listType == 2}">
            <c:forEach var="data" items="${list}" varStatus="status">
                <c:set var="aTotal" value="${aTotal + data.aCnt}"/>
                <c:set var="bTotal" value="${bTotal + data.bCnt}"/>
                <c:set var="cTotal" value="${cTotal + data.cCnt}"/>
                <c:set var="etcTotal" value="${etcTotal + data.etcCnt}"/>
                <c:set var="total" value="${total + data.totalCnt}"/>
            </c:forEach>
        </c:if>

        <script>
            var tmRate = ${tmTotal};
            var reRate = ${reTotal};
            var ncrRate = ${ncrTotal};
            var carRate = ${carTotal};
            var evRate = ${evTotal};
            var etcRate = ${etcTotal};

            var aRate = ${aTotal};
            var bRate = ${bTotal};
            var cRate = ${cTotal};

            var listTotal = ${total};

            var tmRateVal = (tmRate / listTotal * 100).toFixed(1);
            var reRateVal = (reRate / listTotal * 100).toFixed(1);
            var ncrRateVal = (ncrRate / listTotal * 100).toFixed(1);
            var carRateVal = (carRate / listTotal * 100).toFixed(1);
            var evRateVal = (evRate / listTotal * 100).toFixed(1);
            var etcRateVal = (etcRate / listTotal * 100).toFixed(1);

            var aRateVal = (aRate / listTotal * 100).toFixed(1);
            var bRateVal = (bRate / listTotal * 100).toFixed(1);
            var cRateVal = (cRate / listTotal * 100).toFixed(1);

            <c:if test="${fn:length(list) != 0}">
            if ('${listType}' === '1') {
                document.getElementById("tmRateTotal").innerText = tmRateVal;
                document.getElementById("reRateTotal").innerText = reRateVal;
                document.getElementById("ncrRateTotal").innerText = ncrRateVal;
            } else {
                document.getElementById("aRateTotal").innerText = aRateVal;
                document.getElementById("bRateTotal").innerText = bRateVal;
                document.getElementById("cRateTotal").innerText = cRateVal;
            }

            document.getElementById("carRateTotal").innerText = carRateVal;
            document.getElementById("evRateTotal").innerText = evRateVal;
            document.getElementById("etcRateTotal").innerText = etcRateVal;
            </c:if>

        </script>
        <c:if test="${fn:length(list) != 0}">
            <tr class="total">
                <th scope="row">합계</th>
                <c:if test="${listType == 1}">
                    <td>${tmTotal}</td>
                    <td id="tmRateTotal"></td>
                    <td>${reTotal}</td>
                    <td id="reRateTotal"></td>
                    <td>${ncrTotal}</td>
                    <td id="ncrRateTotal"></td>
                    <td>${carTotal}</td>
                    <td id="carRateTotal"></td>
                    <td>${evTotal}</td>
                    <td id="evRateTotal"></td>
                    <td>${etcTotal}</td>
                    <td id="etcRateTotal"></td>
                </c:if>
                <c:if test="${listType == 2}">
                    <td>${aTotal}</td>
                    <td id="aRateTotal"></td>
                    <td>${bTotal}</td>
                    <td id="bRateTotal"></td>
                    <td>${cTotal}</td>
                    <td id="cRateTotal"></td>
                    <td>${etcTotal}</td>
                    <td id="etcRateTotal"></td>
                    <td>${evTotal}</td>
                    <td id="evRateTotal"></td>
                    <td>${carTotal}</td>
                    <td id="carRateTotal"></td>
                </c:if>
                <td>${total}</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
