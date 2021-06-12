<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
.table {
	width: 100%;
	border-spacing: 0;
	border-collapse: collapse;
}

.table-content {
	margin-top: 25px;
}
.table-content tr {
	border-bottom: 1px solid #ccc;
	height: 40px;
}
.table-content tr:first-child {
	border-top: 1px solid #ccc;
}
.table-content tr:last-child {
	border-bottom: 1px solid #ccc;
}
.table-content tr > td {
	padding: 5px 0;
}
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

.table-footer {
	margin: 5px auto;
}
.table-footer tr {
	height:45px;
	text-align: center;
}
</style>

<script type="text/javascript">
	function sendOk() {
		var f = document.tipsForm;
		
		var str = f.subject.value;
		if(!str) {
			aler("제목을 입력하세요.");
			f.subject.focus();
			return;
		}
		
		str = f.content.value;
		if(!str) {
			alert("내용을 입력하세요.");
			f.content.focus();
		}
		
		f.action="${pageContext.request.contextPath}/papers/tips/{mode}"
		
		f.submit();
	}
</script>

<div class="body-container" style="width:700px;">
	<div class="body-title">
		<h3><i class="fas fa-chalkboard"></i>게시판</h3>
	</div>
	
	<div class="body-main">
		<form name="tipsForm" method="post">
			<table class="table table-content">
				<tr>
					<td>제목</td>
					<td>
						<input type="text" name="subject" maxlength="100" class="boxTF" value="${dto.subject}">
					</td>
				</tr>
				
				<tr> 
					<td>작성자</td>
					<td> 
					${sessionScope.member.admin}
					</td>
				</tr>
				
				<tr> 
					<td valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
					<td valign="top"> 
						<textarea name="content" class="boxTA">${dto.content}</textarea>
					</td>
				</tr>

				<!-- 첨부파일 -->
				
			</table>
			
			<table class="table table-footer">
				<tr>
					<td>
						<button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
						<button type="reset" class="btn">다시입력</button>
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/papers/tips/list';">${mode=='update'?'수정취소':'등록취소'}</button>
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