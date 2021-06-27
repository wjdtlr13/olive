<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">

.search1  {
	height: 40px;
	border-radius: 3px;
	width:100px;
	border: 1px solid #ccc;
}

.search2 {
	border-radius: 3px;
	width:250px;
	border: 1px solid #ccc;
	padding-left: 10px;
	height: 40px;	
}

.search3 {
	height: 40px;
	width:60px;
	background :#eeeeee;
	border: none;
}
.search {
	margin: 40px;
	text-align: center;
	height: 50px;
}

input:focus {
	outline: none;
}

a {
	text-decoration: none;
	color: gray;
	font-weight: bold;
}
a:hover {
	color: #82A880;
}
</style>
<script type="text/javascript">

function searchList() { 
	var f= document.searchForm;
	 
	f.action="${pageContext.request.contextPath}/admin/memManage/memList";
	f.submit();
}



</script>

<div class="container">
<div class="row" >
        <div class="col-auto" style="font-size: 25px; font-weight: bold;">
            <p>  <img src='${pageContext.request.contextPath}/resources/img/list.png' style="width: 25px; height: 25px; line-height: 50px; text-align: center;">
            	회원 리스트</p>
        </div>
</div>
    <div class="col">
        <hr>
    </div>
    <div class="col">
	<form name="searchForm" method="post">
		<div class="search">
				<select class="search1" name="condition">
                    <option value="all" ${condition=="all"?"selected='selected'":""}>전체</option>		
					<option value="userId">아이디</option>
					<option value="birth">생년월일</option>
					<option value="userName">이름</option>			
				</select>
				<input class="search2" name="keyword"  value="${keyword}" type="text" placeholder="검색어를 입력하세요.">
				<button class="search3"  type="button" onclick="searchList();">검색</button>				
		</div>
	</form>
    </div>
    <div class="col">
        <hr>
    </div>
    <div class="col-auto">
        <p>총 ${dataCount}건</p>
    </div>
    <div class="col d-flex justify-content-center">
        <div class="table-responsive text-center" style="width: 70%;">
            <table class="table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>생년월일</th>
                        <th>가입일</th>
                        <th>회원상세정보보기</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="dto" items="${list}">
                    <tr>
                        <td>${dto.listNum}<br></td>
                        <td>${dto.userId}<br></td>
                        <td>${dto.userName}<br></td>
                        <td>${dto.birth}</td>
                        <td>${dto.created_date}</td>
                        <td>
                        	<a href="${detailUrl}&userId=${dto.userId}">바로가기 [클릭!]</a>
                        </td>
                    </tr>
                    </c:forEach>

                </tbody>
            </table>
        </div>
    </div>
	<table class="table">
		<tr>
			<td align="center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
		</tr>
	</table>
</div>    