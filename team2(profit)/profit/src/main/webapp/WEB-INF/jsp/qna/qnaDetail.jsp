<!DOCTYPE html>
<html lang="zxx">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="./resources/js/jquery-3.3.1.min.js"></script>

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

#tb1{
	border: 1px solid #D7D8D8;
	width: 70%;
	margin-left: auto;
	margin-right: auto;
	font-size: 1.2em;
}

#tb1 tr td{
	padding: 20px;
	text-align: center;
	border: 1px solid #D7D8D8;
	background-color: white;
}

#tb1 tr th{
	padding: 20px;
	text-align: center;
	border: 1px solid #D7D8D8;
	width: 15%;
	background-color: #ECF6FE;
}
</style>
<script type="text/javascript">
	//댓글 등록
	function fn_replyAdd(){
	var formData = new FormData($('#replyfrm')[0]);
		$.ajax({
			type : 'post',
			url : 'qnaReplyAddAjax.do',
			data : formData,
			processData : false,
			contentType : false,
			async:false,
			dataType:"text",
			success : function(data){
				if(data=="ok"){
					alert("댓글이 정상적으로 등록되었습니다.");
					$("textarea[name=replyContent]").val('');
					$(".replyarea").load(location.href + " .replyarea");
				}else if(data=="ng"){
					alert("댓글 등록이 실패하였습니다. 다시 시도해주세요");
				}else{
					alert("댓글 등록이 실패하였습니다. 다시 시도해주세요");
				}
			},
			error : function(error){
				alert("등록이 실패하였습니다. 다시 시도해 주세요.");
				console.log(error);
				console.log(error.status);
			}
		})
	}
	function fn_rereply(cnt){
		var formData = new FormData($('#frm'+ cnt)[0]);

		$.ajax({
			type : 'post',
			url : 'qnaRereplyAddAjax.do',
			data : formData,
			processData : false,
			contentType : false,
			async:false,
			dataType:"text",
			success : function(data){
				if(data=="ok"){
					alert("댓글이 정상적으로 등록되었습니다.");
					$("textarea[name=replyContent]").val('');
					$(".replyarea").load(location.href + " .replyarea");
				}else if(data=="ng"){
					alert("댓글 등록이 실패하였습니다. 다시 시도해주세요");
				}else{
					alert("댓글 등록이 실패하였습니다. 다시 시도해주세요");
				}
			},
			error : function(error){
				alert("등록이 실패하였습니다. 다시 시도해 주세요.");
				console.log(error);
				console.log(error.status);
			}


		})
	}

	function fn_reply_del(seq){
		var result = confirm("정말 댓글을 삭제하시겠습니까?");
		if(result){
			var params = "replySeq="+ seq;
			$.ajax({
				type:"POST",
				async:false,
				url:"QnaReplyDelAjax.do",
				data:params,
				success : function(data){
					if(data=="ok"){
						alert("댓글이 정상적으로 삭제되었습니다.");
						$("textarea[name=replyContent]").val('');
						$(".replyarea").load(location.href + " .replyarea");
					}else if(data=="ng"){
						alert("댓글 삭제가 실패하였습니다. 다시 시도해주세요");
					}else{
						alert("댓글 삭제가 실패하였습니다. 다시 시도해주세요");
					}
				},
				error : function(error){
					alert("삭제가 실패하였습니다. 다시 시도해 주세요.");
					console.log(error);
					console.log(error.status);
				}
			});

		}

	}

	function fn_boardDel(seq){
		var result = confirm("정말 글을 삭제하시겠습니까?");
		if(result){
			var params = "communitySeq="+ seq;
			$.ajax({
				type:"POST",
				async:false,
				url:"BoardDelAjax.do",
				data:params,
				success : function(data){
					if(data=="ok"){
						alert("글이 정상적으로 삭제되었습니다.");
						location.href="boardList.do"
					}else if(data=="ng"){
						alert("글 삭제가 실패하였습니다. 다시 시도해주세요");
					}else{
						alert("글 삭제가 실패하였습니다. 다시 시도해주세요");
					}
				},
				error : function(error){
					alert("삭제가 실패하였습니다. 다시 시도해 주세요.");
					console.log(error);
					console.log(error.status);
				}
			});

		}
	}

	function fn_toggle(cnt){
		$("#rereply_div"+ cnt).toggle("fast");
	}


</script>

