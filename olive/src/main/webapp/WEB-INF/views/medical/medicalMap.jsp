<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/medicalMap.css" type="text/css">

<div style="height: 75px;"></div>
<div class="div-title">올리브네 응급실</div>
<div style="width:1170px; height: 10px; border-top: 1.5px solid #8e8e8e; margin: 20px auto;"></div>

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