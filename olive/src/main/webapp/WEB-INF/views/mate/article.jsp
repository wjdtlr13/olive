<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mate-register.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR">
<head>
<script type="text/javascript">
	function ajaxFun(url, method, query, dataType, fn) {
		$
				.ajax({
					type : method,
					url : url,
					data : query,
					dataType : dataType,
					success : function(data) {
						fn(data);
					},
					beforeSend : function(jqXHR) {
						jqXHR.setRequestHeader("AJAX", true);
					},
					error : function(jqXHR) {
						if (jqXHR.status == 403) {
							location.href = "${pageContext.request.contextPath}/member/login";
							return false;
						}
						console.log(jqXHR.responseText);
					}
				});
	}

	$(function() {
		$("#update").click(function() {
			$(".read").css('display', 'none');
			$(".change").css('display', '');
		})

		$("#delete").click(function() {
			if (!confirm('밥친구 모집을 삭제하시겠습니까?')) {
				return false;
			}

			var url = "${pageContext.request.contextPath}/mate/deleteRegister";

			var f = document.submitForm;
			f.action = url;
			f.submit();
		})
	});

	$(function() {
		$('#listRequest').click(function() {
			$('form[name=submitForm]').hide();
			$(this).closest('.col-lg-6').find('table').show();
			$(this).hide();
			$('#myInfo').show();
		})

		$('#myInfo').click(function() {
			$('form[name=submitForm]').show();
			$(this).closest('.col-lg-6').find('table').hide();
			$(this).hide();
			$('#listRequest').show();
		})

		$(document)
				.on(
						'click',
						'.btnModal',
						function() {
							var introduce = $(this).closest('tr').find(
									'input[name=mate_introduce]').val();
							var kind = $(this).closest('tr').find(
									'input[name=mate_kind]').val();
							var etc = $(this).closest('tr').find(
									'input[name=mate_etc]').val();
							var nName = $(this).closest('tr').find(
									'input[name=nickName]').val();

							$('#contentModal').find('.nickName').text(nName);
							$('#contentModal').find('textarea[name=introduce]')
									.text(kind);
							$('#contentModal').find('textarea[name=kind]')
									.text(kind);
							$('#contentModal').find('textarea[name=nName]')
									.text(nName);
						})
	});
	
	function listRequest() {
		if ('${mode}' != 'mine')
			return;
		var regNum = "$(dto.mate_reg_num)";
		var url = "${pageContext.request.contextPath}/mate/listItsRequest";
		var query = "reg_num=" + regNum;

		var fn = function(data) {

			for (var idx = 0; idx < data.list.length; idx++) {
				var out = "";

				var listNum = data.list[idx].listNum;
				var mate_req_num = data.list[idx].mate_req_num;
				var nickName = data.list[idx].nickName;
				var req_date = data.list[idx].req_date;
				var mate_introduce = data.list[idx].mate_introduce;
				var mate_kind = data.list[idx].mate_kind;
				var mate_etc = data.list[idx].mate_etc;

				item += "<tr><td>" + listNum + "</td><td>" + nickName
						+ "</td><td>" + req_date + "</td>"
				item += '<td><button class="btn btnModal" data-toggle="modal"data-target="#contentModal">확인</button></td>';
				item += '<td><input type="hidden" name="mate_introduce" val="'+mate_introduce+'">';
				item += '<input type="hidden" name="mate_kind" val="'+mate_kind+'">';
				item += '<input type="hidden" name="mate_etc" val="'+mate_etc+'">';
				item += '<input type="hidden" name="nickName" val="'+nickName+'"></td></tr>';
			}
			$('tbody').append(item);
		};
		ajaxFun(url, "post", query, "html", fn);
	}
	
	listRequest();
</script>
</head>


<div class="col">
	<p>현재는 약속을 삭제해야 식당 재선택이 가능합니다.</p>
	
