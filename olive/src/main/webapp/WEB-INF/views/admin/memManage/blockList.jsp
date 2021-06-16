<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">

function stopMemberChange() { 
	var f= document.stopMemberForm;
	var enabled= f.enabled.value;
 
		
		if(confirm("선택한 아이디를 정지하시겠습니까?")) {
			enabled=0;
			f.submit();
		}else {
			return;
		}

	
}

</script>

<div class="container">
        <div class="col text-center article-name">
        	<p>신고회원리스트</p>
        </div>

        <div class="row d-flex justify-content-center align-items-center ">
            <div class="col-auto search"><select style="height: 36px;">
                    <optgroup label="This is a group">
                        <option value="12" selected="">This is item 1</option>
                        <option value="13">This is item 2</option>
                        <option value="14">This is item 3</option>
                    </optgroup>
                </select>
            </div>
            <div class="col-auto search" ><input type="text" style="border: 1px solid #ccc; margin: 0; width:200px;  height: 36px;"></div>
            <div class="col-auto search"><button class="btn btn-primary btn-list" type="button">Button</button></div>
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
                    <optgroup label="This is a group">
                        <option value="12" selected="">This is item 1</option>
                        <option value="13">This is item 2</option>
                        <option value="14">This is item 3</option>
                    </optgroup>
                </select></div>
        </div>
        <hr>

        <div class="table-responsive">
        <form name="stopMemberForm" method="post">
            <table class="table">
                <thead>
                    <tr>
                        <th style="width: 15%;">NUM</th>
                        <th>USER</th>
                        <th style="width: 15%;">신고횟수</th>
                        <th style="width: 15%;">회원정지</th>
                        <th style="width: 15%;">정지여부</th>
                    </tr>
                </thead>
                <tbody>

                	<c:forEach var="dto" items="${blockList}">
                    <tr>
                        <td style="width: 15%;">${dto.memberIdx}</td>
                        <td>${dto.userId}</td>
                        <td style="width: 15%;">${dto.warn_cnt}</td>
                        <c:if test="${dto.warn_cnt >= 2}">
                        <input type="hidden" name="enabled" value="${dto.enabled}">
                        <td><button type="button" onclick="stopMemberChange()">회원정지</button> </td></c:if>
                        <td>${dto.enabled}</td>
                    </tr>
                    </c:forEach>
                </tbody>
                
            </table>
            </form>
        </div>
</div>