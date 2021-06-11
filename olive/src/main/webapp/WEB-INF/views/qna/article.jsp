<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
                <div class="col-auto"><button class="btn btn-primary btn-list" type="button">목록</button></div>
                <div class="col-auto"><button class="btn btn-primary btn-list" type="button">수정</button></div>
                <div class="col-auto"><button class="btn btn-primary btn-list" type="button">삭제</button></div>
            </div>
           
        </div>
 		<hr>
        <div class="col">
            <p style="font-size: 25px;"><strong>Answer</strong></p>
        </div>
        <div class="col">
            <p><strong>관리자</strong></p>
        </div>
        <div class="col">
            <p>2021-03-06</p>
        </div>
        <hr>
        <div class="col"><textarea style="width: 100%;height: 300px;border-style: none; resize: none;" placeholder="답변하기"></textarea></div>
            <div class="row d-flex justify-content-end">
                <div class="col-auto"><button class="btn btn-primary btn-list" type="button">목록</button></div>
                <div class="col-auto"><button class="btn btn-primary btn-list" type="button">수정</button></div>
                <div class="col-auto"><button class="btn btn-primary btn-list" type="button">삭제</button></div>
            </div>
    </div>