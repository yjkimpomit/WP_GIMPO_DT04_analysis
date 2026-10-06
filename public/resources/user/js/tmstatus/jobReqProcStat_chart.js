var cssVar = function (name) {
	return getComputedStyle(document.documentElement)
		.getPropertyValue(name)
		.trim();
};

//TM현황 작업요청 건수 차트
var procstat_data = {
	categories: chartList.map(item => item.labels),
	series: [
		{
			name: '발행',
			data: chartList.map(item => item.pubCnt)
		},
		{
			name: '취소',
			data: chartList.map(item => item.cancelCnt)
		},
		{
			name: '미결',
			data: chartList.map(item => item.susCnt)
		},
		{
			name: '완료',
			data: chartList.map(item => item.comCnt)
		}
	]
};

var maxValue = Math.max(...procstat_data.series.flatMap(series => series.data));

var procstat_chartoptions = {
		chart: {
			width: '100%',
			height: '100%',
			title:{
				text: '호기별 작업요청 처리현황',
				offsetY: 10,
				align: 'center'
			}
		},
		series: {
			eventDetectType: 'grouped'
		},
		xAxis: {
			height: 200,
			label: {
				//categories 글자 가로로 변경하는 옵션
				rotatable: true
			}
		},
		yAxis: {
			width: 50,
			scale: {
				min: 0,
				max: maxValue,
				stepSize: maxValue,
			}
		},
		legend: {
			visible: false,
		},
		theme:{
			title:{
				fontSize: 16,
				fontWeight: 700,
				color: cssVar('--chart-text')
			},
			xAxis: {
				title: {
					color: cssVar('--chart-text')
				},
				label: {
					color: cssVar('--chart-text-muted'),
					fontSize: 12
				},
				color: cssVar('--chart-axis'),
				width: 1
			},
			yAxis: {
				title: {
					color: cssVar('--chart-text')
				},
				label: {
					color: cssVar('--chart-text-muted'),
					fontSize: 12
				},
				color: cssVar('--chart-axis'),
				width: 1
			},
			chart: {
				backgroundColor: cssVar('--chart-bg')
			},

			series: {
				colors: [
					cssVar('--chart-1'),
					cssVar('--chart-11'),
					cssVar('--chart-5'),
					cssVar('--chart-2')
				]
				//barWidth: 24
			}
		},
		responsive: {
			animation: { duration: 300 }
		},
		exportMenu:{visible: false}
};

var procstat_chart = document.getElementById('procstat_chart');

var chart_procstat = toastui.Chart.columnChart({el:procstat_chart, data:procstat_data, options:procstat_chartoptions});

updateCharts();

function updateCharts(){
	if(searchVal == "1"){
		procstat_chartoptions.chart.title.text = "호기별 작업요청 처리현황";
	}else if(searchVal == "2"){
		procstat_chartoptions.chart.title.text = "요청부서별 작업요청 처리현황";
	}else if(searchVal == "3"){
		procstat_chartoptions.chart.title.text = "감독부서별 작업요청 처리현황";
	}else if(searchVal == "4"){
		procstat_chartoptions.chart.title.text = "요청자별 작업요청 처리현황";
	}else if(searchVal == "5"){
		procstat_chartoptions.chart.title.text = "설비별 작업요청 처리현황";
	}else if(searchVal == "6"){
		procstat_chartoptions.chart.title.text = "요청부서별 & 감독부서별 작업요청 처리현황";
	}
	procstat_chartoptions.chart.title.align = "center";
	procstat_chartoptions.chart.title.offsetY = 10;
	
	//차트 검색 개수가 20개 이상 일 경우 글자 세로로 변경
	var procListCnt = chartList.length;
	if(procListCnt > 20){
		procstat_chartoptions.xAxis.label.interval = 1;
	}
	chart_procstat.setOptions(procstat_chartoptions);
}

/*-- 20260107 yjkim : 차트 리사이징 start --*/
function resizeProcStatChart() {
	const width = procstat_chart.clientWidth;
	const height = procstat_chart.clientHeight;

	if (width > 0 && height > 0) {
		chart_procstat.resize({ width, height });
	}
}

// 최초 1회 (필수)
resizeProcStatChart();

// 화면 리사이즈 대응
window.addEventListener('resize', resizeProcStatChart);
/*-- 20260107 yjkim : 차트 리사이징 end --*/
