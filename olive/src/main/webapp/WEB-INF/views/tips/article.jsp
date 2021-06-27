<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 
<style type="text/css">
.table-content tr>td {
	padding-left: 5px;
	padding-right: 5px;
}

.body-title {
	font-size: 27px;
	font-weight: 800;
}
</style>

<script type="text/javascript">
<c:if test="${sessionScope.member.userId=='admin'}">
function deleteTips() {
	var q = "num=${dto.num}&${query}";
	var url = "${pageContext.request.contextPath}/tips/delete?" + q;
	
	if(confirm("게시글을 삭제하시겠습니까?")) {
		location.href=url;
	}
}
</c:if>
</script>

<script type="text/javascript">
function login(){
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
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status===403){
				login();
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	$(".btnSendTipsLike").click(function(){
		if(! confirm("게시글에 공감 하십니까?")) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/tips/insertTipsLke";
		var num="${dto.num}";
		var query="num="+num;
		
		var fn = function(data){
			var state=data.state;
			if(state==="true"){
				var count=data.tipsLikeCount;
				$("#tipsLikeCount").text(count);
			} else if (state==="false") {
				alert("게시글 공감은 한번만 가능합니다");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

$(function(){
	lastPage(1);
});

</script>


<div class="container body-container" style="margin-top: 130px;">
	<div class="body-title">
		<span><i class="icofont-google-talk"></i> 올리브의 집문서 </span>
	</div>
	
	<div class="body-main wx-700 ml-30 pt-15">
		<table class="table table-border table-content">
			<tr>
				<td colspan="2" align="center">
					${dto.subject}
				</td>
			</tr>
			
			<tr>
				<td width="50%" align="left">
					작성자 : ${dto.userName}
				</td>
				<td width="50%" align="right">
					${dto.created} | 조회 ${dto.hitCount}
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="left">
					서류다운링크 : ${dto.downLink}
				</td>
			</tr>
			
			<tr style="border: none;">
				<td colspan="2" valign="top" height="200">
					${dto.content}
				</td>
			</tr>
			
			<tr>
				<td colspan="2" style="padding-bottom: 15px;" align="center">
					<button type="button" class="btn btnSendTipsLike" title="좋아요"><i class="icofont-like"></i>&nbsp;&nbsp;<span id="tipsLikeCount">${dto.tipsLikeCount}</span></button>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					첨&nbsp;&nbsp;부:
					<c:if test="${not empty dto.saveFilename}">
						<a href="${pageContext.request.contextPath}/tips/download?num=${dto.num}">${dto.originalFilename}</a>
					</c:if>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					이전글 : 
					<c:if test="${not empty preReadDto}">
						<a href="${pageContext.request.contextPath}/tips/article?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
					</c:if>
				</td>
			</tr>	
			
			<tr>
				<td colspan="2">
					다음글 : 
					<c:if test="${not empty nextReadDto}">
						<a href="${pageContext.request.contextPath}/tips/article?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
					</c:if>
				</td>
			</tr>		
		</table>
		
		<c:if test="${sessionScope.member.userId=='admin'}">
		<table class="table">
			<tr>
				<td width="50%">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/tips/update?num=${dto.num}&page=${page}';">수정</button>
					<button type="button" class="btn" onclick="deleteTips();">삭제</button>
				</td>
				<td align="right">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/tips/list?${query}';">리스트</button>
				</td>				
			</tr>
		</table>
		</c:if>
		
	</div>
</div>