<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
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

.statistics-area ul {
	list-style: none;
	float: left;
	border: 1px solid #ccc;
	width: 350px;
}

.statistics-area ul:first-child {
	margin-right: 30px;
}

.statistics-area ul li {
	padding: 10px 10px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.statistics-area ul li:first-child {
	background: #e4e4e4;
	border-bottom: 1px solid #ccc;
}

.statistics-area ul li:last-child {
	border-top: 1px solid #ccc;
}

.statistics-area ul li:nth-child(3) {
	padding: 0 10px 0;
}

.statistics-area .title {
	font-weight: 700;
}

.statistics-area .left-title {
	font-weight: 700;
}

.statistics-area .item {
	width: 80px;
}

.statistics-area .sub-item {
	width: 80px;
	font-size: 12px;
	text-align: right;
	padding-right: 7px;
	box-sizing: border-box;
}

.statistics-area .income-price span {
	color: #0100FF;
}

.statistics-area .axpense-price span {
	color: #FF5E00;
}

.link {
	cursor: pointer;
}

.link:hover {
	color: tomato;
}
</style>

<script type="text/javascript">
	$(function() {
		$("#tab-${menuItem}").addClass("active");

		$("ul.tabs li")
				.click(
						function() {
							var menuItem = $(this).attr("data-menuItem");

							if (menuItem == "stats") {
								location.href = "${pageContext.request.contextPath}/wallet/stats";
							} else {
								location.href = "${pageContext.request.contextPath}/wallet/"
										+ menuItem + "/list";
							}
						});
	});

	function login() {
		location.href = "${pageContext.request.contextPath}/member/login";
	}

	function ajaxFun(url, method, query, dataType, fn) {
		$.ajax({
			type : method,
			url : url,
			data : query,
			dataType : dataType,
			success : function(data) {
				fn(data);
			},
			beforeSend : function(jqXHR) {
				jqXHR.setRequestHeader("AJAX", true);
			},
			error : function(jqXHR) {
				if (jqXHR.status === 403) {
					login();
					return false;
				}

				console.log(jqXHR.responseText);
			}
		});
	}

	$(function() {
		$(".change-month").click(function() {
			var year = $(this).attr("data-year");
			var month = $(this).attr("data-month");
			var $ul = $(this).closest("ul");

			var query = "year=" + year + "&month=" + month;
			var url = "${pageContext.request.contextPath}/wallet/statsMonth";
			var fn = function(data) {
				printMonth(data, $ul);
			};
			ajaxFun(url, "get", query, "json", fn);
		});

		function printMonth(data, $ul) {
			var year = data.year;
			var month = data.month;
			var monthTitle = data.monthTitle;

			// 수입
			var monthIncome = 0;
			if (data.monthIncome)
				monthIncome = data.monthIncome.price;
			monthIncome = numberWithCommas(monthIncome);

			// 지출
			var monthAxpense = 0;
			if (data.monthAxpense)
				monthAxpense = data.monthAxpense.price;
			monthAxpense = numberWithCommas(monthAxpense);

			var cash_price = 0;
			if (data.monthAxpense)
				cash_price = data.monthAxpense.cash_price;
			cash_price = numberWithCommas(cash_price);

			var card_price = 0;
			if (data.monthAxpense)
				card_price = data.monthAxpense.card_price;
			card_price = numberWithCommas(card_price);

			$ul.find("span.title").html(monthTitle);
			$ul.find("span.previous").attr("data-year", year);
			$ul.find("span.previous").attr("data-month", month - 1);
			$ul.find("span.next").attr("data-year", year);
			$ul.find("span.next").attr("data-month", month + 1);

			$ul.find("div.axpense-price span").html(monthAxpense);
			$ul.find("div.axpense-cash-price span").html(cash_price);
			$ul.find("div.axpense-card-price span").html(card_price);
			$ul.find("div.income-price span").html(monthIncome);
		}

		$(".change-day").click(function() {
			var year = $(this).attr("data-year");
			var month = $(this).attr("data-month");
			var day = $(this).attr("data-day");
			var $ul = $(this).closest("ul");

			var query = "year=" + year + "&month=" + month + "&day=" + day;
			var url = "${pageContext.request.contextPath}/wallet/statsDay";

			var fn = function(data) {
				printDay(data, $ul);
			};
			ajaxFun(url, "get", query, "json", fn);
		});

		function printDay(data, $ul) {
			var year = data.year;
			var month = data.month;
			var day = data.day;
			var dayTitle = data.dayTitle;

			var dayIncome = 0;
			if (data.dayIncome)
				dayIncome = data.dayIncome.price;
			dayIncome = numberWithCommas(dayIncome);

			var dayAxpense = 0;
			if (data.dayAxpense)
				dayAxpense = data.dayAxpense.price;
			dayAxpense = numberWithCommas(dayAxpense);

			var cash_price = 0;
			if (data.dayAxpense)
				cash_price = data.dayAxpense.cash_price;
			cash_price = numberWithCommas(cash_price);

			var card_price = 0;
			if (data.dayAxpense)
				card_price = data.dayAxpense.card_price;
			card_price = numberWithCommas(card_price);

			$ul.find("span.title").html(dayTitle);
			$ul.find("span.previous").attr("data-year", year);
			$ul.find("span.previous").attr("data-month", month);
			$ul.find("span.previous").attr("data-day", day - 1);
			$ul.find("span.next").attr("data-year", year);
			$ul.find("span.next").attr("data-month", month);
			$ul.find("span.next").attr("data-day", day + 1);

			$ul.find("div.axpense-price span").html(dayAxpense);
			$ul.find("div.axpense-cash-price span").html(cash_price);
			$ul.find("div.axpense-card-price span").html(card_price);
			$ul.find("div.income-price span").html(dayIncome);
		}
	});

	// 3자리마다 , 삽입
	function numberWithCommas(n) {
		var parts = n.toString().split(".");
		parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return parts.join(".");
	}
</script>

<div class="container body-container">
	<div class="body-title">
		<h2>
			<i class="icofont-calculator"></i> 가계부
		</h2>
	</div>

	<div class="body-main">
		<div>
			<ul class="tabs">
				<li id="tab-expense" data-menuItem="expense">지출</li>
				<li id="tab-income" data-menuItem="income">수입</li>
				<li id="tab-statistics" data-menuItem="stats">통계</li>
			</ul>
		</div>
		<div id="tab-content" style="padding: 25px 10px 5px; clear: both;">
			<div class="statistics-area">
				<ul>
					<li>
						<div class="left-title">월별</div>
						<div>
							<span class="change-month link previous" data-year="${year}"
								data-month="${month-1}"><i class="icofont-simple-left"></i></span>
							<span class="title">${monthTitle}</span> <span
								class="change-month link next" data-year="${year}"
								data-month="${month+1}"><i class="icofont-simple-right"></i></span>
						</div>
						<div class="change-month link thismonth" data-year="${year}"
							data-month="${month}">이달</div>
					</li>
					<li>
						<div class="item">이달의 지출</div>
						<div class="axpense-price">
							<span><fmt:formatNumber
									value="${empty monthAxpense ? 0 : monthAxpense.price}"
									pattern="#,##0" /></span> 원
						</div>
					</li>
					<li>
						<div class="sub-item">현금/통장</div>
						<div class="axpense-cash-price">
							<span><fmt:formatNumber
									value="${empty monthAxpense ? 0 : monthAxpense.cash_price}"
									pattern="#,##0" /></span> 원
						</div>
					</li>
					<li>
						<div class="sub-item">신용카드</div>
						<div class="axpense-card-price">
							<span><fmt:formatNumber
									value="${empty monthAxpense ? 0 : monthAxpense.card_price}"
									pattern="#,##0" /></span> 원
						</div>
					</li>
					<li>
						<div class="item">이달의 수입</div>
						<div class="income-price">
							<span><fmt:formatNumber
									value="${empty monthIncome ? 0 : monthIncome.price}"
									pattern="#,##0" /></span> 원
						</div>
					</li>
				</ul>
				<ul>
					<li>
						<div class="left-title">일별</div>
						<div>
							<span class="change-day link previous" data-year="${year}"
								data-month="${month}" data-day="${day-1}"><i
								class="icofont-simple-left"></i></span> <span class="title">${dayTitle}</span>
							<span class="change-day link next" data-year="${year}"
								data-month="${month}" data-day="${day+1}"><i
								class="icofont-simple-right"></i></span>
						</div>
						<div class="change-day link today" data-year="${year}"
							data-month="${month}" data-day="${day}">오늘</div>
					</li>
					<li>
						<div class="item">오늘의 지출</div>
						<div class="axpense-price">
							<span><fmt:formatNumber
									value="${empty dayAxpense ? 0 : dayAxpense.price}"
									pattern="#,##0" /></span> 원
						</div>
					</li>
					<li>
						<div class="sub-item">현금/통장</div>
						<div class="axpense-cash-price">
							<span><fmt:formatNumber
									value="${empty dayAxpense ? 0 : dayAxpense.cash_price}"
									pattern="#,##0" /></span> 원
						</div>
					</li>
					<li>
						<div class="sub-item">신용카드</div>
						<div class="axpense-card-price">
							<span><fmt:formatNumber
									value="${empty dayAxpense ? 0 : dayAxpense.card_price}"
									pattern="#,##0" /></span> 원
						</div>
					</li>
					<li>
						<div class="item">오늘의 수입</div>
						<div class="income-price">
							<span><fmt:formatNumber
									value="${empty dayIncome ? 0 : dayIncome.price}"
									pattern="#,##0" /></span> 원
						</div>
					</li>
				</ul>
			</div>
			<div class="clear"></div>
		</div>
	</div>


</div>

