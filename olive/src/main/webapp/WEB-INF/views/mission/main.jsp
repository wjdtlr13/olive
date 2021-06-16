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
	    	
			console.log(jqXHR.responseText);
		}
	});
};

$(function(){
	mylistPage(1);
	listPage(1);
});

function listPage(page) {
	var url="${pageContext.request.contextPath}/mission/List";
	var query="pageNo="+page+"&mode=notmy";
	
	var fn = function(data){
		printList(data);
	};
	
	ajaxFun(url, "get", query, "json", fn);
};

function mylistPage(page) {
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
		
		out+="<div class='row justify-content-between align-items-center row1'>";
		out+="<div class='col-auto'><p class='ft30'><strong>"+num+"</strong></p></div>";
		out+="<div class='col-auto'><p class='ft30'><strong>"+subject+"</strong></p></div>";
		out+="<div class='col-auto'><p>"+startDate+" ~ "+endDate+"</p></div></div>";
		out+="<div class='row justify-content-end row2'>";
		out+="<div class='col-auto'><span><em>"+attendee+"명이 함께하는 중</em><br></span></div>";
		out+="<div class='col-auto'><span><i class='fa fa-thumbs-o-up'></i>&nbsp;<em>"+likeCount+"</em></span></div></div>";
		out+="<p class='title-detail'>"+content+"</p><hr>";
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
		
		out+="<div class='col-12'><div class='row justify-content-between'>";
		out+="<div class='col-auto d-flex align-items-center'>";
		out+="<span style='font-size: 25px;'>"+contentNum+"]</span><span class='t1'>"+subject+"</span></div>";
	    out+="<div class='col-auto'><p>"+startDate+" ~ "+endDate+"</p></div></div>";
	    out+="<div class='row justify-content-between'><div class='col-auto'><p>"+content+"</p></div>";
	    out+="<div class='col-auto'><p>";
	    
	    console.log(attendDate);
	    
	    var today = new Date();
	    var sDate = new Date(startDate);
	    var eDate = new Date(endDate);
	    var aDate = new Date(attendDate);
	    if(today<sDate){
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
	    
	    out+="</p></div></div></div>";   
	    
	    
	}
	if(data.list.length>0)
		out+="<hr>";
	$(dest).append(out);
}

</script>

<div class="header">
        <div class="col-12">
            <h1 class="text-center"><strong>올리브의 도전</strong></h1>
        </div>
        	<hr>
        <div class="col-12">
            <h4 class="text-center">도전을 완료하고 포인트도 받아가세요</h4>
        </div>
    </div>
    <div class="container">
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
            </div>
            <hr>
        </div>
        <div id="my-subtitle" class="col subtitle">
            <p><strong>${nickName}님의 도전과제</strong></p>
        </div>
        <div id="my-content" class="col content">
        </div>
        
        
        
        <div id="subtitle" class="col subtitle">
            <p><strong>참여할 수 있는 도전과제</strong></p>
        </div>
        <div id="content" class="col content">
        </div>
    </div>