/**
 * ******************************************************
 * 공통
 * 설비번호 검색
 */

var isFacilityNo;  // pnid 검색 활성화 플래그

/**
 * 설비번호 검색 리스트
 */
function fnSearchFacilityList() {
    isFacilityNo = false;
    var $iegNo = $("#searchForm #iegNo");
    var $iegDescription = $("#searchForm #iegDescription");
    var $resultIegDescription = $("#searchForm #resultIegDescription");

    $.ajax({
        type: "POST",
        url: "/admin/facility/searchList.do",
        data: $("#searchForm").serialize(),
        dataType: "json",
        beforeSend: function () {
            $("#loadingBar").show();
        },
        success: function (data) {
            $iegDescription.val('');

            // return array
            if (data !== null && data.length > 0) {
                var len = data.length;

                if (len > 1) {
                    var $list = $('[id=iegNoList]').eq(0);
                    $list.empty(); // 기존 옵션 제거

                    var val;
                    $.each(data, function (i, item) {
                        val = val + "<option value='" + item.iegNo + "'>" + item.ietDecription + "</option>";
                    });
                    $list.html(val);
                }
                else {
                    $iegNo.val(data[0].iegNo);

                    /* 기본 검색 명칭 보임 */
                    if($iegDescription.length > 0) {
                        $iegDescription.val(data[0].ietDecription);
                    }

                    /* 3d 모델의 설비 추가시 처리 부분 */
                    if($resultIegDescription.length > 0) {
                        $resultIegDescription.val(data[0].ietDecription);
                    }

                    isFacilityNo = true;
                    fnSearchResult();
                }
            }
            else {
                //console.log("data: 설비정보가 없습니다.");
                isFacilityNo = false;
                fnSearchResult();
            }
        },
        complete: function () {
            $("#loadingBar").hide();
        }
    });
}

function fnInitCustomFacilitySearch() {
    /**
     *  설비번호 검색
     */
    $("#searchForm #iegNo").on("keypress change", function (e) {
        var paramIeqNo = $(this).val().trim();
        var checkLen = paramIeqNo.length;
        var isEnter = (e.key === 'Enter' || e.keyCode === 13);

        this.value = paramIeqNo;

        /* 전체 검색 */
        if(isEnter && checkLen === 0) {
            e.preventDefault();

            $('#searchForm input').val('');
            $('#iegNoList').empty();

            isFacilityNo = false;
            fnSearchResult();
            return false;
        }
        else if (isEnter && checkLen >= 2) {
            e.preventDefault();
            if (typeof paramIeqNo === "undefined" || paramIeqNo === "") {
                $("#searchForm #iegDescription").val('');
                return false;
            }

            fnSearchFacilityList();
        }
    });

    /**
     *  P&ID, dataPARC 검색
     */
    $("#searchForm #iegDescription").on("keypress change", function (e) {
        var searchKeyword = $(this).val();
        var checkLen = searchKeyword.length;
        var isEnter = (e.key === 'Enter' || e.keyCode === 13);

        //console.log("searchKeyword: " + searchKeyword + " checkLen: " + checkLen + " isEnter: " + isEnter + "");
        if (isEnter && checkLen >= 2) {
            e.preventDefault();

            $("#iegNo").val("");
            isFacilityNo = false;

            fnSearchResult();
            return false;
        }
    });
}
