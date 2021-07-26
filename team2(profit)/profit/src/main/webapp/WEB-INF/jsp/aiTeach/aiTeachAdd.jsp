<!DOCTYPE html>
<html lang="zxx">
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<body>


	<!-- Breadcrumb Begin -->
	<section class="breadcrumb-option set-bg"
		data-setbg="./resources/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>AI 자세교정</h2>
						<div class="breadcrumb__widget">
							<span>게시글을 작성합니다</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->

	<div class="container">
		<section class="classes spad">
			<div style="text-align: center;">
				<h3
					style="padding-left: 15px; color: #263246; font-family: DM Sans, sans-serif; font-weight: 400;">🔎
					회원들과 공유할 게시글을 작성해주세요. 사진은 자동첨부 됩니다.</h3>
			</div>
			<br /> <br />
			<main role="main" class="container" style="text-align: center;">
				<form name="form" method="get" action="/boardDetail">
					<div class="pt-1"></div>
					<input type="text" name="title" placeholder="제목을 입력하세요"
						style="border-radius: 5px; width: 85%; padding: 5px;border: 1px solid #9e9e9e8a;margin-bottom: 10px;">
<textarea id="ai_write" rows="" cols="" placeholder="내용을 입력하세요" style="border-radius: 5px;">
</textarea>
					
					<br />
					<div class="classes__item__text" style="text-align: center;padding-top: 10px;">
		                 <a href="aiTeachList" class="class-btn_w" style="width: 158px;">게시판에 등록하기</a>
		   		 	</div>
				</form>
			</main>
		</section>
	</div>


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