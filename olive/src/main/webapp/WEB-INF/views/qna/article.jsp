<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">

function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}

function ajaxFun(url, method, query, dataType,fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX",true);
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
    $(document).ready(function() {
        $("#articleAnswer").hide();
    });
});

//답변 폼 보기 / 답변 등록
$(function(){
	$(".btnSendAnswer").click(function(){
		var isVisible = $("#articleAnswer").is(':visible');
		if(! isVisible) {
			// 답변 폼 보기
			$("#articleAnswer").show('3000');
			return false;
		}		
		
		// 답변 등록
		var num="${dto.qnaNum}";
		var content=$(".answerTA").val().trim();
		
		if(! content) {
			$(".answerTA").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${pageContext.request.contextPath}/qna/writeAnswer";
		var query="qnaNum="+num+"&answerContent="+content;
		
		var fn = function(data){
			// 답변 등록 후 다시  글보기로
			location.href="${pageContext.request.contextPath}/qna/article?${query}&qnaNum=${dto.qnaNum}";
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

</script>


<div class="container" style="min-height: 1200px;">
        <div>
            <div class="row">
                <div class="col">
                    <p class="article-name">Question</p>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <p class="article-date">${dto.questioncreated}</p>
                </div>
            </div>
            <hr>
        </div>
        <div>
            <div class="row btn-category">
                <div class="col "><span style="background: #82A880;color: rgb(255,255,255);" >해당카테고리</span></div>
            </div>
            <div class="row">
                <div class="col article-title">
                    <p><strong>${dto.subject}</strong></p>
                </div>
            </div>
        </div>
        <div>
            <div class="col article-content-textarea" >
                <p style="height: 200px;">${dto.questionContent}</p>
            </div>
            <hr>
        </div>
        <div>
            <div class="row d-flex justify-content-center">

                <div class="col-auto">
                    <button>조회수</button>
                </div>
                <div class="col-auto">
                    <button>1</button>
                </div>
            </div>
            <hr>
        </div>
        <div>
            <div class="row">
                <div class="col-auto" >
                    <a class="pre-content">이전글 :</a>
                </div>
                <div class="col">
                    <a class="pre-content">올리브가 글쎄..</a>
                </div>
            </div>
            <hr>
        </div>
        <div>
            <div class="row">
                <div class="col-auto">
                    <a class="next-content">다음글 :</a>
                </div>
                <div class="col">
                    <a class="next-content">올리브가 ??..</a>
                </div>
            </div>
            <hr>
        </div>
        <div>
            <div class="row d-flex justify-content-end">
            	<c:if test="${not empty dto.answerContent }">
                	<div class="col-auto"><button class="btn btn-primary btn-list answerClick" type="button">답변보기</button></div>
                </c:if>
                <div class="col-auto"><button class="btn btn-primary btn-list" type="button"  onclick="javascript:location.href='${pageContext.request.contextPath}/qna/list?${query}';">목록</button></div>
                <c:if test="${sessionScope.member.userId=='userId' }">
               	 <div class="col-auto"><button class="btn btn-primary btn-list" type="button">수정</button></div>
               	 <div class="col-auto"><button class="btn btn-primary btn-list" type="button">삭제</button></div>
           	 	</c:if>
            </div>
           
        </div>
 		<hr>
 		
 		<c:if test="${empty dto.answerContent }">
	 		<div id="articleAnswer">
		        <div class="col">
		            <p style="font-size: 25px;"><strong>Answer</strong></p>
		        </div>
		        <div class="col">
		            <p><strong>관리자</strong></p>
		        </div>
	        
	        <hr>
	        <div class="col"><textarea style="width: 100%;height: 300px;border-style: none; resize: none;" class="answerTA">${dto.answerContent}</textarea></div>
	        </div>  
	          <div class="row d-flex justify-content-end">
	          		<c:if test="${sessionScope.member.userId=='admin'}">
	                <div class="col-auto"><button class="btn btn-primary btn-list btnSendAnswer" type="button">답변등록</button></div>
	          		</c:if>
	          </div>
       </c:if>
		<c:if test="${not empty dto.answerContent }"> 
		
		답변 : ${dto.answerContent }
		
		</c:if> 
          
          
    </div>