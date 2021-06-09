<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style type="text/css">
.map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap {position:relative;width:100%;height:350px;}
#category {position:absolute;top:10px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
#category li {float:left;list-style: none;width:50px;px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
#category li.on {background: #eee;}
#category li:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
#category li:last-child{margin-right:0;border-right:0;}
#category li span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
#category li .category_bg {background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;}
#category li .bank {background-position: -10px 0;}
#category li .mart {background-position: -10px -36px;}
#category li .pharmacy {background-position: -10px -72px;}
#category li .oil {background-position: -10px -108px;}
#category li .cafe {background-position: -10px -144px;}
#category li .store {background-position: -10px -180px;}
#category li.on .category_bg {background-position-x:-46px;}
.placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
.placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
.placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
.placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
.placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
.placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
.placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.placeinfo .tel {color:#0f7833;}
.placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
</style>
<div style=" width: 1100px; height: 30px; font-size: 22px; margin-left: 60px; margin-top: 40px; margin-bottom: 20px;">올리브네 응급실</div>
<div style="width:1170px; height: 30px; border-top: 1.5px solid #8e8e8e; margin: auto;"></div>

<div class="map_wrap" style="border: 2px solid #99aa00; width: 1200px; height: 500px; margin: auto; border-radius: 20px;">
    <div id="map" style="width:100%; height:100%; position:relative; overflow:hidden; border-radius: 20px;"></div>
    <ul id="category">
        <li id="HP8" data-order="2"> 
            <span class="category_bg pharmacy"></span>
            병원
        </li>  
        <li id="PM9" data-order="2"> 
            <span class="category_bg pharmacy"></span>
            약국
        </li>  
    </ul>
</div>
<div style="height: 30px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=03d78d5198e11184a4fbf52c695b0c27&libraries=services"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		level : 5
	// 지도의 확대 레벨 
	};

	//마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이
	var placeOverlay = new kakao.maps.CustomOverlay({
		zIndex : 1
	}), contentNode = document.createElement('div'), markers = [], currCategory = '';

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 생성

	if (navigator.geolocation) {

		// GeoLocation을 이용해서 접속 위치를 얻어옴
		navigator.geolocation.getCurrentPosition(function(position) {

			var lat = position.coords.latitude, // 위도
			lon = position.coords.longitude; // 경도

			var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성
			message = '<div style="padding:5px;">현재 위치가 맞나요 ?!</div>';

			displayMarker(locPosition, message);

		});

	} else {

		var locPosition = new kakao.maps.LatLng(33.450701, 126.570667), message = 'geolocation 사용 불가능'

		displayMarker(locPosition, message);
	}

	// 지도에 마커와 인포윈도우를 표시하는 함수
	function displayMarker(locPosition, message) {

		var marker = new kakao.maps.Marker({
			map : map,
			position : locPosition
		});

		var iwContent = message, iwRemoveable = true;

		var infowindow = new kakao.maps.InfoWindow({
			content : iwContent,
			removable : iwRemoveable
		});

		// 인포윈도우를 마커 위에 표시 
		infowindow.open(map, marker);

		// 지도 중심좌표를 접속위치로 변경
		map.setCenter(locPosition);
	}

	//장소검색 객체 생성
	var ps = new kakao.maps.services.Places(map);

	//지도에 idle 이벤트 등록
	kakao.maps.event.addListener(map, 'idle', searchPlaces);

	contentNode.className = 'placeinfo_wrap';

	addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
	addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);

	placeOverlay.setContent(contentNode);

	//각 카테고리에 클릭 이벤트를 등록합니다
	addCategoryClickEvent();

	//엘리먼트에 이벤트 핸들러를 등록하는 함수
	function addEventHandle(target, type, callback) {
		if (target.addEventListener) {
			target.addEventListener(type, callback);
		} else {
			target.attachEvent('on' + type, callback);
		}
	}

	//카테고리 검색을 요청하는 함수
	function searchPlaces() {
		if (!currCategory) {
			return;
		}

		placeOverlay.setMap(null);

		removeMarker();

		ps.categorySearch(currCategory, placesSearchCB, {
			useMapBounds : true
		});
	}

	//장소검색이 완료됐을 때 호출되는 콜백함
	function placesSearchCB(data, status, pagination) {
		if (status === kakao.maps.services.Status.OK) {

			// 정상적으로 검색이 완료됐으면 지도에 마커 표출
			displayPlaces(data);
		} else if (status === kakao.maps.services.Status.ZERO_RESULT) {

		} else if (status === kakao.maps.services.Status.ERROR) {

		}
	}

	function displayPlaces(places) {
		var order = document.getElementById(currCategory).getAttribute(
				'data-order');
		for (var i = 0; i < places.length; i++) {
			var marker = addMarker(new kakao.maps.LatLng(places[i].y,
					places[i].x), order);
			(function(marker, place) {
				kakao.maps.event.addListener(marker, 'click', function() {
					displayPlaceInfo(place);
				});
			})(marker, places[i]);
		}
	}

	//마커를 생성하고 지도 위에 마커를 표시하는 함수
	function addMarker(position, order) {
		var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', imageSize = new kakao.maps.Size(
				27, 28), imgOptions = {
			spriteSize : new kakao.maps.Size(72, 208),
			spriteOrigin : new kakao.maps.Point(46, (order * 36)),
			offset : new kakao.maps.Point(11, 28)
		}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
				imgOptions), marker = new kakao.maps.Marker({
			position : position,
			image : markerImage
		});

		marker.setMap(map);
		markers.push(marker);

		return marker;
	}

	//지도 위에 표시되고 있는 마커를 모두 제거
	function removeMarker() {
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(null);
		}
		markers = [];
	}

	//클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수
	function displayPlaceInfo(place) {
		var content = '<div class="placeinfo">'
				+ '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">'
				+ place.place_name + '</a>';

		if (place.road_address_name) {
			content += '    <span title="' + place.road_address_name + '">'
					+ place.road_address_name
					+ '</span>'
					+ '  <span class="jibun" title="' + place.address_name + '">(지번 : '
					+ place.address_name + ')</span>';
		} else {
			content += '    <span title="' + place.address_name + '">'
					+ place.address_name + '</span>';
		}

		content += '    <span class="tel">' + place.phone + '</span>'
				+ '</div>' + '<div class="after"></div>';

		contentNode.innerHTML = content;
		placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
		placeOverlay.setMap(map);
	}

	//각 카테고리에 클릭 이벤트 등록
	function addCategoryClickEvent() {
		var category = document.getElementById('category'), children = category.children;

		for (var i = 0; i < children.length; i++) {
			children[i].onclick = onClickCategory;
		}
	}

	//카테고리를 클릭했을 때 호출되는 함수
	function onClickCategory() {
		var id = this.id, className = this.className;

		placeOverlay.setMap(null);

		if (className === 'on') {
			currCategory = '';
			changeCategoryClass();
			removeMarker();
		} else {
			currCategory = id;
			changeCategoryClass(this);
			searchPlaces();
		}
	}

	//클릭된 카테고리에만 클릭된 스타일을 적용하는 함수
	function changeCategoryClass(el) {
		var category = document.getElementById('category'), children = category.children, i;

		for (i = 0; i < children.length; i++) {
			children[i].className = '';
		}

		if (el) {
			el.className = 'on';
		}
	}
</script>