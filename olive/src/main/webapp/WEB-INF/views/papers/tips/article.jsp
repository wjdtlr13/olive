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
<c:if test="${sessionScope.member.userId=='admin'}">
function deleteTips() {
	var q = "num=${dto.num}&${query}";
	var url = "${pageContext.request.contextPath}/papers/tips/delete?" + q;
	
	if(confirm("게시물을 삭제하시겠습니까?")) {
		location.href=url;
	}
}
</c:if>

function login() {
	location.href="${pageContext.request.contextPath}/member/login";
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
			if(jqXHR.status === 403) {
				login();
				return false;
			}
			console.log(jqXHR.responseText);
		}
	
	});
}

$(function(){
	$(".btnSendTipsLike").click(function(){
		var $btn = $(this);
		var bLike = $btn.find("i").css("color")=="rgb(255,0,0)";
		var msg = "이 게시글이 도움이 되었습니까?";
		if(bLike) {
			msg = "게시글에 누른 좋아요를 췩소하시겠습니까?";
		}
		
		if (! confirm(msg)){
			return false;
		}
		
		var url="${pageContext.request.contextPath}/papers/tips/insertTipsLike";
		if(bLike) {
			url="${pageContext.request.contextPath}/papers/tips/deleteTipsLike";
		}
		var query="num=${dto.num}";
		var fn = function(data) {
			var state = data.state;
			var tipsLikeCount = data.tipsLikeCount;
			if(state == "true"){
				if(bLike) {
					$btn.find("i").css("color","black");
				} else {
					$btn.find("i").css("color", "red");
				}
			}
			
			$("#tipsLikeCount").text(tipsLikeCount);
		};
		ajaxFun(url, "post", query, "json", fn);
			
	});
});



</script>



<div class="body-container" style="width: 700px;">
	<div class="body-title">
		<h3><i class="fas fa-chalkboard"></i>서류작성꿀팁 게시물</h3>
	</div>
	
	<div class="body-main">
		<table class="table table-content">
			<tr>
				<td colspan="2" align="center">
					${dto.subject}
				</td>
			</tr>
			
			<tr>
				<td width="50%" align="left">
					작성자 : ${dto.userName} <!-- 관리자 -->
				</td>
				<td width="50%" align="right">
					${dto.created} | 조회 ${dto.hitCount}
				</td>
			</tr>
			
			<tr>
				<td colspan="2" style="padding-bottom: 15px;" align="center">
					<button type="button" class="btn btnSendTipsLike" title="좋아요"><i class="fas fa-thumbs-up" style="color:${isBoardLikeUser?'red;':'black;'}"></i>&nbsp;&nbsp;<span id="TipsLikeCount">${dto.TipsLikeCount}</span></button>
				</td>
			</tr>
			<tr>
			
				<td colspan="2">
					이전글 :
					<c:if test="${not empty preReadDto}">
						<a href="${pageContext.request.contextPath}/papers/tips/article?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
					</c:if>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="${pageContext.request.contextPath}/papers/tips/article?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
					</c:if>
				</td>
			</tr>
		</table>
		
		<table class="table table-footer">
			<tr>
				<td width="50%">
					<c:choose>
						<c:when test="${sessionScope.member.userId=='admin'}">
							<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/papers/tips/update?num=${dto.num}&page=${page}';">수정</button>							
						</c:when>
						<c:otherwise>
							<button type="button" class="btn" disabled="disabled">수정</button>
						</c:otherwise>
					</c:choose>
					
					<c:choose>
			    		<c:when test="${sessionScope.member.userId=='admin'}">
			    			<button type="button" class="btn" onclick="deleteTips();">삭제</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btn" disabled="disabled">삭제</button>
			    		</c:otherwise>
			    	</c:choose>
				</td>
			</tr>
		</table>
	</div>
	<!-- 댓글 자리 -->
	
</div>