<!DOCTYPE html>
<html lang="zxx">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
 @media only screen and (min-width: 768px) {
 	.classes__filter form .class__filter__input {
 		width: calc(70% - 5px);
 		float: left;
 		margin-right: 30px;
 	}
 }

 @media only screen and (max-width: 991px) {
 	.classes__filter form .class__filter__input {
 		width: 100%;
 		margin-right: 0;
 		margin-bottom: 20px;
 		float: none;
 	}
}

.classes__item__text .class-btn:hover {
    background: #ffffff;
    border: 1px solid #5768AD;
    color: #5768AD;
}
.classes__item__text .class-btn {
	font-size: 17px;
	font-weight: 700;
	color: #ffffff;
	background: #5768AD;
	display: inline-block;
	border: 1px solid rgba(155, 158, 163, 0.2);
	padding: 10px 20px 7px;
	border-radius: 2px;
	-webkit-transition: all 0.4s;
	-moz-transition: all 0.4s;
	-ms-transition: all 0.4s;
	-o-transition: all 0.4s;
	transition: all 0.4s;
}

.team__slider.owl-carousel .owl-stage-outer {
	padding-top: 10px;
	padding-bottom: 40px;
}
</style>

<body>

	<!-- Breadcrumb Begin -->
	<section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>레시피</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->
	<!-- Breadcrumb Begin -->
	<section class="team spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12" style="height: 60px;">
					<div class="section-title" style="text-align: left">
						<h3 style="font-weight: bold;">🏆조회수 TOP 5</h3>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="team__slider owl-carousel">
					<c:forEach var="recipeTopList" items="${result}" varStatus="status">
						<div class="col-lg-6">
							<div class="team__item" style="padding-top: 10px; padding-bottom: 10px;">
								<div class="classes__item__pic set-bg" data-setbg="${recipeTopList.filePath}" style="background-image: ${recipeTopList.filePath};">
									<span>${recipeTopList.inDate}</span>
								</div>
								<div class="classes__item__text" style="padding-top: 10px; padding-bottom: 10px; padding-left: 0; padding-right: 0;">
									<div style="text-align: right;">
										<div style="display: inline-block; vertical-align: middle;">
											<img src="./resources/img/common/hit.png" style="width: 19px; height: 12px; opacity: 0.5;">
										</div>
<!-- 										조회수 -->
										<div style="display: inline-block; vertical-align: sub;">
											<p style="margin: 0;">${recipeTopList.commonHit}&nbsp;&nbsp;</p>
										</div>
										<div style="display: inline-block; vertical-align: middle;">
											<img src="./resources/img/common/reply.PNG" style="width: 17px; height: 17px; opacity: 0.5;">
										</div>
<!-- 										댓글수 -->
										<div style="display: inline-block; vertical-align: sub;">
											<p>${recipeTopList.cnt}&nbsp;&nbsp;</p>
										</div>
										<input type="hidden" value="${sessionScope.memberId }" id="sessionId">
										<input type="hidden" value="${recipeTopList.communitySeq}" id="communitySeq">
<!-- 										좋아요 이미지 찍히는 곳 -->
										<div style="display: inline-block; vertical-align: middle;" id="div_good_img">
											<c:set var="recipeTopList" value="${recipeTopList}" />
											<c:if test="${recipeTopList.goodFlag == '1' }">
												<img src="./resources/img/common/red_like.png" style="width: 17px; height: 15px;" class="remove" alt="G">
											</c:if>
											<c:if test="${recipeTopList.goodFlag == '0' }">
												<img src="./resources/img/common/like.png" style="width: 17px; height: 15px;" class="full" alt="G">
											</c:if>
										</div>

<!-- 										좋아요수 -->
										<div style="display: inline-block; vertical-align: sub;" id="div_good_cnt">
											<p>${recipeTopList.boardGood}&nbsp;&nbsp;</p>
										</div>

