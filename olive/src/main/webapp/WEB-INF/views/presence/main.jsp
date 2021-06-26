<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/presence.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR">
<style type="text/css">
.container {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>
<script type="text/javascript">
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
		error:function(jqXHR, textStatus, errorThrown) {
			if(jqXHR.status===403) {
				login();
				return false;
				
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
};

$(function(){
	listPage(1);
	if("${myLatest}"=="") {
		$(".right").find("p").eq(0).hide();
	}
	if("${myToday}"=="1") {
		$(".right").prepend("<p>오늘 이미 출석하셨군요!</p>");
		$(".create").hide();
	}
});


function listPage(page) {
	var url="${pageContext.request.contextPath}/presence/list";
	var query="pageNo="+page;
	
	var fn = function(data){
		printList(data);
	};
	
	ajaxFun(url, "get", query, "json", fn);
};

function printList(data) {
	var dataCount = data.dataCount;
	var page = data.pageNo;
	var totalPage = data.total_page;
	var paging = data.paging;
	
	$(".list").empty();
	
	var out="";
	if(dataCount==0) {
		out+="<div class='col content'><div class='col col2'><p>등록된 자료가 없습니다.</p></div></div>";
		
		$(".list").html(out);
		return;
	}
	
	/*if(page == 1) {
		$("#list").empty();
	}
	*/
	for(var idx=0; idx<data.list.length; idx++) {
		var num=data.list[idx].num;
		var userId=data.list[idx].userId;
		var nickName=data.list[idx].nickName;
		var content=data.list[idx].content;
		var created=data.list[idx].created;
		var hidden=data.list[idx].hidden;
		var continuous=data.list[idx].continuous;
		var pointed=data.list[idx].pointed;
		
		
		if(pointed>1){
		out+="<div class='col event'><span>축하합니다 "+nickName+"님! "+pointed+"포인트 획득!<br></span></div>";	
		}
		out+="<div class='col content'><div class='row justify-content-between'><div class='col-auto col1'><span class='created'><strong>"+created+"</strong></span>";
        out+="<span><strong>출석 "+continuous+"일째</strong></span>";
        if(hidden==1) {
        	out+="<span><strong>숨김</strong></span>";
        }
        out+="</div>";
        if("${sessionScope.member.userId}" == userId){
        	out+="<div class='col-auto'><span class='update' style='color: rgb(120,120,120);'>수정하기 &gt;</span></div>";}
        out+="</div>";
        out+="<div class='row'><div class='col col2'><p>"+content+"</p></div></div>";
        out+="<div class='row'><div class='col col3'><p><strong>- "+nickName+"님</strong></p>";
        out+="<input type='hidden' name='userId' value='"+userId+"'/>";
        out+="<input type='hidden' name='hidden' value='"+hidden+"'/>";
        out+="<input type='hidden' name='continuous' value='"+continuous+"'/>";
        out+="<input type='hidden' name='created' value='"+created+"'/>";
        out+="</div></div><hr></div>";
       }
	out+='<table class="table"><tr><td align="center">'+paging+'</td></tr></table>';
	
	$(".list").append(out);
};

$(function(){
	$(".create").find('.btn').click(function(){
		var pickNum = parseInt(Math.random()*5);
		var pointNum = parseInt(Math.random()*10);
		var pointed = $('input[name=pointed]');
		pointed.val(1);
		if(pickNum == 1) {
			pointed.val(1+pointNum);
		}
		
		$(".left").show();
		$(".content").find("input[name=userId]").val();
		$("input[name=continuous]").val(${continuous}+1);
		$("#btnSubmit").attr("onclick", "insert()");
		$("#createForm").attr("action", "${pageContext.request.contextPath}/presence/insert");
	});
	
	$(document).on('click', '.update', function() {
		$(".left").show();
		$("#content").focus();
		
		var userId = $(this).closest(".content").find("input[name=userId]").val();
		$(".left").find("input[name=userId]").val(userId);
		var hidden = $(this).closest(".content").find("input[name=hidden]").val();
		$(".left").find("input[name=hidden]").val(hidden);
		var continuous = $(this).closest(".content").find("input[name=continuous]").val();
		$(".left").find("input[name=continuous]").val(continuous);
		var created = $(this).closest(".content").find("input[name=created]").val();
		$(".left").find("input[name=created]").val(created);
		
		$("#btnSubmit").attr("onclick", "update()");	
	}); 

	$("#btnCancel").click(function(){
		$("#content").val("");
		$(".left").hide();
	});
	
});

function insert() {
	if(! $.trim($("#content").val()) ) {
		$("#content").focus();
		return;
	}
	
	if($("input:checkbox[id='checkHide']").is(":checked")){
		$(".left").find("input[name=hidden]").val("1");
	} else{
		$(".left").find("input[name=hidden]").val("0");
	}
	
	var f = document.forms[0];
	console.log(f);
	f.submit();
}

function update() {
	if(! $.trim($("#content").val()) ) {
		$("#content").focus();
		return;
	}
	
	if($("input:checkbox[id='checkHide']").is(":checked")){
		$(".left").find("input[name=hidden]").val("1");
	} else{
		$(".left").find("input[name=hidden]").val("0");
	}
	
	var url="${pageContext.request.contextPath}/presence/update";
	var query=$("#createForm").serialize();
	
	var fn = function(data){
		$("#content").val("");
		listPage(1);
		$(".left").hide();
	};
	
	ajaxFun(url, "post", query, "json", fn);
}

</script>

<div class="header">
   	<div class="col-12">
            <h1 class="text-center"><strong style="font-family: 'Noto Sans KR';">올리브의 발도장</strong></h1>
            <hr>
        </div>
    </div>

<div class="container" style="font-family: 'Noto Sans KR';">
    <div class="row" id="title">
        <div class="col">
            <p><strong>오늘까지 올리브와</strong></p>
            <p><strong>${myCount }일을 함께해 주셨어요!</strong></p>
        </div>
    </div>
	<hr>
	<div class="row justify-content-center" id="info">
	    <div class="col-lg-6 left" style="display:none;">
	        <form id="createForm" method="post">
	            <div class="form-check">
	            	<input class="form-check-input" type="checkbox" id="checkHide">
	            		<label class="form-check-label" for="checkHide">내 발도장을 숨깁니다</label>
	            	</div>
	            	<textarea class="form-control" id="content" name="content" placeholder="내용을 입력하세요"></textarea>
	            <div class="form-row justify-content-center">
	                <div class="col-auto">
	                    <div class="btn-group" role="group">
	                    	<button id="btnSubmit" class="btn btn-success" type="button">작성하기</button>
	                    	<button class="btn btn-success" type="reset">다시쓰기</button>
	                    	<button id="btnCancel" class="btn btn-success" type="button">취소하기</button>
	                    </div>
	                </div>
	            </div>
	            <input class="form-control" type="hidden" name="userId" value=${sessionScope.member.userId}>
	            <input class="form-control" type="hidden" name="hidden" value=0>
	            <input class="form-control" type="hidden" name="continuous">
	            <input class="form-control" type="hidden" name="created">
	            <input class="form-control" type="hidden" name="pointed">
	        </form>
	    </div>
	    <div class="col-lg-6 align-content-center right">
	        <p>마지막 출석일은 ${myLatest}이에요</p>
	        <div class="row justify-content-center create">
		        <div class="col-12">
		        	<p>오늘도 도장찍고 포인트 받아가세요</p>
		        </div>
	            <div class="col-auto">
	            	<button class="btn btn-success" type="button">도장찍기</button>
	            </div>
	        </div>
	    </div>
	</div>
	<hr>
	<div class="col list-title">
	    <p>최근 한달간 찍힌 발도장이에요</p>
	</div>
	<div class="list">
	    
	</div>
	
</div>