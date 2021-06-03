<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.table {
	width: 100%;
	border-spacing: 0;
	border-collapse: collapse;
}

.table-content {
	margin-top: 25px;
}

.table-content tr > td:nth-child(1) {
	width: 100px;
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
<div class="body-container" style="width: 700px;">
	<div class="body-title">
        <h3><i class="fas fa-user"></i> ${mode=="member"?"회원 가입":"회원 정보 수정"} </h3>
	</div>
    
	<div class="body-main">
		<form name="memberForm" method="post">
		<table class="table table-content">
			<tr>
				<td>
					<label>아이디</label>
				</td>
				<td>
					<p>
						<input type="text" name="userId" id="userId" maxlength="15" class="boxTF lg" 
							value="${dto.userId}"
							onchange="userIdCheck();"
							${mode=="update" ? "readonly='readonly' ":""}
							placeholder="아이디">
					</p>
					<p class="help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</p>
				</td>
			</tr>
			
			<tr>
				<td>
					<label>패스워드</label>
				</td>
				<td>
					<p>
						<input type="password" name="pwd" maxlength="15" class="boxTF lg"
							placeholder="패스워드">
					</p>
					<p class="help-block">패스워드는 5~10자 이내이며, 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</p>
				</td>
			</tr>
			
			<tr>
				<td>
					<label>패스워드 확인</label>
				</td>
				<td>
					<p>
						<input type="password" name="pwdCheck" maxlength="15" class="boxTF lg"
							placeholder="패스워드 확인">
					</p>
					<p class="help-block">패스워드를 한번 더 입력해주세요.</p>
				</td>
			</tr>
			
			<tr>
				<td>
					<label>이름</label>
				</td>
				<td>
					<p>
						<input type="text" name="userName" maxlength="30" class="boxTF lg"
							value="${dto.userName}" 
							${mode=="update" ? "readonly='readonly' ":""}
							placeholder="이름">
					</p>
				</td>
			</tr>
			<tr>
				<td>
					<label>닉네임</label>
				</td>
				<td>
					<p>
						<input type="text" name="nickName" maxlength="30" class="boxTF lg"
							value="${dto.nickName}" 
							${mode=="update" ? "readonly='readonly' ":""}
							placeholder="닉네임">
					</p>
				</td>
			</tr>
			<tr>
				<td>
					<label>생년월일</label>
				</td>
				<td>
					<p>
						<input type="text" name="birth" maxlength="10" class="boxTF lg"
							value="${dto.birth}" 
							placeholder="생년월일">
					</p>
					<p class="help-block">생년월일은 2000-01-01 형식으로 입력 합니다.</p>
				</td>
			</tr>
			  
			<tr>
				<td>
					<label>이메일</label>
				</td>
				<td>
					<p>
						
						<input type="text" name="email" maxlength="50" class="boxTF lg" value="${dto.email}" >

					</p>
				</td>
			</tr>
			  
			<tr>
				<td>
					<label>전화번호</label>
				</td>
				<td>
					<p>
						
						<input type="text" name="tel" class="boxTF lg" maxlength="11" value="${dto.tel}" >
					</p>
				</td>
			</tr>
			  
			<tr>
				<td>
					<label>우편번호</label>
				</td>
				<td>
					<p>
						<input type="text" name="zip" id="zip" class="boxTF sm" value="${dto.zip}"
							readonly="readonly">
						<button type="button" class="btn" onclick="daumPostcode();">우편번호</button>          
					</p>
				</td>
			</tr>
			  
			<tr>
				<td>
					<label>주소</label>
				</td>
				<td>
					<p>
						<input type="text" name="addr1" id="addr1" maxlength="50" 
							class="boxTF lg" readonly="readonly" value="${dto.addr1}"
							placeholder="기본 주소">
					</p>
					<p>
						<input type="text" name="addr2" id="addr2" maxlength="50" 
							class="boxTF lg" value="${dto.addr2}"  placeholder="나머지 주소">
					</p>
				</td>
			</tr>
			
			<c:if test="${mode=='member'}">
				<tr>
					<td>
						<label>약관동의</label>
					</td>
					<td>
						<p style="padding-top: 5px;">
							<label>
								<input id="agree" name="agree" type="checkbox" checked="checked"
									onchange="form.sendButton.disabled = !checked"> <a href="#">이용약관</a>에 동의합니다.
							</label>
						</p>
					</td>
				</tr>
			</c:if>
		</table>
			
		<table class="table table-footer">
			<tr> 
				<td>
					<button type="button" name="sendButton" class="btn" onclick="memberOk();">${mode=="member"?"회원가입":"정보수정"}</button>
					<button type="reset" class="btn">다시입력</button>
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/';">${mode=="member"?"가입취소":"수정취소"}</button>
				</td>
			</tr>
			<tr>
				<td style="color: blue;">${message}</td>
			</tr>
		</table>
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
