<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/recipe.js"></script>
<style>
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
	width: 140px;
}

#reply {
	width: 90%;
	font-size: 13px;
	color: #6E7580;
	padding-left: 30px;
	border: 1px solid rgba(0, 0, 0, 0.1);
	background: #ffffff;
	border-radius: 2px;
	height: 50px;
	margin-bottom: 35px;
	resize: none;
	padding-top: 14px;
	margin-top: 15px;
}

.breadcrumb-option, .blog-hero {
	padding-top: 215px;
	padding-bottom: 170px;
	margin-top: -50px;
}
</style>
<script type="text/javascript">
	//댓글 등록
	function fn_reipeReplyAdd() {
		var formData = new FormData($('#replyfrm')[0]);
		$.ajax({
			type : 'post',
			url : 'recipeReplyInsert.do',
			data : formData,
			processData : false,
			contentType : false,
			async : false,
			dataType : "text",
			success : function(data) {
				if (data == "ok") {
					alert("댓글이 정상적으로 등록되었습니다.");
					$("textarea[name=replyContent]").val('');
					$(".replyarea").load(location.href + " .replyarea");
				} else if (data == "ng") {
					alert("댓글을 다시 입력해주세요 .");
				} else {
					alert("댓글을 다시 입력해주세요 .");
				}
			}
		})

	}
	//대 댓글 등록 recipeReplyAdd
	function fn_reipeReplyAdd_Add(replySeq) {
		var formData = new FormData($('#replyfrmAdd'+replySeq)[0]);
		$.ajax({
			type : 'post',
			url : 'recipeReplyAdd.do',
			data : formData,
			processData : false,
			contentType : false,
			async : false,
			dataType : "text",
			success : function(data) {
				if (data == "ok") {
					alert("답변이 정상적으로 등록되었습니다.");
					$("textarea[name=replyContent]").val('');
					$(".replyarea").load(location.href + " .replyarea");
				} else if (data == "ng") {
					alert("답변을 다시 입력해주세요 .");
				} else {
					alert("답변을 다시 입력해주세요 .");
				}
			}
		})
	}

	//댓글 삭제
	function fn_reply_del(replySeq) {
		var result = confirm("정말 댓글을 삭제하시겠습니까?" + replySeq);
		if (result) {
			var replySeq = "replySeq=" + replySeq;
			$.ajax({
				type : 'POST',
				async : false,
				url : 'recipeReplyDelete.do',
				data : replySeq,
				success : function(data) {
					if (data == "ok") {
						alert("댓글이 정상적으로 삭제되었습니다.");
						$("textarea[name=replyContent]").val('');
						$(".replyarea").load(location.href + " .replyarea");
					} else if (data == "ng") {
						alert("댓글을 다시 삭제해주세요 .");
					} else {
						alert("댓글을 다시 삭제해주세요 .");
					}
				}
			})
		}
	}
	//대댓글 창
	function recipeDetailReplyAddAdd(replySeq) {
		if($('.replyfrmAdd'+replySeq).css('display') == 'none'){
			$('.replyfrmAdd'+replySeq).css('display','block');
		} else {
			$('.replyfrmAdd'+replySeq).css('display','none')
		}
	};

