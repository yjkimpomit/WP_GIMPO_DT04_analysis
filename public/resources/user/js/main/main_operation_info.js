// set time
function getClock() {
    $.ajax({
        url: '/main/nowDate.do'
        , type: 'POST'
        , dataType: 'json'
        , success: function (data) {
            $("#viewYearDate").html(data.date);
        },
        error: function () {
            console.log('getClock() error');
        }
    });
}

//getClock();

/*<%-- APC 인원현황 --%>*/
function fnMainApcMemberInOutCount() {
    //console.log("### APC 인원현황 ###");
    $.ajax({
        type: "post"
        , url: "/main/apc/memberInOutCount.do"
        , dataType: "json"
        , success: function (data) {
            var datas = JSON.parse(data.apcMemberCount);
            var inM = datas.iah_in;
            var outM = datas.iah_out;

            $("#_APC_IN").html(inM);
            $("#_APC_OUT").html(outM);

            if (inM > outM) {
                $("#_APC_ALERT").addClass("danger");
            }
            else {
                $("#_APC_ALERT").removeClass("danger");
            }
        }
    });
}

/*<%-- LOAD --%>*/
//fnMainApcMemberInOutCount();

/*<%-- TM 현황 : 발행건수 --%>*/
function fnMainTmPublishCount() {
    //console.log("### TM 현황 : 발행건수 ###");
    $.ajax({
        type: "post"
        , url: "/main/tm/tmPublishCount.do"
        , dataType: "json"
        , success: function (data) {
            $("#_TM_PUBLISH").html(data.tmPublishCount);
        }
    });
}

/*<%-- TM 현황 : RedTAG 건수 --%> */
function fnMainTmRedTagCount() {
    //console.log("### TM 현황 : RedTAG 건수 ###");
    $.ajax({
        type: "post"
        , url: "/main/tm/tmRedTagCount.do"
        , dataType: "json"
        , success: function (data) {
            $("#_TM_REDTAG").html(data.tmRedTagCount);
        }
    });
}

//TM현황 5분단위로 조회
//fnMainTmPublishCount();
//fnMainTmRedTagCount();

/*<%-- 대기정보 : 기온 --%>*/
function fnMainAiTemperature() {
    //console.log("### 대기정보 : 기온 ###");
    $.ajax({
        type: "post"
        , url: "/main/ai/temperature.do"
        , dataType: "json"
        , success: function (data) {
            $("#_AI_TEMPERATURE").html(data.result.aiTemperature);
        },
        error: function (request, status, error) {
            $("#_AI_TEMPERATURE").html("-");
        }
    });
}

/*<%-- 대기정보 : 압력 --%>*/
function fnMainAiPressure() {
    //console.log("### 대기정보 : 압력 ###");
    $.ajax({
        type: "post"
        , url: "/main/ai/pressure.do"
        , dataType: "json"
        , success: function (data) {
            $("#_AI_PRESSURE").html(data.result.aiPressure);
        },
        error: function (request, status, error) {
            $("#_AI_PRESSURE").html("-");
        }
    });
}

/*<%-- 대기정보 : 습도 --%>*/
function fnMainAiHumidity() {
    //console.log("### 대기정보 : 습도 ###");
    $.ajax({
        type: "post"
        , url: "/main/ai/humidity.do"
        , dataType: "json"
        , success: function (data) {
            $("#_AI_HUMIDITY").html(data.result.aiHumidity);
        },
        error: function (request, status, error) {
            $("#_AI_HUMIDITY").html("-");
        }
    });
}

/*<%-- 운전시간(H) 정보 --%>*/
function fnMainOperationTime() {
    //console.log("### 운전시간(H) 정보 ###");
    $.ajax({
        type: "post"
        , url: "/main/ot/operationTime.do"
        , dataType: "json"
        , success: function (data) {
            var datas = data.result;

            $("#_OT_GT1_AOH").html(datas.gt1Aoh);
            $("#_OT_GT1_ES").html(datas.gt1Es);
            $("#_OT_GT2_AOH").html(datas.gt2Aoh);
            $("#_OT_GT2_ES").html(datas.gt2Es);
        }
        , error: function (request, status, error) {
            //console.log("### 운전시간(H) 정보 ## code: " + request.status + "\n error: " + error);
            $("#_OT_GT1_AOH").html("-");
            $("#_OT_GT1_ES").html("-");
            $("#_OT_GT2_AOH").html("-");
            $("#_OT_GT2_ES").html("-");
        }
    });
}

