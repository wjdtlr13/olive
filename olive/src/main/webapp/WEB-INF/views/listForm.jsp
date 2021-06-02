<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container">
        <div class="col text-center"><span style="border-style: solid;">올리브 게시판</span></div>
        <div class="col text-center">
            <p><span style="text-decoration: underline;">올리브네 게시판!!</span></p>
        </div>
        <div class="row d-flex justify-content-center align-items-center">
            <div class="col-auto"><select>
                    <optgroup label="This is a group">
                        <option value="12" selected="">This is item 1</option>
                        <option value="13">This is item 2</option>
                        <option value="14">This is item 3</option>
                    </optgroup>
                </select></div>
            <div class="col-auto"><input type="text"></div>
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
                    <optgroup label="This is a group">
                        <option value="12" selected="">This is item 1</option>
                        <option value="13">This is item 2</option>
                        <option value="14">This is item 3</option>
                    </optgroup>
                </select></div>
        </div>
        <hr>
    </div>
    <div class="container">
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
                    <tr>
                        <td style="width: 15%;">2222</td>
                        <td>게시글2</td>
                        <td style="width: 15%;">올립2</td>
                        <td style="width: 20%;">2021-09-09</td>
                    </tr>
                    <tr>
                        <td style="width: 15%;">1111</td>
                        <td>게시글1</td>
                        <td style="width: 15%;">올립1</td>
                        <td style="width: 20%;">2021-09-09</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>