<!-- 										북마크 이미지 찍히는 곳 -->
										<div style="display: inline-block; vertical-align: middle;" id="div_book_img">
											<c:set var="recipeTopList" value="${recipeTopList}" />
											<c:if test="${recipeTopList.bookFlag == '1' }">
												<img src="./resources/img/common/yellow_bookmark.png" style="width: 12px; height: 16px;" class="remove" alt="B">
											</c:if>
											<c:if test="${recipeTopList.bookFlag == '0' }">
												<img src="./resources/img/common/bookmark.png" style="width: 12px; height: 16px;" class="full" alt="B">
											</c:if>
										</div>

<!-- 										북마크수 -->
										<div style="display: inline-block; vertical-align: sub;" id="div_book_cnt">
											<p>${recipeTopList.boardGood}&nbsp;&nbsp;</p>
										</div>
									</div>
									<h4 style="margin-bottom: 10px;">
										<a style="font-size: 0.8em; font-weight: bold;">${recipeTopList.commonTitle}</a>
									</h4>
									<div>
										<div style="display: inline-block; vertical-align: middle;">
											<img src="./resources/img/common/writer.PNG" style="width: 24px; height: 26px; opacity: 0.5;" />
										</div>
										&nbsp;
										<div style="display: inline-block;">
											<h6 style="margin-bottom: 25px; color: #535353">${recipeTopList.inUserId}</h6>
										</div>
									</div>
									<a href="recipeDetail.do?communitySeq=${recipeTopList.communitySeq}" class="class-btn" style="width: 100%; text-align: center;">상세보기</a>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</section>
	<!-- Team Section End -->

	<!-- Classes Section Begin -->
	<section class="classes spad">
		<div class="container">
			<div class="classes__filter">
				<div class="row">
					<div class="col-lg-12">

						<form method="get" id="frm" action="/recipeList.do#location123">
							<input type="hidden">
							<div class="class__filter__select">
								<p>Level:</p>
								<select name="selLev" id="selLev">
									<option value="">전체</option>
									<option value="조회순" <c:if test="${selLev == '조회순'}">selected</c:if>>조회순</option>
									<option value="좋아요순" <c:if test="${selLev == '좋아요순'}">selected</c:if>>좋아요순</option>
									<option value="댓글순" <c:if test="${selLev == '댓글순'}">selected</c:if>>댓글순</option>
								</select>
							</div>
							<div class="class__filter__input">
								<p>Search:</p>
								<input type="text" placeholder="검색" id="keyword" name="keyword" value="${keyword}">
							</div>
							<div class="class__filter__btn">
								<button type="submit" style="cursor: pointer;">
									<i class="fa fa-search"></i>
								</button>
							</div>
							<span id="location123"></span>
						</form>

					</div>
				</div>
			</div>
			<div class="classes__item__text" style="text-align: right; padding-top: 0;">
				<span class="blinking">나만의 레시피 등록하러 가기 → </span>&nbsp;
				<a href="recipeAdd.do" class="class-btn_w">글쓰기</a>
			</div>
			<div class="row">

				<c:forEach var="data" items="${data}" varStatus="status">
					<div class="col-lg-4 col-md-6">
						<div class="classes__item classes__item__page">
							<div class="classes__item__pic set-bg" data-setbg="${data.filePath}"></div>
							<div class="classes__item__text" style="padding-left: 5px; padding-right: 5px;">
								<div style="text-align: right;">
									<div style="display: inline-block;vertical-align:sub;float: left">
										<p style="margin:0;">${fn:substring(data.inDate,0,10)}&nbsp;&nbsp;</p>
									</div>
									<div style="display: inline-block; vertical-align: middle;">
										<img src="./resources/img/common/hit.png" style="width: 19px; height: 12px; opacity: 0.5;">
									</div>
									<div style="display: inline-block; vertical-align: sub;">
										<p style="margin: 0;">${data.commonHit }&nbsp;&nbsp;</p>
									</div>
									<div style="display: inline-block; vertical-align: middle;">
										<img src="./resources/img/common/reply.PNG" style="width: 17px; height: 17px; opacity: 0.5;">
									</div>
									<div style="display: inline-block; vertical-align: sub;">
										<p>${data.cnt}&nbsp;&nbsp;</p>
									</div>
									<input type="hidden" value="${sessionScope.memberId }" id="sessionId">
									<input type="hidden" value="${data.communitySeq}" id="communitySeq">
									<!-- 좋아요 이미지 찍히는 곳 -->
									<div style="display: inline-block; vertical-align: middle;" id="div_good_img">
										<c:set var="data" value="${data}" />
										<c:if test="${data.goodFlag == '1' }">
											<img src="./resources/img/common/red_like.png" style="width: 17px; height: 15px;" class="remove" alt="G">
										</c:if>
										<c:if test="${data.goodFlag == '0' }">
											<img src="./resources/img/common/like.png" style="width: 17px; height: 15px;" class="full" alt="G">
										</c:if>
									</div>

									<!-- 좋아요수 -->
									<div style="display: inline-block; vertical-align: sub;" id="div_good_cnt">
										<p>${data.boardGood}&nbsp;&nbsp;</p>
									</div>

									<!-- 북마크 이미지 찍히는 곳 -->
									<div style="display: inline-block; vertical-align: middle;" id="div_book_img">
										<c:set var="data" value="${data}" />
										<c:if test="${data.bookFlag == '1'}">
											<img src="./resources/img/common/yellow_bookmark.png" style="width: 12px; height: 16px;" class="remove" alt="B">
										</c:if>
										<c:if test="${data.bookFlag == '0' }">
											<img src="./resources/img/common/bookmark.png" style="width: 12px; height: 16px;" class="full" alt="B">
										</c:if>
									</div>

									<!-- 북마크수 -->
									<div style="display: inline-block; vertical-align: sub;" id="div_book_cnt">
										<p>${data.boardGood}&nbsp;&nbsp;</p>
									</div>
								</div>
								<p style="color: #CE60FA;"></p>
								<h4 style="margin-bottom: 30px;">
									<a href="recipeDetail.do?communitySeq=${data.communitySeq}" style="font-size: 0.8em; font-weight: bold;">${data.commonTitle}</a>
								</h4>
								<div>
									<div style="display: inline-block; vertical-align: middle;">
										<img src="./resources/img/common/writer.PNG" style="width: 24px; height: 26px; opacity: 0.5;">
									</div>
									&nbsp;
									<div style="display: inline-block;">
										<h6 style="margin-bottom: 25px;">${data.inUserId}</h6>
									</div>
								</div>
								<a href="recipeDetail.do?communitySeq=${data.communitySeq}" class="class-btn" style="width: 100%; text-align: center;">상세보기</a>
							</div>
						</div>
					</div>

				</c:forEach>

            	<!-- 페이징처리 -->
            	<div class="col-lg-12">
					<div class="classes__pagination">
					<c:if test="${pageMaker.prev}">
						<a href="recipeList.do${pageMaker.makeQuery(pageMaker.startPage - 1)}">
							<span class="arrow_carrot-left"></span>
						</a>
					</c:if>

					<c:set var="page" value="${pageMaker.cri.page}"/>
					<c:set var="idx" value="${idx}"/>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            			<a href="recipeList.do${pageMaker.makeQuery(idx)}" <c:if test="${page == idx }">style="background: #5768AD;color:#FFFFFF;"</c:if>>${idx}</a>
					</c:forEach>

					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<a href="recipeList.do${pageMaker.makeQuery(pageMaker.endPage + 1)}"><span class="arrow_carrot-right"></span></a>
					</c:if>
					</div>
				</div>

			</div>
		</div>
	</section>
	<!-- Classes Section End -->
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