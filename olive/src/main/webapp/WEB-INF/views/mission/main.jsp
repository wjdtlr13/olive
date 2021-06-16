<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mission.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR">
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
		}
	});
};

$(function(){
	mylistPage(1);
	listPage(1);
});

function listPage(page) {
	
	var url="${pageContext.request.contextPath}/mission/List";
	var query="pageNo="+page;
	if('${sessionScope.member.userId}'=='admin')
		query+="&mode=admin";
	else
		query+="&mode=notmy";
	var fn = function(data){
		
		printList(data);
	};
	
	ajaxFun(url, "get", query, "json", fn);
};

function mylistPage(page) {
	if('${sessionScope.member.userId}'=='admin')
		return;
	var url="${pageContext.request.contextPath}/mission/List";
	var query="pageNo="+page+"&mode=my";
	var fn = function(data){
		
		printList(data);
	};
	
	ajaxFun(url, "get", query, "json", fn);
};



function listContent(num) {
	var url="${pageContext.request.contextPath}/mission/ListContent";
	var query="num="+num;
	
	var fn= function(data){
		printListContent(data);
	};
	
	ajaxFun(url, "get", query, "json", fn);
}

function printList(data) {
	var dest = "";
	if(data.mode=="my")
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
	
	for(var idx=0; idx<data.list.length; idx++) {
		var out="";
		
		var num=data.list[idx].num;
		var subject=data.list[idx].subject;
		var startDate=data.list[idx].startDate;
		var endDate=data.list[idx].endDate;
		var attendee=data.list[idx].attendee;
		var likeCount=data.list[idx].likeCount;
		var content=data.list[idx].content;
		
		var formName=num+"missionForm";
		
		out+="<form name='missionForm'>";
		if('${sessionScope.member.userId}'=='admin'){
			out+="<div class='row control'><div class='col text-right' style='padding-right: 20px;'><button class='btn update' type='button'>수정하기&gt;</button>";
			out+="<button class='btn delete' type='button' style='border-bottom-style: none;'>삭제하기&gt;</button></div></div>";
		}
		out+="<div class='row justify-content-between align-items-center row1'>";
		out+="<div class='col-auto'><p class='ft30' name='num'><strong>"+num+"</strong></p></div>";
		out+="<div class='col-auto'><p class='ft30' name='subject'><strong>"+subject+"</strong></p></div>";
		out+="<div class='col-auto'><span name='startDate'>"+startDate+"</span> ~ <span name='endDate'>"+endDate+"</span></div></div>";
		out+="<div class='row justify-content-end row2'>";
		out+="<div class='col-auto'><span><em>"+attendee+"명이 함께하는 중</em><br></span></div>";
		out+="<div class='col-auto'><span><i class='fa fa-thumbs-o-up'></i>&nbsp;<em>"+likeCount+"</em></span></div></div>";
		out+="<p class='title-detail' name='content'>"+content+"</p><hr></form>";
		out+="<div id='con"+num+"' class='row row3'>";
		$(dest).append(out);
		
		listContent(num);
		
		$(dest).append("</div>");
	}

	
};


