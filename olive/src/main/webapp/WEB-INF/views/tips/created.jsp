<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 
<style type="text/css">
.table-content tr > td:nth-child(1) {
	width: 100px;
	text-align: center;
	background: #eee;
}
.table-content tr > td:nth-child(2) {
	padding-left: 10px;
}
.table-content input[type=text], .table-content input[type=file], .table-content textarea {
	width: 97%;
}
.body-container{
	margin-top: 130px;;
}

</style>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	function check(){
		var f = document.tipsForm; 
		
		var str = f.subject.value;
		if(!str){
			alert("제목을 입력하세요.");
			f.subject.focus();
			return false;
		}
	
		str = f.content.value;
		if(!str || str=="<p>&nbsp;</p>") {
			alert("내용을 입력하세요.");
			f.subject.focus();
			return false;
		}
		
		f.action="${pageContext.request.contextPath}/tips/${mode}";
		
		return true;
	}
</script>

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

<div class="container body-container">
	<div class="body-title">
		<h2> 서류 Tip 작성 </h2>
	</div>
	
	<div class="body-main">
		<form name="tipsForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
		<table class="table table-border table-content">
			<tr>
				<td>제&nbsp;&nbsp;&nbsp;목</td>
				<td>
					<input type="text" name="subject" maxlength="100" class="boxTF" value="${dto.subject}">
				</td>
			</tr>
			
			<tr>
				<td>작성자</td>
				<td>
					${sessionScope.member.userName}
				</td>
			</tr>
			
			<tr>
				<td>서류다운링크</td>
				<td>
					<input type="text" name="downlink" class="boxTF" value="${dto.downLink}">
				</td>
			</tr>
			
			<tr>
				<td valign="top">내&nbsp;&nbsp;&nbsp;용</td>
				<td valign="top">
					<textarea name="content" id="content" style="height: 270px;">${dto.content}</textarea>
				</td>
			</tr>
			
			<tr>
				<td>첨&nbsp;&nbsp;&nbsp;부</td>
				<td>
					<input type="file" name="upload" class="boxTF">
				</td>
			</tr>
			
			<c:if test="${mode=='update'}">
				<tr>
					<td>첨부된파일</td>
					<td>
						<c:if test="${not empty dto.saveFilename}">
							<a href="${pageContext.request.contextPath}/tips/deleteFile?num=${dto.num}&page=${page}"><i class="icofont-bin"></i></a>
						</c:if>
						${dto.originalFilename}
					</td>
				</tr>
			</c:if>
		</table>
		
		<table class="table">
			<tr>
				<td align="center">
					<button type="submit" class="btn btn-dark">${mode=='update'?'수정완료':'등록하기'}</button>
					<button type="reset" class="btn">다시입력</button>
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/tips/list';">${mode=='update'?'수정취소':'등록취소'}</button>
						<c:if test="${mode=='update'}">
							<input type="hidden" name="num" value="${dto.num}">
							<input type="hidden" name="saveFilename" value="${dto.saveFilename}">
							<input type="hidden" name="originalFilename" value="${dto.originalFilename}">
							<input type="hidden" name="page" value="${page}">
						</c:if>
				</td>
			</tr>
		</table>
		</form>
	</div>
</div>