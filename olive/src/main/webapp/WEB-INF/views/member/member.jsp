<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/icofont/icofont.min.css" type="text/css">
<style type="text/css">
.body-title {
	margin-top: 80px;
	margin-bottom: 30px;
}
.body-title h2{
	font-weight: 700;
}

.table {
	width: 100%;
	border-spacing: 0;
	border-collapse: collapse;
}

.table-content {
	margin-top: 25px;
}

.table-content tr > td:nth-child(1) {
	width: 130px;
	padding-top: 5px;
	padding-right: 5px;
	text-align: right;
	vertical-align: top;
}
.table-content tr > td:nth-child(1) label {
	font-weight: 700;
}

.table-content tr > td:nth-child(2) {
	padding-left: 10px;
	padding-bottom: 13px;
}

.table-content tr > td:nth-child(2) p:first-child {
	padding-bottom: 5px;
}

.table-content .lg {
	width: 98%;
}

.table-content .md {
	width: 33%;
}

.table-content .sm {
	width: 23%;
}


.table-footer {
	margin: 5px auto;
}
.table-footer tr {
	height:45px;
	text-align: center;
}
</style>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dateUtil.js"></script>
<script type="text/javascript">
function memberOk() {
	var f = document.memberForm;
	var str;

	str = f.userId.value;
	if(!str) {
		alert("아이디를 입력하세요. ");
		f.userId.focus();
		return;
	}
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) { 
		alert("아이디는 5~10자이며 첫글자는 영문자이어야 합니다.");
		f.userId.focus();
		return;
	}
	

	str = f.pwd.value;
	if(!str) {
		alert("패스워드를 입력하세요. ");
		f.pwd.focus();
		return;
	}
	if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
		alert("패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.");
		f.pwd.focus();
		return;
	}

	if(str!= f.pwdCheck.value) {
        alert("패스워드가 일치하지 않습니다. ");
        f.pwdCheck.focus();
        return;
	}
	
    str = f.userName.value;
    if(!str) {
        alert("이름을 입력하세요. ");
        f.userName.focus();
        return;
    }
    str = f.nickName.value;
    if(!str) {
        alert("사용하실 별명을 입력하세요. ");
        f.nickName.focus();
        return;
    }

    str = f.birth.value;
    if(!str || !isValidDateFormat(str)) {
        alert("생년월일를 입력하세요[YYYY-MM-DD]. ");
        f.birth.focus();
        return;
    }
    
    str = f.tel.value;
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel.focus();
        return;
    }

    str = f.email.value;
    if(!str) {
        alert("이메일을 입력하세요. ");
        f.email.focus();
        return;
    }

 	f.action = "${pageContext.request.contextPath}/member/${mode}";
    f.submit();
}


function userIdCheck() {
	/*
	var str = $("#userId").val();
	str = str.trim();
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) { 
		$("#userId").focus();
		return;
	}
	
	// jquery - AJAX : json-post 방식
	var url = "${pageContext.request.contextPath}/member/userIdCheck";
	$.post(url, {userId:str}, function(data){
		var p=data.passed;
		if(p=="true") {
			var s="<span style='color:blue;font-weight:bold;'>"+str+"</span> 아이디는 사용 가능합니다.";
			$("#userId").parent().next(".help-block").html(s);
		} else {
			var s="<span style='color:red;font-weight:bold;'>"+str+"</span> 아이디는 사용할 수 없습니다.";
			$("#userId").parent().next(".help-block").html(s);
			$("#userId").val("");
			$("#userId").focus();
		}
	}, "json");
*/	
}

</script>


<style type="text/css">
.body-container {
	max-width: 850px; margin: 10px auto 5px; padding-top: 20px;
}
</style>

