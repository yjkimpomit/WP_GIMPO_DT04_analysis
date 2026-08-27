# 템플릿 기반 동적 탭 요청 가이드

## 권장 요청문

아래 문구를 복사한 후 화면명과 칼럼명만 변경하여 요청합니다.

```text
[화면명]의 연계 테이블을 template 기반 동적 탭으로 구현해줘.

- 기존 Bootstrap 탭과 독립된 content-tabs 컴포넌트를 사용
- 최초에는 기본 목록 탭만 표시
- 목록 행 클릭 시 해당 행의 [제목 칼럼명]을 탭 제목으로 사용
- 탭 제목은 최대 200px이며 초과 문구는 말줄임 처리
- 탭에 마우스를 올리면 title 속성으로 전체 제목 표시
- 동일 테이블의 여러 행을 각각 독립 탭으로 열 수 있게 구현
- 이미 열린 행을 다시 클릭하면 새 탭을 만들지 않고 기존 탭 활성화
- 각 탭 우측에 닫기 버튼 제공
- 부모 탭을 닫으면 해당 탭에서 생성된 하위 탭도 함께 제거
- 탭을 닫으면 원본 행의 active 및 aria-selected 상태 제거
- 최상위 테이블의 다른 행을 클릭하면 기존 하위 탭 그룹을 모두 닫고 새 그룹 생성
- 탭 목록이 너비를 초과하면 우측에 이전, 다음, 목록 버튼 표시
- 목록 버튼 클릭 시 열린 탭 목록을 표시하고 항목 클릭 시 해당 탭 활성화
- 클릭, 방향키, Home, End, Esc 키보드 조작 및 ARIA 속성 지원
- 탭 콘텐츠는 HTML template을 복제하여 실제 DOM에 생성·삭제
- 다른 화면에서도 재사용할 수 있도록 data 속성 기반 범용 JavaScript로 작성
- 반응형 CSS는 min-width 기준으로 작성
```

## 화면별로 제공할 정보

요청 시 다음 정보를 함께 전달하면 정확하게 구현할 수 있습니다.

1. 기본 목록 테이블의 `aria-label`
2. 탭 제목으로 사용할 셀의 `data-field` 값
3. 행 클릭 시 열릴 상세 테이블 마크업 또는 데이터 URL
4. 상세 테이블에서 다시 열릴 하위 콘텐츠의 유무
5. 최상위 행 변경 시 기존 탭을 유지할지 전체 닫을지 여부
6. 동일 행 재클릭 시 기존 탭 활성화 또는 중복 탭 생성 여부

## 기본 마크업 규칙

행 클릭으로 탭을 생성할 테이블에 템플릿 ID와 제목 칼럼을 지정합니다.

```html
<table
    class="data-table data-table--list data-table--interactive"
    aria-label="점검보고서 목록"
    data-content-tab-template="inspection-detail-template"
    data-content-tab-title-field="제목">
</table>
```

연계 콘텐츠는 `template`으로 정의합니다.

```html
<template id="inspection-detail-template">
    <div class="content-tabs__panel" data-content-tab-template-panel role="tabpanel">
        <div class="result-panel__body">
            <div class="result-header">...</div>
            <div class="table-responsive">...</div>
        </div>
    </div>
</template>
```

템플릿 내부 테이블에 다시 `data-content-tab-template`을 지정하면 N단계로 확장할 수 있습니다.

## 독립 리소스 구성

- 스크립트: `/resources/js/html-common/content-tabs.js`
- 스타일: `/resources/css/content-tabs.css`
- 적용 예시: `/pages/preventive-inspection/preventive-inspection-report.html`

기존 Bootstrap 탭과 클래스 및 이벤트가 분리되어 있습니다. 공통 화면에서는
`winbox-content.css`가 `content-tabs.css`를 불러오므로 별도 링크가 필요하지 않습니다.
독립 페이지에서 직접 사용할 때는 다음 순서로 연결합니다.

```html
<link rel="stylesheet" href="/resources/css/content-tabs.css">
<script src="/resources/js/html-common/content-tabs.js"></script>
```

## 완료 검수 기준

- 서로 다른 행에서 여러 탭이 생성되는가
- 동일 행 재클릭 시 기존 탭이 활성화되는가
- 부모 탭 삭제 시 해당 하위 탭만 삭제되는가
- 탭 삭제 시 원본 행의 선택 상태가 제거되는가
- 긴 제목이 말줄임되고 전체 제목을 확인할 수 있는가
- 탭 오버플로 시 이동 및 목록 버튼이 동작하는가
- 키보드만으로 탭 이동, 선택, 목록 닫기가 가능한가
- 기존 Bootstrap 탭과 이벤트 또는 클래스가 충돌하지 않는가
