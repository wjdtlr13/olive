<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style type="text/css">
.imgPreView {
	cursor: pointer;
	border: 1px solid #ccc;
	width: 45px;
	height: 45px;
	line-height: 45px;
	border-radius:45px;
	background: #eee;
	position: relative;
	z-index: 9999;
	background-repeat : no-repeat;
	background-size : cover;
	text-align: center;
	font-size: 13px;
	font-family: 나눔고딕
}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mission.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR">
<script type="text/javascript">
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
			error : function(jqXHR, textStatus, errorThrown) {
				if (jqXHR.status === 403) {
					login();
					return false;

				}

				console.log(jqXHR.responseText);
			}
		});
	};
	
	function ajaxFileFun(url, method, query, dataType, fn) {
		$.ajax({
			type:method,
			url:url,
			processData: false,  // file 전송시 필수. 서버로전송할 데이터를 쿼리문자열로 변환여부
			contentType: false,  // file 전송시 필수. 서버에전송할 데이터의 Content-Type. 기본:application/x-www-urlencoded
			data:query,
			dataType:dataType,
			success:function(data) {
				fn(data);
			},
			beforeSend:function(jqXHR) {
				jqXHR.setRequestHeader("AJAX", true);
			},
			error:function(jqXHR) {
				if(jqXHR.status===403) {
					login();
					return false;
				}
		    	
				console.log(jqXHR.responseText);
			}
		});
	}
	
	$(function() {
		mylistPage(1);
		listPage(1);
	});

	function listPage(page) {

		var url = "${pageContext.request.contextPath}/mission/list";
		var query = "pageNo=" + page;
		if ('${sessionScope.member.userId}' == 'admin')
			query += "&mode=admin";
		else
			query += "&mode=notmy";
		var fn = function(data) {

			printList(data);
		};

		ajaxFun(url, "get", query, "json", fn);
	};

	function mylistPage(page) {
		if ('${sessionScope.member.userId}' == 'admin')
			return;
		var url = "${pageContext.request.contextPath}/mission/list";
		var query = "pageNo=" + page + "&mode=my";
		var fn = function(data) {

			printList(data);
		};

		ajaxFun(url, "get", query, "json", fn);
	};

	function listContent(num, mode) {
		var url = "${pageContext.request.contextPath}/mission/listcontent";
		var query = "num=" + num + "&mode=" + mode;

		var fn = function(data) {
			printListContent(data);
		};

		ajaxFun(url, "get", query, "json", fn);
	}

	function printList(data) {
		var dest = "";
		if (data.mode == "my")
			dest = "#my-content";
		else
			dest = "#content";

		$(dest).empty();
		//var dataCount = data.dataCount;
		//var page = data.pageNo;
		//var totalPage = data.total_page;
		//pageNo = page;
		//total_page = totalPage;

		//if(page==1) {
		//	$(".my-content").empty();
		//}

		for (var idx = 0; idx < data.list.length; idx++) {
			var out = "";

			var num = data.list[idx].num;
			var subject = data.list[idx].subject;
			var startDate = data.list[idx].startDate;
			var endDate = data.list[idx].endDate;
			var attendee = data.list[idx].attendee;
			var likeCount = data.list[idx].likeCount;
			var content = data.list[idx].content;

			var formName = num + "missionForm";

			out += "<form name='missionForm'>";
			if ('${sessionScope.member.userId}' == 'admin') {
				out += "<div class='row control'><div class='col text-right status' style='padding-right: 20px;'><button class='btn update' type='button'>수정하기&gt;</button>";
				out += "<button class='btn delete' type='button' style='border-bottom-style: none;'>삭제하기&gt;</button></div></div>";
			} else if (data.mode == "notmy") {
				out += "<div class='row control'><div class='col text-right status' style='padding-right: 20px;'>";
				out += "<button class='btn attend' type='button'>참여하기&gt;</button></div></div>";
			}
			out += "<div class='row justify-content-between align-items-center row1'>";
			out += "<div class='col-auto'><p class='ft30' name='num'><strong>"
					+ num + "</strong></p></div>";
			out += "<div class='col-auto'><p class='ft30' name='subject'><strong>"
					+ subject + "</strong></p></div>";
			out += "<div class='col-auto'><span name='startDate'>" + startDate
					+ "</span> ~ <span name='endDate'>" + endDate
					+ "</span></div></div>";
			out += "<div class='row justify-content-end row2'>";
			out += "<div class='col-auto'><span><em>" + attendee
					+ "명이 함께하는 중</em><br></span></div>";
			out += "<div class='col-auto'><span><i class='fa fa-thumbs-o-up'></i>&nbsp;<em>"
					+ likeCount + "</em></span></div></div>";
			out += "<p class='title-detail' name='content'>" + content
					+ "</p><hr></form>";
			out += "<div id='con"+num+"' class='row row3'>";
			$(dest).append(out);

			listContent(num, data.mode);

			$(dest).append("</div>");
		}

	};

	function printListContent(data) {

		var out = "";
		for (var idx = 0; idx < data.list.length; idx++) {
			var accept = data.list[idx].accept;
			var contentNum = data.list[idx].contentNum;
			var subject = data.list[idx].subject;
			var startDate = data.list[idx].startDate;
			var endDate = data.list[idx].endDate;
			var attendDate = data.list[idx].attendDate;
			var content = data.list[idx].content;
			var missionNum = data.list[idx].missionNum;

			var dest = "#con" + missionNum;
			$(dest).empty();

			out += "<div class='col-12'><form name='contentForm'><div class='row justify-content-between'>";
			out += "<div class='col-auto d-flex align-items-center'>";
			out += "<p style='font-size: 25px;' name='contentNum'>"
					+ contentNum + "</p>]<p class='t1' name='subject'>"
					+ subject + "</p></div>";
			out += "<div class='col-auto'><span name='startDate'>" + startDate
					+ "</span> ~ <span name='endDate'>" + endDate
					+ "</span></div></div>";
			out += "<div class='row justify-content-between'><div class='col-auto'><p name='content'>"
					+ content + "</p></div>";
			out += "<div class='col-auto status'><p>";

			var today = new Date();
			var sDate = new Date(startDate);
			var eDate = new Date(endDate);
			var aDate = new Date(attendDate);
			if ('${sessionScope.member.userId}' == 'admin') {
				out += "<button class='btn update' type='button'>수정&gt;</button>";
				out += "<button class='btn delete' type='button' style='border-bottom-style: none;'>삭제&gt;</button>";
			} else if (data.mode == 'notmy') {

			} else if (today < sDate) {
				out += "예정된 도전";
			} else if (attendDate != "") {
				if (accept == 1)
					out += "<p>" + attendDate + " 달성!</p>";
				else if (today > eDate)
					out += "달성하지 못함";
				else
					out += '<button type="button" class="btn btnInsertForm" data-toggle="modal" data-target="#contentModal">도전 수정하기&gt;</button>';
			} else {
				if (today > eDate)
					out += "달성하지 못함";
				else
					out += '<button type="button" class="btn btnInsertForm" data-toggle="modal" data-target="#contentModal">지금 도전하기&gt;</button>';
			}

			out += "</p></div></div></div></form>";

		}
		if (data.list.length > 0)
			out += "<hr>";
		$(dest).append(out);
	}

	$(function() {

		$(document)
				.on(
						'click',
						'.update',
						function() {
							var form = $(this).closest('form');

							form
									.find('button.update')
									.replaceWith(
											"<button type='button' class='btn update-submit'>수정하기&gt;</button>"
													+ "<button type='button' class='btn update-cancel'>취소하기&gt;</button>");
							form.find('button.delete').remove();

							if (form.attr('name') == 'contentForm') {
								var num = form.find('p[name=contentNum]')
										.text();
								form
										.find('p[name=contentNum]')
										.replaceWith(
												"<input name='contentNum' readonly='readonly' value='"+num+"'>");
							} else {
								var num = form.find('p[name=num]').text();
								form
										.find('p[name=num]')
										.replaceWith(
												"<input name='num' readonly='readonly' value='"+num+"'>");
							}
							;
							var subject = form.find('p[name=subject]').text();
							form
									.find('p[name=subject]')
									.replaceWith(
											"<input name='subject' value='"+subject+"'>");

							var startDate = form.find('span[name=startDate]')
									.text();
							form
									.find('span[name=startDate]')
									.replaceWith(
											"<input type='date' name='startDate' value='"+startDate+"'>");

							var endDate = form.find('span[name=endDate]')
									.text();
							form
									.find('span[name=endDate]')
									.replaceWith(
											"<input type='date' name='endDate' value='"+endDate+"'>");

							var content = form.find('p[name=content]').text();
							form
									.find('p[name=content]')
									.replaceWith(
											"<textarea style='width:100%; border:1px solid silver; resize:none;' name='content'>"
													+ content + "</textarea>");

						});

		$(document).on('click', '.update-cancel', function() {
			listPage(1);
		});

		$(document)
				.on(
						'click',
						'.update-submit',
						function() {
							var url;

							var form = $(this).closest('form');
							var name = form.attr('name');
							if (name == 'missionForm') {
								url = "${pageContext.request.contextPath}/mission/updatemission";
							} else {
								url = "${pageContext.request.contextPath}/mission/updatecontent";

							}
							;

							console.log(url);
							var query = $(this).closest('form').serialize()
									+ "&userId=${sessionScope.member.userId}";
							console.log(query);
							var fn = function(data) {
								listPage(1)
							};

							ajaxFun(url, "post", query, "json", fn);
						});

	});

	$(function() {
		$(document)
				.on(
						'click',
						'.delete',
						function() {
							if (!confirm('도전과제를 삭제하시겠습니까?')) {
								return false;
							}

							var url;
							var num;
							var query;
							var form = $(this).closest('form');
							var name = form.attr('name');
							if (name == 'missionForm') {
								url = "${pageContext.request.contextPath}/mission/deletemission";
								num = form.find('p[name=num]').text();
								query = "num=" + num;
							} else {
								url = "${pageContext.request.contextPath}/mission/deletecontent";
								num = form.find('p[name=contentNum]').text();
								query = "contentNum=" + num;
							}
							;

							query += "&userId=${sessionScope.member.userId}";

							console.log(query);
							console.log(url);
							var fn = function(data) {
								listPage(1)
							};

							ajaxFun(url, "post", query, "json", fn);
						})
	});

	$(function() {
		$(document)
				.on(
						'click',
						'.attend',
						function() {
							if (!confirm('미션에 참여하시겠습니까?'))
								return false;

							var form = $(this).closest('form');
							console.log(form);
							var num = form.find('p[name=num]').text();
							console.log(num);
							var id = '${sessionScope.member.userId}';

							var url = '${pageContext.request.contextPath}/mission/insertattend';
							var query = 'num=' + num + '&userId=' + id;

							var fn = function(data) {
								alert(form.find('p[name=subject]').text()
										+ ' 미션에 참여하셨습니다!');
								listPage(1);
								mylistPage(1);
							};

							ajaxFun(url, "post", query, "json", fn);
						})
	});