function printListContent(data) {
	
	var out="";
	for(var idx=0; idx<data.list.length; idx++) {
		var accept = data.list[idx].accept;
		var contentNum = data.list[idx].contentNum;
		var subject = data.list[idx].subject;
		var startDate = data.list[idx].startDate;
		var endDate = data.list[idx].endDate;
		var attendDate = data.list[idx].attendDate;
		var content = data.list[idx].content;
		var missionNum = data.list[idx].missionNum;
		
		var dest="#con"+missionNum;
		$(dest).empty();
		
		
		out+="<div class='col-12'><form name='contentForm'><div class='row justify-content-between'>";
		out+="<div class='col-auto d-flex align-items-center'>";
		out+="<p style='font-size: 25px;' name='num'>"+contentNum+"</p>]<p class='t1' name='subject'>"+subject+"</p></div>";
	    out+="<div class='col-auto'><span name='startDate'>"+startDate+"</span> ~ <span name='endDate'>"+endDate+"</span></div></div>";
	    out+="<div class='row justify-content-between'><div class='col-auto'><p name='content'>"+content+"</p></div>";
	    out+="<div class='col-auto'><p>";
	    
	    var today = new Date();
	    var sDate = new Date(startDate);
	    var eDate = new Date(endDate);
	    var aDate = new Date(attendDate);
	    if('${sessionScope.member.userId}'=='admin'){
	    	out+="<button class='btn update' type='button'>수정&gt;</button>";
			out+="<button class='btn delete' type='button' style='border-bottom-style: none;'>삭제&gt;</button>";
	    }
	    else if(today<sDate){
	    	out+="예정된 도전";
	    }
	    else if(attendDate!="") {
	    	if(accept==1)
	    		out+="<p>"+attendDate+" 달성!</p>";
	    	else if(today>eDate)
	    		out+="달성하지 못함";
	    	else
	    		out+="<a href='#'>도전 수정하기&gt;</a>";
	    }
	    else{
	    	if(today>eDate)
	    		out+="달성하지 못함";
	    	else
	    		out+="<a href='#'>지금 도전하기&gt;</a>";
	    }
	    
	    out+="</p></div></div></div></form>";   
	    
	    
	}
	if(data.list.length>0)
		out+="<hr>";
	$(dest).append(out);
}

