<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
</style>
<script type="text/javascript">

	function fn_numberAlert(flag, seq){
		
		if(flag == 'N'){
			alert("보유하신 이용권이 존재하지 않습니다.");
			location.href="buyTicket.do";
			return;
		}
		 if(confirm("상담을 진행하면 이용권 하나가 차감됩니다. 계속 진행하시겠습니까?"))
		 {	
		  	location.href="chatting.do?chatProfileSeq=" + seq;
		 }
	}
	
	function fn_toggle(cnt){
		$("#rereply_div"+ cnt).toggle("fast");
	}

	function fn_replyAdd(){
		var formData = new FormData($('#replyfrm')[0]);
		$.ajax({
			type : 'post',
			url : 'chatReplyAddAjax.do',
			data : formData,
			processData : false,
			contentType : false,
			async:false,
			dataType:"text",
			success : function(data){
				if(data=="ok"){
					alert("문의 댓글이 정상적으로 등록되었습니다.");
					$("textarea[name=replyContent]").val('');
					$(".replyarea").load(location.href + " .replyarea");
				}else if(data=="ng"){
					alert("문의 댓글이 실패하였습니다. 다시 시도해주세요");
				}else{
					alert("문의 댓글이 실패하였습니다. 다시 시도해주세요");
				}
			},
			error : function(error){
				alert("문의 댓글이 실패하였습니다. 다시 시도해 주세요.");
				console.log(error);
				console.log(error.status);
			}
		})
	}

	function fn_rereply(cnt){
		var formData = new FormData($('#frm'+ cnt)[0]);
		
		$.ajax({
			type : 'post',
			url : 'chatRereplyAddAjax.do',
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
					alert("문의댓글 등록이 실패하였습니다. 다시 시도해주세요");
				}else{
					alert("문의댓글 등록이 실패하였습니다. 다시 시도해주세요");
				}
			},
			error : function(error){
				alert("문의댓글 등록이 실패하였습니다. 다시 시도해 주세요.");
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
	function fn_private(seq){
		var result = confirm("상담 프로필을 비활성화 하시겠습니까?");
		if(result == true){
			location.href = "chatProfilePrivate.do?chatProfileSeq=" + seq;
		}else{
			return;
		}
	}
	
	function fn_public(seq){
		var result = confirm("상담 프로필을 활성화 하시겠습니까?");
		if(result == true){
			location.href = "chatProfilePublic.do?chatProfileSeq=" + seq;
		}else{
			return false;
		}
	}
	
</script>
</head>

<body>
<!-- Breadcrumb Begin -->
    <section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h2>1:1 상담</h2>
                        
                    </div>
                </div>
            </div>
        </div>
    </section>
<!-- Breadcrumb End -->
<section class="about spad">
        <div class="container">
            
            <div class="row">
                <div class="col-lg-7 p-0">
                    <div class="about__pic" style="text-align: center;margin-top: 50px;">
                        <img src="${chatDetail['filePath']}" style="width: 500px;height: 500px;">
                    </div>
                </div>
                <div class="col-lg-5 p-0">
                    <div class="about__text">
                        <div class="section-title">
                            <h2>${chatDetail['memberName']} <span style="font-size: 0.6em;color:#5768AD">헬스 트레이너</span></h2>
                            <br>
                            <p style="font-weight: bold;">▶ 간단소개</p>
                            <p> ${chatDetail['chatProfileIntro']}</p>
                        </div>
                        <div class="appointment__text" style="background-color: #9e9e9e0a;padding:10px;">
							<!-- <div class="row">
					<div class="col-lg-12">
						<div class="section-title">
							<h2></h2>
						</div>
					</div>
				</div> -->
							<form action="#" class="appointment__form">
								<div class="text-center">

									<div class="col-lg-6 text-center mypage_myinfo"
										style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
										<div class="row">
											<div class="col-lg-12"></div>
											<div class="col-lg-12 text-center" style="padding:0">
												<textarea readonly="readonly"
													style="background-color: #3f51b50d; color: black;padding:20px;margin:0;border-radius: 10px;resize: none;
													width: 460px;height: 300px;">
${chatDetail['chatProfileMemo']}</textarea>

											</div>
										</div>
									</div>
                    </div>
                    </form>
                </div>
	                <div class="classes__item__text"  style="text-align: center;padding-top: 10px;">
	                	<c:if test="${memberGubun eq 'U'}">
				         <a class="class-btn_w" style="font-size: 1.05em;width:110px;" onclick="fn_numberAlert('${ticketAvailable}','${chatDetail['chatProfileSeq']}')">1:1 상담</a>
				         </c:if>
				         <c:if test="${memberId eq chatDetail['chatProfileId']}">
				         <a href="chatProfileMod.do?chatProfileSeq=${chatDetail['chatProfileSeq']}" class="class-btn_w" style="font-size: 1.05em;width: 110px;" >수정</a>
				         	<c:if test="${chatDetail['chatProfilePrivate'] eq 'N'}">
					         <a class="class-btn_w" style="font-size: 1.05em;width: 110px;" onclick="fn_private(${chatDetail['chatProfileSeq']})">비활성화</a>
				         	</c:if>
				         	<c:if test="${chatDetail['chatProfilePrivate'] eq 'Y'}">
					         <a class="class-btn_w" style="font-size: 1.05em;width: 110px;" onclick="fn_public(${chatDetail['chatProfileSeq']})">활성화</a>
				         	</c:if>
				         </c:if>
				         <a href="chatList.do" class="class-btn_w" style="font-size: 1.05em;width: 110px;" >목록</a>
				    </div>
            </div>
        </div>
        </div>
        </div>
        
    </section>
    <!-- About Section End -->
	 <!-- Leave Comment Begin -->
    <div class="leave-comment spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="leave__comment__text">
                        <h2>😜궁금하신 점을 문의해보세요</h2>
                    </div>
                </div>
                
                <div id="reply_area" class="col-lg-4 order-lg-1 order-2 replyarea" style="width: 100%;flex: 0 0 100%;max-width: 100%;padding-right: 0px;margin-left: 23px;">
                
                    <div class="blog__sidebar">
                        
                        <div class="blog__sidebar__comment" style="overflow-x:hidden;height: 500px;padding:10px;">
                            <h4>댓글</h4>
	                            <div class="classes__sidebar__comment" style="border-bottom: 0">
	                                   <c:forEach var="result" items="${chatDetail['replyList']}" varStatus="status">
	                                <form id="frm${status.count}">
	                                <input type="hidden" name="chatProfileSeq" value="${result.chatProfileSeq}">
	                                <c:if test="${empty result.replyParentSeq}"><c:set var="cnt" value="${result.replySeq}" /></c:if>
									<input type="hidden" name="replyParentSeq" value="${cnt}">
	                                <div class="classes__sidebar__comment__pic" style="<c:if test="${result.replyDepth == 2}">margin-left:100px;</c:if>">
	                                    <img src="${result.filePath}" alt="">
	                                </div>
	                                <div class="classes__sidebar__comment__text">
	                                    <h6>
	                                     	${result.memberNickname}&nbsp;&nbsp;&nbsp;&nbsp;
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
				                                    <img src="${chatDetail['myprofileimage']}" alt="" >
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
                            <input type="hidden" name="chatProfileSeq" value="${chatDetail['chatProfileSeq']}">
                            <div class="row">
                                <div class="col-lg-12">
                                </div>
                                <div class="col-lg-12">
	                                <div class="classes__sidebar__comment__pic">
	                                    <img src="${chatDetail['myprofileimage']}" alt="">
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
</body>
<!-- Js Plugins -->
    <script src="./resources/js/jquery-3.3.1.min.js"></script>
    <script src="./resources/js/bootstrap.min.js"></script>
    <script src="./resources/js/jquery.nice-select.min.js"></script>
    <script src="./resources/js/jquery.barfiller.js"></script>
    <script src="./resources/js/jquery.slicknav.js"></script>
    <script src="./resources/js/owl.carousel.min.js"></script>
    <script src="./resources/js/main.js"></script>
</html>