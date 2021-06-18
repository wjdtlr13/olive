<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home.css">


<style type="text/css">
a {
	color: black;
	text-decoration: none;
}

a:hover {
	text-decoration: none;
	color: #e57373;
}
.board-wrap {
	width: 870px;
	margin: auto;
}

.board-wrap div {
	font-weight: 600;
	padding-bottom: 5px;
}
.table-board{
	width: 100%;
}
.table-board td {
	padding: 7px 0px;
	font-size: 14px;
	padding-left: 3px;
}
.table-notice td:first-child, .table-free td:first-child{
	width: 60%;
}
.table-board td:nth-child(2){
	padding-left: 70px;
}

.table-prefer td:first-child{
	width: 50%;
}
.table-board td:nth-child(2){
	width: 20%;
}
.table-board tr:not(:last-of-type){
	border-bottom: 1px solid #eeeeee;
}
.weatherNcovid {
	height: 520px;
}
.weather-wrap, .covid-wrap {
	width: 400px;
	height: 200px;
	margin-top: 40px;
	border-radius: 30px;	
	background:#fafafa;
	box-shadow: 5px 5px 5px #eceff1;
}
.weather2-wrap{
	width: 850px;
	height: 200px;
	border-radius: 30px;	
	background:#fafafa;
	box-shadow: 5px 5px 5px #eceff1;
	margin-left:200px;
	margin-top: 20px;
	
}
.weather-wrap {
	margin-left:200px;
	float: left;
	padding-top: 30px;
	padding-left: 45px;
}
#wCity, #wTemp {
	font-weight:600;
	font-size: 19px;
}

.weather-wrap img{
	width: 150px;
	height: 150px;
}
.covid-wrap {
	float: left;
	margin-left: 50px;
}
.comment, #wStatus{
	font-size: 19px;
	font-weight: 500;
}
.div-cast-wrap{
	width: 160px;
	height: 160px;
	float: left;
	margin-left: 5px;
}
</style>
<div class="carousel slide" data-ride="carousel" id="carousel-1">
        <div class="carousel-inner">
            <div class="carousel-item active">
        		<svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#777"/></svg>
					<div class="container">
		          <div class="carousel-caption text-start">
		            <h1>Example headline.</h1>
		            <p>Some representative placeholder content for the first slide of the carousel.</p>
		            <p><a class="btn btn-lg btn-primary" href="#">Sign up today</a></p>
		          </div>
		        </div>
		      </div>
	      <div class="carousel-item">
	        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#777"/></svg>
	
	        <div class="container">
	          <div class="carousel-caption">
	            <h1>Another example headline.</h1>
	            <p>Some representative placeholder content for the second slide of the carousel.</p>
	            <p><a class="btn btn-lg btn-primary" href="#">Learn more</a></p>
	          </div>
	        </div>
	      </div>
	      <div class="carousel-item">
	        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#777"/></svg>
	
	        <div class="container">
	          <div class="carousel-caption text-end">
	            <h1>One more for good measure.</h1>
	            <p>Some representative placeholder content for the third slide of this carousel.</p>
	            <p><a class="btn btn-lg btn-primary" href="#">Browse gallery</a></p>
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

<div class="div-container">
	<div class="weatherNcovid">
		<div class="weather-wrap">
			<div class="div-comment"><span class="comment">우리동네  </span><span id="wCity"></span><span class="comment"> 는 현재  </span><span id="wTemp"></span></div>
			<img id="wIcon"><span id="wStatus"></span>
		</div>
		
		<div class="covid-wrap">
		
		</div>
		
		<div class="weather2-wrap" style="float: left;">
			<div class="comment" style="text-align: center; margin-top: 10px;">우리 동네 주간 예보</div>
			<div class="div-cast-wrap cast1">
				<div><img id="hIcon1" width="70px" height="70px">&nbsp;&nbsp;&nbsp;<span id="hTemp1"></span></div>
				<div><span id="hStatus1"></span></div>
				<span id="hDate1"></span>
			</div>
			<div class="div-cast-wrap cast2">
				<div><img id="hIcon2" width="70px" height="70px">&nbsp;&nbsp;&nbsp;<span id="hTemp2"></span></div>
				<div><span id="hStatus2"></span></div>
				<span id="hDate2"></span>
			</div>
			<div class="div-cast-wrap cast3">
				<div><img id="hIcon3" width="70px" height="70px">&nbsp;&nbsp;&nbsp;<span id="hTemp3"></span></div>
				<div><span id="hStatus3"></span></div>
				<span id="hDate3"></span>
			</div>
			<div class="div-cast-wrap cast4">
				<div><img id="hIcon4" width="70px" height="70px">&nbsp;&nbsp;&nbsp;<span id="hTemp4"></span></div>
				<div><span id="hStatus4"></span></div>
				<span id="hDate4"></span>
			</div>
			<div class="div-cast-wrap cast5">
				<div><img id="hIcon5" width="70px" height="70px">&nbsp;&nbsp;&nbsp;<span id="hTemp5"></span></div>
				<div><span id="hStatus5"></span></div>
				<span id="hDate5"></span>
			</div>
			
		</div>
	</div>
	
	<div class="board-wrap">
		<div><a href="${pageContext.request.contextPath}/notice/list">관리실에서 알립니다</a></div>
		<table class="table-board table-notice">	
				<tr><td>공지입니다.</td><td>관리자</td><td>2020.01.01</td></tr>
				<tr><td>공지공지</td><td>관리자</td><td>2020.01.01</td></tr>
				<tr><td>공지예요</td><td>관리자</td><td>2020.01.01</td></tr>
				<tr><td>필독해주세요</td><td>관리자</td><td>2020.01.01</td></tr>
				<tr><td>안녕하세요</td><td>관리자</td><td>2020.01.01</td></tr>	
		</table>
		
		<div class="space-box" style="height: 25px;"></div>
					
		<div><a href="${pageContext.request.contextPath}/free/list">형형색깔 올리브</a></div>
		<table class="table-board table-free">
			<tr><td>얘들아 합정 맛집 추천 좀</td><td>닉네임</td><td>2021.01.01</td></tr>	
			<tr><td>강남역 ㅇㅇ치과 좋아요</td><td>닉네임</td><td>2021.01.01</td></tr>	
			<tr><td>집에 벌레 들어왔는데 어떡하지</td><td>닉네임</td><td>2021.01.01</td></tr>	
			<tr><td>신촌에서 고터 어떻게 가?</td><td>닉네임</td><td>2021.01.01</td></tr>	
			<tr><td>자취 최고최고</td><td>닉네임</td><td>2021.01.01</td></tr>	
		</table>		
				
		<div class="space-box" style="height: 25px;"></div>
				
		
	</div>	
	
