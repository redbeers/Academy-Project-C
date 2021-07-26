<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<style type="text/css">
.btn div {
	display: inline-block;
	padding-right: .75rem;
	padding-left: .75rem;
}

#t1, #t2, #t3, #t4 {
	display: none;
}
</style>
</head>
<body>
	<!-- Blog Hero Begin -->
	<section class="breadcrumb-option blog-hero set-bg" data-setbg="./resources/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="blog__hero__text">
						<h2>온라인 강의</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Blog Hero End -->
	<!-- 	main html 시작 -->
	<section class="about spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-7 p-0" style="overflow: hidden; display: flex; align-items: center; justify-content: center;">
					<div class="about__pic" style="">
						<img src="./resources/img/classes/pul.gif" alt="" style="width: 85%; height: 450px;">
					</div>
				</div>
				<div class="col-lg-5 p-0">
					<div class="about__text">
						<div class="section-title">
							<h2>What We Do</h2>
							<p>To be invited to the nearest Cali center and get free physical advice to learn more about the program.</p>
						</div>
						<div class="about__bar">
							<div class="about__bar__item">
								<p>Breathing</p>
								<div id="bar1" class="barfiller">
									<span class="tip" style="left: 562.603px; transition: left 1s ease-in-out 0s;">82%</span>
									<span class="fill" data-percentage="82" style="background: rgb(87, 104, 173); width: 590.4px; transition: width 1s ease-in-out 0s;"></span>
								</div>
							</div>
							<div class="about__bar__item">
								<p>Methabolism</p>
								<div id="bar2" class="barfiller">
									<span class="tip" style="left: 497.803px; transition: left 1s ease-in-out 0s;">73%</span>
									<span class="fill" data-percentage="73" style="background: rgb(87, 104, 173); width: 525.6px; transition: width 1s ease-in-out 0s;"></span>
								</div>
							</div>
							<div class="about__bar__item">
								<p>Flexibility</p>
								<div id="bar3" class="barfiller">
									<span class="tip" style="left: 562.603px; transition: left 1s ease-in-out 0s;">82%</span>
									<span class="fill" data-percentage="82" style="background: rgb(87, 104, 173); width: 590.4px; transition: width 1s ease-in-out 0s;"></span>
								</div>
							</div>
							<div class="about__bar__item">
								<p>Strongness</p>
								<div id="bar4" class="barfiller">
									<span class="tip" style="left: 591.403px; transition: left 1s ease-in-out 0s;">86%</span>
									<span class="fill" data-percentage="86" style="background: rgb(87, 104, 173); width: 619.2px; transition: width 1s ease-in-out 0s;"></span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 	main html 시작 -->
	<!-- 	변경 DIV 시작 -->
	<script type="text/javascript">
		// 	style="border-bottom: 3px solid #7952B3;"
		$(function() {
			$('#tite1').click(function() {
				$('#li1').css('border-bottom', '3px solid #7952B3');
				$('#li2').css('border-bottom', '3px solid #ffffff');
				$('#li3').css('border-bottom', '3px solid #ffffff');
				$('#li4').css('border-bottom', '3px solid #ffffff');
				$('#t1').show().siblings('div').hide();
			})
		});
		$(function() {
			$('#tite2').click(function() {
				$('#li1').css('border-bottom', '3px solid #ffffff');
				$('#li2').css('border-bottom', '3px solid #7952B3');
				$('#li3').css('border-bottom', '3px solid #ffffff');
				$('#li4').css('border-bottom', '3px solid #ffffff');
				$('#t2').show().siblings('div').hide();
			})
		});
		$(function() {
			$('#tite3').click(function() {
				$('#li1').css('border-bottom', '3px solid #ffffff');
				$('#li2').css('border-bottom', '3px solid #ffffff');
				$('#li3').css('border-bottom', '3px solid #7952B3');
				$('#li4').css('border-bottom', '3px solid #ffffff');
				$('#t3').show().siblings('div').hide();
			})
		});
		$(function() {
			$('#tite4').click(function() {
				$('#li1').css('border-bottom', '3px solid #ffffff');
				$('#li2').css('border-bottom', '3px solid #ffffff');
				$('#li3').css('border-bottom', '3px solid #ffffff');
				$('#li4').css('border-bottom', '3px solid #7952B3');
				$('#t4').show().siblings('div').hide();
			})
		});
	</script>
	<section class="about spad">
		<div class="container">
			<main id="main" class="site-main" role="main">
				<div id="" class="">
					<div class="d-flex justify-content-between align-items-center has-border">
						<ul id="titeul" class="nav sub-nav sub-nav--has-border">
							<li class="nav-item" id="li1">
								<a id="tite1" class="nav-link sub-nav-link">클래스 소개</a>
							</li>
							<li class="nav-item" id="li2">
								<a id="tite2" class="nav-link sub-nav-link">커리큘럼</a>
							</li>
							<li class="nav-item" id="li3">
								<a id="tite3" class="nav-link sub-nav-link">리뷰</a>
							</li>
							<li class="nav-item" id="li4">
								<a id="tite4" class="nav-link sub-nav-link ">문의하기</a>
							</li>
						</ul>
					</div>
					<div class="tab-content" style="padding-bottom: 50px; padding-top: 50px;">
						<div class="tab-pane fade mt-2 mt-lg-5 active show" id="description-tab" role="tabpanel" aria-expanded="false">
							<div id="t1" style="display: block;">
								<p>요청서를 보낸 후 어떻게 진행되는지 알려드릴게요1111</p>
								<p>1 요청서 작성 요청서 작성 도움이 필요한 서비스의 요청서를 상세히 작성하고 고수를 소개받으세요</p>
								<p>2 견적 비교 견적 비교 최대 48시간 이내에 고수들이 제공하는 견적을 받아보고 꼼꼼히 비교해 보세요</p>
								<p>3 연락 및 거래 연락 및 거래 원하는 고수와 채팅 및 전화(안심번호)를 통해 거래하세요</p>
								<p>4 리뷰 쓰기 리뷰 쓰기 거래가 잘 마무리 되었다면 서비스에 대한 리뷰를 남겨주세요</p>
							</div>
							<div id="t2">
								<h3>필라테스</h3>
								<p>살사댄스에 피트니스가 결합하여 만들어진 줌바! 신나는 라틴음악에 맞추어 역동적으로 추는 춤! 라틴댄스의 기본스텝을 바탕으로 팔의 움직임을 더하여 쉴 새 없이 움직이는게 특징입니다. 1시간에 -1000kcal 러닝머신 약 7배 효과!!!!!</p>
							</div>
							<div id="t3">
								<div class="row">
									<div class="col-lg-12">
										<div class="leave__comment__text">
											<h2>자유롭게 리뷰를 달아보세요😁</h2>
											<form action="#">
												<div class="row">
													<div class="col-lg-12"></div>
													<div class="col-lg-12 text-center">
														<textarea placeholder="리뷰를 입력해 주세요."></textarea>
														<button type="submit" class="site-btn" style="font-size: 1.2em;">작성 완료</button>
													</div>
												</div>
											</form>
										</div>
									</div>
									<div class="col-lg-4 order-lg-1 order-2" style="width: 100%; flex: 0 0 100%; max-width: 100%; padding-right: 0px; margin-left: 23px;">
										<div class="blog__sidebar">
											<div class="blog__sidebar__comment" style="overflow: scroll; height: 500px;">
												<h4>리뷰</h4>
												<div class="classes__sidebar__comment">
													<div class="classes__sidebar__comment__pic">
														<img src="./resources/img/classes-details/comment-1.png" alt="">
														<div class="classes__sidebar__comment__rating">
															<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-half-o"></i>
														</div>
													</div>
													<div class="classes__sidebar__comment__text">
														<span>04 Mar 2018</span>
														<h6>Brandon Kelley</h6>
														<p>Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit,</p>
													</div>
												</div>
												<div class="classes__sidebar__comment">
													<div class="classes__sidebar__comment__pic">
														<img src="./resources/img/classes-details/comment-1.png" alt="">
														<div class="classes__sidebar__comment__rating">
															<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-half-o"></i>
														</div>
													</div>
													<div class="classes__sidebar__comment__text">
														<span>04 Mar 2018</span>
														<h6>Brandon Kelley</h6>
														<p>Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit,</p>
													</div>
												</div>
												<div class="classes__sidebar__comment">
													<div class="classes__sidebar__comment__pic">
														<img src="./resources/img/classes-details/comment-1.png" alt="">
														<div class="classes__sidebar__comment__rating">
															<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-half-o"></i>
														</div>
													</div>
													<div class="classes__sidebar__comment__text">
														<span>04 Mar 2018</span>
														<h6>Brandon Kelley</h6>
														<p>Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit,</p>
													</div>
												</div>
												<div class="classes__sidebar__comment">
													<div class="classes__sidebar__comment__pic">
														<img src="./resources/img/classes-details/comment-1.png" alt="">
														<div class="classes__sidebar__comment__rating">
															<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-half-o"></i>
														</div>
													</div>
													<div class="classes__sidebar__comment__text">
														<span>04 Mar 2018</span>
														<h6>Brandon Kelley</h6>
														<p>Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit,</p>
													</div>
												</div>
												<div class="classes__sidebar__comment">
													<div class="classes__sidebar__comment__pic">
														<img src="./resources/img/classes-details/comment-2.png" alt="">
														<div class="classes__sidebar__comment__rating">
															<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-half-o"></i>
														</div>
													</div>
													<div class="classes__sidebar__comment__text">
														<span>04 Mar 2018</span>
														<h6>Christina Kelley</h6>
														<p>Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet,</p>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div id="t4">
								<div class="row">
									<div class="col-lg-12">
										<div class="leave__comment__text">
											<h3>📝 문의를 남겨주세요</h3>
											<form action="#">
												<div class="row">
													<div class="col-lg-12"></div>
													<div class="col-lg-12 text-center">
														<textarea placeholder="리뷰를 입력해 주세요."></textarea>
														<button type="submit" class="site-btn" style="font-size: 1.2em;">작성 완료</button>
													</div>
												</div>
											</form>
										</div>
									</div>
									<div class="col-lg-4 order-lg-1 order-2" style="width: 100%; flex: 0 0 100%; max-width: 100%; padding-right: 0px; margin-left: 23px;">
										<div class="blog__sidebar">
											<div class="blog__sidebar__comment" style="overflow: scroll; height: 500px;">
												<h4>리뷰</h4>
												<div class="classes__sidebar__comment">
													<div class="classes__sidebar__comment__pic">
														<img src="./resources/img/classes-details/comment-1.png" alt="">
														<div class="classes__sidebar__comment__rating">
															<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-half-o"></i>
														</div>
													</div>
													<div class="classes__sidebar__comment__text">
														<span>04 Mar 2018</span>
														<h6>Brandon Kelley</h6>
														<p>Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit,</p>
													</div>
												</div>
												<div class="classes__sidebar__comment">
													<div class="classes__sidebar__comment__pic">
														<img src="./resources/img/classes-details/comment-1.png" alt="">
														<div class="classes__sidebar__comment__rating">
															<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-half-o"></i>
														</div>
													</div>
													<div class="classes__sidebar__comment__text">
														<span>04 Mar 2018</span>
														<h6>Brandon Kelley</h6>
														<p>Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit,</p>
													</div>
												</div>
												<div class="classes__sidebar__comment">
													<div class="classes__sidebar__comment__pic">
														<img src="./resources/img/classes-details/comment-1.png" alt="">
														<div class="classes__sidebar__comment__rating">
															<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-half-o"></i>
														</div>
													</div>
													<div class="classes__sidebar__comment__text">
														<span>04 Mar 2018</span>
														<h6>Brandon Kelley</h6>
														<p>Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit,</p>
													</div>
												</div>
												<div class="classes__sidebar__comment">
													<div class="classes__sidebar__comment__pic">
														<img src="./resources/img/classes-details/comment-1.png" alt="">
														<div class="classes__sidebar__comment__rating">
															<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-half-o"></i>
														</div>
													</div>
													<div class="classes__sidebar__comment__text">
														<span>04 Mar 2018</span>
														<h6>Brandon Kelley</h6>
														<p>Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit,</p>
													</div>
												</div>
												<div class="classes__sidebar__comment">
													<div class="classes__sidebar__comment__pic">
														<img src="./resources/img/classes-details/comment-2.png" alt="">
														<div class="classes__sidebar__comment__rating">
															<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-half-o"></i>
														</div>
													</div>
													<div class="classes__sidebar__comment__text">
														<span>04 Mar 2018</span>
														<h6>Christina Kelley</h6>
														<p>Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet,</p>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
			</main>
		</div>
	</section>
	<!-- 	변경 DIV 시작 -->
</body>
<!-- Js Plugins -->
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="./resources/js/jquery.nice-select.min.js"></script>
<script src="./resources/js/jquery.barfiller.js"></script>
<script src="./resources/js/jquery.slicknav.js"></script>
<script src="./resources/js/owl.carousel.min.js"></script>
<script src="./resources/js/main.js"></script>
<link rel="stylesheet" href="https://themes.getbootstrap.com/wp-content/themes/bootstrap-marketplace/style.css?ver=1590611604">
</html>