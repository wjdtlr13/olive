<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="col-auto">
        <p style="font-size: 25px;">회원 상세정보</p>
    </div>
    <div class="col">
        <hr>
    </div>
    <div class="container" style="background: #e6ee9c;width: 80%;border-radius: 30px;padding: 30px;">
    <div class="col">
    	<form name="searchForm" action="${pageContext.request.contextPath}/admin/memManage/memList" method="post">
        <div class="text-center">
        	<select>
                <optgroup label="검색 카테고리">
                    <option value="date" >날짜</option>
                    <option value="name">이름</option>
                    <option value="id">아이디</option>
                </optgroup>
            </select>
            <input type="search" style="width: 25%;">
            
            <button type="button" onclick="searchList()"> <i class="fa fa-search"></i></button>
        </div>
   		</form>
    </div>        
        <div class="row">
            <div class="col">
                <p>이름</p>
            </div>
            <div class="col">
                <p>${dto.userName}</p>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <p>닉네임</p>
            </div>
            <div class="col">
                <p>${dto.nickName}</p>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <p>아이디</p>
            </div>
            <div class="col">
                <p>${dto.userId}</p>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <p>생년월일</p>
            </div>
            <div class="col">
                <p>${dto.birth}</p>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <p>연락처</p>
            </div>
            <div class="col">
                <p>${dto.tel}</p>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <p>좋아하는 음식</p>
            </div>
            <div class="col">
                <p>딸기</p>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <p>싫어하는 음식</p>
            </div>
            <div class="col">
                <p>오이</p>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <p>주소</p>
            </div>
            <div class="col">
                <p>${dto.addr1}</p>
                <p>${dto.addr2}</p>
                <p>${dto.zip}</p>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <p>자기소개</p>
            </div>
            <div class="col">
                <p>${dto.selfIntro}</p>
            </div>
        </div>
    <div class="col d-flex justify-content-center">
        <div class="table-responsive text-center" style="width: 70%;">
            <table class="table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>아이디</th>
                        <th>내용</th>
                        <th>등록일</th>
                        <th>조회수</th>
                        <th>추천수</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="vo" items="${list}">
                    <tr>
                        <td>${vo.listnum}<br></td>
                        <td>${vo.userId}<br></td>
                        <td>${vo.content}<br></td>
                        <td>${vo.created_date}</td>
                        <td>dd</td>
                        <td>2021-06-07</td>
                    </tr>
                    </c:forEach>

                </tbody>
            </table>
        </div>
    </div> 
    <div class="col d-flex justify-content-center">
        <div class="table-responsive text-center" style="width: 70%;">
            <table class="table">
                <thead>
                    <tr>
                        <th>최근댓글</th>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>생년월일</th>
                        <th>가입일</th>
                        <th>최근 접속일</th>
                        <th>회원상세정보보기</th>
                    </tr>
                </thead>
                <tbody>
                	
                    <tr>
                        <td>111<br></td>
                        <td>가<br></td>
                        <td>가<br></td>
                        <td>2020-01-01</td>
                        <td>2021-06-07</td>
                        <td>2021-06-07</td>
                        <td>
                        	<button type="button" onclick="javascript:location.href='${pageContext.request.contextPath}/admin/memManage/memDetail';">바로가기[클릭!]</button>
                        </td>
                    </tr>
                    

                </tbody>
            </table>
        </div>
    </div>            
    </div>