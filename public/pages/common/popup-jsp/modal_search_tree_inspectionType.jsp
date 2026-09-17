<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--<!-- 점검종류 팝업 -->--%>

<c:import url="/header.do"/>

<body>
<!-- 로딩박스 -->
<div class="loading-box" id="loadingBar" style="display: none;">
    <div class="loader"></div>
</div>

<main class="winbox-layout page-content page-content--popup" id="searchResultPopup">
    <h1 class="page-content__heading visually-hidden">점검종류 검색</h1>
    
    <%--<!-- 검색결과 리스트 -->--%>
    <div class="search-box" aria-label="점검종류-검색">
        <form id="form_search_result2" method="post" autocomplete="off">
            <div class="row">
                <div class="col-md-4">
                    <label class="form-label" for="inspectorTypeCode">CODE</label>
                    <input class="form-control" id="inspectorTypeCode" name="code">
                </div>
                <div class="col-md">
                    <label class="form-label" for="inspectorTypeDesc">DESCRIPTION</label>
                    <input class="form-control" id="inspectorTypeDesc" name="description">
                </div>

                <div class="col-md-auto">
                    <button type="button" class="btn btn-primary" onclick="fnCodeSearch()">
                        <span class="icon icon-search"></span>
                        <span>검색</span>
                    </button>
                </div>
            </div>
        </form>
    </div>

    <div class="table-responsive" id="codeDetailList">

    </div>
    
</main>

<%--<!-- 감독부서 및 요청부서 팝업 트리 정보 -->--%>
<script src="${pageContext.request.contextPath}/resources/js/tree/search-division-dept.js"></script>

<%--<!-- 기능위치번호 및 설비종류 팝업 트리 정보 -->--%>
<script src="${pageContext.request.contextPath}/resources/js/tree/search-facility-location.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tree/search-facility-system.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tree/search-facility-type.js"></script>

</body>
<c:import url="/footer.do"/>