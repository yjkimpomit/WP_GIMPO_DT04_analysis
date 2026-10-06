# public 폴더 구조 및 링크 점검

점검일: 2026-10-06

## 후속 수정 반영

- 기존 `/pages/` 참조 32건을 `/WEB-INF/html/user/`로 변경했다. `/pages/data/equipment/`의 불필요한 `data/`도 제거했다.
- 삭제된 `bootstrap-tab.js` 참조 9건을 `/resources/user/js/bootstrap/bootstrap.bundle.min.js`로 변경했다. 수정 파일 내 번들 중복 로드는 없다.
- `__temp/`로 이동한 공통 스크립트 참조 4건을 현재 위치로 변경했다. 쿼리 문자열은 유지했다.
- 총 21개 소스 파일을 수정했다. 이전 경로 잔존 여부와 변경 대상 파일 존재 여부를 확인했다.
- `dataparc-list.html`은 새 경로에도 파일이 없다. 주소는 변경했지만 이 1건은 파일 복구 또는 별도 대상 지정이 필요하다.

아래 목록과 78건 집계는 수정 전 점검 기록이다. 브라우저 동작 검증은 수행하지 않았다.

## 변경된 구조

- 사용자 홈: `index.html` → `WEB-INF/html/user/home/index.html`
- 사용자 화면: `pages/` → `WEB-INF/html/user/`
- 공통 조각: `common/` → `WEB-INF/html/user/common/`
- 관리자 화면: `admin/` → `WEB-INF/html/admin/`
- 정적 자원: `resources/user/`, `resources/admin/` 아래 CSS·JS·이미지 유지
- 일부 공통 JS: `resources/user/js/common/` → `resources/user/js/__temp/`
- `resources/user/vendor/`, 일부 라이브러리 및 이미지 파일 삭제

## 결과

텍스트 파일 702개를 대상으로 정적 참조를 탐색하고, 검색된 참조 531개를 대조했다. 주석 예시·확장자 목록·조건부 모듈 의존성을 수동 분리했다. **로컬 파일 불일치 78건, 31개 파일**이다. 같은 경로라도 서로 다른 줄은 별도 건으로 집계했다. 원본 HTML/CSS/JS는 수정하지 않았다.

이 결과는 public을 URL 루트로 사용하는 정적 서버 기준이다. 실제 서버의 컨트롤러 매핑, 별도 저장소, 실행 응답은 검증하지 않았다. JSP의 `.do` 주소는 파일 누락으로 판정하지 않았다. 외부 URL·앵커·실행 중 조합되는 모든 경로를 검증한 결과는 아니다.

## 우선 조치

1. 남은 `/pages/`, `/admin/pages/` 주소를 현재 화면 위치 또는 서버 공개 URL에 맞춘다. 홈의 header/menu AJAX 주소와 주요 메뉴 경로는 새 파일 위치와 일치한다.
2. 9개 화면의 삭제된 `bootstrap-tab.js` 참조를 정리한다. 기존 번들 로드 여부와 의존 동작을 확인한 뒤 공식 Bootstrap 번들을 사용한다.
3. work-report-popup, temp-clear-date-inputs, tab-content-loader의 이동 경로를 반영한다. equipment-tm-popup, equipment-tree는 현재 파일이 없다.
4. 잘못된 이미지 경로와 누락 아이콘을 복구한다. jQuery UI는 공식 배포본의 images 자산을 함께 배치한다.

## 파일별 상세

### README.md

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [README.md:16](D:/PROJECT/WP_GIMPO_DT04_analysis/public/README.md:16) | `./docs/page-component-matrix.md` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |
| [README.md:17](D:/PROJECT/WP_GIMPO_DT04_analysis/public/README.md:17) | `./docs/migration-risk-report.md` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |
| [README.md:18](D:/PROJECT/WP_GIMPO_DT04_analysis/public/README.md:18) | `./docs/css-tab-analysis.md` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |
| [README.md:19](D:/PROJECT/WP_GIMPO_DT04_analysis/public/README.md:19) | `./docs/css-button-analysis.md` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |
| [README.md:20](D:/PROJECT/WP_GIMPO_DT04_analysis/public/README.md:20) | `./docs/button-theme-test-result.md` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |
| [README.md:21](D:/PROJECT/WP_GIMPO_DT04_analysis/public/README.md:21) | `./docs/tab-theme-test-result.md` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |
| [README.md:22](D:/PROJECT/WP_GIMPO_DT04_analysis/public/README.md:22) | `./docs/table-theme-test-result.md` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |

