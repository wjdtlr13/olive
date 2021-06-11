<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<script type="text/javascript">

function searchList() {
	var f= document.searchForm;
	
	f.action="${pageContext.request.contextPath}/admin/memManage/memList";
	f.submit();
}



</script>

<div class="container">
<div class="row" style="padding-left: 20px;">
        <div class="col-auto">
            <p>회원 리스트</p>
        </div>
    </div>
    <div class="col">
        <hr>
    </div>
    <div class="col">
    	<form name="searchForm" action="${pageContext.request.contextPath}/admin/memManage/memList" method="post">
        <div class="text-center">
        	<select>
                <optgroup label="검색 카테고리">
                    <option value="date" >날짜</option>
                    <option value="name">이름</option>
                    <option value="id">아이디</option>
                </optgroup>
            </select>
            <input type="search" style="width: 25%;">
            
            <button type="button" onclick="searchList()"> <i class="fa fa-search"></i></button>
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
                        <th>최근 접속일</th>
                        <th>회원상세정보보기</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="dto" items="${list}">
                    <tr>
                        <td>${dto.memberidx}<br></td>
                        <td>${dto.userId}<br></td>
                        <td>${dto.userName}<br></td>
                        <td>${dto.birth}</td>
                        <td>${dto.created_date}</td>
                        <td>${dto.last_login}</td>
                        <td>
                        	<a href="${detailUrl}&userId=${dto.userId}">바로가기[클릭!]</a>
                        </td>
                    </tr>
                    </c:forEach>

                </tbody>
            </table>
        </div>
    </div>
    <div class="col d-flex justify-content-center">
        <nav>
            <ul class="pagination">
                <li class="page-item"><a class="page-link" href="#" aria-label="Previous"><span aria-hidden="true">«</span></a></li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item"><a class="page-link" href="#">4</a></li>
                <li class="page-item"><a class="page-link" href="#">5</a></li>
                <li class="page-item"><a class="page-link" href="#" aria-label="Next"><span aria-hidden="true">»</span></a></li>
            </ul>
        </nav>
    </div>
</div>    