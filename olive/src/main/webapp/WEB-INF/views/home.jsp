<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.highcharts-figure, .highcharts-data-table table {
    min-width: 360px; 
    max-width: 900px;
    margin: 1em auto;
}
.highcharts-data-table table {
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}
.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 13px;
    color: #555;
}
.highcharts-data-table th {
	font-weight: 600;
    padding: 0.5em;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
    padding: 0.5em;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}
.highcharts-data-table tr:hover {
    background: #f1f7ff;
}


a {
	color: black;
	text-decoration: none;
}
a:hover {
	text-decoration: none;
	color: #e57373;
}
.board-wrap {
	padding-top : 60px;
	width: 870px;
	margin: auto;
}
.photo-wrap{
	margin-top: 56px;
}
.photo-wrap img{
	width: 100%;
	height: 480px;
	opacity: 0.5;
}
.div-photo{
	width: 98%;
	margin: auto;
}
.board-wrap div {
	font-weight: 600;
	padding-bottom: 5px;
	font-size: 19px;
}
.table-board {
	width: 100%;
}
.table-board td {
	padding: 10px 0px;
	font-size: 16px;
	padding-left: 10px;
}
.table-notice td:first-child, .table-free td:first-child {
	width: 60%;
}
.table-board td:nth-child(2) {
	padding-left: 70px;
}
.table-prefer td:first-child {
	width: 50%;
}
.table-board td:nth-child(2) {
	width: 20%;
}
.table-board tr:not(:last-of-type){
border-bottom: 1px solid #eeeeee;
}
.div-covid {
	height: 570px;
	padding-top: 50px;
}

#hIcon1, #hIcon2, #hIcon3, #hIcon4, #hIcon5,#wIcon {
	width: 150px;
	height: 150px;
}
.comment {
	font-size: 19px;
	font-weight: 500;
}

.div-cast-wrap {
	width: 220px;
	height: 220px;
	float: left;
	margin-top: 8px;
	margin-left: 20px;
}

#hDate1, #hDate2, #hDate3, #hDate4, #hDate5,#hDate0 {
	text-align: center;
}

.junggo-wrap {
	margin-bottom: 30px;
	width: 1200px;
	height: 300px;
	margin: auto;
}

.junggo-title {
	font-weight: 600;
	font-size: 20px;
	text-align: center;
	margin-bottom: 15px;
}

.junggo-wrap img {
	width: 200px;
	height: 200px;
}

.junggo-sub {
	text-align: center;
	margin-top: 8px;
}

