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
	height: 35px;
}
.table-content tr:first-child {
	border-top: 2px solid #ccc;
}
.table-content tr:last-child {
	border-bottom: 1px solid #ccc;
}
.table-content tr > td {
	padding: 7px 5px;
}

.table-footer {
	margin: 5px auto;
}
.table-footer tr {
	height:45px;
}

.table-reply {
	margin-top: 15px;
}
</style>

<script type="text/javascript">

<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.userId}">
function deleteAuction() {
	var q = "num=${dto.num}&${query}";
	var url="${pageContext.request.contextPath}/auction/delete?" + q;
	
	if(confirm("게시글을 삭제하시겠습니까?")) {
		location.href=url;
	}
}
</c:if>

</script>

<script type="text/javascript">
function login(){
	location.href="${pageContext.request.contextPath}/member/login"
}

function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data){
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403){
				login();
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	$(".btnSendAuctionLike").click(function(){
		var $btn = $(this);
		var bLike = $btn.find("i").css("color")=="rgb(255, 0, 0)";
		var msg = "게시글에 공감하시겠습니까 ?";
		if(bLike) {
			msg = "게시글 공감을 취소하시겠습니까 ?";
		}
		
		if( ! confirm(msg)) {
			return false;	
		}
		
		var url="${pageContext.request.contextPath}/auction/insertAuctionLike";
		if(bLike) {
			url="${pageContext.request.contextPath}/auction/deleteAuctionLike";
		}
		var query="num=${dto.num}";
		var fn = function(data) {
			var state = data.state;
			var auctionLikeCount = data.auctionLikeCount;
			if(state=="true") {
				if(bLike) {
					$btn.find("i").css("color","black");
				} else {
					$btn.find("i").css("color","red");
				}
			}
			
			$("#auctionLikeCount").text(auctionLikeCount);
			
		};
		ajaxFun(url, "post", query, "json", fn);

	});
});

$(function(){
	listPage(1);
});

