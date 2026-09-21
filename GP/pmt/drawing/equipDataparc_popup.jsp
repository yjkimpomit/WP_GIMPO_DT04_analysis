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

<!-- dataPARC 화면 -->
<main class="winbox-layout page-content page-content--popup document-viewer-page">
    <div class="page-content__placeholder page-content__placeholder--flex">
        <h1 class="page-content__heading visually-hidden">dataPARC 보기</h1>
        <div class="splitview">
            <aside class="splitview__pane splitview__pane--sidebar" aria-label="dataPARC 정보 검색">
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
                                <label class="form-label" for="iegNo">설비, dataPARC 검색</label>
                                <div class="form-control-group form-control-group--vertical">
                                    <input class="form-control form-control--return" placeholder="TAG 번호, 설비번호, P&ID 번호" list="iegNoList" id="iegNo" name="searchKeyword" placeholder="" value="<c:out value='${dataparcVO.searchKeyword}'/>">
                                    <input class="form-control" type="text" id="iegDescription" name="iegDescription" aria-label="설비명" readonly>
                                </div>
                            </div>
                            
                            <%-- 설비정보가 2개 이상인 경우 보여줌 --%>
                            <datalist id="iegNoList"></datalist>
                        </div>
                        <div class="filter-panel__actions">
                            <button type="button" class="button button--secondary" id="btnList" onclick="toggleDocuList()" disabled>목록보기</button>
                        </div>
                    </div>
                    
                    <div class="filter-panel__section" aria-labelledby="dataparc-category-title">
                        <h2 class="filter-panel__section-title" id="dataparc-category-title">카테고리</h2>
                        
                        <div class="filter-panel__section-body">
                            <fieldset class="form-field dataparc-unit-group">
                                <legend class="form-label">1호기</legend>
                                <div class="form-field__content dataparc-category-buttons" data-pressed-button-group>
                                    <button type="button" class="button button--accent-mint" aria-pressed="false" onclick="fnViewPageCategory('/drawing/dataparc/ICMS/2001_MAIN_BOILER.svg')">BOILER</button>
                                    <button type="button" class="button button--accent-mint" aria-pressed="false" onclick="fnViewPageCategory('/drawing/dataparc/ICMS/2002_MAIN_BOP.svg')">BOP</button>
                                    <button type="button" class="button button--accent-mint" aria-pressed="false" onclick="fnViewPageCategory('/drawing/dataparc/ICMS/2003_MAIN_PACKAGE.svg')">PACKAGE</button>
                                    <button type="button" class="button button--accent-mint" aria-pressed="false" onclick="fnViewPageCategory('/drawing/dataparc/ICMS/3004_MAIN_COMMON.svg')">COMMON</button>
                                    <button type="button" class="button button--accent-mint" aria-pressed="false" onclick="fnViewPageCategory('/drawing/dataparc/ICMS/2005_MAIN_TURBINE.svg')">TURBINE</button>
                                    <button type="button" class="button button--accent-mint" aria-pressed="false" onclick="fnViewPageCategory('/drawing/dataparc/ICMS/9/2000_PLANT%20OVERVIEW.svg')">OVERVIEW</button>
                                    <button type="button" class="button button--accent-mint" aria-pressed="false" onclick="fnViewPageCategory('/drawing/dataparc/ECMS/No.01_OVERVIEW.svg')">ECMS</button>
                                </div>
                            </fieldset>
                            
                            <fieldset class="form-field dataparc-unit-group">
                                <legend class="form-label">2호기</legend>
                                <div class="form-field__content dataparc-category-buttons" data-pressed-button-group>
                                    <button type="button" class="button button--accent-teal" aria-pressed="false" onclick="fnViewPageCategory('/drawing/dataparc/ICMS/4001_MAIN_BOILER.svg')">BOILER</button>
                                    <button type="button" class="button button--accent-teal" aria-pressed="false" onclick="fnViewPageCategory('/drawing/dataparc/ICMS/4002_MAIN_BOP.svg')">BOP</button>
                                    <button type="button" class="button button--accent-teal" aria-pressed="false" onclick="fnViewPageCategory('/drawing/dataparc/ICMS/4003_MAIN_PACKAGE.svg')">PACKAGE</button>
                                    <button type="button" class="button button--accent-teal" aria-pressed="false" onclick="fnViewPageCategory('/drawing/dataparc/ICMS/3004_MAIN_COMMON.svg')">COMMON</button>
                                    <button type="button" class="button button--accent-teal" aria-pressed="false" onclick="fnViewPageCategory('/drawing/dataparc/ICMS/4005_MAIN_TURBINE.svg')">TURBINE</button>
                                    <button type="button" class="button button--accent-teal" aria-pressed="false" onclick="fnViewPageCategory('/drawing/dataparc/ICMS/10/4000_PLANT%20OVERVIEW.svg')">OVERVIEW</button>
                                    <button type="button" class="button button--accent-teal" aria-pressed="false" onclick="fnViewPageCategory('/drawing/dataparc/ECMS/No.01_OVERVIEW.svg')">ECMS</button>
                                </div>
                            </fieldset>
                        </div>
                        
                    </div>
                </form>
            </aside>
            <div class="splitview__pane" role="region" aria-label="dataPARC 이미지">
                <div class="document-viewer document-viewer--fit-width">
                    <iframe class="dataparc-iframe" id="_VIEW_IFRAME" src=""></iframe>
                </div>
                <!-- 연계문서 -->
                <div class="doc-box active d-none" id="_DOC_VIEW" hidden>
                    <div class="doc-header">
                        <strong>연계문서</strong>
                        <span class="icon icon-close" title="닫기" onclick="toggleDocuList();"></span>
                    </div>
                    <div class="linked-data" id="_DOC_LIST">
                        <%-- 문서 리스트 --%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%--<div class="popup-body has-iframe">
    &lt;%&ndash; 호기별 카테고리 &ndash;%&gt;
    &lt;%&ndash;<div class="grid grid--2 dataparc">
        <div class="grid__item">
            <div class="dataparc-category">
                <h4>9호기</h4>
                <div class="category-list">
                </div>
            </div>
        </div>
        <div class="grid__item">
            <div class="dataparc-category">
                <h4>10호기</h4>
                <div class="category-list">
                </div>
            </div>
        </div>
    </div>&ndash;%&gt;
    
    
    <div class="iframe-box">
    
    
    </div>
