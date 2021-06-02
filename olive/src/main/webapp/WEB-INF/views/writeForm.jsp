<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="col">
        <p>글 등록</p>
    </div>
    <div class="row">
        <div class="col-2">
            <p>제목</p>
        </div>
        <div class="col"><input type="text" placeholder="제목을 입력하시오" style="width: 100%;"></div>
        <div class="col-4"><select style="width: 100%;">
                <optgroup label="This is a group">
                    <option value="12" selected="">This is item 1</option>
                    <option value="13">This is item 2</option>
                    <option value="14">This is item 3</option>
                </optgroup>
            </select></div>
    </div>
    <div class="row">
        <div class="col-2">
            <p>작성자</p>
        </div>
        <div class="col"><input type="text" style="width: 100%;"></div>
    </div>
    <div class="row">
        <div class="col-2">
            <p>가격</p>
        </div>
        <div class="col"><input type="text" style="width: 100%;"></div>
    </div>
    <div class="row">
        <div class="col-2">
            <p>내용</p>
        </div>
        <div class="col"><textarea style="width: 100%;height: 400px;" resize="none" placeholder="내용을 입력"></textarea></div>
    </div>
    <div class="row">
        <div class="col-2">
            <p>첨부된 파일</p>
        </div>
        <div class="col"><input type="file"></div>
    </div>
    <div class="row d-flex justify-content-center">
        <div class="col-auto"><button class="btn btn-primary" type="button">등록하기</button></div>
        <div class="col-auto"><button class="btn btn-primary" type="button">다시입력</button></div>
        <div class="col-auto"><button class="btn btn-primary" type="button">등록취소</button></div>
    </div>