</script>

<div class="header">
	<div class="col-12">
		<h1 class="text-center">
			<strong>올리브의 도전</strong>
		</h1>
	</div>
	<div class="col-12">
		<hr>
	</div>
	<div class="col-12">
		<h4 class="text-center">도전을 완료하고 포인트도 받아가세요</h4>
	</div>
</div>

<div class="container">
	<div class="col title">

		<div class="row">
			<div class="col-12">
				<c:choose>
					<c:when test="${sessionScope.member.userId!='admin'}">
						<p>
							<strong>${nickName }님께선 지금까지</strong>
						</p>
					</c:when>
					<c:otherwise>
						<p>
							<strong>${nickName } 관리자님 환영합니다.</strong>
						</p>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<c:if test="${sessionScope.member.userId!='admin'}">
			<div class="row">
				<div class="col-12">
					<p>
						<strong>${myComplete }개의 도전과제를 완수하셨어요!</strong>
					</p>
				</div>
			</div>
			<div class="row">
				<div class="col-12 link">
					<a href="#">보러가기&gt;</a>
				</div>
				<hr>
			</div>
		</c:if>
	</div>

	<c:if test="${sessionScope.member.userId!='admin'}">
		<div id="my-subtitle" class="col subtitle">
			<p>
				<strong>${nickName}님의 도전과제</strong>
			</p>
		</div>
		<div id="my-content" class="col content"></div>
	</c:if>

	<c:if test="${sessionScope.member.userId=='admin'}">
		<div class="row">
			<div class="col-12 text-right">
				<button type="button" class="btn" data-toggle="modal"
					data-target="#myModal">등록하기 ></button>
			</div>
			<hr>
		</div>
	</c:if>

	<div id="subtitle" class="col subtitle">
		<p>
			<strong>현재 참여할 수 있는 도전과제</strong>
		</p>
	</div>
	<div id="content" class="col content"></div>