### WEB-INF/html/admin/index.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/admin/index.html:57](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/admin/index.html:57) | `/admin/pages/equipment-information.html` | 현재 파일 위치: `/WEB-INF/html/admin/pages/equipment-information.html` |

### WEB-INF/html/admin/pages/equipment-information.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/admin/pages/equipment-information.html:233](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/admin/pages/equipment-information.html:233) | `/resources/images/sample/52921-01240.jpg` | 동일 이름 파일(대체 전 내용 확인): `/resources/user/images/sample/52921-01240.jpg` |

### WEB-INF/html/user/common/header.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/common/header.html:2](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/common/header.html:2) | `/resources/images/logo.svg` | 동일 이름 파일(대체 전 내용 확인): `/resources/admin/images/logo.svg`, `/resources/user/images/logo.svg`, `/resources/user/images/pano/logo.svg` |

### WEB-INF/html/user/common/popup/popup-equipment-master.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/common/popup/popup-equipment-master.html:146](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/common/popup/popup-equipment-master.html:146) | `/resources/user/vendor/bootstrap-5.3.8/js/bootstrap-tab.js` | 삭제된 vendor 참조. 기존 공식 `bootstrap.bundle.min.js` 로드 여부와 탭 의존 코드를 확인해 교체 |

### WEB-INF/html/user/common/popup/popup-equipment.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/common/popup/popup-equipment.html:34](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/common/popup/popup-equipment.html:34) | `/pages/common/popup/popup-equipment-type.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-equipment-type.html` |
| [WEB-INF/html/user/common/popup/popup-equipment.html:68](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/common/popup/popup-equipment.html:68) | `/pages/common/popup/popup-functional-location.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-functional-location.html` |
| [WEB-INF/html/user/common/popup/popup-equipment.html:194](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/common/popup/popup-equipment.html:194) | `/resources/user/vendor/bootstrap-5.3.8/js/bootstrap-tab.js` | 삭제된 vendor 참조. 기존 공식 `bootstrap.bundle.min.js` 로드 여부와 탭 의존 코드를 확인해 교체 |

### WEB-INF/html/user/daily-status/equipment-classification.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/daily-status/equipment-classification.html:437](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/daily-status/equipment-classification.html:437) | `/resources/user/vendor/bootstrap-5.3.8/js/bootstrap-tab.js` | 삭제된 vendor 참조. 기존 공식 `bootstrap.bundle.min.js` 로드 여부와 탭 의존 코드를 확인해 교체 |

### WEB-INF/html/user/daily-status/routineWorkOrder.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/daily-status/routineWorkOrder.html:37](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/daily-status/routineWorkOrder.html:37) | `/pages/common/popup/popup-requester.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-requester.html` |
| [WEB-INF/html/user/daily-status/routineWorkOrder.html:51](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/daily-status/routineWorkOrder.html:51) | `/pages/common/popup/popup-department.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-department.html` |
| [WEB-INF/html/user/daily-status/routineWorkOrder.html:65](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/daily-status/routineWorkOrder.html:65) | `/pages/common/popup/popup-department.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-department.html` |
| [WEB-INF/html/user/daily-status/routineWorkOrder.html:111](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/daily-status/routineWorkOrder.html:111) | `/pages/daily-status/equipment-classification.html` | 현재 파일 위치: `/WEB-INF/html/user/daily-status/equipment-classification.html` |

### WEB-INF/html/user/daily-status/workReport.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/daily-status/workReport.html:265](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/daily-status/workReport.html:265) | `/resources/user/js/common/work-report-popup.js` | 동일 이름 파일(대체 전 내용 확인): `/resources/user/js/__temp/work-report-popup.js` |

### WEB-INF/html/user/dataparc/dataparc.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/dataparc/dataparc.html:39](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/dataparc/dataparc.html:39) | `/pages/dataparc/dataparc-list.html` | 대상 파일 자체가 없음. 경로 변경만으로 해결되지 않음 |
| [WEB-INF/html/user/dataparc/dataparc.html:44](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/dataparc/dataparc.html:44) | `/pages/dataparc/dataparc-trend.html` | 현재 파일 위치: `/WEB-INF/html/user/dataparc/dataparc-trend.html` |

