<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--<!-- W/O 검색 팝업 : 팝업내 검색박스 + 테이블 나오는 팝업 bPopup -->--%>

<c:import url="/header.do"/>

<body>
<!-- 로딩박스 -->
<div class="loading-box" id="loadingBar" style="display: none;">
    <div class="loader"></div>
</div>

<main class="winbox-layout page-content page-content--popup" id="searchWoTreePopup">
    <h1 class="page-content__heading visually-hidden">W/O 검색</h1>
    
    <div class="result-panel" id="woSearchListForm"></div>
    
</main>

<%--<!-- 감독부서 및 요청부서 팝업 트리 정보 -->--%>
<script src="${pageContext.request.contextPath}/resources/js/tree/search-division-dept.js"></script>

<%--<!-- 기능위치번호 및 설비종류 팝업 트리 정보 -->--%>
<script src="${pageContext.request.contextPath}/resources/js/tree/search-facility-location.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tree/search-facility-system.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tree/search-facility-type.js"></script>

</body>
<c:import url="/footer.do"/>