/*<%-- 발전기 출력 정보 --%>*/
function fnMainGeneratorOutput() {
    $.ajax({
        type: "post"
        , url: "/main/generator/output.do"
        , dataType: "json"
        , success: function (data) {
            var datas = data.result;

            $("#_PO_RT_9").html(datas.PORT9);
            $("#_PO_RT_10").html(datas.PORT10);
        }
        , error: function (request, status, error) {
            //console.log("### 발전기 출력 정보 ## code: " + request.status + "\n error: " + error);
            $("#_PO_RT_9").html("-");
            $("#_PO_RT_10").html("-");
        }
    });
}

/*<%-- 발전효율 : 실시간 --%>*/
function fnMainPgeRealtime() {
    $.ajax({
        type: "post"
        , url: "/main/pge/realtime.do"
        , dataType: "json"
        , success: function (data) {
            var datas = data.result;

            $("#_PE_RT_9").html(datas.PERT9);
            $("#_PE_RT_10").html(datas.PERT10);
        },
        error: function (request, status, error) {
            $("#_PE_RT_9").html("-");
            $("#_PE_RT_10").html("-");
        }
    });
}

//fnMainAiTemperature();
//fnMainAiPressure();
//fnMainAiHumidity();
//fnMainOperationTime();

/*
* 실시간 정보
* Interval : 1분마다
* */
function fnMainIntervalRun() {
    //setInterval(getClock, 30000);

    //setInterval(fnMainApcMemberInOutCount, 5 * 60000);

    //setInterval(fnMainTmPublishCount, 5 * 60000);
    //setInterval(fnMainTmRedTagCount, 5 * 60000);

    fnMainGeneratorOutput();
    fnMainPgeRealtime();

    setInterval(function () {
        //fnMainAiTemperature();
        //fnMainAiPressure();
        //fnMainAiHumidity();
        //fnMainOperationTime();
        fnMainGeneratorOutput();    // 발전출력
        fnMainPgeRealtime();        // 발전효율
    }, 60000);
}

fnMainIntervalRun();

/* 일일안전작업현황 */
function fnWorkReportHazardSummaryList() {
    $.ajax({
        type: "POST"
        , url: "/dailySafety/workReportHazardSummary.do"
        , dataType: "json"
        , success: function (data) {
            /* 상단/왼쪽 Summary 뷰 */
            $("._QS_TOT").text(data.TOT); // 합계
            $("._QS_G").text(data.G);   // 일반
            $("._QS_HW").text(data.HW); // 화기
            $("._QS_C").text(data.C); // 밀폐
            $("._QS_H").text(data.H); // 고소
            $("._QS_HO").text(data.HO); // 중량물
            $("._QS_PO").text(data.PO); // 정전
            $("._QS_E").text(data.E); // 굴착
            $("._QS_D").text(data.D); // 잠수
            $("._QS_R").text(data.R); // 방사선
            $("._QS_CS").text(data.CS); // 화학
            $("._QS_O").text(data.O); // 기타
/*
            var h = parseInt(data.H);
            var po = parseInt(data.PO);
            var e = parseInt(data.E);
            var d = parseInt(data.D);
            var r = parseInt(data.R);
            var cs = parseInt(data.CS);
            var o = parseInt(data.O);
            $("._QS_ETC").text(h + po + e + d + r + cs + o); // 상단 기타(고소,정전,굴착,잠수,방사선,화학,기타)
*/
        }
        , error: function (request, status, error) {
            console.log("code:" + request.status + "\n message:" + request.responseText + "\n error:" + error);
        }
    });
}

fnWorkReportHazardSummaryList();

/* 1시간마다 RELOAD */
setInterval(function () {
    fnWorkReportHazardSummaryList();
}, 3600000);
