<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css"> 
* {
	margin: 0; padding: 0;
	
	
}

.body-container {
	width: 1000px;
	margin: 20px auto;
	height: 1000px;
	padding-left: 10px;
	
	
}
textarea {
	width:600px;
	height:500px;
	resize: none;
	padding: 10px 10px;
	border: 1px solid #ccc;	
	margin-top: 5px;
}
textarea:focus {
	outline: none;
}

table {
	width: 700px;
	
}
input {
	float: left;
	border: 1px solid #ccc;
	padding-left: 5px;
}
input:focus {
	outline: none;
}
.title {
	width:300px;
	line-height: 50px;
	font-size: 20px;
	font-weight: bold;
	
	margin-right: 10px;
	margin-bottom: 20px;
		
}
.title-file {
	width:300px;

	font-size: 20px;
	font-weight: bold;
	
	margin-right: 10px;
	margin-bottom: 20px;
}
.input-content {
	width: 350px;
	height: 35px;
	margin-right: 20px;
	line-height: 35px;
}
select {
	float:right;
	width: 240px;
	height: 35px;	
	box-sizing: content-box;
	border: 1px solid #ccc;
}
select:focus {
	outline: none;
}
tr {
	height: 50px;
}
button {
	width: 100px;
	height: 35px;
	border: 1px solid #ccc;
	background-color: #fff;
	border-radius: 5px;
}
button:hover {
	color: white;
	background-color: #6C9174;
}
</style>
<script type="text/javascript">


function sendNotice() {
	var f= document.noticeForm;
	
	f.action="${pageContext.request.contextPath}/notice/${mode}";
	
	f.submit();
	
}



</script>
</head>
<body>

<div class="body-container" >
	
	<h2 style="margin: 20px 0;">${mode=='update'?'공지글 수정':'공지등록'}</h2>
	<form name="noticeForm" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<td class="title">제목</td>
			<td><input class="input-content" type="text" name="subject" placeholder="제목을 입력하시오" value="${dto.subject}">
 				
			</td>
		</tr>
		<tr>
			<td class="title">작성자</td>
			<td ><input type="text" class="input-content" name="userId" value="${dto.userId}"></td>
			
		</tr>
		<tr>
		  <td>작성일<input type="text"name="created" value="${dto.created}"></td>
		</tr>	
		<tr>
			<td class="title">공지여부</td>
			<td><input type="checkbox" class="input-content" name="notice" value="1" ${dto.notice==1 ? "checked='checked' ":""}>공지글로 작성</td>
		</tr>
		<tr>
			<td class="title">내용</td>
			<td><textarea name="content">${dto.content} </textarea></td>
		</tr>	
		<tr><!-- 
			<td class="title-file">첨부된 파일</td>
			<td><input type="file" name="upload" multiple="multiple" class="input-content" style="line-height: "></td>
		 -->
		 <td>
		 	<c:if test="${mode=='update'}">
		 		<input type="hidden" name="num" value="${dto.num}">
		 	</c:if>
		 </td>
		</tr>
												
	</table>
	
	<div style="text-align: center; width: 700px;margin-top: 20px;">
		<button type="button" onclick="sendNotice()">${mode=='update'?'수정완료':'등록하기'}</button>
		<button type="reset">다시입력</button>
		<button type="button" onclick="javascript:location.href='${pageContext.request.contextPath}/notice/list';" >취소</button>				
		<c:if test="${mode=='update'}">
			<input type="hidden" name="num" value="${dto.num}">
			<input type="hidden" name="page" value="${page}">
			
		</c:if>
	</div>
	</form>
</div>

</body>