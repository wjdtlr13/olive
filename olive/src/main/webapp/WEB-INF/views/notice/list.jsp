<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title> 
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
* {
	margin: 0; padding: 0;
	
	font-family: 맑은 고딕, 돋움;
}

.body-container {
	width: 1000px;
	margin: 20px auto;
	min-height: 700px;
	
	
}
.body-top-select1 {
	height: 30px;
	border: 1px solid #ccc;
	border-radius:5px; 
	width: 130px;
		
}

.center {
	clear: both;
}


.body-top-select2 {
	
	
	border: 1px solid #ccc;	
	height: 30px;
	border-radius:5px; 		
	float: right;
}

.body-title {
	text-align: center;
	font-size: 30px;
	font-weight: bold;
	margin: 30px auto;
	width: 300px;
	height: 60px;

	
	

	
}
.body-subtitle {
	text-align: center;	
	border-bottom: 2px solid #eee;
	width: 150px;
	margin: 0 auto;
}
table {
	width: 1000px;
	margin: 10px auto;
	border-collapse: collapse;
	border-spacing: 0;
}
thead {
	background-color: #B6CC98;
	height: 40px;
	line-height: 40px;
	border-bottom: 2px solid gray;
	border-top: 2px solid gray;
	color: white;
}
.head-No {
	width:150px;
	text-align: center;
	height: 25px;
}
.head-Contents {
	width:300px;
	text-align: left;
	height: 25px;
}
.head-Name {
	width:150px;
	text-align: center;
	height: 25px;
}

.head-Date {
	width:150px;
	text-align: center;
	height: 25px;
}  
tbody tr {
	border-bottom: 1px solid #ccc;
	height: 40px;
}
tbody {
	border-bottom: 2px solid gray;
}

 .created {
	float: right;
	height: 35px;
	width: 60px;
	color: white;
	border: 1px solid #fff;
	border-radius: 5px;
	background: #6C9174;
}

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
	border-radius: 3px;
	width:60px;
	background :#6C9174;
	border: 1px solid #6C9174;
	color: white;

	
}
.search {
	margin-top: 60px;
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
.body-middle {
	margin-top:50px;
	margin-bottom:20px;
	
}

select:focus {
	outline: none;
}
</style>
</head>
<body>

<div class="body-container" >
    <div class="body-title">
        <h3>올리브 게시판 </h3>
    </div>
    
	<div class="body-subtitle">
		올리브네 게시판!
	</div>
	<div class="search">
			<select class="search1">
				<option>검색종류1</option>
				<option>검색종류2</option>
				<option>검색종류3</option>			
			</select>
			<input class="search2" type="text" placeholder="검색어를 입력하세요">
			<button class="search3">검색</button>				
	</div>
	<div class="body-middle">
		<select class="body-top-select1">
			<option>카테고리1</option>
			<option>카테고리2</option>
			<option>카테고리3</option>
			<option>카테고리4</option>		
		</select>
		<select class="body-top-select2">
			<option>카테고리1</option>
			<option>카테고리2</option>
			<option>카테고리3</option>
			<option>카테고리4</option>		
		</select>		
		
	</div>
	

		
	
	<div class="center"></div>
	
	<table>
		<thead>
			<tr>
				<th class="head-No">NO</th>
				<th class="head-Contents"style="text-align: center;">CONTENTS</th>				
				<th class="head-Name">NAME</th>				
				<th class="head-Date">DATE</th>				
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${list}">
			<tr>
				<td class="head-No">${dto.listNum}</td>
				<td class="head-Contents"><a href="${articleUrl}&num=${dto.num}">${dto.subject}</a> </td>
				<td class="head-Name">${dto.userId}</td>
				<td class="head-Date">${dto.created}</td>				
			</tr>
			</c:forEach>
		</tbody>
	
	</table>
	<div >
	<button class="created" onclick="javascript:location.href='${pageContext.request.contextPath}/notice/created';">작성</button>
	</div>

	</div>



</body>