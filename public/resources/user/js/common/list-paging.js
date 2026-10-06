/**
 * 페이지 공통 스크립트
 * 리스트의 페이지 control
 * 페이지 이동, 이전, 다음 페이지로 이동 제어
 */

/**
 * 메인 화면의 페이지 이동 제어 메소드
 * @param f 버튼 플래그
 * @returns {boolean}
 */
function fnMovePage(f, targetForm) {
    const $targetFormPageIndex = "#" + targetForm + " #pageIndex";
    const $userPage = $("#currentPage");
    let currentPage = parseInt($userPage.val());

    if (f === 'P') {
        if (currentPage === 1) {
            title = "페이지 이동";
            content = "처음 페이지입니다.";
            fnAlert(title, content);
            return false;
        }
        currentPage = currentPage - 1;
    } else if (f === 'N') {
        if (currentPage === totalPage) {
            title = "페이지 이동";
            content = "마지막 페이지입니다.";
            fnAlert(title, content);
            return false;
        }
        currentPage = currentPage + 1;
    } else if (f === 'M') {
        if (currentPage > totalPage) {
            $userPage.val(totalPage);
            title = "페이지 이동";
            content = "마지막 페이지는 " + totalPage + "입니다. 이 페이지를 초과할 수 없습니다.";
            fnAlert(title, content);
            return false;
        }
    }

    $userPage.val(currentPage);
    $targetFormPageIndex.val(currentPage);

    /* 각 페이지로 호출하는 메소드 */
    fnLoadCompletePageMove();
}

function fnLoadPageMoveSub() {

}