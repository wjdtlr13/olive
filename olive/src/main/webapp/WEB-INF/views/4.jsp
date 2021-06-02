<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container" style="background: #f0f4c3;width: 85%;border-radius: 30px;">
        <div class="col">
            <p>받은 메세지 확인</p>
        </div>
        <div class="col">
            <hr>
        </div>
        <div class="row d-flex justify-content-between">
            <div class="col-auto">
                <div class="row">
                    <div class="col-auto"><img src="assets/img/user.png"></div>
                    <div class="col-auto">
                        <p>이름 아이디 닉네임</p>
                    </div>
                </div>
            </div>
            <div class="col-auto">
                <p>2021.05.29 20:11</p>
            </div>
        </div>
        <div class="col text-center"><textarea class="form-control-lg" resize="none" placeholder="내용을 입력하세요." rows="30" style="width: 70%;height: 300px;"></textarea></div>
        <div class="col text-center"><button class="btn btn-secondary" type="button">답장</button></div>
    </div>