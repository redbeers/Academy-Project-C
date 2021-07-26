.<!DOCTYPE html>
<html lang="zxx">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="./resources/js/board.js"></script>
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
    background:#5768AD;
    display: inline-block;
    border: 1px solid rgba(155, 158, 163, 0.2);
    padding: 10px 20px 7px;
    border-radius: 2px;
    -webkit-transition: all 0.4s;
    -moz-transition: all 0.4s;
    -ms-transition: all 0.4s;
    -o-transition: all 0.4s;
    transition: all 0.4s;
    width:140px;
}

#reply{

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
    margin-top: -75px;
}

</style>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
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


function fn_toggle(cnt){
	$("#rereply_div"+ cnt).toggle("fast");
}

function fn_replyAdd(){
	var formData = new FormData($('#replyfrm')[0]);
	$.ajax({
		type : 'post',
		url : 'replyAddAjax.do',
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
		url : 'rereplyAddAjax.do',
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
			url:"replyDelAjax.do",
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
</script>
<body>


    <!-- Breadcrumb Begin -->
    <section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h2>자유 게시판</h2>
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
                <div style="display: left;width: 30%">
                <div class="blog__sidebar" >
						<div class="blog__sidebar__recent">
							<h4>최신글</h4>
							<c:forEach var="result" items="${BoardDetail['recentBoardList']}" varStatus="status">
							<div class="blog__recent__item" onclick="location.href='boardDetail.do?communitySeq=${result.communitySeq}'">
								<div class="blog__recent__item__pic">
									<img src="${result.filePath}" alt="" style="width: 90px;height: 70px;">
								</div>
								<div class="blog__recent__item__text">
									<h6>${result.commonTitle}</h6>
									<span>${fn:substring(result.inDate,0,16)}</span>
									
								</div>
							</div>
							</c:forEach>
						</div>
						<div class="blog__sidebar__tags" >
							<h4>인기글</h4>
							<c:forEach var="result" items="${BoardDetail['bestBoardList']}" varStatus="status">
							<div class="blog__recent__item" onclick="location.href='boardDetail.do?communitySeq=${result.communitySeq}'">
								<div class="blog__recent__item__pic">
									<img src="${result.filePath}" alt="" style="width: 90px;height: 70px;">
								</div>
								<div class="blog__recent__item__text">
									<h6>${result.commonTitle}</h6>
									<span>${fn:substring(result.inDate,0,16)}</span>
									
								</div>
							</div>
							</c:forEach>
						</div>
					</div>
				</div>
                <div class="col-lg-8 order-lg-2 order-1" style="background-color: white;padding: 30px;border: 1px solid #ebecef;border-radius: 10px;display: left;">
                	<div style="margin-bottom: 30px;">
                		<span style="font-size: 1.3em; font-weight: bold;color: #545454">${BoardDetail['commonTitle']}</span>
                	</div>
                	<div style="float: left;margin-left: 5px;padding-top:5px;">
                        	<p style="font-weight: bold; color: #8B94B5;padding-right: 30px;">카테고리 | <span>${BoardDetail['communityCategoryName']}</span></p>
                        </div>
                	<div  style="text-align: right;margin-bottom: 5px;padding-right: 8px;">
                        <div style="display: inline-block;vertical-align:sub;">
							<p style="margin:0;">${BoardDetail['inDate']}&nbsp;&nbsp;</p>
						</div>
                        <div style="display: inline-block; vertical-align: middle;">
							<img src="./resources/img/common/hit.png" style="width: 19px; height: 12px; opacity: 0.5;">
						</div>
						<div style="display: inline-block;vertical-align:sub;">
							<p style="margin:0;">${BoardDetail['commonHit']}&nbsp;&nbsp;</p>
						</div>
						<div style="display: inline-block; vertical-align: middle;">
							<img src="./resources/img/common/newreply.png" style="width: 17px; height: 17px; opacity: 0.5;">
						</div>
						<div style="display: inline-block;vertical-align:sub;">
							<p>${BoardDetail['boardReply']}&nbsp;&nbsp;</p>
						</div>
						
						<input type="hidden" value="${sessionScope.memberId }" id="sessionId">
						<input type="hidden" value="${BoardDetail['communitySeq']}" id="communitySeq">
						
						<!-- 좋아요 이미지 찍히는 곳 -->
						<div style="display: inline-block; vertical-align: middle;" id="div_good_img">
							<c:set var="goodFlag" value="${BoardDetail['goodFlag']}"/>
                  			<c:if test="${goodFlag == '1' }">
								<img src="./resources/img/common/red_like.png" style="width: 17px; height: 15px;" class="remove" alt="G">
							</c:if>
							<c:if test="${goodFlag == '0' }">
								<img src="./resources/img/common/like.png" style="width: 17px; height: 15px;" class="full" alt="G">
							</c:if>
						</div>
						
						<!-- 좋아요수 -->
						<div style="display: inline-block;vertical-align:sub;" id="div_good_cnt">
							<p>${BoardDetail['boardGood']}&nbsp;&nbsp;</p>
						</div>
						
						<!-- 북마크 이미지 찍히는 곳 -->
						<div style="display: inline-block; vertical-align: middle;" id="div_book_img">
							<c:set var="bookFlag" value="${BoardDetail['bookFlag']}"/>
                  			<c:if test="${bookFlag == '1' }">
								<img src="./resources/img/common/yellow_bookmark.png" style="width: 12px; height: 16px;" class="remove" alt="B">
							</c:if>
							<c:if test="${bookFlag == '0' }">
								<img src="./resources/img/common/bookmark.png" style="width: 12px; height: 16px;" class="full" alt="B">
							</c:if>
						</div>
						
						<!-- 북마크수 -->
						<div style="display: inline-block;vertical-align:sub;" id="div_book_cnt">
							<p>${BoardDetail['boardBook']}&nbsp;&nbsp;</p>
						</div> 
        			</div>
        			<hr style="color: #545454">
                    <div class="blog__details">
                    	<div style="width: auto;min-height: 780px;" >
						
						
						${BoardDetail['commonContent']}
						
						</div>
						<div style="text-align: right;">
                        	<div class="classes__item__text" style="text-align: center;">
		                        
		                        <c:if test="${BoardDetail['inUserId'] eq memberId}">
		                        <a href="boardMod.do?communitySeq=${BoardDetail['communitySeq']}" class="class-btn" style="text-align: center;">수정</a>
		                        <a class="class-btn" style="text-align: center;" onclick="fn_boardDel(${BoardDetail['communitySeq']})">삭제</a>
								</c:if>
	                            <a href="boardList.do" class="class-btn" style="text-align: center;">목록</a>
                        	
                        	
                        	</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Details Section End -->

    <!-- Leave Comment Begin -->
    <div class="leave-comment spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="leave__comment__text">
                        <h2>😁자유롭게 댓글을 달아보세요</h2>
                    </div>
                </div>
                
                <div id="reply_area" class="col-lg-4 order-lg-1 order-2 replyarea" style="width: 100%;flex: 0 0 100%;max-width: 100%;padding-right: 0px;margin-left: 23px;">
                
                    <div class="blog__sidebar">
                        
                        <div class="blog__sidebar__comment" style="overflow-x:hidden;height: 500px;padding:10px;">
                            <h4>댓글(총 ${BoardDetail['replyCnt']}개)</h4>
	                            <div class="classes__sidebar__comment" style="border-bottom: 0">
	                                   <c:forEach var="result" items="${BoardDetail['replyList']}" varStatus="status">
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
				                                    <img src="${BoardDetail['MyProfileImage']}" alt="" >
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
                            <input type="hidden" name="communitySeq" value="${BoardDetail['communitySeq']}">
                            <div class="row">
                                <div class="col-lg-12">
                                </div>
                                <div class="col-lg-12">
	                                <div class="classes__sidebar__comment__pic">
	                                    <img src="${BoardDetail['MyProfileImage']}" alt="">
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
    <script src="./resources/js/jquery-3.3.1.min.js"></script>
    <script src="./resources/js/bootstrap.min.js"></script>
    <script src="./resources/js/jquery.nice-select.min.js"></script>
    <script src="./resources/js/jquery.barfiller.js"></script>
    <script src="./resources/js/jquery.slicknav.js"></script>
    <script src="./resources/js/owl.carousel.min.js"></script>
    <script src="./resources/js/main.js"></script>
<script type="text/javascript">

$(function(){
///////////////
	
// 	$(".full").click(function(){
		
// 		alert("dddddd");

	
// 	});
	
	
});
</script>
</body>

</html>