//좋아요 북마크
	$(function(){
		//좋아요북마크 취소
		$(document).on("click",".remove",function(){
			var memberId = $("#sessionId").val();
			var communitySeq = $("#communitySeq").val();
			var bookgoodGubun = $(this).attr('alt');

			$.ajax({
				type : "get",
				data : {memberId:memberId, bookgoodGubun:bookgoodGubun, communitySeq:communitySeq},
				url : "removeBookgoodAjax.do",
				success : function(result) {
					if (result == "no") {
						alert("문제가 발생하였습니다. 잠시후 다시 시도해주세요")
					} else {
						if(bookgoodGubun == 'G'){
							var txt = "";
							txt += "<img src='./resources/img/common/like.png' style='width: 17px; height: 15px;' class='full' alt='G' />"
							$("#div_good_img").html(txt);
							var txt2 = "";
							txt2 += "<p>"+result+"&nbsp;&nbsp;</p>"
							$("#div_good_cnt").html(txt2);
						}else{
							var txt = "";
							txt += "<img src='./resources/img/common/bookmark.png' style='width: 12px; height: 16px;' class='full' alt='B' />"
							$("#div_book_img").html(txt);
							var txt2 = "";
							txt2 += "<p>"+result+"&nbsp;&nbsp;</p>"
							$("#div_book_cnt").html(txt2);
						}
					}
				},
				error : function() {
					alert("오류발생");
				}
			});
		}); //.remove 클릭 이벤트 끝


		//좋아요북마크 추가
		$(document).on("click",".full",function(){
			var memberId = $("#sessionId").val();
			var communitySeq = $("#communitySeq").val();
			var bookgoodGubun = $(this).attr('alt');

			$.ajax({
				type : "get",
				data : {memberId:memberId, bookgoodGubun:bookgoodGubun, communitySeq:communitySeq},
				url : "addBookgoodAjax.do",
				success : function(result) {
					if (result == "no") {
						alert("문제가 발생하였습니다. 잠시후 다시 시도해주세요")
					} else {
						if(bookgoodGubun == 'G'){
							var txt = "";
							txt += "<img src='./resources/img/common/red_like.png' style='width: 17px; height: 15px;' class='remove' alt='G' />"
							$("#div_good_img").html(txt);
							var txt2 = "";
							txt2 += "<p>"+result+"&nbsp;&nbsp;</p>"
							$("#div_good_cnt").html(txt2);
						}else{
							var txt = "";
							txt += "<img src='./resources/img/common/yellow_bookmark.png' style='width: 12px; height: 16px;' class='remove' alt='B' />"
							$("#div_book_img").html(txt);
							var txt2 = "";
							txt2 += "<p>"+result+"&nbsp;&nbsp;</p>"
							$("#div_book_cnt").html(txt2);
						}
					}
				},
				error : function() {
					alert("오류발생");
				}
			});
		}); //.full 이벤트 끝


	});

</script>

