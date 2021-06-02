<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
<style type="text/css">


.login-all {
  background:rgb(108,111,0); padding:80px 0
   
   }
 .login-all form{
   max-width:400px;width:90%;margin:0 auto;background-color:#fff;padding:40px;border-radius:4px;color:#505e6c;box-shadow:1px 1px 5px rgba(0,0,0,.1)
   }  
 .login-all .illustration{
   text-align:center;padding:0 0 20px;font-size:100px;color:#f4476b
   }
   
.loginForm h2{
  text-align: center;
  margin: 30px;
  font-family:'Bebas Neue', cursive;
  font-size:64px;
}

.idForm{
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
}

.passForm{
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
}

.id {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.pw {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.login-btn {
  position:relative;
  left:50%;
  transform: translateX(-50%);
  margin-bottom: 40px;
  width:80%;
  height:40px;
  background: linear-gradient(125deg,#BDFF12,#75BC00,#1B6200);
  background-position: left;
  background-size: 200%;
  color:#7A7A7A;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}

.login-btn:hover {
  background-position: right;
}

.bottomText {
  text-align: center; 
}
.fa.fa-lock{
   color:#558b2f
</style>

<script type="text/javascript">
function sendLogin() {
	var f = document.loginForm;

	var str = f.userId.value;
	if(!str) {
		f.userId.focus();
		return;
	}

	str = f.userPwd.value;
	if(!str) {
		f.userPwd.focus();
		return;
	}

	f.action = "${pageContext.request.contextPath}/member/login";
	f.submit();
}
</script>
<div class="body-container">
	<div class="body-main" style="min-height: 600px;">
	<section class="login-all">
	     <form name="loginForm" method="post" class="loginForm">
      		<h2>Olive-IN</h2>
      		<div class="illustration">
            	<i class="fa fa-lock"></i>
            </div> 
			<div class="idForm">
				<input type="text" name="userId" class="id" placeholder="ID">
			</div>
			<div class="passForm">
				<input type="password" name="userPwd" class="pw" placeholder="PW">
			</div>
			<button type="button" class="login-btn" onclick="sendLogin()">로그인</button>
			<div class="bottomText">
				 회원이 아니신가요? Olive <a href="location.href='${pageContext.request.contextPath}/member/member';"> 입주신청</a>
			</div>
    	</form>
    </section>
    </div>
</div>
