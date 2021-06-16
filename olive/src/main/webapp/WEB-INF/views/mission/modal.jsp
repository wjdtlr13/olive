<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mission-modal.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR">


<body style="font-family: 'Noto Sans KR', sans-serif;">
    <div class="col header">
        <div></div>
    </div>
    <div class="col title">
        <p><strong>도전 과제를 등록합니다</strong></p>
    </div>
    <div class="container list">
        <div class="row">
            <div class="col"><span>시작날짜</span></div>
            <div class="col"><span>끝날짜</span></div>
        </div>
        <div class="row">
            <div class="col"><input type="date"></div>
            <div class="col"><input type="date"></div>
        </div>
        <div class="row">
            <div class="col-3"><span>제목</span></div>
            <div class="col"><input type="text"></div>
        </div>
        <div class="row">
            <div class="col-3"><span>내용</span></div>
            <div class="col"><textarea wrap="hard"></textarea></div>
        </div>
    </div>
    <div class="col subtitle">
        <p>도전 항목을 등록합니다</p>
    </div>
    <div class="container list">
        <div class="col text-right"><span>삭제하기 &gt;</span></div>
        <div class="row">
            <div class="col"><span>시작날짜</span></div>
            <div class="col"><span>끝날짜</span></div>
        </div>
        <div class="row">
            <div class="col"><input type="date"></div>
            <div class="col"><input type="date"></div>
        </div>
        <div class="row">
            <div class="col-3"><span>제목</span></div>
            <div class="col"><input type="text"></div>
        </div>
        <div class="row">
            <div class="col-3"><span>내용</span></div>
            <div class="col"><textarea wrap="hard"></textarea></div>
        </div>
    </div>
    <div class="col text-right" style="padding: 0 40px;"><span>추가하기 &gt;</span></div>
    <div class="col d-flex justify-content-center" style="background: #e4e65e;margin-top: 10px;"><button class="btn btn-secondary" type="button">등록하기</button><button class="btn btn-secondary" type="button">다시쓰기</button><button class="btn btn-secondary" type="button">취소하기</button></div>
    <div class="col footer">
        <p class="text-right">작성자 : 관리자</p>
    </div>
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
</body>
