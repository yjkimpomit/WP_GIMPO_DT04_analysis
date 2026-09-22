/*
* common.js
*
* */

/* set WinBox */
var targetWinbox;

/* WinBox temp get data */
var winboxIsOpen = true;
var winboxTop;
var winboxHeight;

// winbox device control
var WINBOX_BREAKPOINT = 576;
var WINBOX_DESKTOP_INSET = 16;
var WINBOX_MOBILE_INSET = 8;
var WINBOX_MOBILE_TOP = 56;
var WINBOX_HEADER_HEIGHT = 40;
var WINBOX_MINIMIZED_GAP = 8;

function fnLayoutMinimizedWinboxes() {
	var topWindow = window.top;
	var base = getWinboxGroupOptions();
	var minimizedElements = Array.from(topWindow.document.querySelectorAll(".winbox.app-winbox.min"));
	var count = minimizedElements.length;

	if (count === 0) return;

	var availableWidth = topWindow.innerWidth - base.left - base.right;
	var totalGap = WINBOX_MINIMIZED_GAP * Math.max(0, count - 1);
	var minimizedWidth = Math.min(160, Math.max(80, (availableWidth - totalGap) / count));
	var left = base.left;
	var top = topWindow.innerHeight - base.bottom - WINBOX_HEADER_HEIGHT;

	minimizedElements.forEach(function (element) {
		var winbox = element.winbox;

		if (winbox && winbox.resize && winbox.move) {
			winbox.resize(minimizedWidth, WINBOX_HEADER_HEIGHT, true);
			winbox.move(left, top, true);
		} else {
			element.style.width = minimizedWidth + "px";
			element.style.height = WINBOX_HEADER_HEIGHT + "px";
			element.style.left = left + "px";
			element.style.top = top + "px";
		}

		left += minimizedWidth + WINBOX_MINIMIZED_GAP;
	});
}

function fnScheduleMinimizedWinboxLayout() {
	window.top.requestAnimationFrame(fnLayoutMinimizedWinboxes);
}

function getDesktopGnbWidth() {
	var value = window.top.getComputedStyle(window.top.document.documentElement)
		.getPropertyValue('--gnb-width-collapsed');

	return Number.parseFloat(value) || 80;
}

function getWinboxGroup(isMobileView) {
	if (isMobileView) {
		return {
			top: WINBOX_MOBILE_TOP,
			left: WINBOX_MOBILE_INSET,
			right: WINBOX_MOBILE_INSET,
			bottom: WINBOX_MOBILE_INSET,
			border: 0
		};
	}

	return {
		top: WINBOX_DESKTOP_INSET,
		left: getDesktopGnbWidth(),
		right: WINBOX_DESKTOP_INSET,
		bottom: WINBOX_DESKTOP_INSET,
		border: 0
	};
}

/* pc 모드에서 width 체크 */
function fnGetDeviceWidth() {
	var width = window.top.innerWidth;

	return getWinboxGroup(width < WINBOX_BREAKPOINT);
}

/* 디바이스 체크 */
function getDeviceType() {
	var checkDevice = window.top.checkDevice;

	if (checkDevice === "mobile") {
		return getWinboxGroup(true);
	} else {
		return fnGetDeviceWidth();
	}
}

function getWinboxGroupOptions() {
	return getDeviceType();
}

/* start run resize */
var winboxResizeTimer = null;

function fnResizeOpenedWinbox() {
	var $winboxes = $(".winbox:not(.min)");
	if ($winboxes.length === 0) return;

	// header open/close 상태와 device width 기준으로 top/height 재계산
	fnSetWinboxTop(".winbox:not(.min)", winboxIsOpen, "resize");
}

window.addEventListener("resize", function () {
	clearTimeout(winboxResizeTimer);

	winboxResizeTimer = setTimeout(function () {
		fnResizeOpenedWinbox();
	}, 100);

});

/* end run resize */

/**
 * 메뉴 팝업창 열기
 * @param url
 * @param target
 */
function fnOpenPopup(url, target) {
	var title = target.data("title");

	// 기존 메뉴 닫기
	//var closeTarget = ['대시보드', '서비스 바로가기', '일일안전현황', '설비정보', '설비상세정보', 'TM현황', '작업현황', '예방점검현황', '조기경보', 'CCTV', '파노라마', '설비검색', '개선요청', '로그시트', '방문자 조회', 'dataPARC', 'P&ID'];
	var closeTarget = ['대시보드'];
	$('.wb-title').each(function () {
		// 이미 열려져 있는 창 닫기
		/*if (closeTarget.includes(title) && title === $(this).text()) {
			$(this).closest('.wb-header').find('.wb-close').trigger('click');
			return false;
		}*/

		// 같은 메뉴 2개 사용안함 - 메뉴 리스트와 비교해서 창닫기
		var title = $(this).text();
		if (closeTarget.some(closeTarget => title.includes(closeTarget))) {
			if (title === "설비상세정보") {
				// Set 3d model flag
				//setRenderActive("false");
			}

			$(this).closest('.wb-header').find('.wb-close').trigger('click');
		}

		// all close
		// $('.wb-close').trigger('click');
	});

	// 모든 창 최소화
	fnCloseAllWinbox();

	var base = getWinboxGroupOptions();
	winboxTop = base.top;
	winboxHeight = base.height;

	targetWinbox = new WinBox(title, Object.assign({}, base, {
		groupId: "winMain-group",
		header: WINBOX_HEADER_HEIGHT,
		class: ["app-winbox"],
		url: url,
		onCreate: function (options) {
			options.autoResize = true;
		},
		onmaximize: function () {
			if (this.min) return;
			fnSetWinboxTop(this, winboxIsOpen, "max");
			setRenderActive("false");
		},
		onclose: function (force) {
			var targetText = this.title;

			if (targetText === "대시보드") {
				// iframe check
				var iframe = this.window;
				if (iframe) {
					// dashboard interval stop
					clearInterval(iframe.intervalWorkReportT3);
					clearInterval(iframe.intervalChartDatas9);
					clearInterval(iframe.intervalChartDatas10);
					clearInterval(iframe.intervalOutputStatsApiT3);
				}
			}

			setRenderActive("true");
			fnScheduleMinimizedWinboxLayout();
		},
		onminimize: function () {
			setRenderActive("true");
			fnScheduleMinimizedWinboxLayout();
		},
		onrestore: function () {
			fnScheduleMinimizedWinboxLayout();
		},
		onfocus() {
			setRenderActive("false");
		}
	}));

	setRenderActive("false");
	targetWinbox.maximize();
}

