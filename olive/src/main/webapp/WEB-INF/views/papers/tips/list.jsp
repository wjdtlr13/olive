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

.table-header {
	margin-top: 20px;
}
.table-header tr {
	height: 37px;
}

.table-list tr {
	height: 35px;
	border-bottom: 1px solid #ccc;
	text-align: center;
}
.table-list tr:first-child {
	border-top: 2px solid #ccc;
	background: #eee;
	height: 35px;
}
.table-list tr:last-child {
	border-bottom: 1px solid #ccc;
}
.table-list tr > th {
	color: #777;
}

.table-list tr > td:nth-child(2) {
	box-sizing: border-box;
	padding-left: 10px;
	text-align: left;
}

.table-paging tr > td {
	height: 40px;
	line-height: 40px;
	text-align:center;
	padding: 5px;
	box-sizing: border-box;
}

.table-footer {
	margin: 10px auto;
}
.table-footer tr {
	height:45px;
}
</style>

<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.submit();
	}
</script>

<div class="body-container" style="width: 700px;">
	<div class="body-title">
		<h3><i class="fas fa-chalkboard"> 문서 게시판 </i></h3>	
	</div>
	
	<div class="body-main">
		<table class="table table-header">
			<tr>	
				<td align="left" width="50%">
					${dataCount}개(${page}/${total_page} 페이지)				
				</td>
				<td align="right">
					&nbsp;
				</td>
			</tr>		
		</table>
	
		<table class="table table-list">
			<tr>
				<th width="60">글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			
			<c:forEach var="dto" items="${list}">
			<tr>
				<td>${dto.listNum}</td>
				<td>
					<c:url var="url" value="/papers/tips/article">
						<c:param name="num" value="${dto.num}"/>
						<c:param name="page" value="${page}"/>
						<c:if test="${not empty keyword}">
							<c:param name="condition" value="${condition}"/>
							<c:param name="keyword" value="${keyword}"/>
						</c:if>
					</c:url>
					<a href="${url}">${dto.subject}</a>
				</td>
				<td>${dto.userName}</td> <!-- 관리자... 뺄까... -->
				<td>${dto.created}</td>
				<td>${dto.hitCount}</td>
			</tr>
			</c:forEach>
		</table>
	
		<table class="table table-paging">
			<tr>
				<td>${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
			</tr>
		</table>
		<table>
			<tr>
				<td align="left" width="100">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/papers/tips/list';">새로고침</button>
				</td>
				<td align="center">
					<form name="searchForm" action="${pageContext.request.contextPath}/papers/tips/list" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
							<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
							<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
						</select>
						<input type="text" name="keyword" value="${keyword}" class="boxTF">
						<button type="button" class="btn" onclick="searchList()">검색</button>
					</form>
				</td>
				<!-- c:if session.admin -->
				<td align="right" width="100">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/papers/tips/created';">글올리기</button>
				</td>
			</tr>
		</table>
	
	</div>
</div>