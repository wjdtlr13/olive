<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
.body_title{
	font-size: 27px;
	font-weight: 800;
}
.body-con{
	font-size: 18px;
}
.btn{
	width: 60px;
	height: 40px;
	background-color: #424242;
	color: white;
	border: 1px solid #ddd;
	cursor: pointer;
	margin-bottom: 10px;
}

a {
 text-decoration: none;
}
a:hover {
	color: 
}
</style>

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}
 
function ajaxFun(url, method, query, dataType,fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX",true);
		},
		error:function(jqXHR) {
			if(jqXHR.status===403) {
				login();
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
    $(document).ready(function() {
        $("#articleAnswer").hide();
    });
});

//답변 폼 보기 / 답변 등록
$(function(){
	$(".btnSendAnswer").click(function(){
		var isVisible = $("#articleAnswer").is(':visible');
		if(! isVisible) {
			// 답변 폼 보기
			$("#articleAnswer").show('3000');
			return false;
		}		
		
		// 답변 등록
		var num="${dto.qnaNum}";
		var content=$(".answerTA").val().trim();
		
		if(! content) {
			$(".answerTA").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${pageContext.request.contextPath}/qna/writeAnswer";
		var query="qnaNum="+num+"&answerContent="+content;
		
		var fn = function(data){
			// 답변 등록 후 다시  글보기로
			location.href="${pageContext.request.contextPath}/qna/article?${query}&qnaNum=${dto.qnaNum}";
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

</script>

	<div style="height: 100px;"></div>
	<div class="body_title" style="width: 70%; margin: auto;">올리브의 궁금증</div>
	<div class="body-con" style="width: 70%; margin: auto;">

		<div>
			<table style="width: 100%;margin: 30px auto; border-spacing: 0px; border-collapse: collapse; border-top: 1px solid #111;">
				
				<tr style="height: 50px; border-bottom: 1px solid #ddd; background: #e0e0e0">
					<td style="text-align: center; padding-left: 200px; font-weight: 700;">${dto.subject}</td>
					<td width="20%" align="right" >
						${dto.nickName}&nbsp;&nbsp;|&nbsp;&nbsp;${dto.questioncreated}
					</td>
				</tr>
				
				<tr style="width: 100%; float: left;">
				  <td style="padding: 20px 20px; margin-left:100px; line-height: 60px;" valign="top" height="200">
				  	 ${dto.questionContent}
				  </td>
				</tr>
			</table>
		<table style="width: 100%;margin: 30px auto; border-spacing: 0px; border-collapse: collapse; border-top: 1px solid #ddd;">
				<tr height="55" style="border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">
					<td colspan="2" align="left" style="padding-left: 5px;">
					이전
					<c:if test="${not empty preReadDto}">
						<a style="padding-left: 20px;" href="${pageContext.request.contextPath}/qna/article${query}&qnaNum=${preReadDto.qnaNum}">${preReadDto.subject} </a>
					</c:if>
					</td>
				</tr>
				
				<tr height="55" style="border-bottom: 1px solid #ddd;">
					<td colspan="2" align="left" style="padding-left: 5px;">
					다음
					<c:if test="${not empty nextReadDto}">
						<a style="padding-left: 20px;" href="${pageContext.request.contextPath}/qna/article${query}&qnaNum=${nextReadDto.qnaNum}">${nextReadDto.subject} </a>
					</c:if>
					</td>
				</tr>
		</table>	
 		<c:if test="${empty dto.answerContent }">
	 		<div id="articleAnswer">
		        <div class="col">
		            <p style="font-size: 25px;"><strong>Answer</strong></p>
		        </div>
		        <div class="col">
		            <p><strong>관리자</strong></p>
		        </div>
	        
	        <hr>
	        <div class="col"><textarea name="answerContent" style="width: 100%;height: 300px;border-style: none; resize: none;" class="answerTA">${dto.answerContent}</textarea></div>
	        </div>  
	          <div class="row d-flex justify-content-end">
	          		<c:if test="${sessionScope.member.userId=='admin'}">
	                <div class="col-auto"><button class="btn btn-primary btn-list btnSendAnswer" type="button">답변등록</button></div>
	          		</c:if>
	          </div>
       </c:if>				
		 <c:if test="${not empty dto.answerContent }"> <!--관리자가 답변했을 경우 -->
			<table style="width: 100%;margin: 30px auto; border-spacing: 0px; border-collapse: collapse; border-top: 1px solid #111;">
				<tr style="height: 50px; border-bottom: 1px solid #ddd; background: #f9fbe7">
					<td style="text-align: center; padding-left: 200px; font-weight: 700;">[RE] ${dto.subject}</td>
					<td width="20%" align="right" >
						관리자&nbsp;&nbsp;|&nbsp;&nbsp;${dto.answercreated}
					</td>
				</tr>
				
				<tr style="width: 100%; float: left;">
				  <td style="padding: 20px 20px; margin-left:100px; line-height: 60px;" valign="top" height="200">
				 	 ${dto.answerContent }
				  </td>
				</tr>						
			</table>
		</c:if>
		

			
			<!--  <table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="62">
				<td width="600" align="left" style="padding-left: 20px;">
					 <c:if test="${sessionScope.member.userId=='userId' }">
			          <button type="button" class="btn">수정</button>
						<button type="button" class="btn" onclick="deleteNotice();">삭제</button>
					</c:if>
				</td>
				<td align="right">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/qna/list?${query}';">목록</button>
				</td>					
			</table>
			-->
        <div>
            <div class="row d-flex justify-content-end">
                <div class="col-auto"><button class="btn btn-primary btn-list" type="button"  onclick="javascript:location.href='${pageContext.request.contextPath}/qna/list?${query}';">목록</button></div>
                <c:if test="${sessionScope.member.userId=='userId' }">
               	 <div class="col-auto"><button class="btn btn-primary btn-list" type="button">삭제</button></div>
           	 	</c:if>
            </div>
           
        </div>

      			
		</div>
	
	</div>