</div>


<c:if test="${sessionScope.member.userId=='admin'}">
	<div id="myModal" class="modal fade" role="dialog" tabindex="-1">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header flex-column">
					<div class="col header">
						<div></div>
					</div>
					<div class="col mtitle">
						<p>
							<strong>도전 과제를 등록합니다</strong>
						</p>
					</div>
				</div>
				<div class="modal-body">
					<form id="modal-missionForm" method="post">
						<div class="row">
							<div class="col">
								<span>시작날짜</span>
							</div>
							<div class="col">
								<span>끝날짜</span>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<input type="date" name="startDate">
							</div>
							<div class="col">
								<input type="date" name="endDate">
							</div>
						</div>
						<div class="row">
							<div class="col-3">
								<span>제목</span>
							</div>
							<div class="col">
								<input type="text" name="subject">
							</div>
						</div>
						<div class="row">
							<div class="col-3">
								<span>내용</span>
							</div>
							<div class="col">
								<textarea wrap="hard" name="content"></textarea>
							</div>
						</div>
						<input type="hidden" name="userId"
							value="${sessionScope.member.userId }">
					</form>
					<section class="stitle">
						<p>
							<strong>도전 항목을 등록합니다</strong>
						</p>
					</section>
					<form id="modal-contentForm">
						<div id="content-end"></div>
						<input type="hidden" name="userId"
							value="${sessionScope.member.userId }">
					</form>
					<div class="col text-right">
						<button class="btn content-add">추가하기 &gt;</button>
					</div>
				</div>
				<div class="modal-footer flex-column">
					<div class="col d-flex justify-content-center">
						<button id="modal-submit" class="btn btn-secondary" type="button">등록하기</button>
						<button class="btn btn-secondary" class="close"
							data-dismiss="modal" aria-label="Close">취소하기</button>
					</div>
					<div class="col footer">
						<p class="text-right">작성자 : ${sessionScope.member.nickName }</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:if>
