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
function deleteWisdom() {
	var q = "num=${dto.num}&${query}";
	var url = "${pageContext.request.contextPath}/wisdom/delete?" + q;

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
	$(".btnSendWisdomLike").click(function(){
		if(! confirm("게시물에 공감 하십니까 ? ")) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/wisdom/insertwisdomLike";
		var num="${dto.num}";
		// var query={num:num};
		var query="num="+num;
		
		var fn = function(data){
			var state=data.state;
			if(state==="true") {
				var count = data.wisdomLikeCount;
				$("#wisdomLikeCount").text(count);
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
	var url = "${pageContext.request.contextPath}/wisdom/listReply";
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
		
		var url="${pageContext.request.contextPath}/wisdom/insertReply";
		var query="num="+num+"&content="+content;
		
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
		
		var url="${pageContext.request.contextPath}/wisdom/deleteReply";
		var query="replyNum="+replyNum+"&mode=reply";
		
		var fn = function(data){
			// var state=data.state;
			listPage(page);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});





</script>

<div style="width: 65%; margin: auto;">
    <div class="div-title" style="margin-top: 120px;">
        <span>올리브 나무</span>
    </div>
    
    <div class="body-main">
    	<table class="table table-content">
    	
    		<!-- 작성 글 보기 -->
    		<tr>
    			<td colspan="2" align="center">
					 ${dto.subject}
				</td>
    		</tr>
    		
    		<tr>
				<td width="50%" align="left">
					작성자 : ${dto.nickName}
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
					<button type="button" class="btn btnSendWisdomLike" title="좋아요"><i class="icofont-like"></i>&nbsp;&nbsp;<span id="wisdomLikeCount">${dto.wisdomLikeCount}</span></button>
				</td>
			</tr>
		</table>
		<table class="table table-border table-content">
    		<tr>
				<td colspan="2">
					이전글 :
					<c:if test="${not empty preReadDto}">
						<a href="${pageContext.request.contextPath}/wisdom/article?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
					</c:if>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="${pageContext.request.contextPath}/wisdom/article?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
					</c:if>
				</td>
			</tr>
    	</table>			
    		<!-- 수정삭제리스트 -->
    	<table class="table">
			<tr>
				<td width="50%">
					<c:choose>
						<c:when test="${sessionScope.member.userId==dto.userId}">
			    			<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/wisdom/update?num=${dto.num}&page=${page}';">수정</button>
			    		</c:when>
			    		<c:otherwise>
			    			&nbsp;
			    		</c:otherwise>
			    	</c:choose>
			    	
			    	<c:choose>
			    		<c:when test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
			    			<button type="button" class="btn" onclick="deleteWisdom();">삭제</button>
			    		</c:when>
			    		<c:otherwise>
			    			&nbsp;
			    		</c:otherwise>
			    	</c:choose>
				</td>
			
				<td align="right">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/wisdom/treeList?${query}';">리스트</button>
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