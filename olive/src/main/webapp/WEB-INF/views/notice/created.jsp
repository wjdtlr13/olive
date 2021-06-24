<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">

.bodytitle span {
	font-size: 22px;
	font-weight: 800;
}

.btn {
	width: 100px;
	height: 45px;
	border-radius: 0;
	background-color: #524c00;
	color: white;
	border: none;
	font-size: 13px;
}

.boxTA {
	resize: none;
	max-height: 295px;
	overflow-y: scroll;
	width: 650px;
	height: 295px;
	border: solid 1px #ddd;
	border-radius: 0;
	appearance: none;
	line-height: 20px;
	margin-left: 10px;
	margin-top: 20px;
	padding-left: 15px;
	padding-top: 15px;
}

.boxTF {
	height: 42px;
	width: 650px;
	border: solid 1px #ddd;
	padding-left: 15px;
}
</style>

<script type="text/javascript">
function sendNotice() {
	var f= document.noticeForm;
	
	f.action="${pageContext.request.contextPath}/notice/${mode}";
	
	f.submit();
}
</script>

<div class="container body-container">
	<div class="bodytitle" style="margin-top: 70px;">
		<span> 공지사항 </span>
	</div>
    
	<div>
	<form name="noticeForm" method="post" enctype="multipart/form-data">
		<table style="width: 100%;margin: 30px auto; border-spacing: 0px; border-collapse: collapse; border-top: 2px solid #111;">
			<tr align="left" height=100px; style=" border-bottom: 1px solid #ddd; ">
				<td style="text-align: center; font-weight: 600; ">제목</td>
				<td style="padding-left: 10px; ">
					<input type="text" name="subject" maxlength="50" class="boxTF" value="${dto.subject}">
				</td>			
			</tr>
			<tr align="left" style="border-bottom: 1px solid #ddd; height: 355px;">
				<td style="text-align: center; width: 250px; font-weight: 600;">내용</td>
				<td valign="top">
					<textarea name="content" class="boxTA">${dto.content}</textarea>	
				</td>
			</tr>
			<tr align="left" height=70px; style=" border-bottom: 1px solid #ddd; ">
				<td style="text-align: center; width: 250px; font-weight: 600;">공지 고정여부</td>
				<td><input style="width: 20px;" type="checkbox" class="input-content" value="1" ${dto.notice==1 ? "checked='checked' ":""}></td>
			</tr>								
		</table>
		
		<table style="margin: auto;">
			<tr>
				<td align="center" style="padding-bottom: 30px;">
					<button type="button" class="btn" onclick="sendNotice();">${mode=='update'?'수정':'등록'}</button>
					<button type="reset" class="btn">다시입력</button>
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/notice/list?page=${page}';">${mode=='update'?'수정취소':'등록취소'}</button>
					<c:if test="${mode=='update'}">
						<input type="hidden" name="num" value="${dto.num}">
						<input type="hidden" name="page" value="${page}">
					</c:if>
				</td>
			</tr>
		</table>
	</form>
		
		
	</div>
</div>	


