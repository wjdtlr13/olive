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
	width: 700px;
	margin: 20px auto;
	height: 650px;
	border: 1px solid #eee;
	padding: 0 10px;

	
}
.article-top1 {
	height: 30px;
	line-height: 30px;
}
.article-top2 {
	border-bottom: 1px solid #ccc;


}

.article-name {
	text-decoration: none;
	font-size: 13px;
	color: black;
	font-weight: bold;
		height: 30px;
	line-height: 30px;
	
}
.article-date {
	font-size: 11px;
	color: #ccc;
	height: 20px;
}
a:hover {
	color: #1b5e20
}
.btn-category {
	margin: 10px 0;
	background-color: #82A880;
	color: white;
	border-radius: 3px;
	font-size: 11px;
	height: 20px;
	width: 90px;
	line-height: 20px;
	border: none;
}

.article-middle {
	
	border-bottom: 1px solid #ccc;
	height: 70px;
	line-height: 20px;
}
.article-content {
	padding: 20px 0;
	height: 270px;
	border-bottom: 3px solid #ccc;
}
.article-like{
	margin: 20px auto;
	text-align: center;
}

.article-content-textarea {
	border: none;
	width: 670px;
	height: 230px;
	resize: none;
	
}
textarea:focus {
	outline: none;
}
.reply-container {
	width: 700px;
	margin: 20px auto;
	height: 130px;
	border: 1px solid #eee;
	padding: 0 10px;

}
.reply-top {
	padding-left:10px;
	line-height: 40px;
	border-bottom: 1px solid #ccc;
}

.reply-content-textarea {
	border: none;
	width: 500px;
	height: 55px;
	resize: none;
	margin: 10px 0;
	float: left;
	
	
}
.btn-reply {
	margin: 10px 0;
	width: 50px;
	height: 35px;
	float:right;
	background-color: #82A880;
	color: white;
	border-radius: 3px;
	border: none;
	
}
button:hover {
	background-color: #506852;
}
.btn-list {
	background-color: #82A880;
	color: white;
	border-radius: 3px;
	border: none;	
	width: 50px;
	height: 35px;
	float: right;
	margin-left: 5px;
	
}
.article-pre {
	height: 35px;
	line-height: 35px;
	border-bottom: 1px solid #ccc;
}
.article-next {
	height: 35px;
	line-height: 35px;
}
.heart {
	margin: 13px 15px;
	border: 1px solid #ccc;;
	background-color: #fff;
	border-radius:5px;
	float: right;
	text-align: center;
	width: 30px;
	height: 30px;
	
}
.heart:hover {
	color: red;
}
</style>
<script type="text/javascript">

function deleteNotice() {

	if(confirm("게시물을 삭제 하시겠습니까 ?")) {
		var num = "${dto.num}";
		var url="${pageContext.request.contextPath}/notice/delete?num="+num+"&${query}";
		location.href=url;
	}

}
/*
	//if(confirm("게시물을 삭제 하시겠습니까 ?")) {
		alert("삭제");
		//var num = "${dto.num}";
		//var url="${pageContext.request.contextPath}/notice/delete?num="+num+"&${query}";
		//location.href=url;
	//}  

 */

</script>
</head>
<body>

<div class="body-container" >
	
	<div class="article-top">
		<a class="article-name" href="${pageContext.request.contextPath}/notice/list">NOTICE</a>
	</div>
	<div class="article-top2">
		<p class="article-date">${dto.created}</p>
	</div>	
	<div class="article-middle">
		<button class="btn-category">해당카테고리</button>
		
		<p  style="font-weight: bold; font-size: 17px;">${dto.subject}</p>
	</div>
	<div class="article-content">
		<textarea class="article-content-textarea" cols="3" rows="5" style="overflow: auto;">${dto.content}</textarea>
	</div>	
	<div class="article-like">
		<p>좋아요! &nbsp;1 &nbsp;&nbsp; 조회수 &nbsp;1 </p>
	</div>
	<div class="article-pre">
		<p>이전글 : <a>올리브가 글쎄..</a> </p>
	</div>	
	<div class="article-next">
		<p>다음글 : <a>올리브가 ??..</a> </p>
	</div>		


	<div style="clear: both;" >
		<button type="button" class="btn-list" onclick="deleteNotice();">삭제</button>
		<button type="button" class="btn-list" onclick="javascript:location.href='${pageContext.request.contextPath}/notice/update?num=${dto.num}&page=${page}';">수정</button>
		<button type="button" class="btn-list" onclick="javascript:location.href='${pageContext.request.contextPath}/notice/list?${query}';">목록</button>
		
	</div>
</div>


</body>