<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--<!-- 검색박스내 사용자/점검자/감독자 검색시 열리는 팝업 : 트리박스 + 테이블 나오는 팝업 bPopup -->--%>

<c:import url="/header.do"/>

<body>
<!-- 로딩박스 -->
<div class="loading-box" id="loadingBar" style="display: none;">
    <div class="loader"></div>
</div>

<main class="winbox-layout page-content page-content--popup" id="searchItemPopup">
    <h1 class="page-content__heading visually-hidden">사용자/점검자/감독자 검색</h1>

    <%--<!-- 요청자,감독자,점검자 공통 값 저장 -->--%>
    <input id="chkTitleTree" type="hidden" value="${chkTitleTree}">
    <div class="splitview">
        <aside class="splitview__pane splitview__pane--sidebar">
            <div class="filter-panel filter-panel--with-section">
                
                <div class="filter-panel__section">
                    <div class="filter-panel__section-title">
                        <div class="form-field">
                            <span class="">부서를 선택해주세요.</span>
                            <label class="form-choice">
                                <input type="checkbox" value="" id="id_code1">
                                <span>전출자 포함</span>
                            </label>
                        </div>
                    </div>

                    <%--<!-- 트리메뉴 데이터 들어가는 영역 START -->--%>
                    <div class="tree-explorer__tree jstree-box" role="tree" tabindex="0">
                        <div id="divisionTree2" class="ztree"></div>
                    </div>
                </div>
                <%--<!-- 트리메뉴 데이터 들어가는 영역 END -->--%>
            </div>
        </aside>
        <div class="splitview__pane splitview__pane--content">
            <div class="result-panel" id="userDetailList">
            </div>
        </div>
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