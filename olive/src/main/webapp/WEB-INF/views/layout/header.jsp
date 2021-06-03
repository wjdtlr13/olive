<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

  <nav class="navbar navbar-dark navbar-expand-lg" style="background: rgb(108,111,0);">
        <div class="container-fluid"><a class="navbar-brand" href="#">OLIVE ALONE</a><button data-toggle="collapse" class="navbar-toggler" data-target="#navcol-2"><span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="navcol-2">
                <ul class="navbar-nav">
                    <li class="nav-item dropdown"><a class="dropdown-toggle nav-link" aria-expanded="false" data-toggle="dropdown" href="#">meal</a>
                        <div class="dropdown-menu"><a class="dropdown-item" href="#">올리브의 동네맛집</a><a class="dropdown-item" href="#">올리브의 밥친구</a></div>
                    </li>
                    <li class="nav-item dropdown"><a class="dropdown-toggle nav-link" aria-expanded="false" data-toggle="dropdown" href="#">saving</a>
                        <div class="dropdown-menu"><a class="dropdown-item" href="#">주고받는 올리브</a><a class="dropdown-item" href="#">함께 사는 올리브</a></div>
                    </li>
                    <li class="nav-item dropdown"><a class="dropdown-toggle nav-link" aria-expanded="false" data-toggle="dropdown" href="#">life-info</a>
                        <div class="dropdown-menu"><a class="dropdown-item" href="#">올리브나무</a><a class="dropdown-item" href="#">올리브열매</a></div>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="#">board</a></li>
                    <li class="nav-item dropdown"><a class="dropdown-toggle nav-link" aria-expanded="false" data-toggle="dropdown" href="#">real-estate</a>
                        <div class="dropdown-menu"><a class="dropdown-item" href="#">올리브의 새집</a><a class="dropdown-item" href="#">올리브의 집문서</a><a class="dropdown-item" href="#">꿀팁안내봇</a></div>
                    </li>
                    <li class="nav-item dropdown"><a class="dropdown-toggle nav-link" aria-expanded="false" data-toggle="dropdown" href="#">medical</a>
                        <div class="dropdown-menu"><a class="dropdown-item" href="#">올리브네 응급실</a><a class="dropdown-item" href="#">올리브의 구급상자</a></div>
                    </li>
                    <li class="nav-item dropdown"><a class="dropdown-toggle nav-link" aria-expanded="false" data-toggle="dropdown" href="#">cash book</a>
                        <div class="dropdown-menu"><a class="dropdown-item" href="#">올리브의 지갑사정</a><a class="dropdown-item" href="#">올리브의 스케줄</a></div>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="#">QnA</a></li>
                    <li class="nav-item dropdown"><a class="dropdown-toggle nav-link" aria-expanded="false" data-toggle="dropdown" href="#">Olive</a>
                        <div class="dropdown-menu"><a class="dropdown-item" href="#">올리브의 발도장</a><a class="dropdown-item" href="#">올리브의 도전</a></div>
                    </li>
                    <li class="nav-item dropdown"><a class="dropdown-toggle nav-link" aria-expanded="false" data-toggle="dropdown" href="#"><i class="fa fa-user" style="font-size: 30px;"></i> </a>
                        <div class="dropdown-menu"><a class="dropdown-item" href="#">공지사항</a><a class="dropdown-item" href="#">로그인</a><a class="dropdown-item" href="#">입주신청</a></div>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

<script>
function dialogLogin() {
    $("#modalUserId").val("");
    $("#modalUserPwd").val("");
	$("#modalLogin").modal("show");	
    $("#modalUserId").focus();
}

function modalSendLogin() {
	var f=document.modalLoginForm;
	
    if(!f.userId.value) {
    	f.userId.focus();
    	return false;
    }	

    if(!f.userPwd.value) {
    	f.userPwd.focus();
    	return false;
    }	

   f.action="${pageContext.request.contextPath}/member/login"; 
   f.submit();
}
</script>

<div id="modalLogin" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title text-center" style="font-family: 나눔고딕, 맑은 고딕, sans-serif;">회원 로그인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>
			<div class="modal-body">
				<form name="modalLoginForm" method="post">
					<div class="form-group">
						<label for="modalUserId">아이디</label>
						<input class="form-control" id="modalUserId" name="userId" type="text" placeholder="아이디">
					</div>
					<div class="form-group">
						<label for="modalUserPwd">패스워드</label>
						<input class="form-control" id="modalUserPwd" name="userPwd" type="password" placeholder="패스워드">
					</div>
			        
					<div class="form-group">
						<button class="btn btn-lg btn-primary btn-block" type="button" onclick="modalSendLogin();">로그인 <i class="bi bi-check2"></i></button>
					</div>
                    
					<div class="text-center">
						<button type="button" class="btn btn-link" onclick="location.href='${pageContext.request.contextPath}/member/member';">회원가입</button>
						<button type="button" class="btn btn-link">아이디찾기</button>
						<button type="button" class="btn btn-link">패스워드찾기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
