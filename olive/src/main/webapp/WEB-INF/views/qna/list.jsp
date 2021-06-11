<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container">
        <div class="col text-center article-name">
        	<p>Q&A</p>
        </div>
        <div class="col text-center">
            <p ><span style="border-bottom: 1px solid #ccc;">Q&A 게시판입니다</span></p>
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
            <table class="table">
                <thead>
                    <tr>
                        <th style="width: 15%;">NO</th>
                        <th>CONTENTS</th>
                        <th style="width: 15%;">NAME</th>
                        <th style="width: 20%;">DATE</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="dto" items="${list}">
                    <tr>
                        <td style="width: 15%;">${dto.qnaNum}</td>
                        <td><a href="${articleUrl}&qnaNum=${dto.qnaNum}"> ${dto.subject}</a></td>
                        <td style="width: 15%;">${dto.questionId}</td>
                        <td style="width: 20%;">${dto.questioncreated}</td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
</div>