function listPage(page) {
	var url="${pageContext.request.contextPath}/auction/listReply";
	var query="num=${dto.num}&pageNo="+page;
	var selector="#listReply";
	
	var fn=function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

$(function(){
	$(".btnSendReply").click(function(){
		var num="${dto.num}";
		var $tb=$(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${pageContext.request.contextPath}/auction/insertReply";
		var query="num="+num+"&content="+content+"&answer=0";
		
		var fn = function(data) {
			$tb.find("textarea").val("");
			listPage(1);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

////////////////

$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("게시글을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var replyNum=$(this).attr("data-replyNum");
		var page=$(this).attr("data-pageNo");
		
		var url="${pageContext.request.contextPath}/auction/deleteReply";
		var query="replyNum="+replyNum+"&mode=reply";
		
		var fn = function(data){
			// var state=data.state;
			listPage(page);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

$(function(){
	// 댓글의 답글 리스트
	function listReplyAnswer(answer) {
		var url="${pageContext.request.contextPath}/auction/listReplyAnswer";
		var query="answer="+answer;
		var selector="#listReplyAnswer"+answer;
		
		var fn=function(data){
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "html", fn);
	}
	
	// 댓글의 답글 개수
	function countReplyAnswer(answer) {
		var url="${pageContext.request.contextPath}/auction/countReplyAnswer";
		var query="answer="+answer;
		var fn=function(data) {
			var count=data.count;
			var id="#answerCount"+answer;
			$(id).html(count);
		};
		ajaxFun(url, "get", query, "json", fn);
	}
	
	// 답글 버튼
	$("body").on("click", ".btnReplyAnswerLayout", function(){
		var $tr = $(this).closest("tr").next();
		var isVisible = $tr.is(":visible");
		var replyNum = $(this).attr("data-replyNum");
		if(isVisible) {
			$tr.hide();
		} else {
			$tr.show();
			
			// 답글 리스트
			listReplyAnswer(replyNum);
			
			// 답글 개수
			countReplyAnswer(replyNum);
		}
	});
	
	// 답글 등록
	$("body").on("click", ".btnSendReplyAnswer", function(){
		var num="${dto.num}";
		var replyNum=$(this).attr("data-replyNum");
		var $td=$(this).closest("td");
		var content = $td.find("textarea").val().trim();
		if(! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${pageContext.request.contextPath}/auction/insertReply";
		var query="num="+num+"&content="+content+"&answer="+replyNum;
		var fn=function(data) {
			$td.find("textarea").val("");
			if(data.state=="true") {
				listReplyAnswer(replyNum);
				countReplyAnswer(replyNum);
			}
		};
		ajaxFun(url, "post", query, "json", fn);
		
	});

	// 댓글별 답글 삭제
	$("body").on("click", ".deleteReplyAnswer", function(){
		if(! confirm("게시글을 삭제하시겠습니까 ? ")) {
		    return;
		}
		
		var replyNum=$(this).attr("data-replyNum");
		var answer=$(this).attr("data-answer");
		
		var url="${pageContext.request.contextPath}/auction/deleteReply";
		var query="replyNum="+replyNum+"&mode=answer";
		
		var fn = function(data){
			listReplyAnswer(answer);
			countReplyAnswer(answer);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

</script>


<div class="body-container" style="width:70px;">
	<div class="body-title">
		<h3><i class="fas fa-chalkboard"></i>공동구매 게시글</h3>
	</div>
	
	<div class="body-main">
		<table class="table table-content">
			<tr>
				<td align="left">${dto.tag}</td>
				<td align="center">${dto.subject}</td>
			</tr>
			
			<tr>
				<td width="50%" align="left">
					작성자 : ${dto.userName} | 작성일 ${dto.created}
				</td>
				
				<td width="50%" align="right">
					기간 : ${dto.startDate} 부터 ${dto.endDate} 까지
				</td>
			</tr>
			
			<tr>
				<td width="50%" align="left">
					가격  ${dto.price}
				</td>
				
				<td width="50%" align="right">
					조회수 : ${dto.hitCount}
				</td>
			</tr>
			
			<tr style="border: none;">
				<td colspan="2" valign="top" height="200">
					${dto.content}
				</td>
			</tr>
			
			<tr>
				<td colspan="2" style="padding-bottom: 15px;" align="center">
					<button type="button" class="btn btnSendAuctionLike" title="좋아요"><i class="fas fa-thumbs-up" style="color:${isAuctionLikeUser?'red;':'black;'}"></i>&nbsp;&nbsp;<span id="auctionLikeCount">${dto.auctionLikeCount}</span></button>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					이전글 :
					<c:if test="${not empty preAuctionDto}">
						<a href="${pageContext.request.contextPath}/auction/article?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
					</c:if>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					다음글 :
					<c:if test="${not empty nextAuctionDto}">
						<a href="${pageContext.request.contextPath}/auction/article?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
					</c:if>
				</td>
			</tr>
		</table>
		
		<table class="table table-footer">
			<tr>
				<td width="50%">
					<c:choose>
						<c:when test="${sessionScope.member.userId==dto.userId}">
			    			<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/auction/update?num=${dto.num}&page=${page}';">수정</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btn" disabled="disabled">수정</button>
			    		</c:otherwise>
			    	</c:choose>
			    	
			    	<c:choose>
			    		<c:when test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
			    			<button type="button" class="btn" onclick="deleteAuction();">삭제</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btn" disabled="disabled">삭제</button>
			    		</c:otherwise>
			    	</c:choose>
				</td>
			
				<td align="right">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/auction/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
	</div>
	
	<div>
		<table class="table table-reply">
			<tr height='30'> 
				<td align='left' >
					<span style='font-weight: bold;' >댓글쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
				</td>
			</tr>
			<tr>
				<td style='padding:5px 5px 0;'>
					<textarea class='boxTA' style='width:99%; height: 70px;'></textarea>
				</td>
			</tr>
			<tr>
			   <td align='right'>
			        <button type='button' class='btn btnSendReply' style='padding:10px 20px;'>댓글 등록</button>
			    </td>
			 </tr>
		</table>
		     
		<div id="listReply"></div>
    </div>

</div>
