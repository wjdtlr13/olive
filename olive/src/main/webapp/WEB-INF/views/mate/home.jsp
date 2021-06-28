<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<head>
<script type="text/javascript">

</script>
</head>
 
   <div class="start" style="background: url('${pageContext.request.contextPath}/resources/img/mate/mates.jpg');width: 100vw;height: 100vh;background-size: cover;">
        <div class="text-center d-flex flex-column justify-content-center align-items-center" style="font-family: 'Gothic A1', sans-serif;background: rgba(0,0,0,0.38);width: 100vw;height: 100vh;">
            <p style="color: rgb(237,255,223);font-size: 3rem;">올리브의 동네맛집</p>
            <p style="color: rgb(170,205,93);font-size: 2rem;padding-bottom: 10px;"><strong>이젠 혼밥하지 마세요. 올리브 얼론이 도와드릴게요</strong></p>
            <div class="row" style="width: 50%;">
                <div class="col d-flex justify-content-around">
	                <button class="btn btn-success" onclick="location.href='${pageContext.request.contextPath}/mate/select'" type="button" style="font-size: 1.5rem;background: rgb(114,137,61);border-style: none;padding: 12px;border-radius: 12px;">등록하기</button>
	                <button class="btn btn-success" onclick="location.href='${pageContext.request.contextPath}/mate/registerList?mode=upcoming'" type="button" style="font-size: 1.5rem;background: rgb(114,137,61);border-style: none;padding: 12px;border-radius: 12px;">내 신청 보기</button>
                </div>
            </div>
        </div>
    </div>