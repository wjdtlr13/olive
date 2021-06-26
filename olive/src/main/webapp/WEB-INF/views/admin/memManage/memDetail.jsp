<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style type="text/css">
 
.detail {
	background-color: #eee;
	min-height: 500px; 
	padding-top: 50px;
	width: 1000px;
	
}
.row {
	padding-left: 0;
}
.col {
	padding-right: 0;
}

.title {
	font-weight: bold;
	font-size: 17px;
}
p {

}
</style>

<div class="col-auto"> 
        <p style="font-size: 25px; padding-left: 0; font-weight: bold; ">
        	<img src='${pageContext.request.contextPath}/resources/img/info.png' style="width: 25px; height: 25px; line-height: 50px; text-align: center;">
		회원 상세정보</p>
       
    <div class="col" >
        <hr>
    </div>

<div class="container detail"  style="" >
       
        <div class="row">
            <div class="col">
                <p class="title">이름</p>
            </div>
            <div class="col">
                <p>${dto.userName}</p>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <p class="title">닉네임</p>
            </div>
            <div class="col">
                <p>${dto.nickName}</p>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <p class="title">아이디</p>
            </div>
            <div class="col">
                <p>${dto.userId}</p>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <p class="title">생년월일</p>
            </div>
            <div class="col">
                <p>${dto.birth}</p>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <p class="title">연락처</p>
            </div>
            <div class="col">
                <p>${dto.tel}</p>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <p class="title">주소</p>
            </div>
            <div class="col">
                <p>${dto.addr1}</p>
                <p>${dto.addr2}</p>
                <p>${dto.zip}</p>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <p class="title">자기소개</p>
            </div>
            <div class="col">
                <p>${dto.selfIntro}</p>
            </div>
        </div>

    </div>
</div>     