/* winbox popupstandard control : check unity activity */
function fnOpenPopupStandardSetUnityControl(isFlag) {
	const topWindow = window.top;

	setTimeout(() => {
		window.top.setRenderActive(isFlag);
	}, 100);

	return false;
}

/**
 * WinBox에서 독립 WinBox로 띄우기
 * 이 메소드만 부모의 scriipt 변수를 필요로 하므로 parent를 사용해야 함
 * 멀티뷰 화면
 *
 * @param url
 * @param target
 */
function fnOpenPopupStandard(url, title) {
	// 열려져 있는 모든 창 최소화
	fnAllMinParentWinbox();

	/* iframe으로 팝업이므로 상위의 checkDevice 정보를 가지고 옴 */
	var checkDevice = window.top.checkDevice;

	// 기존 메뉴 닫기
	var closeTarget = ['파노라마', 'dataPARC', 'P&ID'];

	window.top.$('.wb-title').each(function () {
		var title = $(this).text();
		if (closeTarget.some(closeTarget => title.includes(closeTarget))) {
			$(this).closest('.wb-header').find('.wb-close').trigger('click');
		}
	});

	/* 설비상세정보 - 개수 제한 체크 */
	var count = 0;
	window.top.$('.wb-title').each(function () {
		var title = $(this).text();
		if (title.includes("설비상세정보")) {
			count++;
		}
	});

	if (count >= 3) {
		// 자동으로 이전 팝업 창 닫기
		var tot = count - 3;
		window.top.$('.wb-title').each(function (idx, t) {
			var title = $(this).text();
			if (title.includes("설비상세정보")) {
				if (idx <= tot) {
					$(this).closest('.wb-header').find('.wb-close').trigger('click');
				}
			}
		});
	}
	/* 설비상세정보 - 개수 제한 체크 끝 */

	// 상위에 팝업창 생성
	var base = getWinboxGroupOptions();
	var topWindow = window.top;

	targetWinbox = new topWindow.WinBox(title, Object.assign({}, base, {
		groupId: "winMain-group"
		, header: WINBOX_HEADER_HEIGHT
		, root: topWindow.document.body
		, class: ["app-winbox"]
		, url: url, onCreate: function (options) {
			options.autoResize = true;
		},
		onmaximize: function () {
			if (this.min) return;
			fnSetWinboxTop(this, window.top.winboxIsOpen, "max");
			fnOpenPopupStandardSetUnityControl("false");

		},
		onclose: function (force) {
			//var targetText = this.title;
			fnOpenPopupStandardSetUnityControl("true");
			fnScheduleMinimizedWinboxLayout();
		},
		onminimize: function () {
			fnOpenPopupStandardSetUnityControl("true");
			fnScheduleMinimizedWinboxLayout();
		},
		onrestore: function () {
			fnScheduleMinimizedWinboxLayout();
		},
		onfocus() {
			fnOpenPopupStandardSetUnityControl("false");
		},
		onblur() {
			fnOpenPopupStandardSetUnityControl("true");
		}
	}));

	// model deactive
	window.top.setRenderActive("false");
	targetWinbox.maximize();
}

/**
 * 설비정보 메뉴 팝업창 열기
 * @param url
 * @param target
 */
