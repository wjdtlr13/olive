<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

 <div class="container">
        <div class="col">
            <p style="font-size: 25px;"><strong>올리브의 지갑사정</strong></p>
        </div>
        <div class="col">
            <hr>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="row">
                    <div class="col">
                        <div style="width: 200px;">
                            <p>총수입</p>
                            <p style="font-size: 30px;">10,000,000원</p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row d-flex justify-content-center">
                            <div class="col-auto" style="padding: 0px;"><button class="btn btn-primary" type="button">내역</button></div>
                            <div class="col-auto d-flex" style="padding: 0px;"><button class="btn btn-primary" type="button">통계</button></div>
                        </div>
                    </div>
                    <div class="col text-center"><select>
                            <optgroup label="This is a group">
                                <option value="12" selected="">This is item 1</option>
                                <option value="13">This is item 2</option>
                                <option value="14">This is item 3</option>
                            </optgroup>
                        </select></div>
                </div>
                <div class="row">
                    <div class="col-auto d-flex justify-content-center align-items-center"><span style="background: var(--gray);">카테고리</span></div>
                    <div class="col">
                        <div class="row">
                            <div class="col">
                                <p>내역</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <p>2021-05-21</p>
                            </div>
                        </div>
                    </div>
                    <div class="col d-flex align-items-center">
                        <p>-1500원</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-auto d-flex justify-content-center align-items-center"><span style="background: var(--gray);">카테고리</span></div>
                    <div class="col">
                        <div class="row">
                            <div class="col">
                                <p>내역</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <p>2021-05-21</p>
                            </div>
                        </div>
                    </div>
                    <div class="col d-flex align-items-center">
                        <p>-1500원</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="row">
                    <div class="col text-center"><img style="width: 100%;height: 400px;">
                        <hr>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <p><strong>가장 큰 지출사항</strong></p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-auto d-flex justify-content-center align-items-center"><span style="background: var(--gray);">카테고리</span></div>
                    <div class="col">
                        <div class="row">
                            <div class="col">
                                <p>내역</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <p>2021-05-21</p>
                            </div>
                        </div>
                    </div>
                    <div class="col d-flex align-items-center">
                        <p>-1500원</p>
                    </div>
                </div>
            </div>
        </div>
    </div>