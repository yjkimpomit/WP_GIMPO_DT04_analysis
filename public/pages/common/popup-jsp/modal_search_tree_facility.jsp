<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--<!-- 설비검색 팝업 : 팝업내 검색박스 + 트리박스 + 테이블 나오는 팝업 bPopup -->--%>

<c:import url="/header.do"/>

<body>
<!-- 로딩박스 -->
<div class="loading-box" id="loadingBar" style="display: none;">
    <div class="loader"></div>
</div>

<main class="winbox-layout page-content page-content--popup" id="searchFacilityPopup">
    <h1 class="page-content__heading visually-hidden">설비검색</h1>
    
    <div class="splitview">
        
        <aside class="splitview__pane splitview__pane--sidebar" aria-label="설비마스터-검색">
            
            <%--<!-- 검색영역 -->--%>
            <form class="filter-panel filter-panel--with-section" id="form_search_result1" method="post" autocomplete="off">
                
                <div class="filter-panel__header">
                    <span class="filter-panel__title">검색</span>
                    <button class="filter-panel__toggle"
                            type="button"
                            aria-label="설비마스터 검색 접기"
                            aria-expanded="true"
                            aria-controls="filter-panel-search"></button>
                </div>
                
                <div class="filter-panel__search" id="filter-panel-search">
                    
                    <!-- filter-panel__fields 안에서 form-field 단위로 반복 -->
                    <div class="filter-panel__fields">
                        
                        <div class="form-field">
                            <label class="form-label" id="equipType">설비종류</label>
                            <div class="form-control-group">
                                <input class="form-control form-control--search" id="equipTypeOption" name="eqType" onclick="searchFacilityTypeTreePopup($(this));">
                                <input class="form-control" type="text" value="" id="equipTypeInput" disabled="">
                            </div>
                        </div>
                        
                        <fieldset class="form-field">
                            <legend class="form-label">설비명</legend>
                            
                            <label class="visually-hidden" for="equipNameOption">설비명 선택1</label>
                            <input class="form-control" id="equipNameOption" name="searchKeywordTo">
                            
                            <label class="form-choice">
                                <input type="radio" value="0" id="rbAnd" name="searchCondition">
                                <span>AND</span>
                            </label>
                            <label class="form-choice">
                                <input type="radio" value="1" name="searchCondition" id="rbOr" checked>
                                <span>OR</span>
                            </label>
                            
                            <label class="visually-hidden" for="equipNameOption2">설비명 선택2</label>
                            <input class="form-control" id="equipNameOption2" name="searchKeywordFrom">
                        </fieldset>
                        
                        <div class="form-field">
                            <label class="form-label" id="fnLocation">기능위치번호</label>
                            <div class="form-control-group">
                                <input class="form-control form-control--search" id="fnLocationOption" name="locNo" onclick="searchFacilityLocTreePopup($(this));">
                                <input class="form-control" type="text" value="" id="fnLocationInput" disabled="">
                            </div>
                        </div>
                        
                        <div class="form-field">
                            <label class="form-label" for="facType">설비구분</label>
                            <select class="form-select" id="facType">
                                <option value="----------------------------------">----------------------------------</option>
                            </select>
                        </div>
                        
                        <div class="form-field">
                            <label class="form-label" for="tagNo">TagNo</label>
                            <input class="form-control" id="tagNo" type="text" name="tagNo">
                        </div>
                        
                    </div>
                    
                    <div class="filter-panel__actions">
                        <button type="button" class="button button--primary" onclick="fnFacilityDetailSearch()">검색</button>
                    </div>
                </div>
                
                <div class="filter-panel__section">
                    <div class="tree-explorer__tree" role="group" aria-label="설비분류체계">
                        <div class="tabs equipment-lookup__tree-tabs" data-tabs="" data-tab-content-loader="" data-tab-loader-initialized="true">
                            <%-- 맨 아래 3개의 js 사용 --%>
                            <ul class="nav nav-tabs" id="pills-tab2" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active" id="equipment-lookup-function-tab" data-bs-toggle="pill" data-bs-target="#equipment-lookup-function-panel" type="button" role="tab" aria-controls="equipment-lookup-function-panel" aria-selected="true">기능위치</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="equipment-lookup-system-tab" data-bs-toggle="pill" data-bs-target="#equipment-lookup-system-panel" type="button" role="tab" aria-controls="equipment-lookup-system-panel" aria-selected="false">계통</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="equipment-lookup-type-tab" data-bs-toggle="pill" data-bs-target="#equipment-lookup-type-panel" type="button" role="tab" aria-controls="equipment-lookup-type-panel" aria-selected="false">종류</button>
                                </li>
                            </ul>
                            
                            <div class="tab-content" id="equipment-lookup-tab-content">
                                <div class="tab-pane fade show active" id="equipment-lookup-function-panel" role="tabpanel" aria-labelledby="equipment-lookup-function-tab" tabindex="0">
                                    <%--<!-- 트리메뉴 데이터 들어가는 영역 START -->--%>
                                    <div class="jstree-box" role="tree">
                                        <div id="facilityMaster1" class="ztree"></div>
                                    </div>
                                    <%--<!-- 트리메뉴 데이터 들어가는 영역 END -->--%>
                                </div>
                                <div class="tab-pane fade" id="equipment-lookup-system-panel" role="tabpanel" aria-labelledby="equipment-lookup-system-tab" tabindex="0">
                                    <%--<!-- 트리메뉴 데이터 들어가는 영역 START -->--%>
                                    <div class="jstree-box" role="tree">
                                        <div id="facilityMaster2" class="ztree"></div>
                                    </div>
                                    <%--<!-- 트리메뉴 데이터 들어가는 영역 END -->--%>
                                </div>
                                <div class="tab-pane fade" id="equipment-lookup-type-panel" role="tabpanel" aria-labelledby="equipment-lookup-type-tab" tabindex="0">
                                    <%--<!-- 트리메뉴 데이터 들어가는 영역 START -->--%>
                                    <div class="jstree-box" role="tree">
                                        <div id="facilityMaster3" class="ztree"></div>
                                    </div>
                                    <%--<!-- 트리메뉴 데이터 들어가는 영역 END -->--%>
                                </div>
                            </div>
                        
                        </div>
                    </div>
                </div>
                
            </form>
                
        </aside>
        
        <div class="splitview__pane splitview__pane--content">
            
            <div class="result-panel" id="facilityMasterList"></div>
            
        </div>
    
    </div>
</main>

<%--<!-- 기능위치번호 및 설비종류 팝업 트리 정보 -->--%>
<script src="${pageContext.request.contextPath}/resources/js/tree/search-facility-location.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tree/search-facility-system.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tree/search-facility-type.js"></script>

</body>
<c:import url="/footer.do"/>