### WEB-INF/html/user/equipment/equipment-information.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/equipment/equipment-information.html:34](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/equipment/equipment-information.html:34) | `/resources/user/vendor/bootstrap-5.3.8/js/bootstrap-tab.js` | 삭제된 vendor 참조. 기존 공식 `bootstrap.bundle.min.js` 로드 여부와 탭 의존 코드를 확인해 교체 |
| [WEB-INF/html/user/equipment/equipment-information.html:38](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/equipment/equipment-information.html:38) | `/resources/user/js/common/equipment-tm-popup.js` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |

### WEB-INF/html/user/equipment/equipment-operation.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/equipment/equipment-operation.html:40](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/equipment/equipment-operation.html:40) | `/pages/equipment/equipment-operation-trend.html` | 현재 파일 위치: `/WEB-INF/html/user/equipment/equipment-operation-trend.html` |
| [WEB-INF/html/user/equipment/equipment-operation.html:53](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/equipment/equipment-operation.html:53) | `/pages/data/equipment/equipment-operation-trend.html` | 현재 파일 위치: `/WEB-INF/html/user/equipment/equipment-operation-trend.html` |

### WEB-INF/html/user/equipment/equipment-search.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/equipment/equipment-search.html:34](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/equipment/equipment-search.html:34) | `/resources/user/js/jquery/jquery-3.7.1.min.js` | 동일 이름 파일(대체 전 내용 확인): `/resources/admin/js/jquery-ui/jquery-3.7.1.min.js` |
| [WEB-INF/html/user/equipment/equipment-search.html:36](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/equipment/equipment-search.html:36) | `/resources/user/js/pages/equipment-tree.js` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |

### WEB-INF/html/user/equipment/equipment-tm-issue.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/equipment/equipment-tm-issue.html:33](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/equipment/equipment-tm-issue.html:33) | `/pages/common/popup/popup-equipment.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-equipment.html` |
| [WEB-INF/html/user/equipment/equipment-tm-issue.html:49](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/equipment/equipment-tm-issue.html:49) | `/pages/common/popup/popup-requester.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-requester.html` |
| [WEB-INF/html/user/equipment/equipment-tm-issue.html:65](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/equipment/equipment-tm-issue.html:65) | `/pages/common/popup/popup-department.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-department.html` |
| [WEB-INF/html/user/equipment/equipment-tm-issue.html:81](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/equipment/equipment-tm-issue.html:81) | `/pages/common/popup/popup-department.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-department.html` |

### WEB-INF/html/user/equipment/equipment-tm.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/equipment/equipment-tm.html:20](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/equipment/equipment-tm.html:20) | `/pages/equipment/equipment-tm-issue.html` | 현재 파일 위치: `/WEB-INF/html/user/equipment/equipment-tm-issue.html` |
| [WEB-INF/html/user/equipment/equipment-tm.html:126](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/equipment/equipment-tm.html:126) | `/resources/user/js/common/equipment-tm-popup.js` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |

### WEB-INF/html/user/preventive-inspection/preventive-inspection-report.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/preventive-inspection/preventive-inspection-report.html:602](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/preventive-inspection/preventive-inspection-report.html:602) | `/resources/user/js/common/temp-clear-date-inputs.js` | 동일 이름 파일(대체 전 내용 확인): `/resources/user/js/__temp/temp-clear-date-inputs.js` |

### WEB-INF/html/user/preventive-inspection/preventive-inspection.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/preventive-inspection/preventive-inspection.html:43](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/preventive-inspection/preventive-inspection.html:43) | `/resources/user/vendor/bootstrap-5.3.8/js/bootstrap-tab.js` | 삭제된 vendor 참조. 기존 공식 `bootstrap.bundle.min.js` 로드 여부와 탭 의존 코드를 확인해 교체 |
| [WEB-INF/html/user/preventive-inspection/preventive-inspection.html:46](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/preventive-inspection/preventive-inspection.html:46) | `/resources/user/js/common/temp-clear-date-inputs.js` | 동일 이름 파일(대체 전 내용 확인): `/resources/user/js/__temp/temp-clear-date-inputs.js` |

### WEB-INF/html/user/tm/tm-equipment-classification.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/tm/tm-equipment-classification.html:35](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-equipment-classification.html:35) | `/resources/user/vendor/bootstrap-5.3.8/js/bootstrap-tab.js` | 삭제된 vendor 참조. 기존 공식 `bootstrap.bundle.min.js` 로드 여부와 탭 의존 코드를 확인해 교체 |

