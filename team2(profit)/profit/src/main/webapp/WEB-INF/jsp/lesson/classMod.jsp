<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- Breadcrumb Begin -->
	<section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>강의 수정</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->
	<!-- Blog Section Begin -->
	<section class="blog spad">
		<div class="container" style="text-align: center;">
				<!-- 여기부터 달라짐 -->
					<div class="row" style="display: inline-block; width: 100%;">
						<!-- Appoinment Section Begin -->
						<section class="appointment" style="margin-bottom: 50px;">
							<div class="container">
								<div class="appointment__text" style="background-color: #9e9e9e0a">
									<form action="#" class="appointment__form">
										<div class="text-center">
											<h4 style="font-family: DM Sans, sans-serif; color: #111111; font-weight: 400;">강의 수정</h4>
											<br />
											<p style="font-family: DM Sans, sans-serif; font-size: 1.2em; color: #5768AD;">영상/이미지 형식</p>
											<p style="color: #5768AD;">▶ 이미지:100 MB, 동영상:5GB</p>
											<p style="color: #5768AD;">
												▶ 이미지:700 x 500
												<span style="color: #FC7F65;">jpg</span>
												파일로 첨부해주세요.
											</p>
											<p style="color: #5768AD;">
												▶ 동영상:1280 x 720
												<span style="color: #FC7F65;">avi</span>
												파일로 첨부해주세요.
											</p>
											<br />
											<br />
											<div class="col-lg-6 text-center mypage_myinfo" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
												<div style="margin-bottom: 2px;">
													<h5 style="display: inline; float: left; color: black;">강의명</h5>
													&nbsp;
												</div>
												<input type="text" placeholder="예)다리튼튼" style="background-color: #3f51b50d; color: black;" value="">
											</div>
											<div class="col-lg-6 text-center mypage_myinfo" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
												<div style="margin-bottom: 2px;">
													<h5 style="display: inline; float: left; color: black;">썸네일</h5>
													&nbsp;
													<div class="col-lg-12" style="text-align: right; float: left; padding: 0; margin: 0;">
														<input type="button" value="이미지 변경" class="site-btn updateBtn" style="float: right; padding: 1px 6px; font-size: 0.8em; color: white; background-color: #5768AD; width: 130px; height: 40px; margin-right: 7px;" onclick="fn_update()">
													</div>
												</div>
												<div class="input-group" style="margin-bottom: 5px;">
													<input type="text" class="form-control" placeholder="썸네일 이미지" style="background-color: #3f51b50d; color: black; margin-bottom: 5px;">
												</div>
											</div>
											<div class="col-lg-6 text-center mypage_myinfo" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
												<div style="margin-bottom: 2px;">
													<h5 style="display: inline; float: left; color: black;">강의 영상</h5>
													&nbsp;
													<div class="col-lg-12" style="text-align: right; float: left; padding: 0; margin: 0;">
														<input type="button" value="강의 영상 변경" class="site-btn updateBtn" style="float: right; padding: 1px 6px; font-size: 0.8em; color: white; background-color: #5768AD; width: 130px; height: 40px; margin-right: 7px;" onclick="fn_update()">
													</div>
												</div>
												<div class="input-group" style="margin-bottom: 5px;">
													<input type="text" class="form-control" placeholder="강의를 위한 영상" style="background-color: #3f51b50d; color: black; margin-bottom: 5px;">
												</div>
											</div>
											<br>
											<div class="classes__item__text" style="text-align: right;">
												<a href="classDetail" class="class-btn">수정</a>
											</div>
										</div>
									</form>
								</div>
							</div>
						</section>
						<!-- Appoinment Section End -->
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