.junggo-created {
	width: 120px;
	text-align: center;
	margin: auto;
	margin-top: 8px;
	
}
.junggo-div {
	float: left;
	margin: 15px;
	border: 1px solid #eee;
}
.div-title{
 text-align: center;
  margin-top: 15px;
   font-weight:bolder;
    font-size: 25px;
}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home.css">
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<div class="div-container" style="margin-top: 50px;">
	<div class="carousel slide" data-ride="carousel" id="carousel-1">
	        <div class="carousel-inner">
	            <div class="carousel-item active">
	              <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"  style="background: url('${pageContext.request.contextPath}/resources/img/main_window.png');"><rect width="100%" height="100%" fill-opacity="0.4"/></svg>
	               <div class="container">
	                <div class="carousel-caption text-start">
	                  <h2>집에서 홀로 공허함을 느낀 순간이 있나요?</h2>
	                  <p>올리브 얼론에서 새로운 이웃을 만들어보세요.</p>
	                  <p><a class="btn btn-lg btn-primary" href="${pageContext.request.contextPath}/member/member">올리브네 입주신청</a></p>
	                </div>
	              </div>
	            </div>
	         <div class="carousel-item">
	           <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false" style="background: url('${pageContext.request.contextPath}/resources/img/main_meal33.jpg')no-repeat center/contain;"><rect width="100%" height="100%" fill-opacity="0.4"/></svg>
	   
	           <div class="container">
	             <div class="carousel-caption">
	               <h2>매일 혼밥하는 당신! 지겹지는 않나요?</h2>
	               <p>올리브 얼론이 식사메이트를 매칭해드립니다.</p>
	               <p><a class="btn btn-lg btn-primary" href="${pageContext.request.contextPath}/mate/list">올리브의 밥친구</a></p>
	             </div>
	           </div>
	         </div>
	         <div class="carousel-item">
	           <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false" style="background: url('${pageContext.request.contextPath}/resources/img/main_junggo.jpg')no-repeat center/contain;"><rect width="100%" height="100%" fill-opacity="0.4"/></svg>
	   
	           <div class="container">
	             <div class="carousel-caption text-end">
	               <h2>배송비때문에 구매를 망설이신 적, 없으신가요?</h2>
	               <p>다른 사람들과 함께 구매하세요 !</p>
	               <p><a class="btn btn-lg btn-primary" href="${pageContext.request.contextPath}/auction/list">함께사는 올리브</a></p>
	             </div>
	           </div>
	           
	         </div>
	         
	      </div>
	        <div><a class="carousel-control-prev" href="#carousel-1" role="button" data-slide="prev"><span class="carousel-control-prev-icon"></span><span class="sr-only">Previous</span></a><a class="carousel-control-next" href="#carousel-1" role="button" data-slide="next"><span class="carousel-control-next-icon"></span><span class="sr-only">Next</span></a></div>
	        <ol class="carousel-indicators">
	            <li data-target="#carousel-1" data-slide-to="0" class="active"></li>
	            <li data-target="#carousel-1" data-slide-to="1"></li>
	            <li data-target="#carousel-1" data-slide-to="2"></li>
	        </ol>
	    </div>

	<div class="div-weekly" style="width: 100%; height: 330px;"">
		<div class="div-title">우리 동네 날씨 ( <span id="wCity"></span> )</div>
			<div style="margin: auto; width: 1200px; height: 330px;">		
				<div class="div-cast-wrap cast0">
					<div><img id="wIcon" width="70px" height="70px">&nbsp;&nbsp;&nbsp;<span id="wTemp"></span></div>
					<div style="text-align: center;"><span id="wStatus"></span></div>
					<div id="hDate0" style="color: #ef5350; font-weight: bolder;">현재</div>
				</div>
							
				<div class="div-cast-wrap cast1">
					<div><img id="hIcon1" width="70px" height="70px">&nbsp;&nbsp;&nbsp;<span id="hTemp1"></span></div>
					<div style="text-align: center;"><span id="hStatus1"></span></div>
					<div id="hDate1"></div>
				</div>
				<div class="div-cast-wrap cast2">
					<div><img id="hIcon2" width="70px" height="70px">&nbsp;&nbsp;&nbsp;<span id="hTemp2"></span></div>
					<div style="text-align: center;"><span id="hStatus2"></span></div>
					<div id="hDate2"></div>
				</div>
				<div class="div-cast-wrap cast3">
					<div><img id="hIcon3" width="70px" height="70px">&nbsp;&nbsp;&nbsp;<span id="hTemp3"></span></div>
					<div style="text-align: center;"><span id="hStatus3"></span></div>
					<div id="hDate3"></div>
				</div>
				<div class="div-cast-wrap cast4">
					<div><img id="hIcon4" width="70px" height="70px">&nbsp;&nbsp;&nbsp;<span id="hTemp4"></span></div>
					<div style="text-align: center;"><span id="hStatus4"></span></div>
					<div id="hDate4"></div>
				</div>
			</div>
	</div>
		
		<div style="width: 70%; height: 30px; border-bottom: 1px dashed #a4a4a4; margin: auto;"></div>
		
		
	<div class="div-covid">
		<div class="div-title"">우리 동네 코로나</div>
		<figure class="highcharts-figure">
		    <div id="container"></div>
		</figure>
	</div>

	<div class="space-box" style="height: 50px;"></div>	
	<div style="width: 73%; height: 30px; border-bottom: 1px dashed #a4a4a4; margin: auto;"></div>
	<div class="space-box" style="height: 70px;"></div>
	
	
	<div class="junggo-wrap">
	<div class="junggo-title"><a href="${pageContext.request.contextPath}/junggo/list">주고받는 올리브</a></div>
		<c:forEach var="dto" items="${listJunggo}">			
			<div class="junggo-div">
				<div><a href="${pageContext.request.contextPath}/junggo/article?page=1&num=${dto.num}"><img src="${dto.imageFileName}"></a></div>
				<div class="junggo-sub"><a href="${pageContext.request.contextPath}/junggo/article?page=1&num=${dto.num}">${dto.subject}</a></div>
				<div class="junggo-created">${dto.price}원</div>
			</div> 		
		</c:forEach>
 	</div>
 	
	<div class="space-box" style="height: 70px;"></div>
	<div style="width: 73%; height: 30px; border-bottom: 1px dashed #a4a4a4; margin: auto;"></div> 		
	<div class="space-box" style="height: 50px;"></div>
	
	<div class="board-wrap">
		<div><a href="${pageContext.request.contextPath}/notice/list">관리실에서 알립니다</a></div>
		<table class="table-board table-notice">
			<c:forEach var="dto" items="${listNotice}" >
				<tr><td><a href="${pageContext.request.contextPath}/notice/article?num=${dto.num}&page=1">${dto.subject}</a></td><td>관리자</td><td>${dto.created}</td></tr>
			</c:forEach>
		</table>
 		
		<div class="space-box" style="height: 40px;"></div>
 				
		<div><a href="${pageContext.request.contextPath}/free/list">형형색깔 올리브</a></div>
		<table class="table-board table-free">
			<c:forEach var="dto" items="${listFree}">			
				<tr><td><a href="${pageContext.request.contextPath}/free/article?num=${dto.num}&page=1">${dto.subject}</a></td><td>${dto.nickName}</td><td>${dto.created}</td></tr>	
			</c:forEach>
		</table> 
			
 	</div>

	
	<div class="space-box" style="height: 50px;"></div>
		
