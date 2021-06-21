<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/free-list.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR">


<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}

$(function(){
	if("${categoryNum}"==""){
		$('ul').find('.navnone').addClass('active');
	} else{
		var t = "nav${categoryNum}";
		$('ul').find("."+t).addClass('active');
		
	};
	
});


</script>
	<div class="jumbotron" style="background: #524c00;">
        <h1 style="color: rgb(224,224,224);"><strong>형형색깔 올리브</strong></h1>
        <p style="color: #e6ee9c;font-size: 20px;">어떠한 색깔도 자유롭게 칠할 수 있는 여기는 형형색깔 올리브입니다</p>
        <p><button class="btn" type="button" style="border-style: solid;border-color: #e6ee9c;color: rgb(255,255,255);">지금 글쓰기</button></p>
    </div>

<div class="container">
        <ul class="nav nav-tabs">
        <li class="nav-item"><a class="nav-link category navnone" href="${pageContext.request.contextPath}/free/list">전체</a></li>
        <c:forEach var="map" items="${categoryList}">
        <li class="nav-item"><a class="nav-link category nav${map.num}" href="${pageContext.request.contextPath}/free/list?categoryNum=${map.num}">${map.name }</a></li>
        </c:forEach>    
    </ul>
    
        <div class="col" style="margin: 15px 0;">
            <div>
                
		
		<table class="table table-striped table-hover">
			<thead>
			<tr> 
				<th width="10%">번호</th>
				<th width="40%">제목</th>
				<th width="12.5%">작성자</th>
				<th width="12.5%">작성일</th>
				<th width="12.5%">조회수</th>
				<th width="12.5%">첨부</th>
			</tr>
		 	</thead>
			<tbody>
			<c:forEach var="dto" items="${list}">
			<tr> 
				<td>${dto.listNum}</td>
				<td>
					<c:url var="url" value="/free/article">
						<c:param name="num" value="${dto.num}"/>
						<c:param name="page" value="${page}"/>
						<c:if test="${not empty keyword}">
							<c:param name="condition" value="${condition}"/>
							<c:param name="keyword" value="${keyword}"/>
						</c:if>
						<c:if test="${not empty categoryNum }">
							<c:param name="categoryNum" value="${categoryNum }"/>
						</c:if>
					</c:url>
					<a href="${url}">${dto.subject} (${dto.replyCount})</a>
				</td>
				<td>${dto.nickName}</td>
				<td>${dto.created}</td>
				<td>${dto.hitCount}</td>
				<td>
					<c:if test="${not empty dto.saveFilename}">
						<a href="${pageContext.request.contextPath}/free/download?num=${dto.num}"><i class="fa fa-file-text-o"></i></a>
					</c:if>		      
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		 
		<table class="table">
			<tr>
				<td align="center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
			</tr>
		</table>
		
		 <div class="row">
                <div class="col-auto"><button class="btn" type="button" onclick="javascript:location.href='${pageContext.request.contextPath}/free/list';">새로고침</button></div>
                <div class="col-auto"><button class="btn" type="button" onclick="javascript:location.href='${pageContext.request.contextPath}/free/created';">글올리기</button></div>
                <div class="col">
                    <form class="d-flex justify-content-end" name="searchForm" action="${pageContext.request.contextPath}/free/list" method="post">
                    	<select name="condition" class="form-control" style="width: 130px;">
                           <option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
							<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
							<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
							<option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
							<option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
                          
                        </select><input type="text" name="keyword" value="${keyword}" class="form-control" style="width: 170px;"><c:if test="${not empty categoryNum }">
							<input type="hidden" name="categoryNum" value="${categoryNum}">
						</c:if><button class="btn" type="button" onclick="searchList()">검색</button></form>
                </div>
            </div>
         </div>
      </div>
   </div>