<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

 <div class="container">
        <div class="col"><span style="font-size: 30px;border-bottom-style: solid;"><strong>프로필</strong></span></div>
        <div class="row">
            <div class="col-3">
                <p>이름</p>
            </div>
            <div class="col d-flex align-items-center"><input type="text" style="width: 100%;height: 80%;"></div>
        </div>
        <div class="row">
            <div class="col-3">
                <p>등급</p>
            </div>
            <div class="col d-flex align-items-center"><input type="text" style="width: 100%;height: 80%;"></div>
        </div>
        <div class="row">
            <div class="col-3">
                <p>지역</p>
            </div>
            <div class="col d-flex align-items-center"><input type="text" style="width: 100%;height: 80%;"></div>
        </div>
        <div class="row">
            <div class="col-3">
                <p>선호하는 음식</p>
            </div>
            <div class="col d-flex align-items-center"><input type="text" style="width: 100%;height: 80%;"></div>
        </div>
        <div class="row">
            <div class="col-3">
                <p>싫어하는 음식</p>
            </div>
            <div class="col d-flex align-items-center"><input type="text" style="width: 100%;height: 80%;"></div>
        </div>
        <div class="col">
            <p>자기소개!</p>
        </div>
        <div class="col"><textarea style="width: 100%;height: 300px;"></textarea></div>
        <div class="col d-flex justify-content-end"><button class="btn btn-primary" type="button">Button</button></div>
    </div>