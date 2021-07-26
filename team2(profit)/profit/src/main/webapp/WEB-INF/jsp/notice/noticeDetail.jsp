<!DOCTYPE html>
<%@page import="java.io.OutputStream"%>
<html lang="zxx">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

</script>


<body>

	<!-- Blog Hero Begin -->
	<section class="breadcrumb-option blog-hero set-bg" data-setbg="./resources/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="blog__hero__text">
						<h2>공지사항</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Blog Hero End -->

	<!-- Blog Details Section Begin -->
	<section class="blog-details spad">
		<div class="container">
			<div class="row" style="justify-content: center">
				<div class="col-lg-8 order-lg-2 order-1" style="text-align: center;">
					<c:set var="data" value="${data}" />
					<span style="font-size: 1.3em; font-weight: bold;">${data.commonTitle}</span>
				</div>
			</div>
			<div class="blog__details__text">
				<div style="text-align: right; margin-bottom: 0px; padding-right: 8px; line-height: 90px;">
					<div style="display: inline-block; vertical-align: sub;">
						<p style="font-weight: bold; padding-right: 30px;">
							관리자&nbsp;&nbsp; <span>${data.inUserId}</span>
						</p>
					</div>
					<div style="display: inline-block; vertical-align: sub;">
						<p style="margin: 0;">${data.inDate}&nbsp;&nbsp;</p>
					</div>
					<div style="display: inline-block; vertical-align: middle;">
						<img src="./resources/img/common/hit.png" style="width: 19px; height: 12px; opacity: 0.5;">
					</div>
					<div style="display: inline-block; vertical-align: sub;">
						<p style="margin: 0;">${data.commonHit}&nbsp;&nbsp;</p>
					</div>
				</div>
			</div>
			<hr>
			<c:forEach var="noticeDetailFile" items="${noticeDetailFile}">
				<form id="form${noticeDetailFile.fileDetailSeq}" method="post" action="qnaProfileDownload.do">
					<input type="hidden" name="communitySeq" value="${data.communitySeq}">
					<input type="hidden" name="fileDetailSeq" value="${noticeDetailFile.fileDetailSeq}">
					<c:if test="${not empty noticeDetailFile.fileRealName}">
						<a id="submitA" onclick="document.getElementById('form${noticeDetailFile.fileDetailSeq}').submit();return;" style="float: right; color: #343a40; cursor: pointer">
							<img src="./resources/img/common/DownloadIcon2.jpg" style="width: 25px; height: 25px; opacity: 0.5;">
							${noticeDetailFile.fileRealName}
						</a>
					</c:if>
				</form>
			</c:forEach>
			<br>
			<div class="blog__details__text">
				<p>${data.commonContent}</p>
			</div>
			<hr>


			<div class="classes__item__text" style="text-align: center;">
				<a href="noticeList.do" class="class-btn">목록</a>
				<c:set var="inUser" value="${sessionScope.memberId}" />
				<c:if test="${inUser eq '1'}">
					<a href="${path}noticeMod.do?communitySeq=${data.communitySeq}" class="class-btn">수정</a>
					<a href="${path}noticeDelete.do?communitySeq=${data.communitySeq}" class="class-btn">삭제</a>
				</c:if>
			</div>
		</div>
	</section>
	<!-- Blog Details Section End -->

	<!-- Js Plugins -->
	<script src="./resources/js/bootstrap.min.js"></script>
	<script src="./resources/js/jquery.nice-select.min.js"></script>
	<script src="./resources/js/jquery.barfiller.js"></script>
	<script src="./resources/js/jquery.slicknav.js"></script>
	<script src="./resources/js/owl.carousel.min.js"></script>
	<script src="./resources/js/main.js"></script>


</body>

</html>