</div>--%>

<script src="${pageContext.request.contextPath}/resources/js/facility/custom-facility-search.js"></script>
<script>
    /* 설비검색 이벤트 */
    fnInitCustomFacilitySearch();

    /*function toggleDocuList(flag) {
        $("#_DOC_VIEW").toggleClass("d-none");
        $("#_DOC_VIEW").toggleClass("active");
    }*/
	/* 개발 참고: 기존 모달 팝업 방식에서 WinBox 방식으로 변경되었습니다. 해당 화면을 별도 페이지로 생성하여 WinBox에서 호출될 수 있도록 연결 부탁드립니다.
    *  연결 영역: 현재 페이지의 id="_DOC_VIEW" 부분
    * */
	function toggleDocuList() {
		var topWindow = window.top;

		var box = new topWindow.WinBox("문서 목록", {
			root: topWindow.document.body,
			//url:
			url: "",

			width: Math.min(480, topWindow.innerWidth - 20),
			height: Math.min(400, topWindow.innerHeight - 20),

			x: "center",
			y: "center",

			class: [
				"no-full",
				"app-winbox",
				"app-winbox--detail"
			],

			onresize: function () {
				if (!this.min) {
					this.move("center", "center");
				}
			},

			onclose: function () {
				topWindow.removeEventListener("resize", resizeHandler);
			}
		});

		function resizeHandler() {
			if (!box || !box.g || box.min) return;

			box.resize(
				Math.min(1400, topWindow.innerWidth - 20),
				Math.floor(topWindow.innerHeight * 0.94)
			);

			box.move("center", "center");
		}

		topWindow.addEventListener("resize", resizeHandler);
	}

    // 뷰어 로드
    function fnViewPage(url, t) {
        if (!isFacilityNo) {
            $("#iegDescription").val($(t).data("desc"));
        }

        $("#_VIEW_IFRAME").attr("src", url);
    }

    /* 카테고리 페이지 로드 */
    function fnViewPageCategory(t) {
        var url = "${pageContext.request.contextPath}/multiview/dataparc.do?dataPath=" + t;
        fnViewPage(url, '');
    }

    // 문서 목록 렌더링
    function renderDataparcDocList(list) {
        const html = [];

        $.each(list, function (i, item) {
            var text = (item && item.text) || "";

            const viewerUrl = "${pageContext.request.contextPath}/multiview/dataparc.do"
                + "?dataPath=" + encodeURIComponent(item.data || "")
                + "&searchTag=" + encodeURIComponent(item.tagNo || "");

            html.push(
                '<div class="doc-link" onclick="fnViewPage(\'' + viewerUrl + '\', this); toggleDocuList();" data-desc="[' + item.iegNo + '] ' + text + '">' +
                '<span>' + (item.fileName || '') + ' [' + item.iegNo + ']</span> ' +
                '<span>' + text + '</span>' +
                '</div>'
            );
        });

        $("#_DOC_LIST").html(html.join(""));
    }

    // 검색
    function fnSearchDataParcList(iegNo) {
        $("#btnList").attr("disabled", false);

        $.ajax({
            url: "${pageContext.request.contextPath}/drawing/equipDataparcPopupList.do",
            type: "GET",
            dataType: "json",
            data: {searchKeyword: iegNo},
            success: function (list) {
                if (!list || list.length === 0) {
                    $("#_VIEW_IFRAME").attr("src", "about:blank");
                    $("#_DOC_LIST").empty();
                    $("#btnList").attr("disabled", true);
                    $("#_DOC_VIEW").addClass("d-none").removeClass("active");

                    title = "검색";
                    content = "해당 설비의 dataPARC 정보가 없습니다.";
                    fnAlert();
                    return false;
                }

                renderDataparcDocList(list);

                const first = list[0];
                const firstViewerUrl = "${pageContext.request.contextPath}/multiview/dataparc.do"
                    + "?dataPath=" + encodeURIComponent(first.data || "")
                    + "&searchTag=" + encodeURIComponent(first.tagNo || "");

                fnViewPage(firstViewerUrl);

                /* 설비번호가 이니면 tagno descripton */
                if (!isFacilityNo) {
                    var pnidIegNo = "[" + first.iegNo + "] ";
                    $("#iegDescription").val(pnidIegNo + first.text);
                }

                if (list.length === 1) {
                    $("#_DOC_VIEW").addClass("d-none").removeClass("active");
                } else {
                    $("#_DOC_VIEW").removeClass("d-none").addClass("active");
                }
            },
            error: function (xhr, status, error) {
                alert("dataPARC 조회 중 오류가 발생했습니다.");
            }
        });
    }

    /**
     * 공통: 설비번호 검색
     * js callback 처리 부분
     */
    function fnSearchResult() {
   	    const params = new URLSearchParams(window.location.search);
   	    const dataPath = params.get("dataPath");
   	    const searchTag = params.get("searchTag");

   	    if (dataPath) {
   	        const viewerUrl = "${pageContext.request.contextPath}/multiview/dataparc.do"
   	            + "?dataPath=" + encodeURIComponent(dataPath)
   	            + "&searchTag=" + encodeURIComponent(searchTag || "");

   	        fnViewPage(viewerUrl);
   	        return;
   	    }
   	    
        var iegNo = $("#iegNo").val().trim();

        if (iegNo) {
            fnSearchDataParcList(iegNo);
        } else {
            $("#_DOC_LIST").empty();
            $("#btnList").attr("disabled", true);
        }
    }

    $(function () {
        const params = new URLSearchParams(window.location.search);
        const dataPath = params.get("dataPath");
        const searchTag = params.get("searchTag");

        if (dataPath) {
            const viewerUrl = "${pageContext.request.contextPath}/multiview/dataparc.do"
                + "?dataPath=" + encodeURIComponent(dataPath)
                + "&searchTag=" + encodeURIComponent(searchTag || "");
            
            // 최초 이동용 파라미터 제거
            const cleanUrl = new URL(window.location.href);
            cleanUrl.searchParams.delete("dataPath");
            cleanUrl.searchParams.delete("searchTag");
            history.replaceState(null, "", cleanUrl);
            
            fnViewPage(viewerUrl);
            return;
        }
        
        var iegNo = $("#iegNo").val().trim();
        if (iegNo) {
            fnSearchDataParcList(iegNo);
        }
        else {
            // default svg
            fnViewPageCategory('/drawing/dataparc/ICMS/2001_MAIN_BOILER.svg');
        }
    });
</script>
</body>
<c:import url="/footer.do"/>
