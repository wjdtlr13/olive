<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style type="text/css">
body {
	marin: 0;
	padding: 0;
}

.title {
	font-size: 20px;
	font-weight: lighter;
	padding-top: 50px;
	padding-bottom:30px;
	width: 70%;
	margin: auto;
}

.btn {
	width: 75px;
	height: 40px;
	border-radius: 0;
	background-color: #524c00;
	color: white;
	border: none;
	font-size: 13px;
	margin-left: 700px;
	margin-bottom: 30px; 
	}

.btnSearch {
	background: none;
	padding: 3px;
}

.selectField, .input-search, .btnSearch {
	height: 40px;
	border: 1px solid black;
	border-radius: 0px;
}

.input-search {
	width: 250px;
	padding: 10px;
}

.div-list-con {
	margin: auto;
	width: 72%;
}
.div-question{
	padding: 10px 10px;
	border-top: 1px solid #eeeeee;
	margin-top: 20px;
	font-size: 17px;
	font-weight: bold;
}
.div-question:hover{
cursor: pointer;
}
.div-answer{
	padding: 15px 20px;
	margin-top: 15px;
	font-size: 15px;
	font-weight: lighter;
	background: #f9fbe7;
	border-radius: 30px;
	
}
.update{
	font-size: 12px;
}
.update a:hover{
	cursor: pointer;
}
</style>

<script type="text/javascript">

function listSearch() { // 검색
	var f=document.searchForm;
	f.submit();
}

	$(document).ready(function() {
		$(".div-answer").hide();
		$(".div-question").click(function() { // 제목을 클릭했을때
			var submenu = $(this).next();
			
			if (submenu.is(":visible")) { // submenu 가 화면에 보일때
				submenu.slideUp();
			} else {
				submenu.slideDown();
			}
		});
	});
	
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.userId}">
function deleteList(num, page) {
	if(confirm("게시물이 삭제됩니다.")) {
		var url="${pageContext.request.contextPath}/medical/delete?num="+num+"&page="+page;
		location.href=url;
	}
}
</c:if>
</script>

<script type="text/javascript">

</script>

<div class="container">
	<div class="title">
		<span>올리브의 구급상자</span>	
	</div>
	
	<table style="height: 120px; margin: auto; border-spacing: 0px;">
		<tr>
			<td align="center" style="border-top: 1px solid #111;">
				<form name="searchForm" action="${pageContext.request.contextPath}/medical/list" method="post">
					<div class="boxTFdiv" style="width: 800px; margin-top: 30px;">
					<select name="condition" class="selectField">
						<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
						<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
						<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
					</select>
						<input type="text" name="keyword" class="input-search" value="${keyword}">
						<button type="button" class="btnSearch" onclick="listSearch()"><img class="icon-search" alt="" src="${pageContext.request.contextPath}/resources/img/search.png"></button>
					</div>
					<div align="left">총 ${dataCount}건</div>		
				</form>
			</td>
		</tr>
	</table>
	
	<div class="div-list-con">
	<c:if test="${list.size() > 0}">
		<c:forEach var="dto" items="${list}">
			<div class="div-question">
				${dto.subject}
			</div>
			<div class="div-answer">
				<div class="content">
					<div>${dto.content}</div>
				</div>
				<c:if test="${sessionScope.member.userId=='admin'}">
					<div class="update" align="right">
						<a onclick="javascript:location.href='${pageContext.request.contextPath}/medical/update?num=${dto.num}&page=${page}';">수정</a>&nbsp;|
						<a onclick="deleteList('${dto.num}', '${page}');">삭제</a>
					</div>
				</c:if>
			</div>
		</c:forEach>
	
	</c:if>

	<div style="margin: auto; height: 80px; margin-top: 10px;">
	  	${dataCount==0?"게시물이 존재하지 않습니다.":paging}
	</div>

	<c:if test="${sessionScope.member.userId=='admin'}">
		<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/medical/created';">등록</button>
	</c:if>
	
	</div>
	 
</div>