<div class="body-container">
	<div class="body-title">
		<h2><i class="bi bi-person-square"></i> 회원 가입</h2>
	</div>


	<div class="body-main">
		<form name="memberForm" method="post">
			<div class="form-group form-row">
				<label class="col-sm-2 col-form-label" for="userId">아이디</label>
				<div class="col-sm-8">
					<input class="form-control" id="userId" name="userId" type="text" value="${dto.userId}" 
							${mode=="update" ? "readonly='readonly' ":""}
							onchange="userIdCheck();"
							placeholder="아이디">
					<small class="form-text text-muted help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</small>
				</div>
			</div>
		 
			<div class="form-group form-row">
				<label class="col-sm-2 col-form-label" for="userPwd">패스워드</label>
				<div class="col-sm-8">
		            <input class="form-control" id="userPwd" name="pwd" type="password" placeholder="패스워드">
		            <small class="form-text text-muted">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</small>
		        </div>
		    </div>
		    
		    <div class="form-group form-row">
		        <label class="col-sm-2 col-form-label" for="userPwdCheck">패스워드 확인</label>
		        <div class="col-sm-8">
		            <input class="form-control" id="userPwdCheck" name="pwdCheck" type="password" placeholder="패스워드 확인">
		            <small class="form-text text-muted">패스워드를 한번 더 입력해주세요.</small>
		        </div>
		    </div>
		 
		    <div class="form-group form-row">
		        <label class="col-sm-2 col-form-label" for="userName">이름</label>
		        <div class="col-sm-8">
		            <input class="form-control" id="userName" name="userName" type="text" value="${dto.userName}" 
		            		${mode=="update" ? "readonly='readonly' ":""}
		            		placeholder="이름">
		        </div>
		    </div>
		 
		    <div class="form-group form-row">
		        <label class="col-sm-2 col-form-label" for="nickName">닉네임</label>
		        <div class="col-sm-8">
		            <input class="form-control" id="nickName" name="nickName" type="text" value="${dto.nickName}" 
		            		${mode=="update" ? "readonly='readonly' ":""}
		            		placeholder="닉네임">
		        </div>
		    </div>

		    <div class="form-group form-row">
		        <label class="col-sm-2 col-form-label" for="birth">생년월일</label>
		        <div class="col-sm-8">
		            <input class="form-control" id="birth" name="birth" type="date" value="${dto.birth}" placeholder="생년월일">
		            <small class="form-text text-muted">생년월일은 2000-01-01 형식으로 입력 합니다.</small>
		        </div>
		    </div>

		    <div class="form-group form-row">
		        <label class="col-sm-2 col-form-label" for="birth">이메일</label>
		        <div class="col-sm-8">
		            <input class="form-control" id="email" name="email" type="text" value="${dto.email}" placeholder="이메일">
		        </div>
		    </div>

		    <div class="form-group form-row">
		        <label class="col-sm-2 col-form-label" for="birth">전화번호</label>
		        <div class="col-sm-8">
		            <input class="form-control" id="tel" name="tel" type="text" value="${dto.tel}" placeholder="전화번호">
		        </div>
		    </div>
		
		    <div class="form-group form-row">
		        <label class="col-sm-2 col-form-label" for="zip">우편번호</label>
		        <div class="col-sm-5">
		       		<div class="input-group">
		           		<input class="form-control" id="zip" name="zip" placeholder="우편번호" value="${dto.zip}" readonly="readonly">
		           		<span class="input-group-btn">
		           			<button class="btn btn-light" type="button" style="margin-left: 5px;" onclick="daumPostcode();">우편번호 검색</button>
		           		</span>
		           	</div>
				</div>
		    </div>
	
		    <div class="form-group form-row">
		        <label class="col-sm-2 col-form-label" for="addr1">주소</label>
		        <div class="col-sm-8">
		       		<div>
		           		<input class="form-control" id="addr1" name="addr1" placeholder="기본 주소" value="${dto.addr1}" readonly="readonly">
		           	</div>
		       		<div style="margin-top: 5px;">
		       			<input class="form-control" id="addr2" name="addr2" placeholder="상세 주소" value="${dto.addr2}">
					</div>
				</div>
		    </div>
	
		    <div class="form-group form-row">
		        <label class="col-sm-2 col-form-label" for="agree">약관 동의</label>
				<div class="col-sm-1" style="padding-top: 5px; padding-left: 0; padding-right: 0;">
					<input id="agree" name="agree" type="checkbox" checked="checked"
						style="margin-left: 0;"
						onchange="form.sendButton.disabled = !checked">
				</div>
				<div class="col-sm-5" style="padding-top: 5px; padding-left: 0;">
						<a href="#">이용약관</a>에 동의합니다.
				</div>
		    </div>
		     
		    <div class="form-group form-row">
		        <div class="offset-sm-2 col-sm-10">
		            <button type="submit" name="sendButton" class="btn btn-primary" onclick="memberOk();"> 회원가입 <i class="bi bi-check2"></i></button>
		            <button type="button" class="btn btn-danger" onclick="javascript:location.href='${pageContext.request.contextPath}/';">가입취소</button>
		        </div>
		    </div>
		
		    <div class="form-group row">
				<div class="offset-sm-2 col-sm-10">
					<p class="form-control-plaintext text-center">${message}</p>
		        </div>
		    </div>
		</form>
	</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function daumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('addr2').focus();
            }
        }).open();
    }
</script>
</div>
