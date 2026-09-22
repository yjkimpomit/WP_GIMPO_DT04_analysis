/*
* 운전정보 리스트
* */

/*<%-- 9호기 출력현황 --%>*/
function fnOutputStats9() {
    //console.log("### 9호기 ###");
    $.ajax({
        type: "post"
        , url: "/dashboard/statsT39.do"
        , dataType: "json"
        , success: function (data) {
            $("#_9UM_MW").html(data.result._9UM_MW);
            $("#_9EC_MAIN").html(data.result._9EC_MAIN);
            $("#_9UM_HLC").html(data.result._9UM_HLC);
            $("#_9TNH1_RPM").html(data.result._9TNH1_RPM);
            $("#_9STM_MSP").html(data.result._9STM_MSP);
            $("#_9MS_TT03A").html(data.result._9MS_TT03A);
            $("#_9GE_TE_58A").html(data.result._9GE_TE_58A);
            $("#_E3_9V_PT").html(data.result._E3_9V_PT);
            $("#_E3_9V_RH").html(data.result._E3_9V_RH);
            $("#_9GF_AT31").html(data.result._9GF_AT31);
            $("#_9GF_AT32").html(data.result._9GF_AT32);
            $("#_9GF_AT33").html(data.result._9GF_AT33);
            $("#_9GF_AT35").html(data.result._9GF_AT35);
            $("#_9GF_AT34").html(data.result._9GF_AT34);
            $("#_9V_YM_B").html(data.result._9V_YM_B);
            $("#_9V_ETATM").html(data.result._9V_ETATM);
            $("#_9V_Y_P").html(data.result._9V_Y_P);
            $("#_9V_YE_P").html(data.result._9V_YE_P);
            /*$("#_9V_Y_P_").html(data.result._9V_Y_P);*/
            $("#_9V_YC_P").html(data.result._9V_YC_P);
            $("#_9V_HRM").html(data.result._9V_HRM);
        },
        error: function (request, status, error) {
            $("#_9UM_MW").html("-");
            $("#_9EC_MAIN").html("-");
            $("#_9UM_HLC").html("-");
            $("#_9TNH1_RPM").html("-");
            $("#_9STM_MSP").html("-");
            $("#_9MS_TT03A").html("-");
            $("#_9GE_TE_58A").html("-");
            $("#_E3_9V_PT").html("-");
            $("#_E3_9V_RH").html("-");
            $("#_9GF_AT31").html("-");
            $("#_9GF_AT32").html("-");
            $("#_9GF_AT33").html("-");
            $("#_9GF_AT35").html("-");
            $("#_9GF_AT34").html("-");
            $("#_9V_YM_B").html("-");
            $("#_9V_ETATM").html("-");
            $("#_9V_Y_P").html("-");
            $("#_9V_YE_P").html("-");
            /*$("#_9V_Y_P_").html("-");*/
            $("#_9V_YC_P").html("-");
            $("#_9V_HRM").html("-");
        }
    });
}

/*<%-- 10호기 출력현황 --%>*/
function fnOutputStats10() {
    //console.log("### 10호기 ###");
    $.ajax({
        type: "post"
        , url: "/dashboard/statsT310.do"
        , dataType: "json"
        , success: function (data) {
            /*$("#_10UM_MW").html(data.result._10UM_MW);*/
            $("#_10EC_MAIN").html(data.result._10EC_MAIN);
            $("#_10UM_HLC").html(data.result._10UM_HLC);
            $("#_10TNH1_RPM").html(data.result._10TNH1_RPM);
            $("#_10STM_MSP").html(data.result._10STM_MSP);
            $("#_10MS_TT03A").html(data.result._10MS_TT03A);
            $("#_10GE_TE_58A").html(data.result._10GE_TE_58A);
            $("#_E3_10V_PT").html(data.result._E3_10V_PT);
            $("#_E3_10V_RH").html(data.result._E3_10V_RH);
            $("#_10GF_AT31").html(data.result._10GF_AT31);
            $("#_10GF_AT32").html(data.result._10GF_AT32);
            $("#_10GF_AT33").html(data.result._10GF_AT33);
            $("#_10GF_AT35").html(data.result._10GF_AT35);
            $("#_10GF_AT34").html(data.result._10GF_AT34);
            $("#_10V_YM_B").html(data.result._10V_YM_B);
            $("#_10V_ETATM").html(data.result._10V_ETATM);
            $("#_10V_HRM").html(data.result._10V_HRM);
            /* $("#_10V_Y_P").html(data.result._10V_Y_P);
             $("#_10V_YE_P").html(data.result._10V_YE_P);
             /!*$("#_10V_Y_P_").html(data.result._10V_Y_P);*!/
             $("#_10V_YC_P").html(data.result._10V_YC_P);*/
        },
        error: function (request, status, error) {
            /*$("#_10UM_MW").html("-");*/
            $("#_10EC_MAIN").html("-");
            $("#_10UM_HLC").html("-");
            $("#_10TNH1_RPM").html("-");
            $("#_10STM_MSP").html("-");
            $("#_10MS_TT03A").html("-");
            $("#_10GE_TE_58A").html("-");
            $("#_E3_10V_PT").html("-");
            $("#_E3_10V_RH").html("-");
            $("#_10GF_AT31").html("-");
            $("#_10GF_AT32").html("-");
            $("#_10GF_AT33").html("-");
            $("#_10GF_AT35").html("-");
            $("#_10GF_AT34").html("-");
            $("#_10V_YM_B").html("-");
            $("#_10V_ETATM").html("-");
            $("#_10V_HRM").html("-");
            /*$("#_10V_Y_P").html("-");
            $("#_10V_YE_P").html("-");
            /!*$("#_10V_Y_P_").html("-");*!/
            $("#_10V_YC_P").html("-");*/
        }
    });
}

/*<%-- LOAD --%>*/
fnOutputStats9();
fnOutputStats10();

var intervalOutputStatsApiT3 = setInterval(function(){
    fnOutputStats9();
    fnOutputStats10();
},60000);
