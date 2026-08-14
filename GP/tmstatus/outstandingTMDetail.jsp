<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="modal-header">
	<h5 class="title04">${outstandiingTMInfo.description}</h5>
	<button type="button" class="btn close">
        <span class="icon icon-close"></span><span>닫기</span>
	</button>
</div>

<div class="modal-body">
	<h6 class="title05">상세정보</h6>
	
	<div class="table-box table-responsive">
		<table class="table table-sm view-table" data-tab-id="workReqPane" aria-label="미결TM현황-상세정보">
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
					<td data-field="호기">${outstandiingTMInfo.hoki}</td>
					<th scope="row">승인일자</th>
					<td data-field="승인일자" colspan="3">${outstandiingTMInfo.authoDate}</td>
				</tr>
				<tr>
					<th scope="row">진행상태</th>
					<td data-field="진행상태">${outstandiingTMInfo.noticeStatus}</td>
					<th scope="row">요청번호</th>
					<td data-field="요청번호" colspan="3">${outstandiingTMInfo.noticeNo}</td>
				</tr>
				<tr>
					<th scope="row">요청명</th>
					<td data-field="요청명" colspan="5">${outstandiingTMInfo.description}</td>
				</tr>
				<tr>
					<th scope="row">요청자</th>
					<td data-field="요청자">${outstandiingTMInfo.reqByNm}</td>
					<th scope="row">요청부서</th>
					<td data-field="요청부서">[${outstandiingTMInfo.reqDept}] ${outstandiingTMInfo.reqDeptNm}</td>
					<th scope="row">감독부서</th>
					<td data-field="감독부서">[${outstandiingTMInfo.dept}] ${outstandiingTMInfo.deptNm}</td>
				</tr>
				<tr>
					<th scope="row">작업중요도</th>
					<td data-field="작업중요도">${outstandiingTMInfo.woGrade}</td>
					<th scope="row">우선순위</th>
					<td data-field="우선순위">${outstandiingTMInfo.woPriority}</td>
					<th scope="row">RedTag필요</th>
					<td data-field="RedTag필요">${outstandiingTMInfo.isWorkConfirm}</td>
				</tr>
				<tr>
					<th scope="row">증상</th>
					<td data-field="증상" colspan="5">${outstandiingTMInfo.symptom}</td>
				</tr>
				<tr>
					<th scope="row">설비번호</th>
					<td data-field="설비번호">${outstandiingTMInfo.equipNo}</td>
					<th scope="row">설비명</th>
					<td data-field="설비명" colspan="3">${outstandiingTMInfo.equipNm}</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
