<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/icofont/icofont.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/ui-css.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tabs.css" type="text/css">
<style type="text/css">
.help-block {
	padding: 5px 0;
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

.forms-receiver-name {
	display: inline-block;
}
.receiver-user {
	vertical-align: middle;
	display: inline-block;
	padding: 5px;
	border: 1px solid #002e5b;
	border-radius: 3px;
	color: #0d58ba;
	margin-right: 3px;
}

.dialog-header {
	padding: 5px 0;
}
.dialog-receiver-list {
	padding: 5px;
	border: 1px solid #ccc;
	overflow-y: scroll;
	width: 95%;
	height: 220px;
	margin: 5px 0;
}
.dialog-receiver-list ul, .dialog-receiver-list li{
	list-style: none;
	padding: 0;
}
.dialog-footer {
	text-align: right;
	padding: 5px 0;
}
</style>

<script type="text/javascript">
$(function(){
	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");

		if(tab=="send") {
			return false;
		}

		var url = "${pageContext.request.contextPath}/note/receive/list";
		location.href=url;
	});
});

function sendOk() {
	var f = document.noteForm;

	if($("#forms-receiver-list input[name=receivers]").length==0) {
		alert("받는 사람을 추가하세요. ");
		return;
	}

	str = f.content.value;
	if(!str) {
		alert("내용을 입력하세요. ");
		f.content.focus();
		return;
	}

	f.action="${pageContext.request.contextPath}/note/write";

	f.submit();
}

function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}

function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
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

$(function(){
	$(".btnReceiverDialog").click(function(){
		$("#condition").val("userName");
		$("#keyword").val("");
		$(".dialog-receiver-list ul").empty();
		
		$("#receiver-dialog").dialog({
			  modal: true,
			  height: 450,
			  width: 380,
			  title: '받는사람',
			  close: function(event, ui) {
			  }
		});
	});
	
	// 대화상자 - 받는사람 검색 버튼
	$(".btnReceiverFind").click(function(){
		var condition = $("#condition").val();
		var keyword = $("#keyword").val();
		if(! keyword) {
			$("#keyword").focus();
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/note/listFriend"; 
		var query = "condition="+condition+"&keyword="+encodeURIComponent(keyword);
		
		var fn = function(data){
			$(".dialog-receiver-list ul").empty();
			searchListFriend(data);
		};
		ajaxFun(url, "get", query, "json", fn);
	});
	
	function searchListFriend(data) {
		var s;
		for(var i=0; i<data.listFriend.length; i++) {
			var userId = data.listFriend[i].userId;
			var userName = data.listFriend[i].userName;
			
			s = "<li><input type='checkbox' data-userId='"+userId+"' title='"+userId+"'><span>"+userName+"</span></li>";
			$(".dialog-receiver-list ul").append(s);
		}
	}
	
	// 대화상자-받는 사람 추가 버튼
	$(".btnAdd").click(function(){
		var len1 = $(".dialog-receiver-list ul input[type=checkbox]:checked").length;
		var len2 = $("#forms-receiver-list input[name=receivers]").length;
		
		if(len1 == 0) {
			alert("추가할 사람을 먼저 선택하세요.");
			return false;			
		}
		
		if(len1 + len2 >= 5) {
			alert("받는사람은 최대 5명까지만 가능합니다.");
			return false;
		}
		
		var b, userId, userName, s;

		b = false;
		$(".dialog-receiver-list ul input[type=checkbox]:checked").each(function(){
			userId = $(this).attr("data-userId");
			userName = $(this).next("span").text();
			
			$("#forms-receiver-list input[name=receivers]").each(function(){
				if($(this).val() == userId) {
					b = true;
					return false;
				}
			});
			
			if(! b) {
				s = "<span class='receiver-user'>"+userName+" <i class='icofont-bin' data-userId='"+userId+"'></i></span>";
				$(".forms-receiver-name").append(s);
				
				s = "<input type='hidden' name='receivers' value='"+userId+"'>";
				$("#forms-receiver-list").append(s);
			}
		});
		
		$('#receiver-dialog').dialog("close");
	});
	
	$(".btnClose").click(function(){
		$('#receiver-dialog').dialog("close");
	});
	
	$("body").on("click", ".icofont-bin", function(){
		var userId = $(this).attr("data-userId");
		
		$(this).parent().remove();
		$("#forms-receiver-list input[name=receivers]").each(function(){
			var receiver = $(this).val();
			if(userId == receiver) {
				$(this).remove();
				return false;
			}
		});
		
	});

});

</script>

<div class="container body-container">
    <div class="body-title">
		<h2><i class="icofont-ui-messaging"></i> 쪽지함 </h2>
    </div>
    
    <div class="body-main wx-800 ml-30 pt-15">
		<div>
			<ul class="tabs">
				<li id="tab-receive" data-tab="receive">받은 쪽지함</li>
				<li id="tab-send" data-tab="send" class="active">보낸 쪽지함</li>
			</ul>
		</div>
		<div id="tab-content" style="clear:both; padding: 20px 10px 0;">
		
			<form name="noteForm" method="post">
			<table class="table table-border table-content">
				<tr> 
					<td>받는사람</td>
					<td> 
						<div>
							<button type="button" class="btn btnReceiverDialog">추가</button>
							<div class="forms-receiver-name"></div>
						</div>
						<p class="help-block">
							한번에 보낼수 있는 최대 인원은 5명입니다.
						</p>
					</td>
				</tr>
				
				<tr> 
					<td valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
					<td valign="top"> 
						<textarea name="content" class="boxTA">${dto.content}</textarea>
					</td>
				</tr>
				  
			</table>
				
			<table class="table">
				<tr> 
					<td align="center">
						<button type="button" class="btn btn-dark" onclick="sendOk();">보내기</button>
						<button type="reset" class="btn">다시입력</button>
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/note/send/list';">취소</button>
						<div id="forms-receiver-list"></div>
					</td>
				</tr>
			</table>
			</form>
		</div>
	</div>
	
	<div id="receiver-dialog" style="display: none;">
		<div class="dialog-header">
			<select name="condition" id="condition" class="selectField">
				<option value="userName">이름</option>
				<option value="userId">아이디</option>
			</select>
			<input type="text" name="keyword" id="keyword" class="boxTF" style="width: 150px;">
			<button type="button" class="btn btnReceiverFind"> <i class="icofont-search-user"></i> </button>
		</div>
		<div class="dialog-receiver-list">
			<ul></ul>
		</div>
		<div class="dialog-footer">
			<button type="button" class="btn btnAdd">추가</button>
			<button type="button" class="btn btnClose">종료</button>
		</div>
	</div>
    
</div>