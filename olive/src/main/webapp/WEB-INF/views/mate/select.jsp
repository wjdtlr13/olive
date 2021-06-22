<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mate-food.css">
 <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR">
 
<head>
    <meta charset="utf-8">
    <title>키워드로 장소검색하고 목록으로 표출하기</title>
    <style>
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
</style>

<script type="text/javascript">
function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data){
			fn(data);
		},
		beforeSend : function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error : function(jqXHR) {
			if (jqXHR.status == 403) {
				location.href="${pageContext.request.contextPath}/member/login";
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	$(document).on('click', '.select-next', function(){
		var url="${pageContext.request.contextPath}/mate/register";
		var query = $(this).closest('form').serialize();
		query+="&categoryNum="+document.getElementById('categoryNum').value;
		var address = $(this).closest('form').find('input[name=eating_address]').val();
		
		var fn = function(data){
			$('#register-section').html(data);
			$('textarea[name=mate_etc]').focus();
			displayStaticMap(address);
		};
		ajaxFun(url, "post", query, "html", fn);
	});
	$(document).on('click', '#back', function(){
		$('#register-section').empty();
		$('#keyword').focus();
	});
	
});



</script>
</head>
<body>
<div class="jumbotron" style="background: rgb(103,98,23);border-radius: 0px;">
        <h1 style="color: rgb(222,232,192);">메이트 등록을 시작합니다</h1>
        <hr style="height: 2px;width: 80%;background: rgb(222,232,192);margin: 30px 0;">
    </div>
<div class="map_wrap col">
	  <div class="row" style="padding: 10px;">
        <div class="col-12 col-lg-6" style="padding: 5px 20px;">
            <p style="font-size: 24px;margin: 0px;color: #444444;">지도의 주소는:&nbsp;</p>
            <div class="row justify-content-around" style="padding: 5px 20px;">
                <div class="col-auto">
                    <h1 id="centerAddr"><strong>${address }</strong></h1>
                    
                </div>
                <div class="col-auto" style="margin-top: 5px;">
                	<div class="option">
            			<div><form onsubmit="searchPlaces(); return false;">
                    		<input type="hidden" value="서울시 은평구 구산동 한식" id="keyword" size="15">
                    		<input type="hidden" value="한식" id="selectedType">
                    		<input type="hidden" id="categoryNum" value=1> 
                    	<button type="submit" class="btn btn-success" style="margin-left: 10px;padding: 8px;font-size: 18px;border-style: none;min-width: 88px;background: rgb(82,76,0);">
                    		<strong>찾아보기</strong></button> 
                		</form></div>
        			</div>
                </div>
        	</div>
      	</div>
        <div class="col-sm-12 col-lg-6 food-list">
            <div class="row justify-content-around">
                <div class="col-auto food-type" style="background: url('${pageContext.request.contextPath}/resources/img/mate/mate-korean.jpg') no-repeat; background-size: cover; min-width: 100px;min-height: 100px;padding: 0;">
                    <p class=" d-flex justify-content-center align-items-center"><strong>한식</strong></p><input type="hidden" class="category" value=1>
                </div>
                <div class="col-auto food-type" style="background: url('${pageContext.request.contextPath}/resources/img/mate/mate-chinese.jpg') no-repeat; background-size: cover; min-width: 100px;min-height: 100px;padding: 0;">
                    <p class=" d-flex justify-content-center align-items-center"><strong>중식</strong></p><input type="hidden" class="category" value=2>
                </div>
                <div class="col-auto food-type" style="background: url('${pageContext.request.contextPath}/resources/img/mate/mate-japanese.jpg') no-repeat; background-size: cover; min-width: 100px;min-height: 100px;padding: 0;">
                    <p class=" d-flex justify-content-center align-items-center"><strong>일식</strong></p><input type="hidden" class="category" value=3>
                </div>
                <div class="col-auto food-type" style="background: url('${pageContext.request.contextPath}/resources/img/mate/mate-western.jpg') no-repeat; background-size: cover; min-width: 100px;min-height: 100px;padding: 0;">
                    <p class=" d-flex justify-content-center align-items-center"><strong>양식</strong></p><input type="hidden" class="category" value=4>
                </div>
                <div class="col-auto food-type" style="background: url('${pageContext.request.contextPath}/resources/img/mate/mate-vegan.jpg') no-repeat; background-size: cover; min-width: 100px;min-height: 100px;padding: 0;">
                    <p class=" d-flex justify-content-center align-items-center"><strong>비건</strong></p><input type="hidden" class="category" value=5>
                </div>
                <div id="pagination" style="width:100%;"></div>
            </div>
        </div>
    </div>
    <div class="row" style="padding: 10px;">
        <div id="map" class="col-md-12 col-lg-7 col-xl-8" style="padding: 0; width:100%; height:600px;"></div>
        <div id="placesList" class="col-md-12 col-lg-5 col-xl-4" style=" border-left: 1px solid #eeeeee; height: 600px; overflow-y: scroll;">
        </div>   
    </div>  
