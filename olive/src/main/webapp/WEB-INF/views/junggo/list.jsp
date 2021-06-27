<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 
<style type="text/css">
*{
	font-size: 18px;
}
.table-content tr {
	text-align: center;
}
.table-content tr:first-child {
	background: #eee;
}
.table-content tr > th {
	color: #777;
	background-color: #afb42b;
}
.table-content tr > td:nth-child(2) {
	box-sizing: border-box;
	padding-left: 10px;
	text-align: left;
}
.body-container{
	margin-top: 130px;
}
.body-title span{
	font-size: 27px;
	font-weight: 800;
}
.body-title{
	border-bottom: 1px;
}
textarea:focus, input:focus{
	outline: none;
}
.btn {
	color:#333;
	font-weight: 200;
	border:1px solid #ccc;
	background-color:#fff;
	text-align:center;
	vertical-align: middle;
	padding:6px 13px;
	border-radius: 3px;
	cursor: pointer;
}
.sbtn{
    width: 30%;
    height: 45px;
    margin-top: 20px;
}
.boxTF {
	border:1px solid #999;
	padding:5px 5px 5px;
	border-radius:4px;
	background-color:#fff;
	vertical-align: middle;
	margin:20px;
}
.boxTF[readonly] {
	background-color:#eeeeee;
	/* border: none;*/
}
.boxTA {
	border:1px solid #999;
	height:150px;
	padding:3px 5px;
	border-radius:4px;
	background-color:#fff;
	resize : none;
}

.selectField {
	border:1px solid #999;
	padding:5px 7px 5px;
	border-radius:4px;
	vertical-align: middle;
	height: 43px;
    margin-top: 20px;
}
</style>

<script type="text/javascript">
function searchList(){
	var f=document.searchForm;
	f.submit();
}
</script>

<div class="container body-container">
	<div class="body-title">
		<span> 주고받는 올리브 </span>
		<p> 이웃들과 중고거래를 통해 절약하는 올리브가 되어 보세요! </p>
	</div>
	
	<div class="body-main">
		<table class="table">
			<tr>
				<td align="left" width="50%">
					${dataCount}개(${page}/${total_page} 페이지)
				</td>
				<td align="right">
					&nbsp;
				</td>
			</tr>
		</table>
		
		<table class="table table-border table-content">
			<tr>
				<th width="6%">번호</th>
				<th> 카테고리 </th>
				<th align="center">제목</th>
				<th width="10%">가격</th>
				<th width="10%">작성자</th>
				<th width="20%">작성일</th>
				<th width="8%">조회수</th>
			</tr>
			
			<c:forEach var="dto" items="${list}">
			<tr>
				<td>${dto.listNum}</td>
				<td>${dto.categoryName}</td>
				<td>
					<a href="${articleUrl}&num=${dto.num}">${dto.subject} (${dto.replyCount}) </a>
				</td>
				<td>${dto.price}</td>
				<td>${dto.userName}</td>
				<td>${dto.created}</td>
				<td>${dto.hitCount}</td>
			</tr>
			</c:forEach>		
		</table>
		
		<table class="table">
			<tr>
				<td align="center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
			</tr>
		</table>
		
		<table class="table">
			<tr>
				<td align="left" width="20%">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/junggo/list';">새로고침</button>
				</td>
				<td align="center" class="search">
					<form name="searchForm" class="d-flex justify-content-end" action="${pageContext.request.contextPath}/junggo/list" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
							<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
							<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
						</select>
						<input type="text" name="keyword" value="${keyword}" class="boxTF">
						<button type="button" class="btn sbtn" onclick="searchList()">검색</button>
					</form>
				</td>
				<td align="right" width="20%">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/junggo/created';">글올리기</button>				
				</td>
			</tr>
		</table>
	</div>
	
	
</div>