</div>
 
 
<script type="text/javascript">

const API_KEY ="c9c0090af725019df0790f1afc93abde";

function handleGeoSucc(position) {
    console.log(position);
    const latitude = position.coords.latitude;  // 경도  
    const longitude = position.coords.longitude;  // 위도
    const coordsObj = {
        latitude,
        longitude
    }
    getWeather(latitude, longitude);
    dailyWeather(latitude,longitude);
}

function handleGeoErr(err) {
    alert("현재 위치를 받아올 수 없습니다.");
}

function requestCoords() { // 현재 위치 받아오는 메소드
    navigator.geolocation.getCurrentPosition(handleGeoSucc, handleGeoErr);
}

requestCoords();

function getWeather(lat, lon) { // 현재 날씨
    fetch('https://api.openweathermap.org/data/2.5/weather?lat='+lat+'&lon='+lon+'&lang=kr&appid='+API_KEY+'&units=metric')
    .then(res => res.json())
    .then(data => {
    	document.getElementById("wCity").innerHTML = data.name;
    	document.getElementById("wIcon").src = 'https://openweathermap.org/img/wn/'+data.weather[0].icon+'@2x.png';
    	document.getElementById("wStatus").innerHTML = data.weather[0].description;
    	document.getElementById("wTemp").innerHTML = data.main.temp +'&#176;C';
    })
}

