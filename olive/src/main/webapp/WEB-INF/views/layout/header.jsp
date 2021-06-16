<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="navbar fixed-top">
	<div class="container flex-center">
		<a href="${pageContext.request.contextPath}/" class="logo">OLIVE ALONE</a><img src="${pageContext.request.contextPath}/resources/img/mainLogo2.png" width="70px;" height="50px;">
		<nav class="nav-menu">
			<ul>
				<li class="dropdown">
					<a href="${pageContext.request.contextPath}/mate/main">meal</a>
					<ul>
                		<li><a href="${pageContext.request.contextPath}/mate/store">올리브의 동네맛집</a></li>
                		<li><a href="${pageContext.request.contextPath}/mate/list">올리브의 밥친구</a></li>
					</ul>
				</li>
				
				<li class="dropdown">
					<a href="#">life-info</a>
					<ul>
                		<li><a href="${pageContext.request.contextPath}/wisdom/treeLlist">올리브 나무</a></li>
                		<li><a href="${pageContext.request.contextPath}/wisdom/beanList">올리브 열매</a></li>
					</ul>
				</li>
				
				<li><a href="${pageContext.request.contextPath}/free/list">board</a></li>
				
				<li class="dropdown">
					<a href="#">saving</a>
					<ul>
                		<li><a href="${pageContext.request.contextPath}/auction/list">함께사는 올리브</a></li>
                		<li><a href="${pageContext.request.contextPath}/junggo/list">주고받는 올리브</a></li>
					</ul>
				</li>
				
				<li class="dropdown">
					<a href="#">medical</a>
					<ul>
                		<li><a href="${pageContext.request.contextPath}/medical/medicalMap">올리브네 응급실</a></li>
                		<li><a href="${pageContext.request.contextPath}/medical/list">올리브의 구급상자</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a href="#">real-estate</a>
					<ul>
                		<li><a href="${pageContext.request.contextPath}/house/info">올리브의 새 집</a></li>
                		<li><a href="${pageContext.request.contextPath}/house/every">올리브의 집문서</a></li>
                		<li><a href="${pageContext.request.contextPath}/house/bot">꿀팁 안내봇</a></li>
					</ul>
				</li>
				
                		<li><a href="${pageContext.request.contextPath}/helper/wallet">cash book</a></li>
                		<li><a href="${pageContext.request.contextPath}/helper/schedule">schedule</a></li>
				<li class="dropdown">
					<a href="#">olive</a>
					<ul>
                		<li><a href="${pageContext.request.contextPath}/mission/main">올리브의 도전</a></li>
                		<li><a href="${pageContext.request.contextPath}/presence/main">올리브의 발도장</a></li>
					</ul>
				</li>
								
				<li><a href="${pageContext.request.contextPath}/qna/list">QnA</a></li>						
				
				<c:choose>
					<c:when test="${empty sessionScope.member}">
						<li class="dropdown"><a href="#"><i class="fa fa-user" style="font-size: 25px;"></i></a>
							<ul>
								<li><a href="${pageContext.request.contextPath}/notice/list">공지사항</a></li>
								<li><a href="${pageContext.request.contextPath}/member/login">로그인</a></li>
								<li><a href="${pageContext.request.contextPath}/member/member">입주신청</a></li>
							</ul>
						</li>
					</c:when>
					<c:otherwise>
						<li class="dropdown"><a href="#"><i class="fa fa-user" style="font-size: 25px;"></i></a>
							<ul>
								<li><a href="${pageContext.request.contextPath}/notice/list">공지사항</a></li>
								<li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
								<li><a href="${pageContext.request.contextPath}/mypage/list">내 정보</a></li>
								<li><a href="${pageContext.request.contextPath}/note/receive/list">우체통</a></li>
								<c:if test="${sessionScope.member.userId=='admin'}">
									<li><a href="${pageContext.request.contextPath}/admin/main">관리실</a></li>
								</c:if>
							</ul>
						</li>
					</c:otherwise>
				</c:choose>
															
			</ul>
		</nav>
	</div>
</div>