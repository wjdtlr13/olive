<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style type="text/css">
* {
	margin: 0; padding: 0; 
}

.body-container {
	width: 70%;
	margin: auto;
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

.title {
	font-size: 25px;
	padding-top: 80px;
	padding-bottom:30px;
	margin: auto;
	font-weight: bold;
	width: 70%;
	border-bottom: 1px solid black;
}

table {
	margin:auto;
	border-collapse: collapse;
	border-spacing: 0;
	width: 100%;
	
}
thead {
	background-color: #eeeeee;
	height: 50px;
	line-height: 40px;
	border-bottom: 1px solid #eee;
	border-top: 1px solid #eee;
}
.head-No {
	width:20%;
	text-align: center;
}
.head-Contents {
	width:30%;
	text-align: left;
}
.head-Name {
	width:20%;
	text-align: center;
}

.head-Date {
	width:20%;
	text-align: center;
}  
tbody tr {
	border-bottom: 1px solid #f5f5f5;
	height: 50px;
}
tbody {
	border-bottom: 1px solid #eee;
}
 .created {
	float: right;
	height: 45px;
	width: 65px;
	color: white;
	border: none;
	background: black;
	margin-top: 30px;
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
.body-middle {
	margin-top:50px;
	margin-bottom:20px;
}

select:focus {
	outline: none;
}
</style>
<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";	
}

function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status===403) {
				login();
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

function ajaxFileFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		processData: false,  // file ????????? ??????. ?????????????????? ???????????? ?????????????????? ????????????
		contentType: false,  // file ????????? ??????. ?????????????????? ???????????? Content-Type. ??????:application/x-www-urlencoded
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status===403) {
				login();
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	listPage(1);
});



</script>

<div class="title">????????? ??????</div>

 <div class="body-container" >


            <!--  
            	<select name="categoryNum">
                    
                    	<c:forEach var="vo" items="${categoryList}">
                       		<option value="${vo.categoryNum}" ${categoryNum==vo.categoryNum? "selected='selected'":""}>${vo.category}</option>
                        </c:forEach>
                    
                </select>
           
            <div class="col-auto" ><input type="text" id="keyword" name="keyword" value="${keyword}"></div>
            <div class="col-auto"><button class="btn btn-primary" type="button">Button</button></div>
 		 -->
        <div class="row">
            <div class="col-auto">
            	<select>
                   		<option value="0" ${categoryNum==0? "selected='selected'":""}>??????</option>
                    
                    	<c:forEach var="vo" items="${categoryList}">
                       		<option value="${vo.categoryNum}">${vo.category}</option>
                        </c:forEach>
                    
                </select>
            </div>

        </div>
	<form name="searchForm" method="post">
		<div class="search" >
				<select class="search1"  action="${pageContext.request.contextPath}/wisdom/list"name="condition" >
					<option value="all">??????+??????</option>
					<option value="subject">??????</option>
					<option value="content">??????</option>			
				</select>
				<input class="search2" type="text" placeholder="???????????? ???????????????."  name="keyword" value="${keyword}" >
				<button class="search3"  type="button" onclick="searchList();">??????</button>				
		</div>
	</form>
	<div style="width:100%; height: 20px; border-top: 1px solid black;"></div>

	<table>
		<thead>
			<tr>
				<th class="head-No">??????</th>
				<th class="head-Contents"style="text-align: center;">??????</th>				
				<th class="head-Name">?????????</th>				
				<th class="head-Date">??????</th>			
				<th class="head-Date">?????????</th>	
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${list}">
			<tr>
				<td class="head-No">${dto.listNum}</td>
				<td class="head-Contents"><a href="${articleUrl}&num=${dto.num}">${dto.subject}</a> </td>
				<td class="head-Name">${dto.nickName}</td>
				<td class="head-Date">${dto.created}</td>		
				<td class="head-Date">${dto.hitCount}</td>						
			</tr>
			</c:forEach>
		</tbody>
	
	</table>
			<table class="table">
				<tr>
					<td align="center">
						${dataCount==0?"????????? ???????????? ????????????.":paging}
					</td>
				</tr>
			</table>
			<div>
				<button class="created"
					onclick="javascript:location.href='${pageContext.request.contextPath}/wisdom/created';">??????</button>
			</div>
        </div>

