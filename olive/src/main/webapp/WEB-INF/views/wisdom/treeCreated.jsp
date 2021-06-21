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
	
	font-family: 맑은 고딕, 돋움;
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
	width:100px;
	line-height: 50px;
	font-size: 20px;
	font-weight: bold;
	
	margin-right: 10px;
	margin-bottom: 20px;
		
}
.title-file {
	width:100px;

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

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<body>

<div class="body-container" >
	
	<h2 style="margin: 20px 0;">${mode=='update'?'공지글 수정':'공지등록'}</h2>
	<form name="noticeForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
	<table>
		<tr>
			<td class="title" >제목</td>
			<td><input class="input-content" type="text" name="subject" placeholder="제목을 입력하시오" value="${dto.subject}">
 				
			</td>
		</tr>
		<tr>
			<td class="title">작성자</td>
			<td ><input type="text" class="input-content" name="userId" value="${dto.userId}"></td>
			
		</tr>	
		<tr>
			<td class="title">내용</td>
			<td><textarea name="content" id="content">${dto.content} </textarea></td>
		</tr>
		<tr>
			<td>첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
			<td>
				<input type="file" name="upload"  multiple="multiple"  class="boxTF" class="input-content">
			</td>
		</tr>	
		<tr>
		
			<td class="title-file">첨부된 파일</td>
			
			<td>
				<c:if test="${not empty dto.saveFilename}">
					<input type="file" name="upload" multiple="multiple" class="input-content" style="line-height: ">
				</c:if>
			</td>
			
		 <td>
		 	<c:if test="${mode=='update'}">
		 		<input type="hidden" name="num" value="${dto.num}">
		 	</c:if>
		 </td>
		</tr>
												
	</table>
	
	<div style="text-align: center; width: 700px;margin-top: 20px;">
		<button type="submit" >${mode=='update'?'수정완료':'등록하기'}</button>
		<button type="reset">다시입력</button>
		<button type="button" onclick="javascript:location.href='${pageContext.request.contextPath}/wisdom/treeList';" >취소</button>				
		<c:if test="${mode=='update'}">
			<input type="hidden" name="num" value="${dto.num}">
			<input type="hidden" name="page" value="${page}">
			<input type="hidden" name="saveFilename" value="${dto.saveFilename}">
			<input type="hidden" name="originalFilename" value="${dto.originalFilename}">
			
			
		</c:if>
	</div>
	</form>
</div>

</body>


<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "${pageContext.request.contextPath}/resources/se/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//alert("아싸!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["content"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["content"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
	
	try {
		// elClickedObj.form.submit();
		return check();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 24;
	oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>    