function dailyWeather(lat,lon){ // 5 일 예보
    fetch('https://api.openweathermap.org/data/2.5/forecast?lat='+lat+'&lon='+lon+'&lang=kr&appid='+API_KEY+'&units=metric')
    .then(res => res.json())
    .then(data => {
//    	console.log(data);
//    	document.getElementById("hCity").innerHTML = data.city.name; 지역
    	document.getElementById("hDate1").innerHTML = (data.list[7].dt_txt).substring(5,10).replace('-','월 ')+"일"; // 날짜
    	document.getElementById("hDate2").innerHTML = (data.list[15].dt_txt).substring(5,10).replace('-','월 ')+"일";
    	document.getElementById("hDate3").innerHTML = (data.list[23].dt_txt).substring(5,10).replace('-','월 ')+"일";
    	document.getElementById("hDate4").innerHTML = (data.list[31].dt_txt).substring(5,10).replace('-','월 ')+"일";
    	document.getElementById("hIcon1").src = 'https://openweathermap.org/img/wn/'+data.list[7].weather[0].icon+'@2x.png'; // 아이콘
    	document.getElementById("hIcon2").src = 'https://openweathermap.org/img/wn/'+data.list[15].weather[0].icon+'@2x.png';
    	document.getElementById("hIcon3").src = 'https://openweathermap.org/img/wn/'+data.list[23].weather[0].icon+'@2x.png';
    	document.getElementById("hIcon4").src = 'https://openweathermap.org/img/wn/'+data.list[31].weather[0].icon+'@2x.png';
    	document.getElementById("hTemp1").innerHTML = data.list[7].main.temp +'&#176;C'; // 기온
    	document.getElementById("hTemp2").innerHTML = data.list[15].main.temp +'&#176;C';
    	document.getElementById("hTemp3").innerHTML = data.list[23].main.temp +'&#176;C';
    	document.getElementById("hTemp4").innerHTML = data.list[31].main.temp +'&#176;C';
    	document.getElementById("hStatus1").innerHTML = data.list[7].weather[0].description; // 날씨 상태
    	document.getElementById("hStatus2").innerHTML = data.list[15].weather[0].description;
    	document.getElementById("hStatus3").innerHTML = data.list[23].weather[0].description;
    	document.getElementById("hStatus4").innerHTML = data.list[31].weather[0].description;
    })
}

$(function(){
	var url ="${pageContext.request.contextPath}/covid";

	var date = new Date(); // 오늘 날짜 받아오기
	var year = date.getFullYear(); 
	var month = date.getMonth()+1; 
	var day = date.getDate(); 

	if(month<10){ // 한자리수일 경우 0을 채워줌
	  month = "0" + month; 
	} 
	if(day<10){ 
	  day = "0" + day; 
	} 
	
	var today = year + "" + month + "" + day; // ex) 20210109
	
	var query ="today="+today;
	var fn = function(data){
		covidChart(data);
	}
	ajaxFun(url, "post", "json", query, fn);
});

function ajaxFun(url, method, dataType, query, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data){
			fn(data);
		},
		error:function(e, textStatus, errorThrown) {
			console.log(e.responseText);
		}
	});
}
function covidChart(data) {
	console.log(data);
	
	var daebi = [];
	
	var date = new Date(); // 오늘 날짜 받아오기
	var year = date.getFullYear(); 
	var month = date.getMonth()+1; 
	var day = date.getDate(); 
	var today = data.response.body.items.item[1].stdDay+" 기준";
	
	for(var i=0; i<18; i++){
		daebi[i] = data.response.body.items.item[18-i].incDec;
	}
	
	Highcharts.chart('container', {
	
		  title: {
		    text: '&nbsp;'
		  },
		  subtitle: {
		    text: today
		  },
		  yAxis: {
		    title: {
		      text: '증가 수'
		    }
		  },
		    xAxis: {
		        categories: ['전국','서울', '부산', '대구', '인천', '광주', '대전',
		            '울산', '세종', '경기', '강원', '충북', '충남', '전북', '전남', '경북', '경남', '제주']
		    },
		  legend: {
		    layout: 'vertical',
		    align: 'right',
		    verticalAlign: 'middle'
		  },
		  series: [{
		    name: '전일 대비 확진자',
		    data: daebi
		  }],
	
		  responsive: {
		    rules: [{
		      condition: {
		        maxWidth: 500
		      },
		      chartOptions: {
		        legend: {
		          layout: 'horizontal',
		          align: 'center',
		          verticalAlign: 'bottom'
		        }
		      }
		    }]
		  }
		});
} 
</script>
 