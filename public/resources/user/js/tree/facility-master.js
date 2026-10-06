/**
 * 파일명: resources\user\js\tree\facility-master.js
 * 설명: 설비 마스터 트리 정보의 공통 메소드 *
 */

'use strict';

function fnLoadFacilityTree(zNodes) {
    let treeObj;
    let sourceNodes = [];
    let childrenByParent = new Map();
    let sourceNodeById = new Map();
    let loadedNodeById = new Map();

    // zTree에 추가할 노드 데이터 생성
    function createTreeNode(sourceNode, open) {
        const childNodes = childrenByParent.get(sourceNode.id);
        return Object.assign({}, sourceNode, {
            open: open === true,
            isParent: Boolean(childNodes && childNodes.length),
            _childrenLoaded: false
        });
    }

    // 초기 1~2레벨 트리 생성 및 원본 데이터 인덱싱
    function initializeLazyTree(nodes) {
        sourceNodes = Array.isArray(nodes) ? nodes : [];
        childrenByParent = new Map();
        sourceNodeById = new Map();
        loadedNodeById = new Map();

        for (const node of sourceNodes) {
            sourceNodeById.set(node.id, node);

            if (!childrenByParent.has(node.parent)) {
                childrenByParent.set(node.parent, []);
            }
            childrenByParent.get(node.parent).push(node);
        }

        const initialNodes = (childrenByParent.get('#') || []).map(function (rootNode) {
            const node = createTreeNode(rootNode, true);
            const children = (childrenByParent.get(rootNode.id) || []).map(function (childNode) {
                return createTreeNode(childNode, false);
            });

            if (children.length) {
                node.children = children;
                node._childrenLoaded = true;
            }

            return node;
        });

        treeObj = $.fn.zTree.init($("#facTree"), setting, initialNodes);
        for (const node of treeObj.transformToArray(treeObj.getNodes() || [])) {
            loadedNodeById.set(node.id, node);
        }
    }

    // 선택한 노드의 직계 자식만 지연 로딩
    function loadDirectChildren(node) {
        if (!node || node._childrenLoaded) return;

        const childNodes = childrenByParent.get(node.id) || [];
        node._childrenLoaded = true;
        if (!childNodes.length) return;

        const addedNodes = treeObj.addNodes(node, -1, childNodes.map(function (childNode) {
            return createTreeNode(childNode, false);
        }), true) || [];

        for (const addedNode of addedNodes) {
            loadedNodeById.set(addedNode.id, addedNode);
        }
    }

    // 검색 노드까지의 경로를 단계적으로 로딩
    function ensureNodeLoaded(nodeId) {
        if (loadedNodeById.has(nodeId)) return loadedNodeById.get(nodeId);

        const path = [];
        let sourceNode = sourceNodeById.get(nodeId);
        const visited = new Set();

        while (sourceNode && !visited.has(sourceNode.id)) {
            path.unshift(sourceNode.id);
            visited.add(sourceNode.id);
            sourceNode = sourceNodeById.get(sourceNode.parent);
        }

        for (const pathNodeId of path) {
            if (loadedNodeById.has(pathNodeId)) continue;

            const pathSourceNode = sourceNodeById.get(pathNodeId);
            const parentNode = pathSourceNode && loadedNodeById.get(pathSourceNode.parent);
            if (!parentNode) return null;
            loadDirectChildren(parentNode);
        }

        return loadedNodeById.get(nodeId) || null;
    }

    // zTree 설정
    var setting = {
        view: {
            showIcon: false,
            nameIsHTML: true,
            showTitle: false,
            expandSpeed: ""
        },
        data: {
            key: {
                name: 'text'
            },
            simpleData: {
                enable: true,
                idKey: 'id',
                pIdKey: 'parent',
                rootPId: '#'
            }
        },
        callback: {
            beforeExpand: function (treeId, treeNode) {
                loadDirectChildren(treeNode);
                return true;
            },
            onNodeCreated: function (event, treeId, node) {
            },
            onClick: function (event, treeId, treeNode, clickFlag) {
                try {
                    // 마지막 노드(leaf)/레벨 5(4)일 때만 우측 패널 컨텐츠 로드
                    if (treeNode && (treeNode.isParent === false || treeNode.level >= 4)) {
                        const url = treeNode['data-url'];
                        const level = treeNode['data-level'];
                        const no = treeNode['data-no'];
                        if (!url) return;

                        // 멀티뷰 팝업
                        fnOpenPopupStandard(url, "설비상세정보");
                    }
                } catch (e) {
                    console.error('Error fnLoadFacilityTree() :', e);
                }
            }
        }
    };

    // zTree 초기화
    initializeLazyTree(zNodes);

    /** 트리 노드 열기/닫기 변수 */
    let facTreeExpandedAll = true;

    // 트리를 초기 2레벨 표시 상태로 복원
    function resetTreeToLevel2() {
        initializeLazyTree(sourceNodes);
        facTreeExpandedAll = true;
    }

    // 전체 펼치기에 필요한 레벨까지 노드 로딩
    function loadNodesThroughLevel(maxParentLevel) {
        const nodes = (treeObj.getNodes() || []).slice();

        for (let i = 0; i < nodes.length; i++) {
            const node = nodes[i];
            if (!node.isParent || node.level > maxParentLevel) continue;

            loadDirectChildren(node);
            if (node.children && node.children.length) {
                nodes.push.apply(nodes, node.children);
            }
        }

        return nodes;
    }

    // 검색 실행 로직 분리
    function executeSearch(searchString) {
        if (!searchString || searchString.length < 2) return;

        $('#facTree').find('.text-highlight').removeClass('text-highlight');
        const q = searchString.trim().toLowerCase();
        const nodes = sourceNodes.filter(function (node) {
            const text = String(node.text || '').trim().toLowerCase();
            const no = (node['data-no'] != null ? String(node['data-no']) : '').toLowerCase();
            return q && (text.indexOf(q) !== -1 || no.indexOf(q) !== -1);
        }).map(function (node) {
            return ensureNodeLoaded(node.id);
        }).filter(Boolean);

        let searchCondition = $('#facSelect option:selected').val();

        // 설비(1) 또는 부품(2) 검색 공통 처리
        for (let i = 0; i < nodes.length; i++) {
            let n = nodes[i];
            openParentsTree(n);
            $("#" + n.tId + "_a").addClass('text-highlight');
            if (i === 0) {
                treeObj.selectNode(n);
            }
        }

        if (String(searchCondition) === '2') {
            $.ajax({
                type: "POST",
                url: "/facility/treePartSearch.do",
                data: {ietDecription: searchString},
                dataType: "json",
                success: function (data) {
                    const resultList = JSON.parse(data.result);
                    partSearchSelect(resultList);
                },
                error: function (request, status, error) {
                    console.error("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
                }
            });
        }
        facTreeExpandedAll = false;
    }

    // 검색 기능 구현 (설비명: zTree Fuzzy search, 부품: 서버 검색 결과 강조)
    $('#facSearchInput').off('keypress.zTreeSearch').on('keypress.zTreeSearch', function (e) {
        if (e.keyCode === 13) {
            var searchString = $(this).val();

            if (searchString.length >= 2) {
                $("#facLoadingBar").show();
                setTimeout(function () {
                    executeSearch(searchString);
                    $("#facLoadingBar").hide();
                }, 0);
            }
        }
    });

    /**
     * 트리 노드 열기/닫기
     */
    $('#facSearchButton').on('click', function () {
        if (facTreeExpandedAll === false) {
            // 닫기(개선): 열린 부모만 깊은 레벨부터 닫기
            $("#facLoadingBar").show();

            resetTreeToLevel2();
            $("#facLoadingBar").hide();
            $("#facSearchButton").removeClass("is-expanded").addClass("is-collapsed").attr("aria-label", "트리 전체 펼치기");

        } else {
            // 전체 노드 기준: 부모노드(자식 보유 노드)만 재귀적으로 펼치기
            if (sourceNodes.length > 0) {
                $("#facLoadingBar").show();

                setTimeout(function () {
                    const nodes = loadNodesThroughLevel(3);
                    for (const element of nodes) {
                        const n = element;
                        // 레벨5 까지
                        if (n?.isParent && n.level <= 3 && n.open !== true) {
                            treeObj.expandNode(n, true, false, false);
                        }
                    }

                    $("#facLoadingBar").hide();
                    facTreeExpandedAll = false;

                    $("#facSearchButton").removeClass("is-collapsed").addClass("is-expanded").attr("aria-label", "트리 전체 접기");

                }, 0);
            }
        }
    });

    // **부모 트리 펼치기**
    function openParentsTree(node) {
        if (!node) return;

        // 재귀적 부모노드 오픈
        let current = node;
        while (current) {
            const p = current.getParentNode ? current.getParentNode() : null;
            if (p) treeObj.expandNode(p, true, false, false);
            current = p;
        }

        // 자신 열기
        loadDirectChildren(node);
        treeObj.expandNode(node, true, false, false);
    }

    // **부품 검색 관련 부모 노드 포커스/펼치기**
    function partSearchSelect(resultList) {
        for (const element of resultList) {
            var partParentNodeId = element.id;
            var partParentNode = ensureNodeLoaded(partParentNodeId);
            if (partParentNode) {
                openParentsTree(partParentNode);
                $("#" + partParentNode.tId + "_a").addClass('text-highlight');
            }
        }
    }
}

$(document).ready(function () {
    const $tree = $('#facTree');

    //<%-- load facility tree list --%>
    $.ajax({
        type: "POST",
        url: "/facility/tree.do",
        dataType: "json",
        beforeSend: function () {
            $("#facLoadingBar").show();
        },
        success: function (data) {
            let startInit = function () {
                fnLoadFacilityTree(data);
            };

            if (window.requestAnimationFrame) {
                requestAnimationFrame(function () {
                    setTimeout(startInit, 0);
                });
            } else {
                setTimeout(startInit, 0);
            }
        },
        complete: function () {
            $("#facLoadingBar").hide();
        }
    });

    //<%-- 설비정보 팝업의 아이콘 클릭시 3d 모델로 이동 --%>
    $tree.on('click', '.icon-3d', function (e) {
        e.preventDefault();
        e.stopPropagation();

        let modelType = $(this).attr('data-3d-target');
        let iegNo = $(this).attr('data-3d-target-no');

        // <%-- goto 3d model : call parent main script --%>
        /* 열려져 있는 모든 창을 최소화 함 : only view model */
        window.parent.$(".winbox:not(.min) .wb-min").trigger('click');
        window.parent.modelLoadToUnity(modelType, iegNo);
    });

    //<%-- 설비정보 팝업의 아이콘 클릭시 파노라마로 이동 --%>
    $tree.on('click', '.icon-panorama', function (e) {
        e.preventDefault();
        e.stopPropagation();

        let level = $(this).attr('data-level');
        let iegNo = $(this).attr('data-no');

        // <%-- goto 3d model : call parent main script --%>
        /* 열려져 있는 모든 창을 최소화 함 : only view model */
        window.parent.$(".winbox:not(.min) .wb-min").trigger('click');
        window.parent.openPanoInfoPopup(level, iegNo, "PANO");
    });
});
