<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

 <div class="row" style="padding-left: 20px;">
        <div class="col-auto">
            <p>병원&nbsp;· 약국 정보<br></p>
        </div>
    </div>
    <div class="col">
        <hr>
    </div>
    <div class="col">
        <div class="text-center"><select>
                <optgroup label="This is a group">
                    <option value="12" selected="">This is item 1</option>
                    <option value="13">This is item 2</option>
                    <option value="14">This is item 3</option>
                </optgroup>
            </select><input type="search" style="width: 25%;"><i class="fa fa-search"></i></div>
    </div>
    <div class="col">
        <hr>
    </div>
    <div class="col-auto">
        <p>총 5건</p>
    </div>
    <div class="col d-flex justify-content-center">
        <div class="table-responsive text-center" style="width: 70%;">
            <table class="table">
                <thead>
                    <tr>
                        <th>구분</th>
                        <th>업체명</th>
                        <th>위치</th>
                        <th>운영시간</th>
                        <th>연락처</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>약국<br></td>
                        <td>대학약국신촌점<br></td>
                        <td>서울 서대문구 성산로 486 약희빌딩<br></td>
                        <td>평일 10:00~21:00<br></td>
                        <td>02-111-2222<br></td>
                    </tr>
                    <tr>
                        <td>약국<br></td>
                        <td>대학약국신촌점<br></td>
                        <td>서울 서대문구 성산로 486 약희빌딩<br></td>
                        <td>평일 10:00~21:00<br></td>
                        <td>02-111-2222<br></td>
                    </tr>
                    <tr>
                        <td>약국<br></td>
                        <td>대학약국신촌점<br></td>
                        <td>서울 서대문구 성산로 486 약희빌딩<br></td>
                        <td>평일 10:00~21:00<br></td>
                        <td>02-111-2222<br></td>
                    </tr>
                    <tr>
                        <td>약국<br></td>
                        <td>대학약국신촌점<br></td>
                        <td>서울 서대문구 성산로 486 약희빌딩<br></td>
                        <td>평일 10:00~21:00<br></td>
                        <td>02-111-2222<br></td>
                    </tr>
                    <tr>
                        <td>병원</td>
                        <td>대학병원신촌점<br></td>
                        <td>서울 서대문구 성산로 486 약희빌딩<br></td>
                        <td>평일 10:00~21:00<br></td>
                        <td>02-111-2222<br></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="col d-flex justify-content-center">
        <nav>
            <ul class="pagination">
                <li class="page-item"><a class="page-link" href="#" aria-label="Previous"><span aria-hidden="true">«</span></a></li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item"><a class="page-link" href="#">4</a></li>
                <li class="page-item"><a class="page-link" href="#">5</a></li>
                <li class="page-item"><a class="page-link" href="#" aria-label="Next"><span aria-hidden="true">»</span></a></li>
            </ul>
        </nav>
    </div>