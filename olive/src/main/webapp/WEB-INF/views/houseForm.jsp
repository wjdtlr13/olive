<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

   <div class="container">
        <div class="col text-center"><span style="border-style: solid;">올리브의 새집</span></div>
        <div class="col text-center">
            <p><span style="text-decoration: underline;">올리브의 새집!</span></p>
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
        <div class="col">
            <p style="height: 350px;">이미지</p>
        </div>
        <hr>
        <div class="row d-flex justify-content-around">
            <div class="col-auto">
                <div class="row">
                    <div class="col">
                        <p style="height: 300px;width: 300px;border-style: solid;">이미지<br></p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <p>월세</p>
                    </div>
                    <div class="col-12">
                        <p>평수</p>
                    </div>
                    <div class="col">
                        <p>지역</p>
                    </div>
                </div>
            </div>
            <div class="col-auto">
                <div class="row">
                    <div class="col">
                        <p style="height: 300px;width: 300px;border-style: solid;">이미지<br></p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <p>월세</p>
                    </div>
                    <div class="col-12">
                        <p>평수</p>
                    </div>
                    <div class="col">
                        <p>지역</p>
                    </div>
                </div>
            </div>
            <div class="col-auto">
                <div class="row">
                    <div class="col">
                        <p style="height: 300px;width: 300px;border-style: solid;">이미지<br></p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <p>월세</p>
                    </div>
                    <div class="col-12">
                        <p>평수</p>
                    </div>
                    <div class="col">
                        <p>지역</p>
                    </div>
                </div>
            </div>
        </div>
    </div>