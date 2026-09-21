<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/header.do"/>

<body>
<!-- 로딩박스 -->
<div class="loading-box" id="loadingBar" style="display: none;">
    <div class="loader"></div>
</div>

<!-- P&ID 검색 화면 -->
<main class="winbox-layout page-content page-content--popup document-viewer-page">
    <div class="page-content__placeholder">
        <h1 class="page-content__heading visually-hidden">P&amp;ID 보기</h1>
        <div class="splitview">
            <aside class="splitview__pane splitview__pane--sidebar" aria-label="P&amp;ID 정보 검색">
                <!-- 검색영역 -->
                <form class="filter-panel filter-panel--with-section" id="searchForm" method="post" autocomplete="off">
                    <div class="filter-panel__header">
                        <span class="filter-panel__title">검색</span>
                        <button class="filter-panel__toggle" type="button"
                                aria-label="정보 검색 접기" aria-expanded="true"></button>
                    </div>

                    <div class="filter-panel__search" id="filter-panel-search">
                        <div class="filter-panel__fields">
                            <input type="hidden" name="searchCondition" id="searchCondition">
                            <!-- 개발 연계: 검색 조건 영역은 filter-panel__fields를 사용하고, 각 조건은 form-field 단위로 추가·반복합니다. -->
                            <div class="form-field">
                                <label class="form-label" for="iegNo">설비, 태그 번호</label>
                                <div class="form-control-group form-control-group--vertical">
                                    <input class="form-control form-control--return" list="iegNoList" id="iegNo" name="searchKeyword" value="${pnidVO.searchKeyword}" placeholder="설비, 태그 번호 입력 후 엔터">
                                    <input class="form-control d-none" type="text" id="iegDescription" aria-label="설비명">
                                </div>
                            </div>

                            <%-- 설비정보가 2개 이상인 경우 보여줌 --%>
                            <datalist id="iegNoList"></datalist>
                        </div>
                    </div>
                    <div class="filter-panel__section">
                        <h2 class="filter-panel__section-title">연계 정보</h2>
                        
                        <div class="filter-panel__section-body">
                            <div class="linked-data" id="_DOC_LIST">
                                <%-- 문서 리스트 --%>
                            </div>
                        </div>
                    </div>
                </form>
            </aside>

            <div class="splitview__pane" role="region" aria-label="P&amp;ID 이미지">
                <div class="document-viewer document-viewer--fit-width">
                    <iframe class="pnid-iframe" id="_VIEW_IFRAME" src="" title=""></iframe>
                </div>
            </div>
        </div>
    </div>
</main>

<script src="${pageContext.request.contextPath}/resources/js/facility/custom-facility-search.js"></script>
<script>
    /* 설비검색 이벤트 */
    fnInitCustomFacilitySearch();

    /* set VAR */
    var $viewIframe = $("#_VIEW_IFRAME");
    var $btnList = $("#btnList");
    var $docList = $("#_DOC_LIST");

    // 뷰어 로드
    function fnViewPage(url, t) {
        $viewIframe.attr("src", url);
    }

    // 문서 목록 렌더링
    function renderPnidDocList(list) {
        const html = [];

        $.each(list, function (i, item) {
            var text = (item && item.text) || "";

            const viewerUrl = "${pageContext.request.contextPath}/multiview/pnid.do"
                + "?dataPath=" + encodeURIComponent(item.data || "")
                + "&searchTag=" + encodeURIComponent(item.tagNo || "");

            html.push(
                '<div class="doc-link" onclick="fnViewPage(\'' + viewerUrl + '\', this);" data-desc="' + text + '">' +
                '<span>' + (item.fileName || '') + ' [' + item.iegNo + ']</span> ' +
                '<span>' + text + '</span>' +
                '</div>'
            );
        });

        $docList.html(html.join(""));
    }

    // pnid 검색 리스트
    function fnSearchPnidList() {
        $btnList.attr("disabled", false);

        $.ajax({
            url: "${pageContext.request.contextPath}/drawing/equipPnidPopupList.do",
            type: "GET",
            dataType: "json",
            data: $("#searchForm").serialize(),
            success: function (list) {
                if (!list || list.length === 0) {
                    $viewIframe.attr("src", "about:blank");
                    $docList.empty();
                    $btnList.attr("disabled", true);

                    title = "검색";
                    content = "해당 설비의 P&ID 정보가 없습니다.";
                    fnAlert();
                    return false;
                }
                /* doc list */
                renderPnidDocList(list);

                // 첫 번째 문서 우선 로드
                const first = list[0];
                const firstViewerUrl = "${pageContext.request.contextPath}/multiview/pnid.do"
                    + "?dataPath=" + encodeURIComponent(first.data || "")
                    + "&searchTag=" + encodeURIComponent(first.tagNo || "")
                    + "&disableInitZoom=true";

                fnViewPage(firstViewerUrl);
            },
            error: function (xhr, status, error) {
                alert("P&ID 조회 중 오류가 발생했습니다.");
            }
        });
    }

    /**
     * 공통: 설비번호 검색
     * js callback 처리 부분
     */
    function fnSearchResult() {
        var iegNo = $("#iegNo").val().trim();

        if (iegNo) {
            fnSearchPnidList();
        } else {
            $docList.empty();
            $btnList.attr("disabled", true);
        }
    }

    $(function () {
        fnSearchPnidList();
    });
</script>
</body>
<c:import url="/footer.do"/>
