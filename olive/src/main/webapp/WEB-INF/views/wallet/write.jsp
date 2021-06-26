<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/icofont/icofont.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tabs.css" type="text/css">
<style type="text/css">
.body-title {
	margin-top: 80px;
	margin-bottom: 30px;
}
.body-title h2{
	font-weight: 700;
}
.table-content tr > td:nth-child(1) {
	width: 100px;
	text-align: center;
	background: #eee;
}
.table-content tr > td:nth-child(2) {
	padding-left: 10px;
}
.table-content input[type=text], .table-content input[type=file], .table-content textarea {
	width: 97%;
}

</style>

<script type="text/javascript">
$(function(){
	$("#tab-${menuItem}").addClass("active");

	$("ul.tabs li").click(function() {
		var menuItem = $(this).attr("data-menuItem");
		
		if(menuItem=="stats") {
			location.href="${pageContext.request.contextPath}/wallet/stats";
		} else {
			location.href="${pageContext.request.contextPath}/wallet/"+menuItem+"/insert";
		}
	});
});

function sendOk() {
	var f = document.walletForm;

	if(! /^(\d{4}-\d{2}-\d{2})$/.test(f.use_date.value)) {
		alert("날짜를 입력하세요 !!!")
		f.use_date.focus();
	}
	
	if(! /^(\d+)$/.test(f.price.value)) {
		alert("금액을 입력하세요 !!!")
		f.price.focus();
	}
	
	f.action="${pageContext.request.contextPath}/wallet/${menuItem}/${mode}";
	f.submit();
}

$(function(){
	if($("select[name=cash]").val() != "신용카드") {
		$("select[name=installment]").hide();
	}
	
	$("select[name=cash]").change(function(){
		var s = $(this).val();
		if(s != "신용카드") {
			$("select[name=installment]").val("");
			$("select[name=installment]").hide();
			return false;
		}
		
		$("select[name=installment]").show();
	});
});
</script>

<div class="container body-container">
	<div class="body-title">
		<h2><i class="icofont-calculator"></i> 가계부 </h2>
	</div>
    
	<div class="body-main">
		<div>
			<ul class="tabs">
				<li id="tab-expense" data-menuItem="expense">지출</li>
				<li id="tab-income" data-menuItem="income">수입</li>
				<li id="tab-statistics" data-menuItem="stats">통계</li>
			</ul>
		</div>
		<div id="tab-content" style="padding: 15px 10px 5px; clear: both;">
		
			<form name="walletForm" method="post">
			<table class="table table-content">
				<tr>
					<td>입력종류</td>
					<td>
						${menuItem=="expense"?"지출":"수입"}
					</td>
				</tr>
				<tr>
					<td>날짜</td>
					<td>
						<div class="form-row">
							<div class="col col-sm-3">
								<input type="date" name="use_date" class="form-control" value="${empty now ? dto.use_date : now}">
							</div>
						</div>
					</td>
				</tr>				
				<tr>
					<td>${menuItem=="expense"?"결제":"입금"}</td>
					<td>
						<div class="form-row">
							<div class="col col-sm-3">
								<select name="cash" class="form-control">
									<option value="현금" ${dto.cash=="현금"?"selected='selected'":""}>현금</option>
									<option value="통장" ${dto.cash=="통장"?"selected='selected'":""}>통장</option>
									<c:if test="${menuItem=='expense'}">
										<option value="체크카드" ${dto.cash=="체크카드"?"selected='selected'":""}>체크카드</option>
										<option value="신용카드" ${dto.cash=="신용카드"?"selected='selected'":""}>신용카드</option>
									</c:if>
								</select>
							</div>
							<div class="col col-sm-3" style="padding-left: 5px;">
								<select name="installment" class="form-control">
									<option value="">일시불</option>
									<c:forEach var="i" begin="2" end="60">
										<option value="${i}개월" ${dto.installment==(i+="개월")?"selected='selected'":""}>${i} 개월</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</td>
				</tr>				
				<tr>				
					<td>분류</td>
					<td> 
						<div class="form-row">
							<div class="col col-sm-3">
								<select name="categoryNum" class="form-control">
									<c:forEach var="vo" items="${listCategory}">
										<option value="${vo.categoryNum}" ${dto.categoryNum==vo.categoryNum?"selected='selected'":""}>${vo.category}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</td>
				</tr>
			
				<tr> 
					<td>금액</td>
					<td> 
						<div class="form-row">
							<div class="col col-sm-3">
								<input type="text" name="price" class="form-control" value="${dto.price}">
							</div>
						</div>
					</td>
				</tr>
			
				<tr> 
					<td valign="top" style="border-bottom: 1px solid #dee2e6;">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
					<td valign="top" style="border-bottom: 1px solid #dee2e6;"> 
						<div class="form-row">
							<div class="col">
								<textarea name="memo" class="form-control" style="height: 50px;">${dto.memo}</textarea>
							</div>
						</div>
					</td>
				</tr>
			</table>
			
			<table class="table">
				<tr> 
					<td align="center" style="border-top: none;">
						<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button>
						<button type="reset" class="btn">다시입력</button>
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/wallet/${menuItem}/list';">${mode=='update'?'수정취소':'등록취소'}</button>
						<c:if test="${mode=='update'}">
							<input type="hidden" name="num" value="${dto.num}">
							<input type="hidden" name="page" value="${page}">
						</c:if>
					</td>
				</tr>
			</table>
			</form>
	
		</div>
	</div>
</div>

s