</div>
<div class="col">
	<div class="row">
		<div class="col-lg-6" style="padding: 0px;">
			<div class="d-flex justify-content-end align-items-start welcome"
				style="background: url('${pageContext.request.contextPath}/resources/img/mate/restaurent.png') center;">
				<span style="color: rgb(255, 255, 255); padding: 10px;"><strong><a
						class='menu' target='_blank' href='${dto.eating_url }'>메뉴 보러가기
							&gt;</a></strong></span>
			</div>
			<div class="row">
				<div
					class="col d-flex justify-content-between align-items-center heading">
					<p>
						<strong>${dto.eating_name }</strong>
					</p>
				</div>
			</div>
			<p class="address">${dto.eating_address }</p>
			<p class="address">${dto.eating_tel }</p>
			<div id="staticMap" style="width: 100%; height: 40%;"></div>
		</div>
		<div class="col-lg-6">
			<p style="text-align: right;">
				<c:choose>
					<c:when test="${mode == 'mine' }">
						<button class="btn" id="myInfo" type="button"
							style="display: none;">내 정보 보기</button>
						<button class="btn" id="listRequest" type="button">메이트
							요청이 3개 있습니다 &gt;</button>
						<input id="input1" type="hidden" value="내 정보 보기">
						<input id="input2" type="hidden">
					</c:when>
					<c:when test="${mode == 'available' }">
						<button class="btn" data-toggle="modal"
							data-target="#contentModal">신청하기 &gt;</button>
					</c:when>
				</c:choose>
			</p>
			<form name="submitForm" method="post">
				<div class="col">
					<p class="read" style="margin: 0px;">약속 시간</p>
					<p class="change" style="margin: 0px; display: none;">언제 만나는
						약속인가요?</p>
				</div>
				<div class="col d-flex justify-content-around">
					<input name="eating_date" class="form-control" readonly
						value="${dto.eating_date }" type="date" style="width: 40%;"><input
						name="eating_time" class="form-control" readonly
						value="${dto.eating_time }" type="time" style="width: 40%;">
				</div>
				<div class="col">
					<p class="read"></p>${dto.reg_nickName }님의
					자기 소개
					<p class="change" style="display: none;">자기소개를 적어주세요</p>
					<textarea name="mate_introduce" class="form-control" readonly>${dto.reg_introduce }</textarea>
				</div>
				<div class="col">
					<p class="read">${dto.reg_nickName }님의취향</p>
					<p class="change" style="display: none;">만나고 싶은 사람과 음식 취향을
						알려주세요</p>
					<div class="form-check">
						<input class="form-check-input change" type="checkbox"
							id="formCheck-1" style="display: none;"><label
							class="form-check-label  change" for="formCheck-1"
							style="display: none;">내 프로필의 취향 및 알러지를 추가합니다</label>
					</div>
					<textarea name="mate_kind" class="form-control" readonly>${dto.reg_kind }</textarea>
				</div>
				<div class="col">
					<p class="read">${dto.reg_nickName }님이 하고 싶은 말</p>
					<p class="change" style="display: none;">기타 하고픈 말을 적어주세요</p>
					<textarea name="mate_etc" class="form-control" readonly>${dto.reg_etc }</textarea>
					<input type="hidden" name="userId" value="${dto.reg_userId }">
					<input type="hidden" name="page" value="${page }"> <input
						type="hidden" name="mode" value="${mode }"> <input
						type="hidden" name="readMode" value="${readMode }"> <input
						type="hidden" name="mate_reg_num" value="${dto.mate_reg_num }">
					<input type="hidden" name="mate_regi_num"
						value="${dto.mate_regi_num }">
				</div>
				<c:if test="${mode == 'mine'}">
					<button id="update" class="btn" style="margin-left: 10px;">수정하기</button>
					<button id="delete" class="btn" style="margin-left: 10px;">삭제하기</button>
				</c:if>
			</form>
			<table class="table table-striped table-hover" style="display: none;">
				<thead>
					<tr>
						<th width="15%">번호</th>
						<th width="25%">닉네임</th>
						<th>등록일</th>
						<th width="20%">확인하기</th>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
</div>
<div id="contentModal" class="modal fade writer" role="dialog"
	tabindex="-1">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">
					<c:choose>
						<c:when test="${mode == 'mine' }">
							메이트 보기
						</c:when>
						<c:otherwise>
							메이트 신청하기
						</c:otherwise>
						</c:choose>
				</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<form name="requestForm" method="post">
				<div class="modal-body">
					<table class="table table-border table-content">
						<tr>
							<td valign="top" width="40%"><c:choose>
									<c:when test="${mode=='mine' }">
										<span class="nickName"></span>님의 자기 소개
								</c:when>
									<c:otherwise>
									자기소개를 적어주세요
								</c:otherwise>
								</c:choose></td>
							<td valign="top"><textarea name="mate_introduce" class="boxTA"></textarea>
							</td>
						</tr>
						<tr>
							<td valign="top" width="40%"><c:choose>
									<c:when test="${mode=='mine' }">
										<span class="nickName"></span>님의 취향
								</c:when>
									<c:otherwise>
									만나고 싶은 사람과 음식 취향을 알려주세요
								</c:otherwise>
								</c:choose></td>
							<td valign="top"><textarea name="mate_kind" class="boxTA"></textarea>
							</td>
						</tr>
						<tr>
							<td valign="top" width="40%"><c:choose>
									<c:when test="${mode=='mine' }">
										<span class="nickName"></span>님이 하고 싶은 말
								</c:when>
									<c:otherwise>
									기타 하고픈 말을 적어주세요
								</c:otherwise>
								</c:choose></td>
							<td valign="top"><textarea name="mate_etc" class="boxTA"></textarea>
							</td>
							<td>
								<input type="hidden" name="reg_num" value="${dto.mate_reg_num }">
							</td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-dark btnSendOk">
						<c:choose>
						<c:when test="${mode == 'mine' }">
							함께먹기
						</c:when>
						<c:otherwise>
							신청하기
						</c:otherwise>
						</c:choose>
					</button>
					<button type="button" class="btn btnSendCancel">
						<c:choose>
						<c:when test="${mode == 'mine' }">
							거절하기
						</c:when>
						<c:otherwise>
							취소하기
						</c:otherwise>
						</c:choose>
					</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fb51bdcf55c0cc56b06790613bd6d8b1&libraries=services"></script>
<script>
	// 마커를 담을 배열입니다
	var markers = [];

	var geocoder = new kakao.maps.services.Geocoder();

	function displayStaticMap(address) {
		geocoder.addressSearch(address, function(result, status) {
			// 정상적으로 검색이 완료됐으면 
			if (status === kakao.maps.services.Status.OK) {

				var markerPosition = new kakao.maps.LatLng(result[0].y,
						result[0].x);
				var marker = {
					position : markerPosition
				};

				var staticMapContainer = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
				staticMapOption = {
					center : markerPosition, // 이미지 지도의 중심좌표
					level : 3, // 이미지 지도의 확대 레벨
					marker : marker
				// 이미지 지도에 표시할 마커 
				};

				var staticMap = new kakao.maps.StaticMap(staticMapContainer,
						staticMapOption);
			}
			;
		});
	};

	displayStaticMap("${dto.eating_address}");
	
	$(function(){
		$('.btnSendOk').click(function(){
			var url;
			if('${mode}' == 'mine') {url = '${pageContext.request.contextPath}/mate/requestAccept'; }
			else if('${mode}' == 'available') {url =  '${pageContext.request.contextPath}/mate/insertRequest'; }
			var f = document.requestForm;
			f.action = url;
			f.submit();
		})
	})
</script>