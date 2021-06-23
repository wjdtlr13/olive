<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div style="margin:200px;">
	<div>
		<button onclick="location.href='${pageContext.request.contextPath}/tips/list'">서류작성꿀팁</button>
		<button onclick="location.href='${pageContext.request.contextPath}/tips/office'">내주변동사무소찾기</button>
	</div>
</div>