<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

 <div style="background: url(&quot;assets/img/sky.jpeg&quot;) top / cover;">
        <div class="col text-center">
            <p style="margin: 30px;">우리 동네 날씨</p>
        </div>
        <div class="row">
            <div class="col">
                <div class="row d-flex justify-content-center">
                    <div class="col-auto text-center"><img src="assets/img/sunny.png"></div>
                    <div class="col-auto d-flex d-xl-flex flex-column justify-content-center align-content-center">
                        <div class="row">
                            <div class="col"><span>맑음</span></div>
                        </div>
                        <div class="row">
                            <div class="col"><span>17º<br></span></div>
                        </div>
                        <div class="row">
                            <div class="col"><span>강수 가능성 10%</span></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="row d-flex justify-content-center">
                    <div class="col-auto text-center"><img src="assets/img/tshirt.png"></div>
                    <div class="col-auto d-flex flex-column justify-content-center align-content-center">
                        <div class="row">
                            <div class="col"><span>추천 옷차림<br></span></div>
                        </div>
                        <div class="row">
                            <div class="col"><span>자켓, 가디건, 맨투맨, 후드집업<br></span></div>
                        </div>
                        <div class="row">
                            <div class="col"><span>강수 가능성 10%</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="d-flex justify-content-center" style="background: #f0f4c3;">
        <div class="container" style="background: #ffffff;width: 70%;margin-right: 0px;margin-left: 0px;padding: 0px;margin-top: 50px;border-radius: 30px;">
            <div class="col">
                <div class="row">
                    <div class="col text-center"><span>우리동네 코로나</span></div>
                </div>
                <div class="row">
                    <div class="col text-center"><span>2021년 5월 28일 기준</span></div>
                </div>
            </div>
            <div class="row">
                <div class="col d-flex d-xl-flex justify-content-end align-items-center"><img src="assets/img/covid19.png"></div>
                <div class="col">
                    <div class="row">
                        <div class="col"><span>거리두기 2단계</span></div>
                    </div>
                    <div class="row">
                        <div class="col"><span>전일 대비 확진자 +3명</span></div>
                    </div>
                    <div class="row">
                        <div class="col"><span>당일 확진자 + 13명<br></span></div>
                    </div>
                    <div class="row">
                        <div class="col"><span>영업 운영 제한 10시<br></span></div>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="table-responsive text-center">
                    <table class="table">
                        <thead>
                            <tr>
                                <th style="width: 60%;">관리실에서 알립니다<br></th>
                                <th><a href="http://localhost:9090/olive/#"><strong>&gt; 더보기</strong></a><br></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>커뮤니티 활동을 위한 공지사항입니다.<br></td>
                                <td>2021.05.28<br></td>
                            </tr>
                            <tr>
                                <td>새로 입주한 올리브 필독사항<br></td>
                                <td>2021.04.20<br></td>
                            </tr>
                            <tr>
                                <td>olive alone 입주를 축하합니다.<br></td>
                                <td>2021.03.07<br></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col">
                <div class="table-responsive text-center">
                    <table class="table">
                        <thead>
                            <tr>
                                <th style="width: 60%;"><strong>형형색깔 올리브</strong><br></th>
                                <th><a href="http://localhost:9090/olive/#">&gt; 더보기</a><br></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>오늘 영화관 다녀왔다 ㅋㅋ<br></td>
                                <td>2021.05.28<br></td>
                            </tr>
                            <tr>
                                <td>마포구 혼밥 식당 추천해주세요<br></td>
                                <td>2021.04.20<br></td>
                            </tr>
                            <tr>
                                <td>서교동 코인빨래방 어디있어 ?<br></td>
                                <td>2021.03.07<br></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col">
                <div class="table-responsive text-center">
                    <table class="table">
                        <thead>
                            <tr>
                                <th style="width: 60%;"><strong>올리브네 인기글</strong><br></th>
                                <th><a href="http://localhost:9090/olive/#"><strong>&gt; 더보기</strong></a><br></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>상수역에서 저녁 같이 먹을 올리브 구해요<br></td>
                                <td>2021.05.28<br></td>
                            </tr>
                            <tr>
                                <td>서울 맛집 리스트<br></td>
                                <td>2021.04.20<br></td>
                            </tr>
                            <tr>
                                <td>귤 무료나눔해요<br></td>
                                <td>2021.03.07<br></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col">
                <div class="row">
                    <div class="col text-center"><span>함께 사는 올리브</span></div>
                </div>
                <div class="row">
                    <div class="col text-center"><span>진행중인 공동구매</span></div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row">
                            <div class="col"><img src="assets/img/desk.jpg" style="width: 100%;"></div>
                        </div>
                        <div class="row">
                            <div class="col text-center"><span>과일</span></div>
                        </div>
                        <div class="row">
                            <div class="col text-center"><span>대충 내용 설명</span></div>
                        </div>
                        <div class="row">
                            <div class="col text-center"><i class="fa fa-arrow-right"></i></div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="row">
                            <div class="col"><img src="assets/img/building.jpg" style="width: 100%;"></div>
                        </div>
                        <div class="row">
                            <div class="col text-center"><span>수건</span></div>
                        </div>
                        <div class="row">
                            <div class="col text-center"><span>대충 내용 설명</span></div>
                        </div>
                        <div class="row">
                            <div class="col text-center"><i class="fa fa-arrow-right"></i></div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="row">
                            <div class="col"><img src="assets/img/loft.jpg" style="width: 100%;"></div>
                        </div>
                        <div class="row">
                            <div class="col text-center"><span>휴지</span></div>
                        </div>
                        <div class="row">
                            <div class="col text-center"><span>대충 내용 설명<br></span></div>
                        </div>
                        <div class="row">
                            <div class="col text-center"><i class="fa fa-arrow-right"></i></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>