### WEB-INF/html/user/tm/tm-multiple-status.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/tm/tm-multiple-status.html:50](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-multiple-status.html:50) | `/pages/common/popup/popup-department.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-department.html` |
| [WEB-INF/html/user/tm/tm-multiple-status.html:62](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-multiple-status.html:62) | `/pages/common/popup/popup-department.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-department.html` |
| [WEB-INF/html/user/tm/tm-multiple-status.html:74](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-multiple-status.html:74) | `/pages/tm/tm-equipment-classification.html` | 현재 파일 위치: `/WEB-INF/html/user/tm/tm-equipment-classification.html` |
| [WEB-INF/html/user/tm/tm-multiple-status.html:110](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-multiple-status.html:110) | `/pages/tm/tm-multiple-status-detail.html` | 현재 파일 위치: `/WEB-INF/html/user/tm/tm-multiple-status-detail.html` |
| [WEB-INF/html/user/tm/tm-multiple-status.html:179](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-multiple-status.html:179) | `/resources/user/vendor/bootstrap-5.3.8/js/bootstrap-tab.js` | 삭제된 vendor 참조. 기존 공식 `bootstrap.bundle.min.js` 로드 여부와 탭 의존 코드를 확인해 교체 |

### WEB-INF/html/user/tm/tm-pending-status.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/tm/tm-pending-status.html:40](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-pending-status.html:40) | `/pages/common/popup/popup-department.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-department.html` |
| [WEB-INF/html/user/tm/tm-pending-status.html:63](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-pending-status.html:63) | `/pages/common/popup/popup-department.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-department.html` |
| [WEB-INF/html/user/tm/tm-pending-status.html:100](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-pending-status.html:100) | `/pages/tm/tm-pending-status-detail.html` | 현재 파일 위치: `/WEB-INF/html/user/tm/tm-pending-status-detail.html` |

### WEB-INF/html/user/tm/tm-processing-status.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/tm/tm-processing-status.html:82](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-processing-status.html:82) | `/pages/common/popup/popup-department.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-department.html` |
| [WEB-INF/html/user/tm/tm-processing-status.html:93](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-processing-status.html:93) | `/pages/common/popup/popup-department.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-department.html` |
| [WEB-INF/html/user/tm/tm-processing-status.html:137](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-processing-status.html:137) | `/pages/tm/tm-processing-status-detail.html` | 현재 파일 위치: `/WEB-INF/html/user/tm/tm-processing-status-detail.html` |

### WEB-INF/html/user/tm/tm-work-request-confirmation.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/tm/tm-work-request-confirmation.html:43](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-work-request-confirmation.html:43) | `/pages/common/popup/popup-department.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-department.html` |
| [WEB-INF/html/user/tm/tm-work-request-confirmation.html:70](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-work-request-confirmation.html:70) | `/pages/common/popup/popup-department.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-department.html` |
| [WEB-INF/html/user/tm/tm-work-request-confirmation.html:103](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-work-request-confirmation.html:103) | `/pages/tm/tm-work-request-detail.html` | 현재 파일 위치: `/WEB-INF/html/user/tm/tm-work-request-detail.html` |

### WEB-INF/html/user/tm/tm-work-request-count.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/tm/tm-work-request-count.html:96](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-work-request-count.html:96) | `/pages/common/popup/popup-department.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-department.html` |
| [WEB-INF/html/user/tm/tm-work-request-count.html:107](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-work-request-count.html:107) | `/pages/common/popup/popup-department.html` | 현재 파일 위치: `/WEB-INF/html/user/common/popup/popup-department.html` |
| [WEB-INF/html/user/tm/tm-work-request-count.html:151](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm-work-request-count.html:151) | `/pages/tm/tm-work-request-count-detail.html` | 현재 파일 위치: `/WEB-INF/html/user/tm/tm-work-request-count-detail.html` |

### WEB-INF/html/user/tm/tm.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/tm/tm.html:43](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm.html:43) | `/resources/user/vendor/bootstrap-5.3.8/js/bootstrap-tab.js` | 삭제된 vendor 참조. 기존 공식 `bootstrap.bundle.min.js` 로드 여부와 탭 의존 코드를 확인해 교체 |
| [WEB-INF/html/user/tm/tm.html:44](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/tm/tm.html:44) | `/resources/user/js/common/tab-content-loader.js` | 동일 이름 파일(대체 전 내용 확인): `/resources/user/js/__temp/tab-content-loader.js` |

