# 김포 DT 디자인 이식 사전 분석

작성일: 2026-08-10  
상태: 분석 전용(실제 이식 미수행)

## 분석 경로

- 디자인 원본: `D:\PROJECT\WP_GIMPO_DT02\public`
- 이식 대상: `D:\PROJECT\WP_iPOS_TaeAn_html\public`
- 분석 산출물: `D:\PROJECT\WP_GIMPO_DT04_analysis\public`

요청에 적힌 `D:\PROJECT\WP_GIMPO_DT02\pucblic`는 존재하지 않고 같은 프로젝트에 `public`만 존재하므로, 이를 명백한 철자 오류로 판단해 읽기 전용 분석했다. 두 원본 프로젝트에는 파일을 생성하거나 수정하지 않았다.

## 산출물

- [페이지·컴포넌트 대응표](./docs/page-component-matrix.md)
- [기술·구조 분석 및 위험도 보고서](./docs/migration-risk-report.md)
- [CSS 2차 분석: Bootstrap 탭의 김포 원본 디자인 적용 가능성](./docs/css-tab-analysis.md)
- [CSS 3차 분석: 버튼 디자인 적용 가능성](./docs/css-button-analysis.md)
- [버튼 테마 1차 적용·검증 결과](./docs/button-theme-test-result.md)
- [탭 테마 1차 적용·검증 결과](./docs/tab-theme-test-result.md)
- [테이블 테마 1차 적용·검증 결과](./docs/table-theme-test-result.md)

## 한 줄 결론

김포 디자인은 대상의 업무 기능을 대체하는 프로젝트가 아니라 시각·레이아웃 레퍼런스에 가깝다. 따라서 대상의 DOM과 JavaScript를 보존하고, `.theme-gimpo` 범위의 후순위 CSS와 토큰 매핑으로 공통 외형부터 이식하는 방식이 가장 안전하다.
