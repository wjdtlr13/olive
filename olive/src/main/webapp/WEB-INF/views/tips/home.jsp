<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
#homeImg{
	position : relative;
	width : 600px;
	height: 350px;
}
.btn{
	border : none;
	font-size: 22px;
	font-weight: 700;
	background: transparent;
}
.btn:hover {
	border : none;
	font-size: 17px;
	background: transparent;
} 

button.btn1 {
	position : fixed;
	transform : rotate(345deg);
	left : 22%;
	top : 50%;
}
button.btn2 {
	position : fixed;
    left : 62%;
	top : 55%;
    transform : rotate(25deg);
	
}
</style>
 


<div id="homeImg">
	<div style="background: url('${pageContext.request.contextPath}/resources/img/tips/tipshome.jpg');width: 100vw;height: 100vh;background-size: cover;">
		<div>
			<button class="btn btn1" onclick="location.href='${pageContext.request.contextPath}/tips/list'">서류작성꿀팁</button>
			<button class="btn btn2" onclick="location.href='${pageContext.request.contextPath}/tips/office'">내주변동사무소찾기</button>
		</div>
	</div>

</div>
	
