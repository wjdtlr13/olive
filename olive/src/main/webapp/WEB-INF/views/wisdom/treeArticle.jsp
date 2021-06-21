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
</script>

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}
function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
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
function ajaxFileFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		processData: false,  // file 전송시 필수. 서버로전송할 데이터를 쿼리문자열로 변환여부
		contentType: false,  // file 전송시 필수. 서버에전송할 데이터의 Content-Type. 기본:application/x-www-urlencoded
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
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


//페이징처리
$(function(){
	listPage(1);
});

function listPage(page) {
	var url="${pagecontext.request.contextPath}/wisdom/listReply";
	var query="num=${dto.num}&pageNo="+page;
	var selector="#listReply";

	var fn=function(data) {
		$(selector).html(data);
		
	};
	ajaxFun(url,"get",query,"html",fn);
}

//게시물 좋아요 누르기
$(function(){
	$(".btnSendArticleLike").click(function() {
		if(! confirm("게시물에 공감 하십니까 ? ")) {
			return false;
		}
		var url="${pageContext.request.contextPath}/wisdom/insertArticleLike";
		var num="${dto.num}";		
		var query="num="+num;
		
		var fn=function(data) {
			var articleLike=data.articleLike;
			if(articleLike===0) {
				var count =data.articleLikeCount;
				$("#articleLikeCount").text(count);
			}else if(articleLike===1) {
				alert("게시글 공감은 한번만!!!");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

//댓글달기
$(function(){
	$(".btnSendReply").click(function(){
		var num="${dto.num}";
	
		var content=$(".replyTA").val().trim();
		if(! content) {
			$(".replyTA").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${pageContext.request.contextPath}/wisdom/insertReply";
		var query="num="+num+"&content="+content;
		
		var fn=function(data) {
			$(".replyTA").val("");
			
			var state=data.state;
			if(state==="true") {
				listPage(1);
			} else if(state==="false") {
				alert("댓글을 추가 하지 못했습니다");
			}
		};
		
		ajaxFun(url,"post",query,"json",fn);
	});
});




</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se/ckeditor5/build/ckeditor.js"></script>

</head>
<body>

<div class="body-container" >
	
	<div class="article-top">
		<a class="article-name" href="${pageContext.request.contextPath}/wisdom/list">올리브나무</a>
	</div>
	<div class="article-top2">
		<p class="article-date">${dto.created}</p>
	</div>	
	<div class="article-middle">
		<button class="btn-category"></button>
		
		<p  style="font-weight: bold; font-size: 17px;">${dto.subject}</p>
	</div>
	<div class="article-content">
		<textarea class="editor" cols="3" rows="5" style="overflow: auto;">${dto.content}</textarea>
	</div>
	<div>
		첨&nbsp;&nbsp;부 :
		<c:forEach var="vo" items="${listImage}">
			<img src="${pageContext.request.contextPath}/uploads/wisdom/${vo.imageFileName}">
		</c:forEach>
	</div>	
	<div class="article-like">
		<p><button type="button" class="btnSendArticleLike">조하용 &nbsp;<span id="articleLikeCount">${dto.articleLikeCount}</span></button>&nbsp;&nbsp;&nbsp;  조회수 &nbsp; ${dto.hitCount} </p>
	</div>
	<div class="article-pre">
		<p>이전글 : <a>올리브가 글쎄..</a> </p>
	</div>	
	<div class="article-next">
		<p>다음글 : <a>올리브가 ??..</a> </p>
	</div>		


	<div style="clear: both;" >
		<button type="button" class="btn-list" onclick="deleteNotice();">삭제</button>
		<button type="button" class="btn-list" onclick="javascript:location.href='${pageContext.request.contextPath}/tree/update?num=${dto.num}&page=${page}';">수정</button>
		<button type="button" class="btn-list" onclick="javascript:location.href='${pageContext.request.contextPath}/wisdom/list?${query}';">목록</button>
		
	</div>
		<div class="reply">
			<table class="table table-reply">
				<tr> 
					<td align='left'>
						<span style='font-weight: bold;' >댓글쓰기</span>
					</td>
				</tr>
				<tr>
					<td>
						<textarea class='replyTA' style='width:100%; height: 70px;'></textarea>
					</td>
				</tr>
				<tr>
				   <td align='right'>
				        <button type='button' class='btn btnSendReply' style='padding:7px 20px;'>댓글 등록</button>
				    </td>
				 </tr>
			</table>
			<div id="listReply"></div>
		</div>	
<script type="text/javascript">
ClassicEditor
	.create( document.querySelector( '.editor' ), {
	})
	.then( editor => {
		window.editor = editor;
		editor.isReadOnly = true;
	} );
</script>  	

</div>


</body>