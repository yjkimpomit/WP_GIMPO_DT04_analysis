<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--<!-- 검색박스내 설비종류 검색시 열리는 팝업 : 트리박스만 나오는 팝업 bPopup -->--%>

<c:import url="/header.do"/>

<body>
<!-- 로딩박스 -->
<div class="loading-box" id="loadingBar" style="display: none;">
    <div class="loader"></div>
</div>

<main class="winbox-layout page-content page-content--popup" id="searchFacilityTypeTreePopup">
    <h1 class="page-content__heading visually-hidden">설비종류 검색</h1>

    <%--<!-- 트리메뉴 데이터 들어가는 영역 START -->--%>
    <div class="page-content__placeholder jstree-box">
        <div id="facilityType1" class="ztree"></div>
    </div>
    <%--<!-- 트리메뉴 데이터 들어가는 영역 END -->--%>
    
</main>

<script src="${pageContext.request.contextPath}/resources/js/tree/search-facility-type.js"></script>

</body>
<c:import url="/footer.do"/>