<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mate-register.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR">
<head>
<script type="text/javascript">
$(function(){
	$("#update").click(function(){
		$(".read").css('display', 'none');
		$(".change").css('display', '');
	})
	
	$("#delete").click(function(){
		if(!confirm('도전과제를 삭제하시겠습니까?'))  {
			return false;
		}
				
		var url="${pageContext.request.contextPath}/mate/deleteRegister";
		
		var f = document.submitForm;
		f.action = url;
		f.submit();
	})
});
</script>
</head>


<div class="col">
        <p>현재는 약속을 삭제해야 식당 재선택이 가능합니다.</p>
    </div>
<div class="col">
        <div class="row">
            <div class="col-lg-6" style="padding: 0px;">
                <div class="d-flex justify-content-end align-items-start welcome" style="background: url('${pageContext.request.contextPath}/resources/img/mate/restaurent.png') center;"><span style="color: rgb(255,255,255);padding: 10px;"><strong><a class='menu' target='_blank' href='${dto.eating_url }'>메뉴 보러가기 &gt;</a></strong></span></div>
                <div class="row">
                    <div class="col d-flex justify-content-between align-items-center heading">
                        <p><strong>${dto.eating_name }</strong></p>
                    </div>
                </div>
                <p class="address">${dto.eating_address }</p>
                <p class="address">${dto.eating_tel }</p><div id="staticMap" style="width: 100%;height: 40%;"></div>
            </div>
            <div class="col-lg-6">
                <form name="submitForm" method="post">
                    <div class="col">
                        <p class="read" style="margin: 0px;">언제 만나는 약속인가요?</p><p class="change" style="margin: 0px; display: none;">약속 시간</p>
                    </div>
                    <div class="col d-flex justify-content-around"><input name="eating_date" class="form-control" value="${dto.eating_date }" type="date" style="width: 40%;"><input name="eating_time" class="form-control" value="${dto.eating_time }" type="time" style="width: 40%;"></div>
                    <div class="col">
                        <p class="read">자기소개를 적어주세요</p><p class="change" style="display: none;">${dto.reg_nickName }님의 자기 소개</p><textarea name="mate_introduce" class="form-control">${dto.reg_introduce }</textarea>
                    </div>
                    <div class="col">
                        <p class="read">만나고 싶은 사람과 음식 취향을 알려주세요</p><p class="change" style="display: none;">${dto.reg_nickName }님의 취향</p>
                        <div class="form-check"><input class="form-check-input change" type="checkbox" id="formCheck-1" style="display:none;"><label class="form-check-label  change" for="formCheck-1" style="display:none;">내 프로필의 취향 및 알러지를 추가합니다</label></div><textarea name="mate_kind" class="form-control">${dto.reg_kind }</textarea>
                    </div>
                    <div class="col">
                        <p class="read">기타 하고픈 말을 적어주세요</p><p class="change" style="display: none;">${dto.reg_nickName }님이 하고싶은 말</p><textarea name="mate_etc" class="form-control">${dto.reg_etc }</textarea>
                    	<input type="hidden" name="userId" value="${dto.reg_userId }">
                    	<input type="hidden" name="page" value="${page }">
                    	<input type="hidden" name="mode" value="${mode }">
                    	<input type="hidden" name="mate_reg_num" value="${dto.mate_reg_num }">
                    	<input type="hidden" name="mate_regi_num" value="${dto.mate_regi_num }">
                    </div>
                    
                </form>
                	<button id="update" class="btn" style="margin-left: 10px;">수정하기</button>
                    <button id="delete" class="btn" style="margin-left: 10px;">삭제하기</button>
            </div>
        </div>
    </div>
    
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fb51bdcf55c0cc56b06790613bd6d8b1&libraries=services"></script>
<script>

// 마커를 담을 배열입니다
var markers = [];

var geocoder = new kakao.maps.services.Geocoder();

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

displayStaticMap("${dto.eating_address}");
console.log("${dto.mate_reg_num }");

console.log("${dto.mate_regi_num }");
console.log("${mode }");
console.log("${page}");
</script>