<body>
	<!-- Breadcrumb Begi -->
	<section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg" style="background-image: url(&quot;./resources/img/breadcrumb.jpg&quot;);">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>문의하기 목록</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->

	<!-- Blog Details Section Begin -->
	<section class="blog-details spad">
		<div>
			<table id="tb1">
				<tr>
					<th>제목</th>
					<td>${qnaDetail['commonTitle']}</td>
				</tr>

				<tr>
					<th>작성자</th>
					<td>${qnaDetail['inUserId']}</td>
				</tr>

				<tr>
					<th>작성일</th>
					  <c:set var = "str" value = "${qnaDetail['inDate']}"/>
     				  <c:set var = "date1" value = "${fn:substring(str, 0, 10)}" />
     				  <c:set var = "date2" value = "${fn:substring(str, 10, 20)}" />
					<td>${date1}&nbsp;&nbsp;&nbsp;${date2}</td>
				</tr>
				<tr>
					<td colspan="2">
					${qnaDetail['commonContent']}
					</td>
				</tr>
			</table>
			<div style="text-align: right;">
				<div class="classes__item__text" style="text-align: center;">
					<a href="qnaList.do" class="class-btn" style="text-align: center;">목 록</a>
					<c:set var="inUser" value="${sessionScope.memberId}" />
					<c:if test="${qnaDetail['inUserId'] == inUser}">
						<a href="qnaMod.do?communitySeq=${qnaDetail.communitySeq}" class="class-btn">수정</a>
						<a href="${path}qnaDelete.do?communitySeq=${qnaDetail.communitySeq}" class="class-btn">삭제</a>
					</c:if>
				</div>
			</div>
		</div>
	</section>
	<!-- Blog Details Section End -->




	<!-- Leave Comment Begin -->
    <div class="leave-comment spad">
        <div class="container">
            <div class="row">
                <div id="reply_area" class="col-lg-4 order-lg-1 order-2 replyarea" style="width: 100%;flex: 0 0 100%;max-width: 100%;padding-right: 0px;margin-left: 23px;">

                    <div class="blog__sidebar">

                        <div class="blog__sidebar__comment" style="overflow-x:hidden;height: 500px;padding:10px;">
                            <h4>댓글(총 ${qnaDetail['replyCnt']}개)</h4>
	                            <div class="classes__sidebar__comment" style="border-bottom: 0">
	                                   <c:forEach var="result" items="${qnaDetail['replyList']}" varStatus="status">
	                                <form id="frm${status.count}">
	                                <input type="hidden" name="communitySeq" value="${result.communitySeq}">
	                                <c:if test="${empty result.replyParentSeq}"><c:set var="cnt" value="${result.replySeq}" /></c:if>
									<input type="hidden" name="replyParentSeq" value="${cnt}">
	                                <div class="classes__sidebar__comment__pic" style="<c:if test="${result.replyDepth == 2}">margin-left:100px;</c:if>">
	                                    <img src="${result.filePath}" alt="">
	                                </div>
	                                <div class="classes__sidebar__comment__text">

	                                    <h6>
		                                    <c:if test="${result.memberGubun eq 'T'}">
	                                    	<img src="./resources/img/common/trainer_icon.png" style="width: 25px; height: 25px;">
	                                    	</c:if>
	                                     	${result.memberNickname}&nbsp;
	                                     	<c:if test="${result.memberGubun eq 'T'}">(트레이너)&nbsp;</c:if>
	                                     	<c:if test="${result.replyDepth == 1}">
	                                     	<a style="font-size:0.8em;color:gray;" onclick='fn_toggle(${result.replySeq})'>답글달기</a>
	                                     	</c:if>
	                                     	<span style="font-size: 0.8em;color: gray;float: right;padding-right: 20px;">${fn:substring(result.inDate,0,10)}</span>
	                                    </h6>
	                                    <div style="margin-top: 20px;">
		                                    <p>${result.replyContent}
		                                    <c:if test="${result.inUserId eq memberId}">
		                                    <img src="./resources/img/common/delete.png" style="width: 15px; height: 15x;margin-left: 20px;"onclick="fn_reply_del(${result.replySeq})">
											</c:if>
		                                    </p>
	                                	</div>
	                                </div><br>
	                                <c:if test="${result.replyNextDepth == 1 || empty result.replyNextDepth}">
	                                	<div class="row" >
			                                <div id="rereply_div${cnt}" class="col-lg-12" style="margin-top: 15px;margin-left: 100px;display: none;">
				                                <div class="classes__sidebar__comment__pic">
				                                    <img src="${qnaDetail['MyProfileImage']}" alt="" >
				                                </div>
			                                    <textarea id="reply" name="replyContent" placeholder="답글을 입력해 주세요." style="width: 67%;float: left"></textarea>
			                                    <button type="button" class="site-btn" style="font-size: 1.05em; width: 120px;height: 48px;padding:0;float: left;margin-top: 15px;margin-left: 5px;" onclick="fn_rereply(${status.count})">답글작성</button>
			                                </div>
			                            </div>
	                                	<hr>
	                                </c:if>
	                                </form>
	                                </c:forEach>
	                            </div>
                            <form id="replyfrm">
                            <input type="hidden" name="communitySeq" value="${qnaDetail['communitySeq']}">
                            <div class="row">
                                <div class="col-lg-12">
                                </div>
                                <div class="col-lg-12">
	                                <div class="classes__sidebar__comment__pic">
	                                    <img src="${qnaDetail['MyProfileImage']}" alt="">
	                                </div>
                                    <textarea id="reply" name="replyContent" placeholder="댓글을 입력해 주세요." style="width: 79%;float: left"></textarea>
                                    <button type="button" class="site-btn" style="font-size: 1.05em; width: 120px;height: 48px;padding:0;float: right;margin-top: 15px;" onclick="fn_replyAdd()">댓글작성</button>
                                </div>

                            </div>
                        </form>
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>
    <!-- Leave Comment End -->


	<!-- Js Plugins -->

	<script src="./resources/js/bootstrap.min.js"></script>
	<script src="./resources/js/jquery.nice-select.min.js"></script>
	<script src="./resources/js/jquery.barfiller.js"></script>
	<script src="./resources/js/jquery.slicknav.js"></script>
	<script src="./resources/js/owl.carousel.min.js"></script>
	<script src="./resources/js/main.js"></script>
</body>

</html>