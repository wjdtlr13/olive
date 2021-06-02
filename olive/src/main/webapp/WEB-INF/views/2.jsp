<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container" style="background: #f0f4c3;width: 85%;border-radius: 30px;">
        <div class="col">
            <p>메세지 작성</p>
        </div>
        <div class="col">
            <hr>
        </div>
        <div class="row">
            <div class="col-auto"><img src="assets/img/user.png"></div>
            <div class="col-auto"><input type="text" placeholder="ID를 입력하세요." style="width: 100%;"></div>
        </div>
        <div class="col text-center"><textarea class="form-control-lg" resize="none" placeholder="내용을 입력하세요." rows="30" style="width: 70%;height: 300px;"></textarea></div>
        <div class="col text-center"><img src="assets/img/message.png"></div>
    </div>