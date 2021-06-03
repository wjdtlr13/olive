<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="body-container">
	<div style="margin: 0 auto; padding-top: 90px; width: 420px;">
		<div style="text-align: center;">
			<span style="font-weight: bold; font-size:27px; color: #424951;">${title}</span>
        </div>
        
        <div class="messageBox">
            <div style="line-height: 150%; padding-top: 35px;">
				${message}            
            </div>
            <div style="margin-top: 20px;">
				<button type="button" onclick="javascript:location.href='${pageContext.request.contextPath}/';" class="btnConfirm">메인화면으로 이동</button>
			</div>
        </div>
     </div>
</div>