$(function(){
	$(document).on('click', '.update', function(){
		var form = $(this).closest('form');
		
		form.find('button.update').replaceWith("<button type='button' class='btn update-submit'>수정하기&gt;</button><button type='reset' class='btn'>취소하기&gt;</button>");
		form.find('button.delete').remove();
		
		var num = form.find('p[name=num]').text();
		if(form.attr('name')=='contentForm')
			form.find('p[name=num]').replaceWith("<input name='contentNum' readonly='readonly' value='"+num+"'>");
		else
			form.find('p[name=num]').replaceWith("<input name='num' readonly='readonly' value='"+num+"'>");
		var subject = form.find('p[name=subject]').text();
		form.find('p[name=subject]').replaceWith("<input name='subject' value='"+subject+"'>");
		var startDate = form.find('span[name=startDate]').text();
		form.find('span[name=startDate]').replaceWith("<input type='date' name='startDate' value='"+startDate+"'>");
		var endDate = form.find('span[name=endDate]').text();
		form.find('span[name=endDate]').replaceWith("<input type='date' name='endDate' value='"+endDate+"'>");
		var content = form.find('p[name=content]').text();
		form.find('p[name=content]').replaceWith("<textarea style='width:100%; border:1px solid silver; resize:none;' name='content'>"+content+"</textarea>");
		
	});
	
	$(document).on('click', '.update-submit', function(){
		//내일 할일: 모델로 받고서 하나의 메소드에서 2개를 처리할 수 있는지 보기
		if(form.attr('name')=='contentForm'){}
			
		var url="${pageContext.request.contextPath}/mission/update";
		var query=$(this).closest('form').serialize()+"&userId=${sessionScope.member.userId}";
		var fn = function(data){
			listPage(1)
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
	
	
	
	$(document).on('click', '.delete', function(){
		if(!confirm('도전과제를 삭제하시겠습니까?'))  {
			return false;
		}
				
		var url="${pageContext.request.contextPath}/mission/delete";
		
		var form = $(this).closest('form');
		var num = form.find('p[name=num]').text();
		var query="num="+num+"&userId=${sessionScope.member.userId}";
		console.log(query);
		var fn = function(data){
			listPage(1)
		};
		
		ajaxFun(url, "post", query, "json", fn);
	})
})

$(function(){
	$(document).on('click', '.content-remove', function(){
		$(this).closest('form').empty();
	});
	
	$('.content-add').click(function(){
		var form = '<form name="contentForm">';
		form+='<div class="col text-right"><button class="btn content-remove">삭제하기 &gt;</button></div>';    
		form+='<div class="row"><div class="col"><span>시작날짜</span></div>';
		form+='<div class="col"><span>끝날짜</span></div></div>';
		form+='<div class="row"><div class="col"><input type="date" name="startDate"></div>';
		form+='<div class="col"><input type="date" name="endDate"></div></div>';
		form+='<div class="row"><div class="col-3"><span>제목</span></div>';
		form+='<div class="col"><input type="text" name="subject"></div></div>';
		form+='<div class="row"><div class="col-3"><span>내용</span></div>';
		form+='<div class="col"><textarea wrap="hard" name="content"></textarea></div></div></form>';
		
		$(this).closest('div').prepend(form);
	});
	
})

</script>

<div class="header">
              <div class="col-12">
            <h1 class="text-center"><strong>올리브의 도전</strong></h1>
        </div>
        <div class="col-12">
        <hr>
        </div>
        <div class="col-12">
            <h4 class="text-center">도전을 완료하고 포인트도 받아가세요</h4>
        </div>
    </div>
    <div class="container">
        <c:if test="${sessionScope.member.userId!='admin'}">
        <div class="col title">
            <div class="row">
                <div class="col-12">
                    <p><strong>${nickName }님께선 지금까지</strong></p>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <p><strong>${myComplete }개의 도전과제를 완수하셨어요!</strong></p>
                </div>
            </div>
            
            <div class="row">
                <div class="col-12 link"><a href="#">보러가기&gt;</a></div>
                <hr>
            </div>
            
        </div>
        <div id="my-subtitle" class="col subtitle">
            <p><strong>${nickName}님의 도전과제</strong></p>
        </div>
        <div id="my-content" class="col content">
        </div>
        </c:if>
        <c:if test="${sessionScope.member.userId=='admin'}">
        	 <div class="row">
                <div class="col-12 text-right"><button type="button" class="btn" data-toggle="modal" data-target="#myModal"> 등록하기 ></button></div>
                <hr>
            </div>
        </c:if>
        
        <div id="subtitle" class="col subtitle">
            <p><strong>참여할 수 있는 도전과제</strong></p>
        </div>
        <div id="content" class="col content">
        </div>
    </div>
    <div id="myModal" class="modal fade" role="dialog" tabindex="-1">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header flex-column">
                            <div class="col header">
                                <div></div>
                            </div>
                            <div class="col mtitle">
                                <p><strong>도전 과제를 등록합니다</strong></p>
                            </div>
                        </div>
                        <div class="modal-body">
                        <form name="missionForm">
                            <div class="row">
                                <div class="col"><span>시작날짜</span></div>
                                <div class="col"><span>끝날짜</span></div>
                            </div>
                            <div class="row">
                                <div class="col"><input type="date" name="startDate"></div>
                                <div class="col"><input type="date" name="endDate"></div>
                            </div>
                            <div class="row">
                                <div class="col-3"><span>제목</span></div>
                                <div class="col"><input type="text" name="subject"></div>
                            </div>
                            <div class="row">
                                <div class="col-3"><span>내용</span></div>
                                <div class="col"><textarea wrap="hard" name="title"></textarea></div>
                            </div>
                        </form>
                            <section class="stitle">
                                <p><strong>도전 항목을 등록합니다</strong></p>
                            </section>
                        <form name="contentForm">
                            <div class="col text-right"><button class="btn content-remove">삭제하기 &gt;</button></div>    
                            <div class="row">
                                <div class="col"><span>시작날짜</span></div>
                                <div class="col"><span>끝날짜</span></div>
                            </div>
                            <div class="row">
                                <div class="col"><input type="date" name="startDate"></div>
                                <div class="col"><input type="date" name="endDate"></div>
                            </div>
                            <div class="row">
                                <div class="col-3"><span>제목</span></div>
                                <div class="col"><input type="text" name="subject"></div>
                            </div>
                            <div class="row">
                                <div class="col-3"><span>내용</span></div>
                                <div class="col"><textarea wrap="hard" name="content"></textarea></div>
                            </div>
                        </form>
                            <div class="col text-right"><button class="btn content-add">추가하기 &gt;</button></div>
                        </div>
                        <div class="modal-footer flex-column">
                            <div class="col d-flex justify-content-center"><button class="btn btn-secondary" type="button">등록하기</button><button class="btn btn-secondary" class="close" data-dismiss="modal" aria-label="Close">취소하기</button></div>
                            <div class="col footer">
                                <p class="text-right">작성자 : 관리자</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>