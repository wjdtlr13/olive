<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mate-register.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR">

<div class="col"><button id="back" class="btn" type="button">&lt; 식당 선택하기</button></div>
    <div class="col">
        <div class="row">
            <div class="col-lg-6" style="padding: 0px;">
                <div class="d-flex justify-content-end align-items-start welcome" style="background: url('${pageContext.request.contextPath}/resources/img/mate/restaurent.png') center;"><span style="color: rgb(255,255,255);padding: 10px;"><strong><a class='menu' target='_blank' href='${eating_url }'>메뉴 보러가기 &gt;</a></strong></span></div>
                <div class="row">
                    <div class="col d-flex justify-content-between align-items-center heading">
                        <p><strong>${eating_name }</strong></p>
                    </div>
                </div>
                <p class="address">${eating_address }</p>
                <p class="address">${eating_tel }</p><div id="staticMap" style="width: 100%;height: 40%;"></div>
            </div>
            <div class="col-lg-6">
                <form name="submitForm" action="${pageContext.request.contextPath}/mate/registerSubmit" method="post">
                    <div class="col">
                        <p style="margin: 0px;">언제 만나는 약속인가요?</p>
                    </div>
                    <div class="col d-flex justify-content-around"><input name="eating_date" class="form-control" type="date" style="width: 40%;"><input name="eating_time" class="form-control" type="time" style="width: 40%;"></div>
                    <div class="col">
                        <p>자기소개를 적어주세요</p><textarea name="mate_introduce" class="form-control"></textarea>
                    </div>
                    <div class="col">
                        <p>만나고 싶은 사람과 음식 취향을 알려주세요</p>
                        <div class="form-check"><input class="form-check-input" type="checkbox" id="formCheck-1"><label class="form-check-label" for="formCheck-1">내 프로필의 취향 및 알러지를 추가합니다</label></div><textarea name="mate_kind" class="form-control"></textarea>
                    </div>
                    <div class="col">
                        <p>기타 하고픈 말을 적어주세요</p><textarea name="mate_etc" class="form-control"></textarea>
                    	<input type="hidden" name="eating_name" value="${eating_name}">
                    	<input type="hidden" name="eating_address" value="${eating_address}">
                    	<input type="hidden" name="eating_tel" value="${eating_tel}">
                    	<input type="hidden" name="eating_url" value="${eating_url}">
                    	<input type="hidden" name="userId" value="${sessionScope.member.userId}">
                    	<input type="hidden" name="categoryNum" value="${categoryNum }">
                    </div><button class="btn" type="submit" style="margin-left: 10px;">작성하기</button>
                </form>
            </div>
        </div>
    </div>