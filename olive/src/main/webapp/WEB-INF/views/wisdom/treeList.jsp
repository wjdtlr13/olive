<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
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

$(function(){
	listPage(1);
});



</script>


 <div class="container">
        <div class="col text-center"><span style="border-style: solid;">올리브 게시판</span></div>
        <div class="col text-center">
            <p><span style="text-decoration: underline;">올리브나무게시판입니다</span></p>
        </div>
        <div class="row d-flex justify-content-center align-items-center">
            <div class="col-auto"><select>
                    
                    	<c:forEach var="vo" items="${listCategory}">
                       		<option value="${vo.categoryNum}">${vo.category}</option>
                        </c:forEach>
                    
                </select></div>
            <div class="col-auto" ><input type="text" id="keyword" name="keyword" value="${keyword}"></div>
            <div class="col-auto"><button class="btn btn-primary" type="button">Button</button></div>
        </div>
        <div class="row">
            <div class="col"><select>
                    <optgroup label="This is a group">
                        <option value="12" selected="">This is item 1</option>
                        <option value="13">This is item 2</option>
                        <option value="14">This is item 3</option>
                    </optgroup>
                </select></div>
            <div class="col" style="text-align: right;"><select>
                    <optgroup label="게시글 보기"> 
                        <option value="12" selected="selected">5개씩 보기</option>
                        <option value="13">10개씩 보기</option>
                        <option value="14">15개씩 보기</option>
                    </optgroup>
                </select></div>
        </div>
        <div class="row">
        	<div class="col">
        		<button class="btn btn-primary btn-list" type="button" style="float: right;" onclick="javascript:location.href='${pageContext.request.contextPath}/wisdom/created';">글작성</button>
        	</div>
        </div>        
        
        <hr>
        <div class="row d-flex justify-content-around">
            <c:forEach var="dto" items="${list}">
            <div class="col-auto">
                <div class="row">
                    <div class="col-auto">
						<c:choose>
							<c:when test="${not empty dto.imageFileName}">
								<div >
									<a href="${articleUrl}&num=${dto.num}"><img style="height: 300px;width: 300px; border-style: solid;" src="${pageContext.request.contextPath}/uploads/wisdom/${dto.imageFileName}" title="${dto.subject}"></a>
								</div>
							</c:when>
							<c:otherwise>
								<a href="${articleUrl}&num=${dto.num}"><img src="${pageContext.request.contextPath}/resources/img/noimage.png" title="${dto.subject}"></a>
							</c:otherwise>
						</c:choose>
                       
                    </div>
                </div>
                
                <div class="row">
                   
                    <div class="col">
                        <div class="row">
                            <div class="col-12">
                                <p> ${dto.subject}</p>
                            </div>
                            <div class="col-12">
                                <p>가격</p>
                            </div>
                            <div class="col">
                                <p>${dto.created}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col d-flex justify-content-end align-items-end">
                        <div class="row">
                            <div class="col-auto"><i class="fa fa-heart"></i></div>
                            <div class="col-auto"><span>${dto.articleLikeCount}</span></div>
                        </div>
                    </div>
                </div>
            </div>
            </c:forEach>


        </div>
    </div>
