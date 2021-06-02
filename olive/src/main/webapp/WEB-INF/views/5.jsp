<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="row" style="padding-left: 20px;">
        <div class="col-auto">
            <p>회원 리스트</p>
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
                        <th>번호</th>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>생년월일</th>
                        <th>가입일</th>
                        <th>최근 접속일</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>5<br></td>
                        <td>name<br></td>
                        <td>김이름<br></td>
                        <td>1999.01.23</td>
                        <td>2020.01.03</td>
                        <td>2021.03.23</td>
                    </tr>
                    <tr>
                        <td>4<br></td>
                        <td>name<br></td>
                        <td>김이름<br></td>
                        <td>1999.01.23</td>
                        <td>2020.01.03</td>
                        <td>2021.03.23</td>
                    </tr>
                    <tr>
                        <td>3<br></td>
                        <td>name<br></td>
                        <td>김이름<br></td>
                        <td>1999.01.23</td>
                        <td>2020.01.03</td>
                        <td>2021.03.23</td>
                    </tr>
                    <tr>
                        <td>2<br></td>
                        <td>name<br></td>
                        <td>김이름<br></td>
                        <td>1999.01.23</td>
                        <td>2020.01.03</td>
                        <td>2021.03.23</td>
                    </tr>
                    <tr>
                        <td>1<br></td>
                        <td>name<br></td>
                        <td>김이름<br></td>
                        <td>1999.01.23</td>
                        <td>2020.01.03</td>
                        <td>2021.03.23</td>
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