</div>

<div id="register-section">
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fb51bdcf55c0cc56b06790613bd6d8b1&libraries=services"></script>
<script>

// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  
// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

	//주소-좌표 변환 시작
//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
searchAddrFromCoords(map.getCenter(), displayCenterInfo);
    

// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'idle', function() {
    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
});

function searchAddrFromCoords(coords, callback) {
    // 좌표로 행정동 주소 정보를 요청합니다
    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
}
    
function searchDetailAddrFromCoords(coords, callback) {
    // 좌표로 법정동 상세 주소 정보를 요청합니다
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}

// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
function displayCenterInfo(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        var infoDiv = document.getElementById('centerAddr');

        for(var i = 0; i < result.length; i++) {
            // 행정동의 region_type 값은 'H' 이므로
            if (result[i].region_type === 'H') {
                infoDiv.innerHTML = result[i].address_name;
                break;
            }
        }
    }    
}
	//주소-좌표 변환 끝

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {
	
	var address = document.getElementById('centerAddr').innerText;
	var kind = document.getElementById('selectedType').value;
	var keyword = address+" "+kind;
    document.getElementById('keyword').value = keyword;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

$(function(){
	$('.food-type').find('p').click(function(){
		var kind = $(this).text();
		var address = document.getElementById('centerAddr').innerText;
		var keyword = address+" "+kind;
		var categoryNum = $(this).closest('div').find('.category').val();
		document.getElementById('keyword').value = keyword;
		document.getElementById('selectedType').value = kind;
		document.getElementById('categoryNum').value = categoryNum;
		 
		 if (!keyword.replace(/^\s+|\s+$/g, '')) {
		        alert('키워드를 입력해주세요!');
		        return false;
		    }

		    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		    ps.keywordSearch( keyword, placesSearchCB); 
	})
})

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {
	var el = document.createElement('div'),
    itemStr='<div class="row" style="border-top: 2px solid lightgrey;border-bottom: 2px solid lightgrey;padding: 0;margin: 0;">';
    itemStr+='<div class="col-auto d-flex align-items-center"><span style="font-size: 25px;color: rgb(255,255,255);background: rgb(82,76,0);padding: 0px 10px;border-style: none;border-color: rgb(82,76,0);"><strong>'+(index+1)+'</strong></span></div>';
    itemStr+='<div class="col"><h4><strong>'+places.place_name+'</strong>';
    itemStr+="<a class='menu' target='_blank' href='"+places.place_url+"'>메뉴보기></a></h4>";
    
    if (places.road_address_name) {
    	itemStr+='<p name="eating_address" style="font-size: 18px;margin: 5px;color: #444444;">'+ places.road_address_name +'</p>';
    } else {
    	itemStr+='<p name="eating_address" style="font-size: 18px;margin: 5px;color: #444444;">'+ places.address_name +'</p>';
    }
    itemStr+='<p name="eating_tel" style="font-size: 18px;margin: 5px;color: #666666;">'+places.phone+'</p>';           
    itemStr+='<form name="selectForm" method="post">';
    itemStr+='<input type="hidden" name="eating_name" value="'+places.place_name+'">';
    if (places.road_address_name)
    	itemStr+='<input type="hidden" name="eating_address" value="'+places.road_address_name+'">';
    else
    	itemStr+='<input type="hidden" name="eating_address" value="'+places.address_name+'">';
    itemStr+='<input type="hidden" name="eating_tel" value="'+places.phone+'">';
    itemStr+='<input type="hidden" name="eating_url" value="'+places.place_url+'">';
	itemStr+="<button type='button' class='btn select-next'>선택하기</button></form></div></div>";

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
 
function displayStaticMap(address){
	geocoder.addressSearch(address, function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
			
	        var markerPosition = new kakao.maps.LatLng(result[0].y, result[0].x);
			var marker = {
				position: markerPosition
			};
			
			
			var staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
			staticMapOption = { 
	        center: markerPosition, // 이미지 지도의 중심좌표
	        level: 3, // 이미지 지도의 확대 레벨
	        marker: marker // 이미지 지도에 표시할 마커 
			};
			
			var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
	    };    
	});
};
</script>
</body>