<c:if test="${sessionScope.member.userId!='admin'}">
	<div id="contentModal" class="modal fade writer" role="dialog" tabindex="-1">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<form name="photoForm" method="post" enctype="multipart/form-data">
					<div class="modal-header">
						<h4 class="modal-title">도전 항목 참여하기</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body">
						<table class="table table-border table-content">
							
							<tr>
								<td valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
								<td valign="top"><textarea name="content" class="boxTA"></textarea>
								</td>
							</tr>

							<tr>
								<td>이미지</td>
								<td>
									<div class="imgPreView"></div> <input type="file" name="upload"
									class="boxTF" accept="image/*" style="display: none;">
								</td>
							</tr>

						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-dark btnSendOk">등록완료</button>
						<button type="reset" class="btn">다시입력</button>
						<button type="button" class="btn btnSendCancel">등록취소</button>

						<input type="hidden" name="mode">
						 <input type="hidden" name="contentNum" value="0"> 
						 <input type="hidden" name="imageFileName">
					</div>
				</form>
			</div>
		</div>
	</div>
</c:if>
<script>
	$(function() {
		$(document).on('click', '.content-remove', function() {
			var list = $(this).closest('.content-list');
			list.empty();
			list.remove();
		});

		$(document)
				.on(
						'click',
						'.content-add',
						function() {
							var form = '<div class="content-list">';
							form += '<div class="col text-right"><button class="btn content-remove">삭제하기 &gt;</button></div>';
							form += '<div class="row"><div class="col"><span>시작날짜</span></div>';
							form += '<div class="col"><span>끝날짜</span></div></div>';
							form += '<div class="row"><div class="col"><input type="date" name="startDate"></div>';
							form += '<div class="col"><input type="date" name="endDate"></div></div>';
							form += '<div class="row"><div class="col-3"><span>제목</span></div>';
							form += '<div class="col"><input type="text" name="subject"></div></div>';
							form += '<div class="row"><div class="col-3"><span>내용</span></div>';
							form += '<div class="col"><textarea wrap="hard" name="content"></textarea></div></div></div>';

							$('#content-end').append(form);
						});

		$('#modal-submit')
				.click(
						function() {
							var url = "${pageContext.request.contextPath}/mission/insertmission";
							var query = $('#modal-missionForm').serialize();
							var fn = function(data) {
								$('#modal-missionForm').find('input').val('');
								$('#modal-missionForm').find('textarea')
										.val('');
								var num = data.num;
								insertContent(num);
							}

							ajaxFun(url, "post", query, "json", fn);

						});

	});

	function insertContent(num) {
		var url = "${pageContext.request.contextPath}/mission/insertcontent";
		var query = $('#modal-contentForm').serialize();
		var subject = $('#modal-contentForm').find('input[name="subject"]').eq(0);
		if (subject.length == 0) {
			$('#myModal').modal("hide");
			mylistPage(1);
			listPage(1);
		}
		;
		query += "&missionNum=" + num;
		console.log(query);

		var fn = function(data) {
			$('.content-list').empty();
			$('.content-list').remove();
			$('#myModal').modal("hide");
			mylistPage(1);
			listPage(1);

		}

		ajaxFun(url, "post", query, "json", fn);
	}
	
	//이미지 불러오기
	
	$(function(){
		// 글쓰기폼-등록 완료 버튼
		$(".btnSendOk").click(function(){
			var f = document.photoForm;
			
			if(! f.content.value) {
				f.content.focus();
				return false;
			}
			
			var mode = f.mode.value;
			if(mode=="insert" && ! f.upload.value) {
				f.upload.focus();
				return false;
			}
			
			var url="${pageContext.request.contextPath}/mission/"+mode+"contentattend";
			console.log(url);
			var query = new FormData(f);// IE는 10이상에서만 가능
			console.log(query);
			var fn = function(data){
				var state=data.state;
		    	
				if(mode=="insert") {
					$('#contentModal').modal('hide');
					//mylistPage(1);
				} 
				/*else {
					var page = $(".list-body").attr("data-pageNo");
					listPage(page);
				} 
				
				$(".list").show(100);
				$(".writer").hide(100);
				*/
			};
			
			ajaxFileFun(url, "post", query, "json", fn);		
		});

		// 글쓰기폼-등록 취소 버튼
		$(".btnSendCancel").click(function(){
			$('#contentModal').modal('hide');
			
			/*$(".list").show(100);
			$(".writer").hide(100);*/
		});
	});
	
	$(function(){
	
		// 리스트-글 등록하기 버튼
		$(document).on('click', ".btnInsertForm", function(){
			$(".writer .imgPreView").css("background-image", "none");
			$(".writer .imgPreView").html("<div class='icofont-camera-alt'>에이</div>");
			$("form[name=photoForm] .btnSendOk").text("등록완료");
			$("form[name=photoForm] .btnSendCancel").text("등록취소");
			var num = $(this).closest('form').find('p[name=contentNum]').text();
			
			// 폼 초기화
			// $("form[name=photoForm]")[0].reset();
			$("form[name=photoForm]").each(function(){
				this.reset();
			});
			
			$("form[name=photoForm] input[name=mode]").val("insert");
			//$("form[name=photoForm] textarea[name=content]").val(content);
			$("form[name=photoForm] input[name=contentNum]").val(num);
			$("form[name=photoForm] input[name=imageFileName]").val(imageFileName);
			//$(".list").hide(100);
			//$(".writer").show(100);
		});
		
		// 리스트-글보기
		$("body").on("click", ".list-body .item", function(){
			var num = $(this).attr("data-num");
			var url = "${pageContext.request.contextPath}/photo/article";
			var query = "num="+num;
			var params = $('form[name=searchForm]').serialize();
			query = query + "&" + params;
			
			var fn = function(data){
				//printArticle(data);
			};
			ajaxFun(url, "get", query, "json", fn);
			
		
		});
		
		function printArticle(data) {
			if(data.state == "false") {
				alert("삭제된 게시물입니다.");
				return;
			}
			
			$(".list").hide(100);
			$(".article").show(100);
			
			var uid = data.uid;
			
			var num = data.dto.num;
			var userName = data.dto.userName;
			var subject = data.dto.subject;
			var content = data.dto.content;
			var imageFileName = data.dto.imageFileName;
			var created = data.dto.created;
			
			$(".article .subject").html(subject);
			$(".article .name").html(userName);
			$(".article .created").html(created);
			$(".article .content").html(content);
			var src = "${pageContext.request.contextPath}/uploads/photo/"+imageFileName;
			$(".article .img").attr("src",src);		
			
			$("form[name=photoForm]")[0].reset();
			$(".article .btnUpdateForm").prop("disabled", false);
			$(".article .btnDelete").attr("disabled", false);
			//$(".writer .imgPreView").css("background-image", "none");
			if(uid=="writer") {
				// 등록한 사람
				$(".article .btnUpdateForm").attr("data-num", num);
				$(".article .btnDelete").attr("data-num", num);
				$(".article .btnDelete").attr("data-imageFileName", imageFileName);
				
				$("form[name=photoForm] input[name=subject]").val(subject);
				$("form[name=photoForm] textarea[name=content]").val(content);
				$("form[name=photoForm] input[name=num]").val(num);
				$("form[name=photoForm] input[name=imageFileName]").val(imageFileName);
				$("form[name=photoForm] input[name=mode]").val("update");
				
				$(".writer .imgPreView").empty();
				$(".writer .imgPreView").css("background-image", "url("+src+")");
				
				$("form[name=photoForm] .btnSendOk").text("수정완료");
				$("form[name=photoForm] .btnSendCancel").text("수정취소");
				
			} else if(uid=="guest"){
				// 게스트
				$(".article .btnUpdateForm").prop("disabled", true);
				$(".article .btnDelete").attr("disabled", true);
			} else {
				// 관리자
				$(".article .btnUpdateForm").prop("disabled", true);
				$(".article .btnDelete").attr("data-num", num);
				$(".article .btnDelete").attr("data-imageFileName", imageFileName);
			}
		}
	});
	
	// 글보기-글삭제
	$(".btnDelete").click(function(){
		if(! confirm("게시글을 삭제하시 겠습니까 ?")) {
			return false;
		}
		
		var num = $(this).attr("data-num");
		var imageFileName = $(this).attr("data-imageFileName");		
		var url = "${pageContext.request.contextPath}/photo/delete";
		var query = "num="+num+"&imageFileName="+imageFileName;

		var fn = function(data){
			var page = $(".list-body").attr("data-pageNo");
			listPage(page);
			$(".list").show(100);
			$(".article").hide(100);
		};
		ajaxFun(url, "post", query, "json", fn);
	});

$(function(){
	$(".writer .imgPreView").click(function(){
		$("form[name=photoForm] input[name=upload]").trigger("click"); 
	});
	
	$("form[name=photoForm] input[name=upload]").change(function(){
		var file=this.files[0];
		if(! file.type.match("image.*")) {
			this.focus();
			return false;
		}
		
		var reader = new FileReader();
		reader.onload = function(e) {
			$(".writer .imgPreView").empty();
			$(".writer .imgPreView").css("background-image", "url("+e.target.result+")");
		}
		reader.readAsDataURL(file);
	});
});

$(function(){
	
})
</script>