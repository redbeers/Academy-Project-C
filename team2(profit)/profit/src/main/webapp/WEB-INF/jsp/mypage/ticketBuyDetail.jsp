<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
li a {
    font-size: 16px;
    color: #9B9EA3;
}
li a:hover {
    color: #5768AD;
}
</style>
</head>
<body>

    <!-- Breadcrumb Begin -->
    <section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h2>마이페이지</h2>
                        
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb End -->

    <!-- Blog Section Begin -->
    <section class="blog spad">
        <div class="container">
            <div class="row">
            
				<!-- 사이드바 시작 -->
				<div class="col-lg-4 order-lg-1 order-2">
					<div class="blog__sidebar">
						<div class="blog__sidebar__categories">
							<h4>🧡 카테고리 🧡</h4>
							<ul>
								<li><a href="myinfo.do">- 내정보</a></li>
								<li><a href="bookmark.do">- 북마크</a></li>
								<li><a href="myLessonList.do">- 마이클래스</a></li>
								<li><a href="myChatList.do">- 1:1채팅내역</a></li>
							</ul>
						</div>
						
						<br>
						<div class="classes__sidebar">
	                        <div class="classes__sidebar__item classes__sidebar__item--info">
	                            <h4>🧡 채팅이용권 🧡</h4>
	                            <ul class="classes__sidebar__item__widget">
	                                <li><a href="ticketBuyList.do">- 이용권 구매내역</a></li><br>
	                                <li><a href="ticketUseList.do">- 이용권 사용내역</a></li>
	                            </ul>
	                        </div>
                        </div>
                        
						<div class="classes__sidebar">
	                        <div class="classes__sidebar__item classes__sidebar__item--info">
	                            <h4>🧡 트레이너 신청 🧡</h4>
	                            <ul class="classes__sidebar__item__widget">
	                                <li><span class="icon_calendar"></span><a href="trainerApplyList.do">나의 신청내역</a> </li>
	                                <li><span class="icon_id"></span><a href="trainerApply.do">신청하기</a></li>
	                            </ul>
	                        </div>
                        </div>
					</div>
				</div>
				<!-- 사이드바 끝 -->
                
                
                <!-- 여기부터 달라짐 -->
                <div class="col-lg-8 order-lg-2 order-1">
                    <div class="row" style="display: inline-block;width: 100%;" >
                        	<!-- Appoinment Section Begin -->
	<section class="appointment" style=" margin-bottom: 50px;">
		<div class="container">
			<div class="appointment__text" style="background-color: #9e9e9e0a; padding: 60px 10px;">
				<form action="#" class="appointment__form">
					<div class="text-center">
						<h4 style="font-family: DM Sans, sans-serif;color: #111111;font-weight: 400;">이용권 구매내역</h4>
						<br/>
						<p style="font-family: DM Sans, sans-serif;font-size: 1.2em;color:#5768AD;">나의 결제상세 정보를 확인해 보세요.</p>
						<br/><br/>
							<table class="table table-hover">
								<tr>
									<th style="background: #E6E6E6;">결제번호</th>
									<td>A294H90DWP</td>
								</tr>
								<tr>
									<th style="background: #E6E6E6;">이용권 종류</th>
									<td>3회</td>
								</tr>
								<tr>
									<th style="background: #E6E6E6;">결제일시</th>
									<td>2021/06/17</td>
								</tr>
								<tr>
									<th style="background: #E6E6E6;">금액(원)</th>
									<td>4,000</td>
								</tr>
							</table>
							<br/><br/>
							<div 
								style=" max-width: 100%; width: 500px; margin-left: auto;text-align: right;">
	                             <button type="button" class="site-btn" style="font-size: 1em;color: white; background-color: #5768AD;margin-right: 7px;" onClick="location.href='ticketPayList'">뒤로가기</button>
                        	</div>
					</div>
				</form>
			</div>
		</div>
	</section>
	<!-- Appoinment Section End -->
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Section End -->



    <!-- Js Plugins -->
    <script src="./resources/js/jquery-3.3.1.min.js"></script>
    <script src="./resources/js/bootstrap.min.js"></script>
    <script src="./resources/js/jquery.nice-select.min.js"></script>
    <script src="./resources/js/jquery.barfiller.js"></script>
    <script src="./resources/js/jquery.slicknav.js"></script>
    <script src="./resources/js/owl.carousel.min.js"></script>
    <script src="./resources/js/main.js"></script>
</body>
</html>