</head>
<body>
	<!-- Blog Hero Begin -->
	<section class="breadcrumb-option blog-hero set-bg" data-setbg="./resources/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="blog__hero__text">
						<h2>레시피</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Blog Hero End -->

	<!-- Blog Details Section Begin -->
	<section class="blog-details spad">
		<c:set var="data" value="${data}" />
		<div class="container">
			<div class="row" style="justify-content: center">
				<div style="display: left; width: 30%">
					<div class="blog__sidebar">

						<div class="blog__sidebar__recent">
							<h4>최신글</h4>
							<c:forEach var="recipeNewList" items="${recipeNewList}">
								<div class="blog__recent__item" onclick="location.href='recipeDetail.do?communitySeq=${recipeNewList.communitySeq}'">
									<div class="blog__recent__item__pic">
										<img src="${recipeNewList.filePath }" alt="" style="width: 90px; height: 70px;">
									</div>
									<div class="blog__recent__item__text">
										<h6>${recipeNewList.commonTitle }</h6>
										<span>${recipeNewList.inDate }</span>
									</div>
								</div>
							</c:forEach>

						</div>
						<div class="blog__sidebar__tags">
							<h4>인기글</h4>
							<c:forEach var="recipeGoodList" items="${recipeGoodList}">
								<div class="blog__recent__item">
									<div class="blog__recent__item__pic">
										<img src="${recipeGoodList.filePath }" alt="" style="width: 90px; height: 70px;">
									</div>
									<div class="blog__recent__item__text">
										<h6>${recipeGoodList.commonTitle}</h6>
										<span>${recipeGoodList.inDate}</span>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="col-lg-8 order-lg-2 order-1" style="background-color: white; padding: 30px; border: 1px solid #ebecef; border-radius: 10px; display: left;">
					<div style="margin-bottom: 30px;">
						<span style="font-size: 1.3em; font-weight: bold; color: #545454">${data.commonTitle}</span>
					</div>
					<div style="text-align: right; margin-bottom: 5px; padding-right: 8px;">
						<div style="display: inline-block; vertical-align: sub;">
							<p style="margin: 0;">${data.inDate}&nbsp;&nbsp;</p>
						</div>
						<div style="display: inline-block; vertical-align: middle;">
							<img src="./resources/img/common/hit.png" style="width: 19px; height: 12px; opacity: 0.5;">
						</div>
						<div style="display: inline-block; vertical-align: sub;">
							<p style="margin: 0;">${data.commonHit}&nbsp;&nbsp;</p>
						</div>
						<div style="display: inline-block; vertical-align: middle;">
							<img src="./resources/img/common/newreply.png" style="width: 17px; height: 17px; opacity: 0.5;">
						</div>
						<div style="display: inline-block; vertical-align: sub;">
							<p>${data.cnt}&nbsp;&nbsp;</p>
						</div>

						<input type="hidden" value="${sessionScope.memberId }" id="sessionId">
						<input type="hidden" value="${data.communitySeq}" id="communitySeq">
						<!-- 좋아요 이미지 찍히는 곳 -->
						<div style="display: inline-block; vertical-align: middle;" id="div_good_img">
							<c:set var="boardDetail" value="${boardDetail}" />
							<c:if test="${boardDetail.goodFlag == '1' }">
								<img src="./resources/img/common/red_like.png" style="width: 17px; height: 15px;" class="remove" alt="G">
							</c:if>
							<c:if test="${boardDetail.goodFlag == '0' }">
								<img src="./resources/img/common/like.png" style="width: 17px; height: 15px;" class="full" alt="G">
							</c:if>
						</div>

						<!-- 좋아요수 -->
						<div style="display: inline-block; vertical-align: sub;" id="div_good_cnt">
							<p>${boardDetail.boardGood}&nbsp;&nbsp;</p>
						</div>

						<!-- 북마크 이미지 찍히는 곳 -->
						<div style="display: inline-block; vertical-align: middle;" id="div_book_img">
							<c:set var="boardDetail" value="${boardDetail}" />
							<c:if test="${boardDetail.bookFlag == '1' }">
								<img src="./resources/img/common/yellow_bookmark.png" style="width: 12px; height: 16px;" class="remove" alt="B">
							</c:if>
							<c:if test="${boardDetail.bookFlag == '0' }">
								<img src="./resources/img/common/bookmark.png" style="width: 12px; height: 16px;" class="full" alt="B">
							</c:if>
						</div>

						<!-- 북마크수 -->
						<div style="display: inline-block; vertical-align: sub;" id="div_book_cnt">
							<p>${boardDetail.boardBook}&nbsp;&nbsp;</p>
						</div>
					</div>
					<hr style="color: #545454">
					<div class="blog__details">
						<div style="width: auto; height: auto; min-height: 100px;">${data.commonContent}</div>
						<div style="text-align: right;">
							<div class="classes__item__text" style="text-align: center;">
								<a href="recipeList.do" class="class-btn" style="text-align: center;">목 록</a>
								<c:set var="inUser" value="${sessionScope.memberId}" />
								<c:if test="${data.inUserId == inUser}">
									<a href="${path}recipeMod.do?communitySeq=${data.communitySeq}" class="class-btn">수정</a>
									<a href="${path}recipeDelete.do?communitySeq=${data.communitySeq}" class="class-btn">삭제</a>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Blog Details Section End -->

	<!-- Leave Comment Begin -->
	<!-- 	댓글부분 -->
	<div class="leave-comment spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="leave__comment__text">
						<h2>😁자유롭게 댓글을 달아보세요</h2>
					</div>

				</div>
				<div id="reply_area" class="col-lg-4 order-lg-1 order-2 replyarea" style="width: 100%; flex: 0 0 100%; max-width: 100%; padding-right: 0px; margin-left: 23px;">
					<div class="blog__sidebar">
						<div class="blog__sidebar__comment" style="overflow-x: hidden; height: 500px; padding: 10px;">
							<h4>댓글(${data.cnt}개) </h4>
							<div class="classes__sidebar__comment" style="border-bottom: 0">

								<c:set var="recipeDetailReply" value="${recipeDetailReply}" />
								<c:set var="recipeDetailReplyList" value="${recipeDetailReplyList}" />
								<c:set var="recipeDetailMember" value="${recipeDetailMember}" />
								<c:if test="${not empty recipeDetailReply}">
									<c:forEach var="recipeDetailReply" items="${recipeDetailReply}">
										<!-- 댓글달기 -->
										<!-- 댓글목록 -->
										<form id="frm">
											<div class="classes__sidebar__comment__pic">
												<img src="${recipeDetailReply.FILE_PATH }" alt="">
											</div>
											<div class="classes__sidebar__comment__text">
												<h6>
													${recipeDetailReply.IN_USER_ID}&nbsp;&nbsp;&nbsp;&nbsp;
													<a style="font-size: 0.8em; color: gray; cursor:pointer;" onclick="recipeDetailReplyAddAdd(${recipeDetailReply.REPLY_SEQ})">
														답글달기
													</a>
													<span style="font-size: 0.8em; color: gray; float: right; padding-right: 20px;">${recipeDetailReply.IN_DATE}</span>
												</h6>
												<div style="margin-top: 20px;">
													<p>
														${recipeDetailReply.REPLY_CONTENT}
														<c:set var="inUser" value="${sessionScope.memberId}" />
														<c:if test="${recipeDetailReply.IN_USER_ID eq inUser}">
															<img src="./resources/img/common/delete.png" width="15px" onclick="fn_reply_del(${recipeDetailReply.REPLY_SEQ})">
														</c:if>
													</p>
												</div>
											</div>
											<br>
										</form>
										<!--대 댓글 목록 -->
										<c:forEach var="recipeDetailReplyList" items="${recipeDetailReplyList}">
											<c:if test="${recipeDetailReply.REPLY_SEQ eq recipeDetailReplyList.REPLY_PARENT_SEQ}">
												<form id="frm" style="margin-left: 100px;">
													<div class="classes__sidebar__comment__pic">
														<img src="${recipeDetailReplyList.FILE_PATH}" alt="">
													</div>
													<div class="classes__sidebar__comment__text">
														<h6>
															${recipeDetailReplyList.IN_USER_ID}&nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size: 0.8em; color: gray; float: right; padding-right: 20px;">${recipeDetailReplyList.IN_DATE}</span>
														</h6>
														<div style="margin-top: 20px;">
															${recipeDetailReplyList.REPLY_CONTENT}
															<c:set var="inUser" value="${sessionScope.memberId}" />
															<c:if test="${recipeDetailReplyList.IN_USER_ID eq inUser}">
																<img src="./resources/img/common/delete.png" width="15px"  onclick="fn_reply_del(${recipeDetailReplyList.REPLY_SEQ})">
															</c:if>
														</div>
													</div>
													<br>
												</form>
											</c:if>
										</c:forEach>
										<!-- 대댓글 달기 -->
										<form class="replyfrmAdd${recipeDetailReply.REPLY_SEQ}" id="replyfrmAdd${recipeDetailReply.REPLY_SEQ}" style="display: none;">
											<input type="hidden" name="replySeq" value="${recipeDetailReply.REPLY_SEQ}">
											<input type="hidden" name="memberId" value="${memberId}">
											<input type="hidden" name="communitySeq" value="${data.communitySeq}">
											<div class="row">
												<div class="col-lg-12"></div>
												<div class="col-lg-12" style="margin-top: 15px; margin-left: 100px;">
													<div class="classes__sidebar__comment__pic">
														<img src="${recipeDetailMember.FILE_PATH}" alt="" style="max-width: 70px; float: left;">
													</div>
													<textarea id="reply" name="replyContent" placeholder="답글을 입력해 주세요." style="width: 67%; float: left"></textarea>
													<input type="button" class="site-btn" style="font-size: 1.05em; width: 120px; height: 48px; padding: 0; float: left; margin-top: 15px; margin-left: 5px;" onclick="fn_reipeReplyAdd_Add(${recipeDetailReply.REPLY_SEQ})" value="답글작성">
												</div>
											</div>
										</form>
										<hr>
									</c:forEach>
								</c:if>
								<c:if test="${empty recipeDetailReply}">
									<form id="frm">
										<div class="classes__sidebar__comment__text">
											<div style="margin-top: 20px;">
												<input type="hidden" />
												<p>댓글이 없습니다.</p>
											</div>
										</div>
										<br>
										<hr>
									</form>
								</c:if>
							</div>

							<c:set var="inUser" value="${sessionScope.memberId}" />
							<form id="replyfrm">
								<input type="hidden" name="communitySeq" value="${data.communitySeq}">
								<input type="hidden" name="memberId" value="${sessionScope.memberId}">
								<div class="row">
									<div class="col-lg-12"></div>
									<div class="col-lg-12">
										<div class="classes__sidebar__comment__pic">
											<img src="${recipeDetailMember.FILE_PATH}" alt="">
										</div>
										<textarea id="reply" name="replyContent" placeholder="댓글을 입력해 주세요." style="width: 79%; float: left"></textarea>
										<input type="button" class="site-btn" style="font-size: 1.05em; width: 120px; height: 48px; padding: 0; float: right; margin-top: 15px;" onclick="fn_reipeReplyAdd()" value="댓글등록">
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!-- Js Plugins -->
	<script src="./resources/js/bootstrap.min.js"></script>
	<script src="./resources/js/jquery.nice-select.min.js"></script>
	<script src="./resources/js/jquery.barfiller.js"></script>
	<script src="./resources/js/jquery.slicknav.js"></script>
	<script src="./resources/js/owl.carousel.min.js"></script>
	<script src="./resources/js/main.js"></script>
</body>
</html>