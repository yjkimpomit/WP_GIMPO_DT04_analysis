<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- TM현황 > 작업요청처리현황 조회 리스트 --%>
<div class="table-responsive">
    <table class="table table-sm" id="tblJobReqProcStats" aria-label="작업요청처리현황">
        <thead>
        <tr>
            <c:if test="${listOptVal == 1}">
                <th scope="rowgroup" rowspan="2" data-field="호기">호기</th>
            </c:if>
            <c:if test="${listOptVal == 2}">
                <th scope="rowgroup" rowspan="2" data-field="호기">요청부서</th>
            </c:if>
            <c:if test="${listOptVal == 3}">
                <th scope="rowgroup" rowspan="2" data-field="호기">감독부서</th>
            </c:if>
            <c:if test="${listOptVal == 4}">
                <th scope="rowgroup" rowspan="2" data-field="호기">요청자</th>
            </c:if>
            <c:if test="${listOptVal == 5}">
                <th scope="rowgroup" rowspan="2" data-field="호기">설비</th>
            </c:if>
            <c:if test="${listOptVal == 6}">
                <th scope="rowgroup" rowspan="2" data-field="호기">요청부서&감독부서</th>
            </c:if>
            <th scope="colgroup" colspan="3" data-field="발행">발행</th>
            <th scope="col" data-field="취소">취소</th>
            <th scope="colgroup" colspan="7" data-field="미결">미결</th>
            <th scope="col" data-field="완결">완결</th>
            <th scope="rowgroup" rowspan="2" data-field="계">계</th>
        </tr>
        <tr>
            <th scope="col" data-field="발행중">발행중</th>
            <th scope="col" data-field="확정대기">확정대기</th>
            <th scope="col" data-field="확정완료">확정완료</th>
            <th scope="col" data-field="취소요청">취소요청</th>
            <th scope="col" data-field="설계중">설계중</th>
            <th scope="col" data-field="작업허가중">작업허가중</th>
            <th scope="col" data-field="작업중">작업중</th>
            <th scope="col" data-field="발행중">정지중</th>
            <th scope="col" data-field="완결승인중">완결승인중</th>
            <th scope="col" data-field="실적입력중">실적입력중</th>
            <th scope="col" data-field="종결승인중">종결승인중</th>
            <th scope="col" data-field="작업완결">작업완결</th>
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
                <tr class="_TR_JOB_REQ_PROC" data-request-no="${data.hoki}" onclick="showDetail($(this),1)">
                <th scope="row" data-field="구분(호기명)">${data.hokiNm}</th>
            </c:if>
            <c:if test="${listOptVal == 2}">
                <tr class="_TR_JOB_REQ_PROC" data-request-no="${data.reqDeptNo}" onclick="showDetail($(this),2)">
                <th scope="row" data-field="구분(호기명)">${data.reqDeptNm}</th>
            </c:if>
            <c:if test="${listOptVal == 3}">
                <tr class="_TR_JOB_REQ_PROC" data-request-no="${data.deptNo}" onclick="showDetail($(this),3)">
                <th scope="row" data-field="구분(호기명)">${data.deptNm}</th>
            </c:if>
            <c:if test="${listOptVal == 4}">
                <tr class="_TR_JOB_REQ_PROC" data-request-no="${data.reqBy}" onclick="showDetail($(this),4)">
                <th scope="row" data-field="구분(호기명)">${data.reqByNm}</th>
            </c:if>
            <c:if test="${listOptVal == 5}">
                <tr class="_TR_JOB_REQ_PROC" data-request-no="${data.equipNo}" onclick="showDetail($(this),5)">
                <th scope="row" data-field="구분(호기명)">${data.equipNm}</th>
            </c:if>
            <c:if test="${listOptVal == 6}">
                <tr class="_TR_JOB_REQ_PROC" data-request-no="${data.reqDeptNo},${data.deptNo}" onclick="showDetail($(this),6)">
                <th scope="row" data-field="구분(호기명)">${data.bothDeptNm}</th>
                <input type="hidden" id="rnd" value="${data.reqDeptNo},${data.deptNo}"/>
            </c:if>
            <td data-field="발행중">${data.acnt}</td>
            <td data-field="확정대기">${data.bcnt}</td>
            <td data-field="확정완료">${data.ccnt}</td>
            <td data-field="취소요청">${data.dcnt}</td>
            <td data-field="설계중">${data.ecnt}</td>
            <td data-field="작업허가중">${data.fcnt}</td>
            <td data-field="작업중">${data.gcnt}</td>
            <td data-field="정지중">${data.hcnt}</td>
            <td data-field="완결승인중">${data.icnt}</td>
            <td data-field="실적입력중">${data.jcnt}</td>
            <td data-field="종결승인중">${data.kcnt}</td>
            <td data-field="작업완결">${data.lcnt}</td>
            <td data-field="계">${data.totCnt}</td>
            </tr>
        </c:forEach>

        <%-- 합계 발행(발행중) --%>
        <c:set var="atotal" value="0"/>
        <%-- 합계 발행(확정대기) --%>
        <c:set var="btotal" value="0"/>
        <%-- 합계 발행(확정완료) --%>
        <c:set var="ctotal" value="0"/>
        <%-- 합계 취소(취소요청) --%>
        <c:set var="dtotal" value="0"/>
        <%-- 합계 미결(설계중) --%>
        <c:set var="etotal" value="0"/>
        <%-- 합계 미결(작업허가중) --%>
        <c:set var="ftotal" value="0"/>
        <%-- 합계 미결(작업중) --%>
        <c:set var="gtotal" value="0"/>
        <%-- 합계 미결(정지중) --%>
        <c:set var="htotal" value="0"/>
        <%-- 합계 미결(완결승인중) --%>
        <c:set var="itotal" value="0"/>
        <%-- 합계 미결(실적입력중) --%>
        <c:set var="jtotal" value="0"/>
        <%-- 합계 미결(종결승인중) --%>
        <c:set var="ktotal" value="0"/>
        <%-- 합계 완결(작업완결) --%>
        <c:set var="ltotal" value="0"/>
        <%-- 합계 (계) --%>
        <c:set var="total" value="0"/>

        <c:forEach var="data" items="${list}" varStatus="status">
            <c:set var="atotal" value="${atotal + data.acnt}"/>
            <c:set var="btotal" value="${btotal + data.bcnt}"/>
            <c:set var="ctotal" value="${ctotal + data.ccnt}"/>
            <c:set var="dtotal" value="${dtotal + data.dcnt}"/>
            <c:set var="etotal" value="${etotal + data.ecnt}"/>
            <c:set var="ftotal" value="${ftotal + data.fcnt}"/>
            <c:set var="gtotal" value="${gtotal + data.gcnt}"/>
            <c:set var="htotal" value="${htotal + data.hcnt}"/>
            <c:set var="itotal" value="${itotal + data.icnt}"/>
            <c:set var="jtotal" value="${jtotal + data.jcnt}"/>
            <c:set var="ktotal" value="${ktotal + data.kcnt}"/>
            <c:set var="ltotal" value="${ltotal + data.lcnt}"/>
            <c:set var="total" value="${total + data.totCnt}"/>
        </c:forEach>
        <c:if test="${fn:length(list) != 0}">
            <tr class="total">
                <th scope="row">합계</th>
                <td>${atotal}</td>
                <td>${btotal}</td>
                <td>${ctotal}</td>
                <td>${dtotal}</td>
                <td>${etotal}</td>
                <td>${ftotal}</td>
                <td>${gtotal}</td>
                <td>${htotal}</td>
                <td>${itotal}</td>
                <td>${jtotal}</td>
                <td>${ktotal}</td>
                <td>${ltotal}</td>
                <td>${total}</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