<%-- 	
	<div class="board-wrap">
		<div><a href="${pageContext.request.contextPath}/notice/list">관리실에서 알립니다</a></div>
		<table class="table-board table-notice">
			<c:forEach var="dto" items="${listNotice}" >
				<tr><td><a href="${pageContext.request.contextPath}/notice/list?article?num=${dto.num}&page=1">${dto.subject}</a></td><td>관리자</td><td>${dto.created}</td></tr>
			</c:forEach>
		</table>
		
		<div class="space-box" style="height: 25px;"></div>
					
		<div><a href="${pageContext.request.contextPath}/free/list">형형색깔 올리브</a></div>
		<table class="table-board table-free">
			<c:forEach var="dto" items="${listBoard}">			
				<tr><td><a href="${pageContext.request.contextPath}/free/list?article?num=${dto.num}&page=1">${dto.subject}</a></td><td>${nickName}</td><td>${dto.created}</td></tr>	
			</c:forEach>
		</table>		
				
		<div class="space-box" style="height: 25px;"></div>
				
		
	</div>

 --%></div>
 
 
<script type="text/javascript">

const API_KEY ="c9c0090af725019df0790f1afc93abde";
//const API_KEY2 ="2fdc853bf365437bb87c402962fbf242";


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

function dailyWeather(lat,lon){ // 3 시간 단위로 5 일 예보
    fetch('https://api.openweathermap.org/data/2.5/forecast?lat='+lat+'&lon='+lon+'&lang=kr&appid='+API_KEY+'&units=metric')
    .then(res => res.json())
    .then(data => {
    	console.log(data);
//    	document.getElementById("hCity").innerHTML = data.city.name;
    	document.getElementById("hDate1").innerHTML = data.list[7].dt_txt;
    	document.getElementById("hDate2").innerHTML = data.list[15].dt_txt;
    	document.getElementById("hDate3").innerHTML = data.list[23].dt_txt;
    	document.getElementById("hDate4").innerHTML = data.list[31].dt_txt;
    	document.getElementById("hDate5").innerHTML = data.list[39].dt_txt;
    	document.getElementById("hIcon1").src = 'https://openweathermap.org/img/wn/'+data.list[7].weather[0].icon+'@2x.png';
    	document.getElementById("hIcon2").src = 'https://openweathermap.org/img/wn/'+data.list[15].weather[0].icon+'@2x.png';
    	document.getElementById("hIcon3").src = 'https://openweathermap.org/img/wn/'+data.list[23].weather[0].icon+'@2x.png';
    	document.getElementById("hIcon4").src = 'https://openweathermap.org/img/wn/'+data.list[31].weather[0].icon+'@2x.png';
    	document.getElementById("hIcon5").src = 'https://openweathermap.org/img/wn/'+data.list[39].weather[0].icon+'@2x.png';
    	document.getElementById("hTemp1").innerHTML = data.list[7].main.temp +'&#176;C';
    	document.getElementById("hTemp2").innerHTML = data.list[15].main.temp +'&#176;C';
    	document.getElementById("hTemp3").innerHTML = data.list[23].main.temp +'&#176;C';
    	document.getElementById("hTemp4").innerHTML = data.list[31].main.temp +'&#176;C';
    	document.getElementById("hTemp5").innerHTML = data.list[39].main.temp +'&#176;C';
    	document.getElementById("hStatus1").innerHTML = data.list[7].weather[0].description;
    	document.getElementById("hStatus2").innerHTML = data.list[15].weather[0].description;
    	document.getElementById("hStatus3").innerHTML = data.list[23].weather[0].description;
    	document.getElementById("hStatus4").innerHTML = data.list[31].weather[0].description;
    	document.getElementById("hStatus5").innerHTML = data.list[39].weather[0].description;

    	
    })
	
}

</script>
 