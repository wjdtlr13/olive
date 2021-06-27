<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
@charset "UTF-8";

.admin-nav*:before, .admin-nav*:after{
  content: '';
  display: block;
  position: absolute;
}


ul {
  list-style: none;
}

.wrapper {
  display: flex;
  min-height: 100%;
}

.admin-nav {
  width: 230px;
  background: #404040;
}

.admin-nav a {
	color: #fff; text-decoration: none; cursor: pointer;
}
.admin-nav a:hover {
  color: #fff;
}

.admin-nav header {
  position: relative;
  height: 80px;
  padding: 20px 0 0 15px;
  font-size: 16px;
  color: #fff;
  background: #333;
}

.admin-nav header span {
  position: relative;
  display: inline-block;
  width: 36px;
  height: 36px;
  margin: 0 10px 0 0;
  vertical-align: middle;
  border: 1px solid #fff;
}

.admin-nav header span:before {
  content: '\ed05';
  font: normal 20px IcoFont;
  top: 7px;
  left: 9px;
}

.admin-nav header a:before {
  content: '\ef1d';
  font: normal 20px IcoFont;
  top: 28px;
  right: 15px;
}

.admin-nav ul span {
  display: block;
  padding: 15px;
  color: rgba(255,255,255,.5);
  text-transform: uppercase;
  border-bottom: 1px solid #333;
}

.admin-nav ul a {
  position: relative;
  display: block;
  padding: 15px 15px 17px 50px;
  color: #fff;
  border-bottom: 1px solid #333;
}

.admin-navv ul a:hover,
.admin-nav ul a.active {
  background: #535353;
}

.admin-nav ul a:before {
  font: normal 16px IcoFont;
  top: 15px;
  left: 18px;
}

.admin-nav ul li:nth-child(2) a:before { content: '\ef47'; }
.admin-nav ul li:nth-child(3) a:before { content: '\ed0a'; }
.admin-nav ul li:nth-child(4) a:before { content: '\effb'; }
.admin-nav ul li:nth-child(5) a:before { content: '\ecf4'; }
.admin-nav ul li:nth-child(6) a:before { content: '\ead2'; }
.admin-nav ul li:nth-child(7) a:before { content: '\f002'; }

.admin-nav ul li:nth-child(9) a:before { content: '\ed1b'; }
.admin-nav ul li:nth-child(10) a:before { content: '\efe1'; }
.admin-nav ul li:nth-child(11) a:before { content: '\f01b'; }


</style>
<script type="text/javascript">
// 메뉴 활성화
$(function() {
    var url = window.location.pathname;
    var urlRegExp = new RegExp(url.replace(/\/$/, '') + "$");  
    $('nav>ul>li a').each(function() {
  	  if (urlRegExp.test(this.href.replace(/\/$/, ''))) {
            $(this).addClass('active');
        }
    });
});
</script>
<div class="admin-nav">
<nav>
	<header>
		<span></span>
		관리자
		<a href="${pageContext.request.contextPath}/"></a>
	</header>

	<ul>
		<li><span>Navigation</span></li>
		<li><a href="${pageContext.request.contextPath}/admin">Home</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/memManage/memList">회원관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/memManage/blockList">신고회원관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/permit/mission">미션승인</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/permit/list">게시글승인</a></li>
		<li><a href="${pageContext.request.contextPath}/member/logout">Logout</a></li>
	</ul>
</nav>
</div>