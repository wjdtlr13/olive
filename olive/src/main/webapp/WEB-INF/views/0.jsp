<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

 <div class="row" style="padding-left: 20px;">
        <div class="col-auto"><img src="assets/img/email.png"></div>
        <div class="col-auto">
            <p>받은 메시지</p>
        </div>
    </div>
    <div class="row d-flex justify-content-end" style="padding-right: 5%;">
        <div class="col-auto">
            <p>메시지 작성</p>
        </div>
        <div class="col-auto">
            <p>보낸 메시지</p>
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
    <div class="col d-flex justify-content-center">
        <div class="table-responsive" style="width: 70%;">
            <table class="table">
                <thead class="d-none">
                    <tr>
                        <th>Column 1</th>
                        <th>Column 2</th>
                        <th>Column 2</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>7시에 잠실역 1번 출구에서 만나요~~<br></td>
                        <td>name<br></td>
                        <td>05.29 13:11<br></td>
                    </tr>
                    <tr>
                        <td>혹시 밥친구 구하셨나요 ?ㅎㅎ<br></td>
                        <td>name<br></td>
                        <td>05.29 13:11<br></td>
                    </tr>
                    <tr>
                        <td>중고 판매 글 보고 쪽지 드려요<br></td>
                        <td>name<br></td>
                        <td>05.29 13:11<br></td>
                    </tr>
                    <tr>
                        <td>안녕하세요 친하게 지내고 싶어요<br></td>
                        <td>name<br></td>
                        <td>05.29 13:11<br></td>
                    </tr>
                    <tr>
                        <td>물티슈 팔렸나요 ?<br></td>
                        <td>name<br></td>
                        <td>05.29 13:11<br></td>
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