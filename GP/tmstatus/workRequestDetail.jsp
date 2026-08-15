<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- 작업요청확정-상세정보 -->

<!-- winbox detail popup -->
<main class="detail-popup winbox-layout">
	<header class="result-header detail-popup__header">
		<h1 class="detail-popup__title">
			<span>${workRequestInfo.description}</span>
			<span class="result-header__count">(전체 <fmt:formatNumber value="${listCount}" type="number"/>건)</span>
		</h1>
	</header>

	<div class="table-box table-responsive">
		<table class="table table-sm view-table" data-tab-id="workReqPane" aria-label="작업요청확정-상세정보">
			<colgroup>
				<col style="width: 80px;">
				<col>
				<col style="width: 80px;">
				<col>
				<col style="width: 128px;">
				<col>
			</colgroup>
			<tbody>
			<tr>
				<th scope="row">호기</th>
				<td data-field="호기">${workRequestInfo.hoki}</td>
				<th scope="row">승인일자</th>
				<td data-field="승인일자" colspan="3">${workRequestInfo.authoDate}</td>
			</tr>
			<tr>
				<th scope="row">진행상태</th>
				<td data-field="진행상태">${workRequestInfo.noticeStatus}</td>
				<th scope="row">요청번호</th>
				<td data-field="요청번호" colspan="3">${workRequestInfo.noticeNo}</td>
			</tr>
			<tr>
				<th scope="row">요청명</th>
				<td data-field="요청명" colspan="5">${workRequestInfo.description}</td>
			</tr>
			<tr>
				<th scope="row">요청자</th>
				<td data-field="요청자">${workRequestInfo.reqByNm}</td>
				<th scope="row">요청부서</th>
				<td data-field="요청부서">[${workRequestInfo.reqDept}] ${workRequestInfo.reqDeptNm}</td>
				<th scope="row">감독부서</th>
				<td data-field="감독부서">[${workRequestInfo.dept}] ${workRequestInfo.deptNm}</td>
			</tr>
			<tr>
				<th scope="row">작업중요도</th>
				<td data-field="작업중요도">${workRequestInfo.woGrade}</td>
				<th scope="row">우선순위</th>
				<td data-field="우선순위">${workRequestInfo.woPriority}</td>
				<th scope="row">RedTag필요</th>
				<td data-field="RedTag필요">${workRequestInfo.isWorkConfirm}</td>
			</tr>
			<tr>
				<th scope="row">증상</th>
				<td data-field="증상" colspan="5">${workRequestInfo.symptom}</td>
			</tr>
			<tr>
				<th scope="row">설비번호</th>
				<td data-field="설비번호">${workRequestInfo.equipNo}</td>
				<th scope="row">설비명</th>
				<td data-field="설비명" colspan="3">${workRequestInfo.equipNm}</td>
			</tr>
			</tbody>
		</table>
	</div>
</main>
