<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/icofont/icofont.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tabs.css" type="text/css">
<style type="text/css">
.ui-dialog {
	z-index: 9999;
}

.ui-dialog * {
	box-sizing: content-box;
}

.ui-widget-header {
	background: none;
	border: none;
	height:35px;
	line-height:35px;
	border-bottom: 1px solid #ccc;
	border-radius: 0px;
}

.body-title {
	margin-top: 80px;
	margin-bottom: 30px;
}
.body-title h2{
	font-weight: 700;
}

.memo {
	width: 265px;
	white-space:nowrap;
	overflow:hidden;
	text-overflow:ellipsis;
	box-sizing: border-box;
	cursor: pointer;
}
.memo-detaile{
	white-space: pre;
}
.table-content tr {
	text-align: center;
}
.table-content tr:first-child {
	background: #eee;
}
.table-content tr > th {
	color: #777;
}
.table-content tr > td:nth-child(4) {
	box-sizing: border-box;
	padding-right: 10px;
	text-align: right;
}
.table-content tr > td:nth-child(5) {
	box-sizing: border-box;
	padding-left: 10px;
	text-align: left;
}

.link {
	cursor: pointer;
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
			location.href="${pageContext.request.contextPath}/wallet/"+menuItem+"/list";
		}
	});
});

function changeCategory() {
	searchList();
}

function searchList() {
	var f=document.searchForm;
	
	f.categoryNum.value = $("#categoryNum").val();
	
	if(f.startDate.value != "" || f.endDate.value != "") {
		if(! isValidDateFormat(f.startDate.value)) {
			f.startDate.focus();
			return;
		}
		
		if(! isValidDateFormat(f.endDate.value)) {
			f.endDate.focus();
			return;
		}
		
		if(diffDays(f.startDate.value, f.endDate.value) < 0) {
			alert("시작일은 종료일보다 클수 없습니다.");
			f.startDate.focus();
			return;
		}

		if(diffDays(f.endDate.value, dateToString(new Date())) < 0) {
			alert("종료일은 오늘보다 클수 없습니다.");
			f.endDate.focus();
			return;
		}
	}
	
	f.submit();
}

function updateWallet(num) {
	var url = "${pageContext.request.contextPath}/wallet/${menuItem}/update?num="+num+"&page=${page}";
	location.href=url;
}

function deleteWallet(num) {
	if(! confirm("삭제하시겠습니까 ?")) {
		return;
	}
	
	var url = "${pageContext.request.contextPath}/wallet/${menuItem}/delete?num="+num+"&page=${page}";
	location.href=url;	
}

$(function(){
	$("div.memo").click(function(){
		$('#memo-dialog').dialog({
			  modal: true,
			  minHeight: 100,
			  maxHeight: 550,
			  width: 450,
			  title: '상세정보',
			  close: function(event, ui) {
				   $(this).dialog("destroy");
			  }
		});
		$(".memo-detaile").html($(this).text());
	});
});

function setSearchDate(option, value) {
	var date = new Date();

	$("#endDate").val(dateToString(date));
	if(option=="day") {
		$("#startDate").val(dateToString(date));
	} else if(option=="week") {
		date.setDate(date.getDate()-7);
		$("#startDate").val(dateToString(date));
	} else if(option=="month") {
		date.setMonth(date.getMonth()-value);
		date.setDate(date.getDate()+1);
		$("#startDate").val(dateToString(date));
	} else if(option=="year") {
		date.setFullYear(date.getFullYear()-value);
		date.setDate(date.getDate()+1);
		$("#startDate").val(dateToString(date));
	}
}

// 날짜 형식 검사
function isValidDateFormat(data){
    var regexp = /[12][0-9]{3}[\.|\-|\/]?[0-9]{2}[\.|\-|\/]?[0-9]{2}/;
    if(! regexp.test(data))
        return false;

    regexp=/(\.)|(\-)|(\/)/g;
    data=data.replace(regexp, "");
    
	var y=parseInt(data.substr(0, 4));
    var m=parseInt(data.substr(4, 2));
    if(m<1||m>12) 
    	return false;
    var d=parseInt(data.substr(6));
    var lastDay = (new Date(y, m, 0)).getDate();
    if(d<1||d>lastDay)
    	return false;
		
	return true;     
}

// 날짜를 문자열로
function dateToString(date) {
    var y = date.getFullYear();
    var m = date.getMonth() + 1;
    if(m < 10) m='0'+m;
    var d = date.getDate();
    if(d < 10) d='0'+d;
    
    return y + '-' + m + '-' + d;
}

// 문자열을 날짜로
function stringToDate(value) {
	var format=/(\.)|(\-)|(\/)/g;
	value=value.replace(format, "");
    
    format = /[12][0-9]{3}[0-9]{2}[0-9]{2}/;
    if(! format.test(value))
        return "";
    
    var y = parseInt(value.substr(0, 4));
    var m = parseInt(value.substr(4, 2));
    var d = parseInt(value.substr(6, 2));
    
    return new Date(y, m-1, d);
}

