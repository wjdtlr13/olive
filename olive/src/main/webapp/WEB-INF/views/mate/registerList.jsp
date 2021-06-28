<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/free-list.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR">


<script type="text/javascript">
	function searchList() {
		var f = document.searchForm;
		f.submit();
	}

	var mode = "${mode}";

	$(function() {
		$('.nav-tabs').find(mode).addClass('active');

	});

	$(function() {
		$('#listRequest').click(function() {
			$('form[name=submitForm]').hide();
			$(this).closest('.col-lg-6').find('table').show();

		})
	})
</script>
<div class="jumbotron" style="background: rgb(103, 98, 23);">
	<h1 style="color: rgb(224, 224, 224);">
		<strong>올리브의 밥친구</strong>
	</h1>
	<p style="color: #e6ee9c; font-size: 20px;">어떠한 색깔도 자유롭게 칠할 수 있는
		여기는 형형색깔 올리브입니다</p>

</div>

<div class="container">
	<c:if test="${mode != 'available'}">
	<ul class="nav nav-tabs">
		<li class="nav-item"><a id="upcoming"
			class="nav-link category navnone"
			href="${pageContext.request.contextPath}/mate/registerList?mode=upcoming">다가오는
				약속</a></li>
		<li class="nav-item"><a id="past"
			class="nav-link category navnone"
			href="${pageContext.request.contextPath}/mate/registerList?mode=past">지난
				약속</a></li>
		<li class="nav-item"><a id="matched"
			class="nav-link category navnone"
			href="${pageContext.request.contextPath}/mate/registerList?mode=matched">성립된
				약속</a></li>
	</ul>
	</c:if>
	<div class="col" style="margin: 15px 0;">
		<div>


			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th width="5%">번호</th>
						<th width="5%">분류</th>
						<th width="27%">상호명</th>
						<th width="27%">주소</th>
						<th width="12.5%">약속일</th>
						<th width="10%">작성자</th>
						<th width="12.5%">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${list}">
						<tr>
							<td>${dto.listNum}</td>
							<td>${dto.categoryName }</td>
							<td><c:url var="url" value="/mate/article">
									<c:param name="mate_reg_num" value="${dto.mate_reg_num}" />
									<c:param name="page" value="${page}" />
									<c:param name="mate_regi_num" value="${dto.mate_regi_num }" />
									<c:param name="mode" value="${mode }" />
									<c:if test="${not empty keyword}">
										<c:param name="condition" value="${condition}" />
										<c:param name="keyword" value="${keyword}" />
									</c:if>
									<c:if test="${not empty categoryNum }">
										<c:param name="categoryNum" value="${categoryNum }" />
									</c:if>
								</c:url> <a href="${url}">${dto.eating_name}</a></td>
							<td>${dto.eating_address}</td>
							<td>${dto.eating_date}</td>
							<td>${dto.nickName}</td>
							<td>${dto.reg_date }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<table class="table">
				<tr>
					<td align="center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
				</tr>
			</table>

			<div class="row d-none">
				<div class="col-auto">
					<button class="btn" type="button"
						onclick="javascript:location.href='${pageContext.request.contextPath}/free/list';">새로고침</button>
				</div>
				<div class="col-auto">
					<button class="btn" type="button"
						onclick="javascript:location.href='${pageContext.request.contextPath}/free/created';">글올리기</button>
				</div>
				<div class="col">
					<form class="d-flex justify-content-end" name="searchForm"
						action="${pageContext.request.contextPath}/free/list"
						method="post">
						<select name="condition" class="form-control"
							style="width: 130px;">
							<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
							<option value="subject"
								${condition=="subject"?"selected='selected'":""}>제목</option>
							<option value="content"
								${condition=="content"?"selected='selected'":""}>내용</option>
							<option value="userName"
								${condition=="userName"?"selected='selected'":""}>작성자</option>
							<option value="created"
								${condition=="created"?"selected='selected'":""}>등록일</option>

						</select><input type="text" name="keyword" value="${keyword}"
							class="form-control" style="width: 170px;">
						<c:if test="${not empty categoryNum }">
							<input type="hidden" name="categoryNum" value="${categoryNum}">
						</c:if>
						<button class="btn" type="button" onclick="searchList()">검색</button>
						<input type="hidden" name="mode" value="${mode}">
					</form>
				</div>
			</div>
		</div>
	</div>
</div>