function fnOpenPopupFacilityMenu(url, target) {
	var title = target.data("title");
	var base = getWinboxGroupOptions();
	var isMobileView = window.top.innerWidth < WINBOX_BREAKPOINT;

	// Update global top/height
	winboxTop = base.top;
	winboxHeight = base.height;

	if (isMobileView) {
		targetWinbox = new WinBox(title, Object.assign({}, base, {
			groupId: "winMain-group",
			header: WINBOX_HEADER_HEIGHT,
			class: ["app-winbox", "facility"],
			width: "100%",
			height: "100%",
			url: url,
			onCreate: function (options) {
				options.autoResize = true;
			},
			onmaximize: function () {
				if (this.min) return;
				fnSetWinboxTop(this, winboxIsOpen, "max");
				setRenderActive("false");
			},
			onminimize: function () {
				setRenderActive("true");
				fnScheduleMinimizedWinboxLayout();
			},
			onrestore: function () {
				fnScheduleMinimizedWinboxLayout();
			},
			onclose: function () {
				fnScheduleMinimizedWinboxLayout();
			},
			onfocus() {
				setRenderActive("false");
			},
			onblur() {
				setRenderActive("true");
			}
		}));
	} else {
		targetWinbox = new WinBox(title, Object.assign({}, base, {
			groupId: "winMain-group",
			header: WINBOX_HEADER_HEIGHT,
			class: ["app-winbox", "facility"],
			width: 480,
			height: 720,
			x: "center",
			y: "center",
			url: url,
			onCreate: function (options) {
				options.autoResize = true;
			},
			onmaximize: function () {
				if (this.min) return;
				fnSetWinboxTop(this, winboxIsOpen, "max");
				setRenderActive("false");
			},
			onminimize: function () {
				setRenderActive("true");
				fnScheduleMinimizedWinboxLayout();
			},
			onrestore: function () {
				fnScheduleMinimizedWinboxLayout();
			},
			onclose: function () {
				fnScheduleMinimizedWinboxLayout();
			},
			onfocus() {
				setRenderActive("false");
			},
			onblur() {
				setRenderActive("true");
			}
		}));
	}

	if (isMobileView) {
		fnSetWinboxTop(targetWinbox, winboxIsOpen, "facilityMenu");
	}
}

/**
 * 모든 창 닫기
 */
function fnWinPopAllClose() {
	if (!targetWinbox || !targetWinbox.g) return;

	if (confirm("모든 창을 닫겠습니까?")) {
		$(".wb-close").trigger('click');

		setRenderActive("true");
	}
}

/**
 * 모든 창 최소화
 */
function fnWinPopMinimize() {
	if (!targetWinbox || !targetWinbox.g) return;

	if ($(".winbox:not(.min)").length > 0) {
		if (confirm("모든 창을 최소화하겠습니까?")) {
			fnCloseAllWinbox();
		}
	}
}

function fnWinOpenLogVisit(target) {
	fnOpenPopup("/log/index.do", target);
	$('.left-box').removeClass('expand');
}

/**
 * 페이지의 탭메뉴에 대한 기능 설정
 * tab trigger event
 * @param target
 */
function fnSetCommonBootstrapTab(target) {
	try {
		// Normalize to a DOM element (supports jQuery object or DOM node)
		var el = target && target.jquery ? target[0] : target;
		if (!el) return;

		if (window.bootstrap && typeof window.bootstrap.Tab === 'function') {
			var bsTab = new bootstrap.Tab(el);
			bsTab.show();
		} else if (window.jQuery) {
			// Bootstrap이 없더라도 최소한 ARIA/클래스 정리
			var $this = $(el);
			$('.nav-link').removeClass('active').attr('aria-selected', false);
			$this.addClass('active').attr('aria-selected', true);
			var targetSel = $this.attr('data-bs-target') || $this.attr('href');
			// 탭 패널 show 처리
			if (targetSel && targetSel.charAt(0) === '#') {
				$('.tab-pane').removeClass('show active');
				$(targetSel).addClass('show active');
			}
		}
	} catch (e) {
		console.log(e);
	}
}

// 3D모델 사용가이드 버튼제어
function closeControlGuide() {
	window.top.$('.unity-guide').fadeOut(500);
}

// 유니티에서 하단 버튼클릭시 가이드팝업 나타남
function openControlGuide() {
	window.top.$('.unity-guide').fadeIn(500);
}

// 공통 z-index 함수
function getMaxZIndex() {
	let maxZIndex = 0;

	$('.winbox, .site-header').each(function () {
		const zIndex = parseInt($(this).css('z-index'), 10);

		if (!isNaN(zIndex)) {
			maxZIndex = Math.max(maxZIndex, zIndex);
		}
	});

	return maxZIndex;
}

function bringToFront($target) {
	$target.css('z-index', getMaxZIndex() + 1);
}

/**
 * 날짜검색 : 날짜 한달 전으로 세팅하는 공통 함수
 */
