<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
	function btnSubmit() {
		var f =document.qnaForm;
		
		f.action="${pageContext.request.contextPath}/qna/${mode}";
		
		f.submit();
	}

</script>


<div class="container" style="min-height: 1200px;">
        <form name="qnaForm">
        <div>
			
            <div class="row">
                <div class="col">
                    <p class="article-date">${dto.questioncreated}</p>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <p class="userName">${sessionScope.member.userName}</p>
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
                    <input type="text" value="${dto.subject}" placeholder="제목을 입력하세요">
                </div>
            </div>
        </div>
        <div>
            <div class="col article-content-textarea" >
                <textarea style="height: 200px; width: 600px;">${dto.questionContent}</textarea>
            </div>
            <hr>
        </div>
        <div>
            <div class="row d-flex justify-content-center">
                <div class="col-auto">
                    <button class="heart">
                    	<i class="fa fa-heart heart" style="font-size: 20px;width: 20px;height: 20px;"></i>
                    </button>
                </div>
                <div class="col-auto">
                    <button>1</button>
                </div>
                <div class="col-auto">
                    <button>조회수</button>
                </div>
                <div class="col-auto">
                    <button>1</button>
                </div>
            </div>
            <hr>
        
        </div>
       
       </form>
       
        <div>
            <div class="row d-flex justify-content-end">
                <div class="col-auto"><button class="btn btn-primary btn-list" type="button" onclick="javascript:location.href='${pageContext.request.contextPath}/qna/list';">목록</button></div>
	             <div class="col-auto"><button class="btn btn-primary btn-list btnSubmit" type="button">${mode=='update'?'수정':'등록'}</button></div>               
                 <c:if test="${mode=='update'}">
                 	<input type="hidden" name="num" value="${dto.qnaNum}">
                 	<input type="hidden" name="page" value="${page}">
                  </c:if>
                <div class="col-auto"><button class="btn btn-primary btn-list" type="button">삭제</button></div>
            </div>
           
        </div>

    </div>