### WEB-INF/html/user/work-status/red-tag.html

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [WEB-INF/html/user/work-status/red-tag.html:29](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/work-status/red-tag.html:29) | `/resources/user/vendor/bootstrap-5.3.8/js/bootstrap-tab.js` | 삭제된 vendor 참조. 기존 공식 `bootstrap.bundle.min.js` 로드 여부와 탭 의존 코드를 확인해 교체 |

### resources/admin/css/pages.css

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [resources/admin/css/pages.css:555](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/admin/css/pages.css:555) | `/resources/user/images/icons/pid_link.svg` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |
| [resources/admin/css/pages.css:558](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/admin/css/pages.css:558) | `/resources/user/images/icons/pid_link_hover.svg` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |
| [resources/admin/css/pages.css:578](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/admin/css/pages.css:578) | `/resources/user/images/icons/pid_link_last.svg` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |

### resources/admin/js/jquery-ui/jquery-ui.css

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [resources/admin/js/jquery-ui/jquery-ui.css:1067](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/admin/js/jquery-ui/jquery-ui.css:1067) | `images/ui-icons_444444_256x240.png` | 동일 이름 파일(대체 전 내용 확인): `/resources/user/images/pano/egovframework/com/cmm/utl/ui-icons_444444_256x240.png`, `/resources/user/images/pano/ui-icons_444444_256x240.png` |
| [resources/admin/js/jquery-ui/jquery-ui.css:1070](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/admin/js/jquery-ui/jquery-ui.css:1070) | `images/ui-icons_444444_256x240.png` | 동일 이름 파일(대체 전 내용 확인): `/resources/user/images/pano/egovframework/com/cmm/utl/ui-icons_444444_256x240.png`, `/resources/user/images/pano/ui-icons_444444_256x240.png` |
| [resources/admin/js/jquery-ui/jquery-ui.css:1076](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/admin/js/jquery-ui/jquery-ui.css:1076) | `images/ui-icons_555555_256x240.png` | 동일 이름 파일(대체 전 내용 확인): `/resources/user/images/pano/egovframework/com/cmm/utl/ui-icons_555555_256x240.png`, `/resources/user/images/pano/ui-icons_555555_256x240.png` |
| [resources/admin/js/jquery-ui/jquery-ui.css:1080](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/admin/js/jquery-ui/jquery-ui.css:1080) | `images/ui-icons_ffffff_256x240.png` | 동일 이름 파일(대체 전 내용 확인): `/resources/user/images/pano/egovframework/com/cmm/utl/ui-icons_ffffff_256x240.png`, `/resources/user/images/pano/ui-icons_ffffff_256x240.png` |
| [resources/admin/js/jquery-ui/jquery-ui.css:1084](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/admin/js/jquery-ui/jquery-ui.css:1084) | `images/ui-icons_777620_256x240.png` | 동일 이름 파일(대체 전 내용 확인): `/resources/user/images/pano/egovframework/com/cmm/utl/ui-icons_777620_256x240.png`, `/resources/user/images/pano/ui-icons_777620_256x240.png` |
| [resources/admin/js/jquery-ui/jquery-ui.css:1088](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/admin/js/jquery-ui/jquery-ui.css:1088) | `images/ui-icons_cc0000_256x240.png` | 동일 이름 파일(대체 전 내용 확인): `/resources/user/images/pano/egovframework/com/cmm/utl/ui-icons_cc0000_256x240.png`, `/resources/user/images/pano/ui-icons_cc0000_256x240.png` |
| [resources/admin/js/jquery-ui/jquery-ui.css:1091](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/admin/js/jquery-ui/jquery-ui.css:1091) | `images/ui-icons_777777_256x240.png` | 동일 이름 파일(대체 전 내용 확인): `/resources/user/images/pano/egovframework/com/cmm/utl/ui-icons_777777_256x240.png`, `/resources/user/images/pano/ui-icons_777777_256x240.png` |