function setDateS() {
	var today = new Date();
	var yyyy = today.getFullYear();
	var mm = ("0" + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
	var dd = ("0" + today.getDate()).slice(-2);
	var currentDate = yyyy + "-" + mm + "-" + dd;
	$('#designDateEnd').val(currentDate); // 첫 번째 input에 오늘 날짜 설정

	// 두 번째 input 태그 (한 달 전 날짜로 설정)
	today.setMonth(today.getMonth() - 1); // 현재 날짜 기준 한 달 전으로 설정
	var lastMonthDate = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + ("0" + today.getDate()).slice(-2);
	$('#designDateStart').val(lastMonthDate); // 두 번째 input에 한 달 전 날짜 설정
}

/**
 * 검색박스내 W/O  팝업
 * @param target
 */
function searchWoTreePopup(target) {
	var box = new WinBox("W/O 검색", {
		url: "/common/modalSearchTreeWo.do",
		width: Math.min(1400, window.innerWidth - 20) + "px",
		height: Math.min(720, window.innerHeight - 20) + "px",
		x: "center",
		y: "center",
		modal: true,
		oncreate: fnEnableModalInteraction,
		focus: true,
		class: ["app-winbox", "app-winbox--detail"],
		position: "center",
		onresize: function (w, y) {
			if (this.min) return;
			this.move("center", "center");
		},
		onclose: function () {
		}
	});
}

//설비마스터 상세 검색
function fnFacilityDetailSearch() {
	$.ajax({
		type: "POST", url: "/common/facilitydetailList.do?searchUseYn=S", data: $("#form_search_result1").serialize(), dataType: "html", beforeSend: function () {
			$("#loadingBar").css("display", "");
		}, success: function (data) {
			$("#facilityMasterList").html(data);
		}, error: function (request, status, error) {
			console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
		}, complete: function () {
			$("#loadingBar").css("display", "none");
		}
	});
}

//설비마스터 페이지 이동 부분
function fnfacilityDetailPageMove(f) {
	var detailCurrentPage = parseInt($("#detailCurrentPage").val());

	var flg = $("#chkItemNo").val();
	var flgNo = "";
	if (f === 'P') {
		if (detailCurrentPage === 1) {
			alert("처음 페이지입니다.");
			return false;
		}

		detailCurrentPage = detailCurrentPage - 1;
	} else if (f === 'N') {
		if (detailCurrentPage == totalPage) {
			alert("마지막 페이지입니다.");
			return false;
		}

		detailCurrentPage = detailCurrentPage + 1;
	} else if (f === 'M') {
		if (detailCurrentPage > totalPage) {
			alert("마지막 페이지는 " + totalPage + "입니다. 이 페이지를 초과할 수 없습니다.");
			$("#detailCurrentPage").val(totalPage);
			return false;
		}
	}

	$("#detailCurrentPage").val(detailCurrentPage);
	var dataToSend = {};

	if (flg === "S") {
		$.ajax({
			type: "POST", url: "/common/facilitydetailList.do?searchUseYn=S&pageIndex=" + detailCurrentPage, data: $("#form_search_result1").serialize(), dataType: "html", beforeSend: function () {
				$("#loadingBar").css("display", "");
			}, success: function (data) {
				$("#facilityMasterList").html(data);
			}, error: function (request, status, error) {
				console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
			}, complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	} else {
		flgNo = $("#chkItemVal").val();
		if (flg === "M1") {
			dataToSend = { locNo: flgNo }
		} else if (flg === "M2") {
			dataToSend = { eqCategory: flgNo }
		} else if (flg === "M3") {
			dataToSend = { eqType: flgNo }
		}

		$.ajax({
			type: "POST", url: "/common/facilitydetailList.do?searchUseYn=" + flg + "&pageIndex=" + detailCurrentPage, data: dataToSend, dataType: "html", beforeSend: function () {
				$("#loadingBar").css("display", "");
			}, success: function (data) {
				$("#facilityMasterList").html(data);
			}, error: function (request, status, error) {
				console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
			}, complete: function () {
				$("#loadingBar").css("display", "none");
			}
		});
	}
}

// WinBox는 modal일 때 기본적으로 이동 및 리사이즈 pointer event를 차단하여 차단을 해제
function fnEnableModalInteraction() {
	var modal = this.window;
	if (modal.classList.contains("modal") && !modal.hasAttribute("data-modal-overlay")) {
		var parent = modal.parentNode;
		var overlay = modal.ownerDocument.createElement("div");
		overlay.className = "app-winbox-overlay";
		overlay.setAttribute("aria-hidden", "true");
		modal.setAttribute("data-modal-overlay", "");
		// 같은 z-index에서 DOM 순서를 이용해 해당 모달 바로 아래에 배치한다.
		parent.insertBefore(overlay, modal);
		var syncOverlay = function () {
			if (modal.parentNode !== parent) {
				observer.disconnect();
				overlay.remove();
				modal.removeAttribute("data-modal-overlay");
				return;
			}
			overlay.style.zIndex = modal.style.zIndex || "0";
			overlay.hidden = modal.classList.contains("hide") || modal.hidden;
		};
		var observer = new MutationObserver(syncOverlay);
		observer.observe(modal, { attributes: true, attributeFilter: ["style", "class", "hidden"] });
		// 실제 DOM 제거를 감시하므로 onclose가 닫기를 취소하면 오버레이를 유지한다.
		observer.observe(parent, { childList: true });
		syncOverlay();
		["pointerdown", "mousedown", "click", "dblclick", "contextmenu", "wheel", "touchmove"].forEach(function (type) {
			overlay.addEventListener(type, function (event) {
				event.preventDefault();
				event.stopPropagation();
			}, { passive: false });
		});
	}
	var dragHandle = this.window.querySelector(".wb-drag");
	var resizeHandles = this.window.querySelectorAll(".wb-body ~ div");

	if (dragHandle) {
		dragHandle.style.pointerEvents = "auto";
	}

	for (var i = 0; i < resizeHandles.length; i++) {
		resizeHandles[i].style.pointerEvents = "auto";
	}
}

// 검색박스내 설비종류 검색팝업
function searchFacilityTypeTreePopup(target) {
	var box = new WinBox("설비종류 검색", {
		url: "/common/modalSearchTreeFacilityType.do",
		width: Math.min(720, window.innerWidth - 20) + "px",
		height: Math.min(720, window.innerHeight - 20) + "px",
		x: "center",
		y: "center",
		modal: true,
		oncreate: fnEnableModalInteraction,
		focus: true,
		class: ["app-winbox", "app-winbox--detail"],
		position: "center",
		onresize: function (w, y) {
			if (this.min) return;
			this.move("center", "center");
		},
		onclose: function () {
		}
	});
}

// 검색박스내 설비기능위치 검색팝업
function searchFacilityLocTreePopup(target) {
	var box = new WinBox("기능위치번호 검색", {
		url: "/common/modalSearchTreeFacilityLocation.do",
		width: Math.min(720, window.innerWidth - 20) + "px",
		height: Math.min(720, window.innerHeight - 20) + "px",
		x: "center",
		y: "center",
		modal: true,
		oncreate: fnEnableModalInteraction,
		focus: true,
		class: ["app-winbox", "app-winbox--detail"],
		position: "center",
		onresize: function (w, y) {
			if (this.min) return;
			this.move("center", "center");
		},
		onclose: function () {
		}
	});
}

// 검색박스내 감독부서 검색팝업
function searchReqTreePopup(title) {
	var box = new WinBox("감독부서 선택", {
		url: "/common/modalSearchTreeOversightDept.do",
		width: Math.min(1080, window.innerWidth - 20) + "px",
		height: Math.min(720, window.innerHeight - 20) + "px",
		x: "center",
		y: "center",
		modal: true,
		oncreate: fnEnableModalInteraction,
		focus: true,
		class: ["app-winbox", "app-winbox--detail"],
		position: "center",
		onresize: function (w, y) {
			if (this.min) return;
			this.move("center", "center");
		},
		onclose: function () {
		}
	});
}

// 검색박스내 설계부서 검색팝업
function searchdesignDeptTreePopup(target) {
	var box = new WinBox("설계부서 선택", {
		url: "/common/modalSearchTreeDesignDept.do",
		width: Math.min(720, window.innerWidth - 20) + "px",
		height: Math.min(720, window.innerHeight - 20) + "px",
		x: "center",
		y: "center",
		modal: true,
		oncreate: fnEnableModalInteraction,
		focus: true,
		class: ["app-winbox", "app-winbox--detail"],
		position: "center",
		onresize: function (w, y) {
			if (this.min) return;
			this.move("center", "center");
		},
		onclose: function () {
		}
	});
}

// 검색박스내 요청부서 검색팝업
function searchReqDeptTreePopup(target) {
	var box = new WinBox("요청부서 선택", {
		url: "/common/modalSearchTreeRequestDept.do",
		width: Math.min(720, window.innerWidth - 20) + "px",
		height: Math.min(720, window.innerHeight - 20) + "px",
		x: "center",
		y: "center",
		modal: true,
		oncreate: fnEnableModalInteraction,
		focus: true,
		class: ["app-winbox", "app-winbox--detail"],
		position: "center",
		onresize: function (w, y) {
			if (this.min) return;
			this.move("center", "center");
		},
		onclose: function () {
		}
	});
}

// 검색박스내 운전부서 검색팝업
function searchopDeptTreePopup(target) {
	var box = new WinBox("운전부서 선택", {
		url: "/common/modalSearchTreeOperationsDept.do",
		width: Math.min(720, window.innerWidth - 20) + "px",
		height: Math.min(720, window.innerHeight - 20) + "px",
		x: "center",
		y: "center",
		modal: true,
		oncreate: fnEnableModalInteraction,
		focus: true,
		class: ["app-winbox", "app-winbox--detail"],
		position: "center",
		onresize: function (w, y) {
			if (this.min) return;
			this.move("center", "center");
		},
		onclose: function () {
		}
	});
}

// 검색박스내 정비부서 검색팝업
function searchmainDeptTreePopup(target) {
	var box = new WinBox("정비부서 선택", {
		url: "/common/modalSearchTreeMaintenanceDept.do",
		width: Math.min(720, window.innerWidth - 20) + "px",
		height: Math.min(720, window.innerHeight - 20) + "px",
		x: "center",
		y: "center",
		modal: true,
		oncreate: fnEnableModalInteraction,
		focus: true,
		class: ["app-winbox", "app-winbox--detail"],
		position: "center",
		onresize: function (w, y) {
			if (this.min) return;
			this.move("center", "center");
		},
		onclose: function () {
		}
	});
}

// 검색박스내 사용자검색 팝업
function searchItemPopup(target) {
	var title = target.prevAll('label').first().text().trim();
	var chkTitleTree = "";

	if (title === "요청자 검색") {
		chkTitleTree = "1";
	} else if (title === "감독자 검색") {
		chkTitleTree = "2";
	} else if (title === "점검자 검색") {
		chkTitleTree = "3";
	} else if (title === "발행자 검색") {
		chkTitleTree = "4";
	} else if (title === "회수자 검색") {
		chkTitleTree = "5";
	} else if (title === "설계자 검색") {
		chkTitleTree = "6";
	}

	var url = "/common/modalSearchTreeUser.do?chkTitleTree=" + chkTitleTree;

	var box = new WinBox(title, {
		url: url,
		width: Math.min(1080, window.innerWidth - 20) + "px",
		height: Math.min(720, window.innerHeight - 20) + "px",
		x: "center",
		y: "center",
		modal: true,
		oncreate: fnEnableModalInteraction,
		focus: true,
		class: ["app-winbox", "app-winbox--detail"],
		position: "center",
		onresize: function (w, y) {
			if (this.min) return;
			this.move("center", "center");
		},
		onclose: function () {
		}
	});
}

// 사원 리스트
function userDetailList(id) {
	var chkVal = "Y";
	var checkbox = document.getElementById('id_code1');
	if (checkbox.checked) {
		chkVal = "N"
	}

	var deptNo = id;
	$("#loadingBar").css("display", "");
	$.ajax({
		type: "post"
		, url: "/common/userList.do"
		, data: { deptNo: deptNo, isJoin: chkVal }
		, dataType: "html", success: function (data) {
			$("#userDetailList").html(data);
		}, error: function (request, status, error) {
			console.log("code:" + request.status + "\n error:" + error);
		}, complete: function () {
			$("#loadingBar").css("display", "none");
		}
	});
}

// 검색박스내 설비검색 팝업
function searchFacilityPopup(target) {
	var box = new WinBox("설비검색", {
		url: "/common/modalSearchTreeFacility.do",
		width: Math.min(1400, window.innerWidth - 20) + "px",
		height: Math.min(720, window.innerHeight - 20) + "px",
		x: "center",
		y: "center",
		modal: true,
		oncreate: fnEnableModalInteraction,
		focus: true,
		class: ["app-winbox", "app-winbox--detail"],
		position: "center",
		onresize: function (w, y) {
			if (this.min) return;
			this.move("center", "center");
		},
		onclose: function () {
		}
	});
}

//검색박스내 점검종류 팝업
function searchResultPopup(target) {
	var box = new WinBox("점검종류", {
		url: "/common/modalSearchTreeInspectionType.do",
		width: Math.min(1400, window.innerWidth - 20) + "px",
		height: Math.min(720, window.innerHeight - 20) + "px",
		x: "center",
		y: "center",
		modal: true,
		oncreate: fnEnableModalInteraction,
		focus: true,
		class: ["app-winbox", "app-winbox--detail"],
		position: "center",
		onresize: function (w, y) {
			if (this.min) return;
			this.move("center", "center");
		},
		onclose: function () {
		}
	});
}

/**
 * 설비분류체계 팝업창
 */
function fnShowFacilityPackageTreeList() {
	var url = "/common/facilityPackageTreeList.do";
	var box = new WinBox("설비분류체계", {
		url: url,
		width: Math.min(720, window.innerWidth - 20) + "px",
		height: Math.min(640, window.innerHeight - 20) + "px",
		x: "center",
		y: "center",
		modal: true,
		oncreate: fnEnableModalInteraction,
		focus: true,
		class: ["app-winbox", "app-winbox--detail"],
		position: "center",
		onresize: function (w, y) {
			if (this.min) return;
			this.move("center", "center");
		},
		onclose: function () {
		}
	});
}


/* 메인페이지 왼쪽 메뉴에서 도면보기 팝업 */
function fnOpenDrawing(url) {
	$('#menuList').removeClass('show');
	$("#toggle-button").attr('aria-expanded', 'false');
	$('#toggle-button img').attr('src', '/resources/user/images/icons/gnb-menu.svg').attr('alt', '메뉴 열기');

	var popup = window.open(url, '_viewDrawing', 'height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes');
	popup.focus();
}

/* 메인페이지 왼쪽 메뉴에서 파노라마 팝업 */
function fnOpenPano() {
	$('#menuList').removeClass('show');
	$("#toggle-button").attr('aria-expanded', 'false');
	$('#toggle-button img').attr('src', '/resources/user/images/icons/gnb-menu.svg').attr('alt', '메뉴 열기');

	var popup = window.open("/pcm/vi/main.do?pct_sn=84&pci_tag=Taean9_10", '_viewPano', 'height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes');
	popup.focus();
}

/* 모달 팝업창 띄우기 */
function fnOpenModal(url, title, x, y, width, height) {
	title = "Modal Window";
	x = "center";
	y = "center";
	width = "80%";
	height = "64%";

	new WinBox(title, {
		modal: true, oncreate: fnEnableModalInteraction, header: WINBOX_HEADER_HEIGHT, x: x, y: y, width: width, height: height, url: url
	});
}

/* root의 winbox 창 최소화 */
function fnAllMinParentWinbox() {
	window.parent.parent.$(".winbox:not(.min) .wb-min").trigger('click');
}

/**
 * 로딩바 제어
 * @param flag
 */
function fnLoadingBarFlag(flag) {
	$("#loadingBar").css("display", flag);
}

$(document).ready(function () {
	// 터치디바이스 체크
	function checkTouchDevice() {
		const isTouchDevice = 'ontouchstart' in window || navigator.maxTouchPoints > 0;

		// 기존 클래스 제거 (터치 디바이스 여부 갱신)
		$('body').removeClass('touch-device');

		if (isTouchDevice) {
			//console.log("터치 디바이스입니다.");
			$('body').addClass('touch-device');
		} else {
			$('body').removeClass('touch-device');
		}
	}

	checkTouchDevice();
	window.addEventListener('resize', checkTouchDevice);
});

/* 3D Model/운전정보 데이터 연계 박스 start */
let operationInfoInterval = null;

function open_opDataBox(targetId, id) {
	if (operationInfoInterval != null) {
		clearInterval(operationInfoInterval);
		operationInfoInterval = null;
	}

	operationInfoInterval = setInterval(() => {
		fnOperationLoadInterval(targetId, id);
	}, 60000);

	$(targetId).addClass('active');
}

function close_opDataBox(targetId) {
	clearInterval(operationInfoInterval);
	operationInfoInterval = null;
	$(targetId).removeClass('active');
}

/* 모든 winbox 최소화 처리 */
function fnCloseAllWinbox() {
	if (!targetWinbox || !targetWinbox.g) return;

	if ($(".winbox:not(.min)").length > 0) {
		$(".winbox:not(.min) .wb-min").trigger('click');
		setRenderActive("true");
	}
}

function fnOpDataBoxToggle(targetId) {
	fnCloseAllWinbox();

	if ($(targetId).hasClass('active')) {
		$(targetId).removeClass('active');
	} else {
		$(targetId).addClass('active');
	}
}
/* 3D Model/운전정보 데이터 연계 박스 End */

// ESC로 모달 닫히는거 방지
document.addEventListener('keydown', function (e) {
	if (e.key === 'Escape') {
		const modalOpen = document.querySelector('.modal.show');
		if (modalOpen) {
			e.preventDefault();
			e.stopPropagation();
			return false;
		}
	}
}, true);

// 메인공지팝업 - 범용으로 사용가능
function closeThisPopup(button) {
	var thisPopup = button.closest('.popup-layer');
	if (!thisPopup) return;

	if ($("#checkViewToday").is(":checked")) {
		Cookies.set('notice_view_today', 'Y', { expires: 1 });
	}

	thisPopup.classList.remove('open');
}

/**
 * 헤더 토글 이벤트에 따른 windowbox top 처리
 * winbox가 maximized 상태일 경우 height를 100%로 설정
 *
 * @param target
 * @param isOpen
 * @param isFlag
 */
function fnSetWinboxTop(target, isOpen, isFlag) {
	var winboxInstance = null;
	var selector = target;
	var isForceFullLayout = isFlag === "max";
	var isSyncFullLayout = isFlag === "resize" || isFlag === "header";

	// target이 WinBox 객체인 경우 (문자열이 아닌 경우)
	if (typeof target !== 'string') {
		winboxInstance = target;
		selector = "#" + winboxInstance.id;
	}

	var base = getWinboxGroupOptions();
	var top = base.top;
	var left = base.left;
	var right = base.right;
	var bottom = base.bottom;
	var width = window.top.innerWidth - left - right;

	if (!isOpen) {
		top = 0;
	}

	function applyWinboxLayout(element, instance) {
		var $element = $(element);
		var isMaximized = instance && (instance.max || $element.hasClass("max"));
		var isFacility = isFlag === "facilityMenu" || $element.hasClass("facility");
		var isFullLayout = isForceFullLayout || (isSyncFullLayout && isMaximized);
		// 도킹 공간은 창 높이가 아닌 .wb-body 패딩으로 확보한다.
		var layoutBottom = bottom; // 기기별 기본 여백: 모바일 0px, PC 16px
		var height = isOpen ? window.top.innerHeight - top - layoutBottom : window.top.innerHeight;

		var layoutCss = {
			"left": left + "px",
			"top": top + "px"
		};

		if (isFullLayout || isFacility) {
			layoutCss.height = height + "px";
		}

		if (isFullLayout) {
			layoutCss.width = width + "px";
		}

		$element.css(layoutCss);

		if (instance) {
			if (instance.resize && isFullLayout) {
				instance.resize(width, height, true);
			}

			if (instance.move) {
				instance.move(left, top, isFullLayout);
			}
		}
	}

	if (winboxInstance) {
		applyWinboxLayout(selector, winboxInstance);
		return;
	}

	$(selector).each(function () {
		applyWinboxLayout(this, this.winbox);
	});
}

/*
* android
* */

/* unity 보기 */
function fnAndroidShowUnity() {
	if (window.Android) {
		window.Android.showUnityActivity(eqOrgNo, hoki);
	}
}

/* 외부라이브러리 오버라이드용 스타일 헤더에 추가로드시 사용 */
/*
<script>
	loadCss("${pageContext.request.contextPath}/resources/user/js/svgviewer/css/svg-wrapper.css");
</script>
* */
function loadCss(url) {
	if (!document.querySelector(`link[href="${url}"]`)) {
		const link = document.createElement("link");
		link.rel = "stylesheet";
		link.href = url;
		document.head.appendChild(link);
	}
}

/* view test model */
function fnViewTestModel() {
	var testModelTarget = $("._TEST_MODEL_JS");

	if (testModelTarget.hasClass("d-none")) {
		testModelTarget.removeClass("d-none");
	} else {
		testModelTarget.addClass("d-none");
	}
}

function fnViewAdminPage() {
	window.open("/admin/index.do", '_viewAdmin', 'height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes');
}

/* app : 서비스 바로가기 스크립트 */
function fnAppMainWinboxOpen(url, t) {
	/*$('.wb-title').each(function () {
		if ("서비스 바로가기".includes($(this).text())) {
			$(this).closest('.wb-header').find('.wb-close').trigger('click');
		}
	});*/

	// all close
	fnCloseAllWinbox();

	fnOpenPopup(url, t);
}

/**
 * 메세지 팝업 처리
 * @type {string}
 */
var title = "";
var content = "";

function fnAlert() {
	$.alert({
		title: title,
		content: content,
		type: 'red',
		buttons: {
			'확인': {
				btnClass: 'btn-red',
				action: function () {
				}
			}
		}
	});
}

/**
 * 확인 팝업 처리
 */
function fnAlertConfirm() {
	$.alert({
		title: title,
		content: content,
		type: 'red',
		buttons: {
			'확인': {
				btnClass: 'btn-red',
				action: function () {
					window.parent.$(".winbox.app-winbox.app-winbox--detail.focus").find(".wb-close").trigger("click");
				}
			}
		}
	});
}


// 창 생성 경로와 관계없이 실제 WinBox 상태로 모바일 목록을 동기화한다.
function initMobileWinboxDock() {
	// 최상위 문서의 기존 마크업에 동작만 연결한다.
	if (window !== window.top) return;
	const mobileDock = document.querySelector('[data-winbox-dock]');
	if (!mobileDock || mobileDock.dataset.initialized === 'true') return;
	const dockToggle = mobileDock.querySelector(':scope > button');
	const dockList = mobileDock.querySelector(':scope > ul');
	if (!dockToggle || !dockList) return;
	mobileDock.dataset.initialized = 'true';
	// 목록 표시 상태와 스크린리더에 전달하는 펼침 상태를 함께 갱신한다.
	const setDockOpen = (open) => {
		dockToggle.setAttribute('aria-expanded', String(open));
		dockList.hidden = !open;
	};
	dockToggle.addEventListener('click', () => setDockOpen(dockList.hidden));
	// Escape로 닫으면 열기 버튼으로 포커스를 돌리고, 바깥 클릭으로도 목록을 닫는다.
	mobileDock.addEventListener('keydown', (event) => {
		if (event.key !== 'Escape') return;
		setDockOpen(false);
		dockToggle.focus();
	});
	document.addEventListener('click', (event) => {
		if (!mobileDock.contains(event.target)) setDockOpen(false);
	});
	let dockSignature = '';
	const syncMobileDock = (tabs) => {
		// 데스크톱 또는 최소화된 창이 없는 상태에서는 모바일 도크를 숨긴다.
		const desktop = matchMedia('(min-width: 768px)').matches;
		mobileDock.hidden = desktop || !tabs.length;
		if (mobileDock.hidden) setDockOpen(false);
		dockToggle.textContent = `최소화된 창 ${tabs.length}개`;
		// 창 ID·제목·순서가 같으면 DOM 재생성을 생략해 불필요한 포커스 손실을 줄인다.
		const signature = JSON.stringify(tabs.map((win) => [win.id, (win.g.getAttribute('aria-label') || win.title)]));
		if (signature === dockSignature) return;
		dockSignature = signature;
		const hadListFocus = dockList.contains(document.activeElement);
		dockList.replaceChildren(...tabs.map((win) => {
			const item = document.createElement('li');
			const title = (win.g.getAttribute('aria-label') || win.title) || '창';
			const restore = document.createElement('button');
			restore.type = 'button';
			restore.textContent = title;
			restore.setAttribute('aria-label', `${title} 복원`);
			// 선택한 창을 모바일 작업 영역에 최대화하고 키보드 포커스도 해당 창으로 이동한다.
			restore.addEventListener('click', () => {
				setDockOpen(false);
				win.restore();
				win.maximize();
				win.focus();
				win.g.setAttribute('tabindex', '-1');
				win.g.focus();
			});
			const close = document.createElement('button');
			close.type = 'button';
			// 작은 닫기 아이콘과 색상은 CSS에서 처리하고, 버튼에는 접근성 이름을 제공한다.
			close.setAttribute('aria-label', `${title} 닫기`);
			close.addEventListener('click', () => win.close());
			item.append(restore, close);
			return item;
		}));
		// 항목 삭제 후 포커스가 사라지지 않도록 남은 항목 또는 내비게이션으로 이동한다.
		if (hadListFocus) {
			const target = !mobileDock.hidden ? (dockList.querySelector('button') || dockToggle)
				: document.querySelector('.gnb button, .gnb a[href], .site-header button');
			target?.focus();
		}
	};

	let pending = false;
	const sync = () => {
		pending = false;
		// 개별 생성 함수의 관리 목록 대신 실제 DOM에서 최소화된 WinBox 인스턴스를 수집한다.
		const tabs = Array.from(document.querySelectorAll('.winbox.app-winbox.min'))
			.map((element) => element.winbox).filter(Boolean);
		syncMobileDock(tabs);
		// 대체 목록 준비가 끝난 뒤에만 CSS에서 기존 모바일 최소화 탭을 숨긴다.
		document.documentElement.toggleAttribute('data-winbox-dock-ready', true);
	};
	// 연속 상태 변경은 한 프레임으로 묶어 목록을 한 번만 갱신한다.
	const schedule = () => {
		if (pending) return;
		pending = true;
		requestAnimationFrame(sync);
	};
	// WinBox 추가·제거·상태 변경만 감지해 도크 자체의 DOM 변경으로 재귀 갱신되지 않게 한다.
	const observer = new MutationObserver((records) => {
		if (records.some((record) => record.target instanceof Element && (
			(record.type === 'attributes' && record.target.matches('.winbox')) ||
			(record.type === 'childList' && [...record.addedNodes, ...record.removedNodes]
				.some((node) => node instanceof Element && node.matches('.winbox')))
		))) schedule();
	});
	observer.observe(document.body, { childList: true, subtree: true, attributes: true, attributeFilter: ['class', 'aria-label'] });
	window.addEventListener('resize', schedule);
	sync();
}
// 스크립트 로드 시점과 관계없이 문서가 준비되면 도크를 초기화한다.
if (document.readyState === 'loading') {
	document.addEventListener('DOMContentLoaded', initMobileWinboxDock);
} else {
	initMobileWinboxDock();
}