// 두 날짜 사이의 일자 구하기
function diffDays(startDate, endDate) {
    var format=/(\.)|(\-)|(\/)/g;
    startDate=startDate.replace(format, "");
    endDate=endDate.replace(format, "");
    
    format = /[12][0-9]{3}[0-9]{2}[0-9]{2}/;
    if(! format.test(startDate))
        return "";
    if(! format.test(endDate))
        return "";
    
    var sy = parseInt(startDate.substr(0, 4));
    var sm = parseInt(startDate.substr(4, 2));
    var sd = parseInt(startDate.substr(6, 2));
    
    var ey = parseInt(endDate.substr(0, 4));
    var em = parseInt(endDate.substr(4, 2));
    var ed = parseInt(endDate.substr(6, 2));

    var fromDate=new Date(sy, sm-1, sd);
    var toDate=new Date(ey, em-1, ed);
    
    var sn=fromDate.getTime();
    var en=toDate.getTime();
    
    var diff=en-sn;
    var day=Math.floor(diff/(24*3600*1000));
    
    return day;
}

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
			<table class="table">
				<tr>
					<td width="70%" style="border-top: none;">
						<div class="col col-sm-3" style="padding-left: 0;">
							<select id="categoryNum" class="form-control"onchange="changeCategory()">
								<option value="0">분류별</option>
								<c:forEach var="vo" items="${listCategory}">
									<option value="${vo.categoryNum}" ${categoryNum==vo.categoryNum?"selected='selected'":""}>${vo.category}</option>
								</c:forEach>
							</select>
						</div>
				
					</td>
					<td align="right" style="border-top: none;">
						<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/wallet/${menuItem}/insert';" title="등록"><i class="icofont-plus"></i></button>
					</td>
				</tr>
			</table>
			
			<table class="table table-content">
				<tr> 
					<th width="130">날짜</th>
					<th width="180">분류</th>
					<th width="150">${menuItem=="expense"?"결제":"입금"}</th>
					<th width="180">금액</th>
					<th width="265">내용</th>
					<th>변경</th>
				</tr>
			 
				<c:forEach var="dto" items="${list}">
				<tr>
					<td>${dto.use_date}</td>
					<td>${dto.category}</td>
					<td>${dto.cash} ${dto.cash=="신용카드" ? (empty dto.installment ? " - 일시불": " - " += dto.installment) : ""}</td>
					<td>
						<fmt:formatNumber value="${dto.price}" pattern="#,##0"/> 원
					</td>
					<td>
						<div class="memo">${dto.memo}</div>
					</td>
					<td>
						<span class="link" title="수정" onclick="updateWallet('${dto.num}')"><i class="icofont-edit"></i></span>
						<span class="link" title="삭제" onclick="deleteWallet('${dto.num}')"><i class="icofont-bin"></i></span>
					</td>
				</tr>
				</c:forEach>
			</table>
			 
			<table class="table">
				<tr>
					<td align="center" style="border-top: none;">${dataCount==0?"등록된 내역이 없습니다.":paging}</td>
				</tr>
			</table>
			
			<table class="table">
				<tr>
					<td width="90%" style="border-top: none;">
						<form name="searchForm" action="${pageContext.request.contextPath}/wallet/${menuItem}/list" method="post">
						<div class="form-group form-row">
							<div class="col col-sm-5" style="padding-right: 5px;">
								<button type="button" class="btn" onclick="setSearchDate('day', 0);">오늘</button>
								<button type="button" class="btn" onclick="setSearchDate('week', 1);">1주일</button>
								<button type="button" class="btn" onclick="setSearchDate('month', 1);">1개월</button>
								<button type="button" class="btn" onclick="setSearchDate('month', 3);">3개월</button>
								<button type="button" class="btn" onclick="setSearchDate('month', 6);">6개월</button>
								<button type="button" class="btn" onclick="setSearchDate('year', 1);">1년</button>
							</div>
		      				<div class="col col-sm-2" style="padding-right: 5px;">
								<input type="date" name="startDate" id="startDate" class="boxTF" value="${startDate}">
							</div>
		      				<div class="col" style="padding: 0; width: 20px; flex-grow:0;">
								<p class="form-control-plaintext text-center" style="padding: 0; width: 20px; vertical-align: middle;">~</p>
							</div>
		      				<div class="col col-sm-2" style="padding-right: 5px;">
								<input type="date" name="endDate" id="endDate" class="boxTF" value="${endDate}">
								<input type="hidden" name="categoryNum" value="${categoryNum}">
							</div>
							<div class="col col-sm-2">
								<button type="button" class="btn" onclick="searchList()" title="검색"><i class="icofont-ui-search"></i></button>
							</div>
						</div>
						</form>
					</td>
					<td align="right" style="border-top: none;">
						<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/wallet/${menuItem}/list';" title="초기화"><i class="icofont-ui-reply"></i></button>
					</td>
				</tr>
			</table>
	
		</div>
	</div>
	
	<div id="memo-dialog" style="display: none;">
		<div class="memo-detaile"></div>
	</div>
	
</div>

