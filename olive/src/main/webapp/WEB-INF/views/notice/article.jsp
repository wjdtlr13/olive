<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">
.body_title{
	font-size: 27px;
	font-weight: 800;
}
.body-con{
	font-size: 18px;
}
.btn{
	width: 60px;
	height: 40px;
	background-color: #424242;
	color: white;
	border: 1px solid #ddd;
	cursor: pointer;
	margin-bottom: 10px;
}

a {
 text-decoration: none;

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
	<div style="height: 100px;"></div>
	<div class="body_title" style="width: 70%; margin: auto;">공지사항</div>
	<div class="body-con" style="width: 70%; margin: auto;">

		<div>
			<table style="width: 100%;margin: 30px auto; border-spacing: 0px; border-collapse: collapse; border-top: 1.5px solid #111;">
				
				<tr style="height: 70px; border-bottom: 1px solid #ddd;">
					<td style="text-align: center; padding-left: 200px; font-weight: 700;">${dto.subject}</td>
					<td width="30%" align="right" >
						${dto.created} | 조회 ${dto.hitCount}
					</td>
				</tr>
				<tr style="width: 100%; float: left;">
				  <td style="padding: 20px 20px; margin-left:100px; text-align: center; line-height: 60px;" valign="top" height="400">
				  	${dto.content}
				  </td>
				 </tr>
					
				<tr height="55" style="border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">
					<td colspan="2" align="left" style="padding-left: 5px;">
					이전
					<c:if test="${not empty preReadDto}">
						<a style="padding-left: 20px;" href="${pageContext.request.contextPath}/notice/article?${query}&num=${preReadDto.num}">${preReadDto.subject} </a>
					</c:if>
					</td>
				</tr>
				
				<tr height="55" style="border-bottom: 1px solid #ddd;">
					<td colspan="2" align="left" style="padding-left: 5px;">
					다음
					<c:if test="${not empty nextReadDto}">
						<a style="padding-left: 20px;" href="${pageContext.request.contextPath}/notice/article?${query}&num=${nextReadDto.num}">${nextReadDto.subject} </a>
					</c:if>
					</td>
				</tr>
			</table>
			
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="62">
				<td width="600" align="left" style="padding-left: 20px;">
					<c:if test="${sessionScope.member.userId=='admin'}">
			          <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/notice/update?num=${dto.num}&page=${page}';">수정</button>
						<button type="button" class="btn" onclick="deleteNotice();">삭제</button>
					</c:if>
				</td>
				<td align="right">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/notice/list?${query}';">목록</button>
				</td>					
			</table>
		</div>
	
	</div>
