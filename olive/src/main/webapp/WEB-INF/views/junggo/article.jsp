<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 
<style type="text/css">
.ck.ck-editor__editable_inline, .ck.ck-toolbar {
	border: none;
} 
.div-title{
  font-size: 27px;
  font-weight: 800;
  margin-bottom: 30px;
}
.table-content tr > td {
	padding-left: 5px; padding-right: 5px;
}

.reply {
	padding: 15px 0 10px;
}
.reply .table-reply tr td {
	padding-top: 0;
}

.reply .reply-list tbody tr td {
	padding: 7px 5px;
}

</style>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/ckeditor5/build/ckeditor.js"></script>
<script type="text/javascript">
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.userId}">
function deleteJunggo() {
	var q = "num=${dto.num}&${query}";
	var url = "${pageContext.request.contextPath}/junggo/delete?" + q;

	if(confirm("게시글을 삭제 하시 겠습니까 ? ")) {
			location.href=url;
	}
}
</c:if>
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

// 게시글 공감 여부
$(function(){
	$(".btnSendJunggoLike").click(function(){
		if(! confirm("게시물에 공감 하십니까 ? ")) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/junggo/insertJunggoLike";
		var num="${dto.num}";
		// var query={num:num};
		var query="num="+num;
		
		var fn = function(data){
			var state=data.state;
			if(state==="true") {
				var count = data.junggoLikeCount;
				$("#JunggoLikeCount").text(count);
			} else if(state==="false") {
				alert("게시글 공감은 한번만 가능합니다. !!!");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 페이징 처리
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "${pageContext.request.contextPath}/junggo/listReply";
	var query = "num=${dto.num}&pageNo="+page;
	var selector = "#listReply";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 리플 등록
$(function(){
	$(".btnSendReply").click(function(){
		var num="${dto.num}";
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${pageContext.request.contextPath}/junggo/insertReply";
		var query="num="+num+"&content="+content+"&answer=0";
		
		var fn = function(data){
			$tb.find("textarea").val("");
			
			var state=data.state;
			if(state==="true") {
				listPage(1);
			} else if(state==="false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});


// 댓글 삭제
$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("게시글을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var replyNum=$(this).attr("data-replyNum");
		var page=$(this).attr("data-pageNo");
		
		var url="${pageContext.request.contextPath}/junggo/deleteReply";
		var query="replyNum="+replyNum+"&mode=reply";
		
		var fn = function(data){
			// var state=data.state;
			listPage(page);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

//댓글별 답글 리스트
function listReplyAnswer(answer) {
	var url="${pageContext.request.contextPath}/junggo/listReplyAnswer";
	var query="answer="+answer;
	var selector="#listReplyAnswer"+answer;
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 댓글별 답글 개수
function countReplyAnswer(answer) {
	var url="${pageContext.request.contextPath}/junggo/countReplyAnswer";
	var query="answer="+answer;
	
	var fn = function(data){
		var count=data.count;
		var vid="#answerCount"+answer;
		$(vid).html(count);
	};
	
	ajaxFun(url, "post", query, "json", fn);
}

// 답글 버튼(댓글별 답글 등록폼 및 답글리스트)
$(function(){
	$("body").on("click", ".btnReplyAnswerLayout", function(){
		var $trReplyAnswer = $(this).closest("tr").next();
		
		var isVisible = $trReplyAnswer.is(':visible');
		var replyNum = $(this).attr("data-replyNum");
			
		if(isVisible) {
			$trReplyAnswer.hide();
		} else {
			$trReplyAnswer.show();
            
			// 답글 리스트
			listReplyAnswer(replyNum);
			
			// 답글 개수
			countReplyAnswer(replyNum);
		}
	});
	
});

// 댓글별 답글 등록
$(function(){
	$("body").on("click", ".btnSendReplyAnswer", function(){
		var num="${dto.num}";
		var replyNum=$(this).attr("data-replyNum");
		var $td=$(this).closest("td");
		
		var content=$td.find("textarea").val().trim();
		if(! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${pageContext.request.contextPath}/junggo/insertReply";
		var query="num="+num+"&content="+content+"&answer="+replyNum;
		
		var fn = function(data){
			$td.find("textarea").val("");
			
			var state=data.state;
			if(state==="true") {
				listReplyAnswer(replyNum);
				countReplyAnswer(replyNum);
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 댓글별 답글 삭제
$(function(){
	$("body").on("click", ".deleteReplyAnswer", function(){
		if(! confirm("게시글을 삭제하시겠습니까 ? ")) {
		    return;
		}
		
		var replyNum=$(this).attr("data-replyNum");
		var answer=$(this).attr("data-answer");
		
		var url="${pageContext.request.contextPath}/junggo/deleteReply";
		var query="replyNum="+replyNum+"&mode=answer";
		
		var fn = function(data){
			listReplyAnswer(answer);
			countReplyAnswer(answer);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});
</script>

<div style="width: 65%; margin: auto;">
    <div class="div-title" style="margin-top: 120px;">
        <span>주고받는 올리브</span>
    </div>
    
    <div class="body-main">
    	<table class="table table-content">
    	
    		<!-- 작성 글 보기 -->
    		<tr>
    			<td colspan="2" align="center">
					[${dto.categoryName}]  ${dto.subject}
				</td>
    		</tr>
    		
    		<tr>
				<td width="50%" align="left">
					작성자 : ${dto.userName}
				</td>
				<td width="50%" align="right">
					가격 : ${dto.price}원
				</td>
			</tr>
			
			<tr>
				<td width="50%" align="left">
					조회 ${dto.hitCount}
				</td>
				<td width="50%" align="right">
					${dto.created} 
				</td>
			</tr>
    		
    		<tr style="border: none;">
				<td colspan="2" valign="top" height="200">
					<div class="editor">${dto.content}</div>
				</td>
			</tr>
    		
    		<!-- 좋아요 -->
    		<tr>
				<td colspan="2" style="padding-bottom: 15px;" align="center">
					<button type="button" class="btn btnSendJunggoLike" title="좋아요"><i class="icofont-like"></i>&nbsp;&nbsp;<span id="junggoLikeCount">${dto.junggoLikeCount}</span></button>
				</td>
			</tr>
		</table>
			
    		<!-- 수정삭제리스트 -->
    	<table class="table">
			<tr>
				<td width="50%">
					<c:choose>
						<c:when test="${sessionScope.member.userId==dto.userId}">
			    			<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/junggo/update?num=${dto.num}&page=${page}';">수정</button>
			    		</c:when>
			    		<c:otherwise>
			    			&nbsp;
			    		</c:otherwise>
			    	</c:choose>
			    	
			    	<c:choose>
			    		<c:when test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
			    			<button type="button" class="btn" onclick="deleteJunggo();">삭제</button>
			    		</c:when>
			    		<c:otherwise>
			    			&nbsp;
			    		</c:otherwise>
			    	</c:choose>
				</td>
			
				<td align="right">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/junggo/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
    	
    	<!-- 댓글 -->
    	<div class="reply">
	    	<table class="reply table table-reply">
				<tr> 
					<td align='left'>
						<span style='font-weight: bold;' >댓글쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
					</td>
				</tr>
				<tr>
					<td>
						<textarea class='boxTA' style='width:100%; height: 70px;'></textarea>
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
    	
    	<!-- 이전글다음글 -->
		<table class="table table-border table-content">
    		<tr>
				<td colspan="2">
					이전글 :
					<c:if test="${not empty preReadDto}">
						<a href="${pageContext.request.contextPath}/junggo/article?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
					</c:if>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="${pageContext.request.contextPath}/junggo/article?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
					</c:if>
				</td>
			</tr>
    	</table>
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