### resources/user/css/components.css

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [resources/user/css/components.css:363](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/user/css/components.css:363) | `/resources/user/images/icons/keyboard_return-disabled.svg` | 동일 이름 파일(대체 전 내용 확인): `/resources/admin/images/icons/keyboard_return-disabled.svg` |
| [resources/user/css/components.css:367](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/user/css/components.css:367) | `/resources/user/images/icons/search-disabled.svg` | 동일 이름 파일(대체 전 내용 확인): `/resources/admin/images/icons/search-disabled.svg` |
| [resources/user/css/components.css:371](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/user/css/components.css:371) | `/resources/user/images/icons/calendar-disabled.svg` | 동일 이름 파일(대체 전 내용 확인): `/resources/admin/images/icons/calendar-disabled.svg` |

### resources/user/css/pages.css

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [resources/user/css/pages.css:597](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/user/css/pages.css:597) | `/resources/user/images/icons/pid_link.svg` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |
| [resources/user/css/pages.css:600](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/user/css/pages.css:600) | `/resources/user/images/icons/pid_link_hover.svg` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |
| [resources/user/css/pages.css:620](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/user/css/pages.css:620) | `/resources/user/images/icons/pid_link_last.svg` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |

### resources/user/js/__temp/work-report-popup.js

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [resources/user/js/__temp/work-report-popup.js:21](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/user/js/__temp/work-report-popup.js:21) | `/pages/daily-status/workReportForm.html` | 현재 파일 위치: `/WEB-INF/html/user/daily-status/workReportForm.html` |

### resources/user/js/common/common.js

| 위치 | 현재 참조 | 확인 결과 / 수정 방향 |
|---|---|---|
| [resources/user/js/common/common.js:959](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/user/js/common/common.js:959) | `/resources/user/images/icons/gnb-menu.svg` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |
| [resources/user/js/common/common.js:969](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/user/js/common/common.js:969) | `/resources/user/images/icons/gnb-menu.svg` | 동일 이름 파일 없음. 파일 복구 또는 참조 제거/대체 필요 |
| [resources/user/js/common/common.js:1178](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/user/js/common/common.js:1178) | `${pageContext.request.contextPath}/resources/user/js/svgviewer/css/svg-wrapper.css` | 정적 .js의 JSP 표현식은 치환되지 않음. CSS 파일도 없음. 실제 배포 CSS와 경로 확인 |

## 별도 확인 사항

- **WEB-INF 직접 접근**: 현재 메뉴·탭·AJAX에 `/WEB-INF/html/...` 주소가 사용된다. 정적 Live Server에서는 파일 위치와 맞지만, Java Servlet 환경에서는 WEB-INF 직접 요청이 제한된다. 해당 환경에 배포한다면 컨트롤러 공개 URL로 연결해야 한다. 서버 설정은 이 폴더에서 확인할 수 없었다.
- [Unity 설정](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/user/js/unity/unity3DViewer.js:39): 실제 조합 주소는 `/unity3DViewer/Build/WP_I-POS.loader.js`, `WP_I-POS.data.unityweb`, `WP_I-POS.framework.js.unityweb`, `WP_I-POS.wasm.unityweb`이다. public 안에는 빌드가 없다. 외부 배포 여부를 확인한다. 문자열 조각 `/WP_I-POS.loader.js` 자체를 오류 경로로 보지 않았다.
- [관리자 설비 이미지](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/admin/pages/equipment-information.html:133): `/modelImages/15880310.jpg`, [사용자 설비 이미지](D:/PROJECT/WP_GIMPO_DT04_analysis/public/WEB-INF/html/user/equipment/equipment-general.html:1712): `/modelImages/15878950.jpg`는 public에 없다. 서버 이미지 저장소 제공 여부를 확인한다.
- [관리자 dummy 데이터](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/admin/js/dataparc/svgDummyUtils.js:117), [사용자 dummy 데이터](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/user/js/svgviewer/dataparc/svgDummyUtils.js:117): `fetch('db.json')`가 호출되지만 동일 파일이 없다. 상대 주소는 JS 파일 위치가 아닌 실행 문서 URL 기준이다.
- [Chart 어댑터](D:/PROJECT/WP_GIMPO_DT04_analysis/public/resources/user/js/chart/chartjs-adapter-date-fns.bundle.min.js:7): 삭제된 `/resources/user/js/chart/chart.js`가 CommonJS/AMD 분기에 남아 있다. 일반 script 로드는 전역 Chart를 사용하므로 즉시 실패로 판정하지 않았다.
- pnid/dataparc의 drawing SVG 문자열은 주석 예시여서 오류 건수에서 제외했다. XLSX 번들의 조건부 require 문자열도 실제 브라우저 링크 오류로 집계하지 않았다.
