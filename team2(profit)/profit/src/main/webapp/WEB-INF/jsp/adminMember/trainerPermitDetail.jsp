<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./resources/datepicker/jquery-ui.css">
<script src="./resources/datepicker/jquery-3.5.1.js"></script>
<script src="./resources/datepicker/jquery-ui.js"></script>

<style type="text/css">
.classes__filter form .class__filter__btn_re {
	padding-right: 125px;
}

.table tr:hover {
	background-color: #f8f6ff;
}
</style>
<script type="text/javascript">
//관리자 메모
function fn_memo(){
	var adminMemo = $("textarea#adminMemo").val();
	var processSeq = $("#processSeq").val();
	//ajax
	$.ajax({
		type : "POST",
		data : "adminMemo=" + adminMemo +"&processSeq=" + processSeq, 
		url : "adminMemoAjax.do",
		dataType : "text", 
	
		success : function(result) {
			console.log(result)
			if (result == "ok") {
				location.reload();
			} else {
				alert("문제가 발생했습니다");
			}
		},
		error : function() {
			alert("오류발생");
		}

	});
	
}


//승인, 보완, 취소 버튼
function fn_updStatus(processStatus){
	
	var resultReason = "";
	var processSeq = $("#processSeq").val();
	var memberName = $("#memberName").val();
	var memberId = $("#memberId").val();
	var memberMobile = $("#memberMobile").val();
	var trainerGym = $("#trainerGym").val();
	var trainerCareer = $("textarea#trainerCareer").val();
	var trainerAward = $("textarea#trainerAward").val();
	
	if(processStatus == 'E'){
		if(confirm("신청서를 승인하시겠습니까?") == true){
				
		}else{
			return;
		}
	}else if(processStatus == 'C'){
		if(confirm("신청서를 보완처리하시겠습니까?") == true){
			resultReason = prompt('보완사유를 입력해주세요');
		}else{
			return;
		}
	}else{
		if(confirm("신청서를 반려처리하시겠습니까?") == true){
			resultReason = prompt('반려사유를 입력해주세요');
		}else{
			return;
		}
	}
	
	//ajax
	$.ajax({
		type : "POST",
		data : "resultReason=" + resultReason +"&processSeq=" + processSeq + 
				"&processStatus=" + processStatus + "&memberName=" + memberName + 
				"&trainerGym=" + trainerGym + "&trainerCareer=" + trainerCareer + 
				"&trainerAward=" + trainerAward +
				"&memberId=" + memberId +
				"&memberMobile=" + memberMobile, 
		url : "updateStatusAjax.do",
		dataType : "text", 
	
		success : function(result) {
			console.log(result)
			if (result == "ok") {
				if(processStatus == 'E'){
					alert("승인처리가 완료되었습니다.");
				}else if(processStatus == 'C'){
					alert("보완처리가 완료되었습니다.");
				}else if(processStatus == 'D'){
					alert("반려처리가 완료되었습니다.");
				}
				location.reload();
			} else {
				alert("문제가 발생했습니다");
			}
		},
		error : function() {
			alert("오류발생");
		}

	});
	
	

}


//첨부파일
var cnt = 1;
function fn_addFile(){
    $("#d_file").append("<br>" + "<input type='file' id='file"+cnt+"' class='file_choice' name='file" + cnt + "'/>");
    $("#d_file").append("<input type='hidden' id='text"+cnt+"' class='file_choice' name='text'/>");
    
    cnt++;
}

function fn_delFile(){
   cnt -= 1;
   $("#file"+cnt).remove();
   
}

//관리자가 파일 직접 삭제=>input text
function fn_del(fileDetailSeq){
	if (confirm("파일을 삭제하시겠습니까?") == true){
		$("div").remove("#"+fileDetailSeq+"");
		$("#del_file").append("<br>" + "<input type='text' name='delFile' value=" + fileDetailSeq + ">");
	}else{  
	    return;
	}

}


//주황-수정완료 버튼
function fn_submit(){
   var msg = "ok";
   
   for(var i=1; i<cnt; i++){
      var file_val = $("#file"+i).val();
      if(!file_val){
         msg = "ng";
      }
   }
   
   if(msg=="ok"){
      var apply = confirm("정보를 수정하시겠습니까?");
      if(apply == true){
         send_file();
      }
      else{
         alert("수정이 취소되었습니다.")
      }
   }else{
      alert("첨부하지 않은 파일은 삭제해주세요");
      
   }
}


//실제 컨트롤러 ajax
function send_file(){
	var formData = new FormData($('#frm')[0]);
	
	console.log(formData)
	
	$.ajax({
		
	   	type : 'post',
	   	url : 'updateAdminPermitDetailAjax.do',
	   	data : formData,
	   	processData : false,
	   	contentType : false,
	   	async:false,
	   	dataType:"text",
	   	success : function(data){
		   if(data=="ok"){
		      alert("정보가 수정되었습니다.");
		      location.reload();
		   }else if(data=="no"){
		      alert("실패하였습니다. 다시 시도해주세요");
		   }else{
		      alert("실패하였습니다. 다시 시도해주세요");
		   }
		},
	   	error : function(error){
	      alert("실패하였습니다. 다시 시도해 주세요.");
	      console.log(error);
	      console.log(error.status);
	   	}
	   
	   
	})
	
	$('#file').css({'display' : 'none'});
	$('#submit').css({'display' : 'none'});
	$('#update').css({'display' : 'block'});
	$('#last_div').css({'display' : 'block'});
	
	$('#trainerGym').prop('readonly', true); 
	$('#trainerAward').prop('readonly', true); 
	$('#trainerCareer').prop('readonly', true); 
	
	$('#div_upload').css({'display' : 'none'});
	$('.div_img').css({'display' : 'none'});
	
	$('.orange').css({'background-color' : 'none'});
	
	
	
 }

//수정하기 클릭
function fn_update() {
	$('#file').css({'display' : 'block'});
	$('#submit').css({'display' : 'block'});
	$('#update').css({'display' : 'none'});
	$('#last_div').css({'display' : 'none'});
	
	$('#div_upload').css({'display' : 'block'});
	$('.div_img').css({'display' : 'inline'});
	
	$('.orange').css({'background-color' : '#fee9b8'});
	
	$('#trainerGym').prop('readonly', false); 
	$('#trainerAward').prop('readonly', false); 
	$('#trainerCareer').prop('readonly', false); 

}


</script>


</head>
<body>
	<!-- Breadcrumb Begin -->
	<section class="breadcrumb-option set-bg" data-setbg="./resources/img/hero/hero-11.jpg"
		style="padding-bottom: 0px; padding-top: 70px;"></section>
	<!-- Breadcrumb End -->


	<!-- 본문 시작 -->
	<section class="blog-details spad">

		<div class="container">
			<h3 style="text-align: center; cursor: pointer; margin-bottom: 30px;" onclick="location.href='trainerPermitList.do'">트레이너 승인</h3>
			<br>
			<div class="row" style="justify-content: center">
				
				<!-- 1번 div -->
				<div style="display: left; margin-right: 20px; width: 30%; background-color: white; padding: 0px; border: 1px solid #ebecef; border-radius: 10px; height: auto;">
					
					<div style="text-align: center;">
						<p style="font-size: 1.2em; font-weight: bold; margin-top: 20px; margin-bottom: 30px;">
							<span style="background-color: #3f51b50d;">&nbsp;접수상세정보&nbsp;</span>
						</p>
					</div>
					<div>
						<div class="box" style="height: 400px; padding-left: 30px; padding-right: 15px;">
							
							<div style="text-align: left;margin-right: 10px;border:none;background-color: #3f51b50d; color: black; padding:5px;">
								<p style="font-weight: bold; font-size: 1.1em; color: #5768AD; margin-bottom: 5px; margin-top: 5px;">
								신청일 : <fmt:formatDate pattern='yyyy-MM-dd' value='${detailVO.inDate }'/>
								</p>
							</div>
							
							<br>
							<div style="text-align: left;margin-right: 10px;border:none;background-color: #3f51b50d; color: black; padding:5px;">
								<p style="font-weight: bold; font-size: 1.1em; color: #5768AD; margin-bottom: 5px; margin-top: 5px;">
								진행상태 : 
								<c:if test="${detailVO.processStatus eq 'B'}">검토</c:if>
								<c:if test="${detailVO.processStatus eq 'C'}">보완</c:if>
								<c:if test="${detailVO.processStatus eq 'D'}">반려</c:if>
								<c:if test="${detailVO.processStatus eq 'E'}">승인</c:if>
								(<fmt:formatDate pattern='yyyy-MM-dd' value='${detailVO.upDate }'/>)
								</p>
							</div>
							<br>
							
							<!-- 보완일경우 -->
							<c:if test="${detailVO.processStatus eq 'C'}">
							<div style="text-align: left;margin-right: 10px;border:none;background-color: #3f51b50d; color: black; padding:5px;">
								<p style="font-weight: bold; font-size: 1.1em; color: #5768AD; margin-bottom: 5px; margin-top: 5px;">
								보완마감일자 : 
								<fmt:formatDate pattern='yyyy-MM-dd' value='${detailVO.processFinishDate }'/></p>
							</div>
							<br>
							<div style="text-align: left;margin-right: 10px;border:none;background-color: #3f51b50d; color: black; padding:5px;">
								<p style="font-weight: bold; font-size: 1.1em; color: #5768AD; margin-bottom: 5px; margin-top: 5px;">
								보완사유 : <br>
								${detailVO.resultReason }</p><br>
							</div>
							</c:if>
							
							<!-- 반려일경우 -->
							<c:if test="${detailVO.processStatus eq 'D'}">
							<div style="text-align: left;margin-right: 10px;border:none;background-color: #3f51b50d; color: black; padding:5px;">
								<p style="font-weight: bold; font-size: 1.1em; color: #5768AD; margin-bottom: 5px; margin-top: 5px;">
								반려사유 : <br>
								${detailVO.resultReason }</p><br>
							</div>
							</c:if>
							<br>
                        </div>
						<br>
						<hr>
					</div>
					
					
					<!-- 관리자 메모 -->
					<div style="text-align: center;">
						<p style="font-size: 1.2em; font-weight: bold; margin-top: 20px; margin-bottom: 30px;">
							<span style="background-color: #3f51b50d;">&nbsp;관리자 메모&nbsp;</span>
						</p>
					</div>
					<div>
						<div class="box" style="height: 370px; padding-left: 30px; padding-right: 15px;">
							<textarea name="adminMemo" id="adminMemo" class="ta" style="border:none;background-color: #3f51b50d; color: black; margin-bottom: 20px; padding:10px 5px;
							resize: none; width:290px; height: 350px;">${detailVO.adminMemo }</textarea>
                            <input type="button" onclick="fn_memo()" value="메모저장" class="site-btn" style="width : 290px;"/>
						</div>
						<br><br><br>
					</div>
				
				<!-- 1번 div 끝 -->
				</div>
				
				
				
				
				<!-- 2번 div -->
				<div class="col-lg-8 order-lg-2 order-1" style="background-color: white; padding: 30px; border: 1px solid #ebecef; border-radius: 10px; display: left; height: auto;">
					<!-- 수정 form 시작 -->
					<form class="appointment__form" id="frm" method="post" enctype="multipart/form-data">
						<div class="text-center">
							
							<!-- 1.이름 -->
							<div class="col-lg-6 text-center mypage_myinfo" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
								<div style="margin-bottom: 2px;">
									<h5 style="display: inline; float: left; color: black;">이름</h5>
									&nbsp;
								</div>
								<input type="text" readonly="readonly" style="background-color: #3f51b50d; color: black;" 
									value="${detailVO.memberName }" name="memberName" id="memberName">
							</div>
							
							<!-- 2.핸드폰번호 -->
							<div class="col-lg-6 text-center mypage_myinfo" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
								<div style="margin-bottom: 2px;">
									<h5 style="display: inline; float: left; color: black;">핸드폰번호</h5>
									&nbsp;
								</div>
								<input type="text" readonly="readonly" style="background-color: #3f51b50d; color: black;" 
									value="${detailVO.memberMobile }" name="memberMobile" id="memberMobile">
							</div>
	
							<!-- 3.이메일 -->
							<div class="col-lg-6 text-center mypage_myinfo" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
								<div style="margin-bottom: 2px;">
									<h5 style="display: inline; float: left; color: black;">이메일</h5>
									&nbsp;
								</div>
								<input type="text" readonly="readonly" style="background-color: #3f51b50d; color: black;" 
									value="${detailVO.memberEmail }" name="memberEmail" id="memberEmail">
							</div>
							
							<!-- 4.성별 -->
							<div class="col-lg-6 text-center mypage_myinfo" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
								<div style="margin-bottom: 2px;">
									<h5 style="display: inline; float: left; color: black;">성별</h5>
									&nbsp;
								</div>
								<input type="text" readonly="readonly" style="background-color: #3f51b50d; color: black;" 
									<c:if test="${ detailVO.memberGender eq 'F'}">
									value="여성"
									</c:if>
									<c:if test="${ detailVO.memberGender eq 'M'}">
									value="남성"
									</c:if>
									name="memberGender" id="memberGender">
							</div>
							
							
							<!-- 여기부터 데이터 수정 가능 -->
							<!-- 5.소속헬스장 -->
							<div class="col-lg-6 text-center mypage_myinfo"
								style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
								<div style="margin-bottom: 2px;">
									<h5 style="display: inline; float: left; color: black;"><span class="orange" style="background-color: none;">소속헬스장</span></h5>
									&nbsp;
								</div>
								<input type="text" readonly="readonly" style="background-color: #3f51b50d; color: black;"
									value="${detailVO.trainerGym }" name="trainerGym" id="trainerGym">
							</div>
							
							<!-- 6.수상이력 -->							
							<div class="col-lg-6 text-center mypage_myinfo" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
								<div style="margin-bottom: 2px;">
									<h5 style="display: inline; float: left; color: black;"><span class="orange" style="background-color: none;">수상이력</span></h5>
									&nbsp;
								</div>
								<div class="row">
									<div class="col-lg-12"></div>
									<div class="col-lg-12 text-center">
										<textarea class="ta" readonly="readonly" style="background-color: #3f51b50d; color: black; margin-bottom: 20px; resize: none;"
											name="trainerAward" id="trainerAward">${detailVO.trainerAward }
	
	                                    </textarea>
										</div>
									</div>
								</div>
	
							<!-- 7.경력 -->
							<div class="col-lg-6 text-center mypage_myinfo" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
								<div style="margin-bottom: 2px;">
									<h5 style="display: inline; float: left; color: black;"><span class="orange" style="background-color: none;">경력</span></h5>
									&nbsp;
								</div>
								<div class="row">
									<div class="col-lg-12"></div>
									<div class="col-lg-12 text-center">
										<textarea class="ta" readonly="readonly" style="background-color: #3f51b50d; color: black; margin-bottom: 20px; resize: none;"
											name="trainerCareer" id="trainerCareer">${detailVO.trainerCareer }
	                                    </textarea>
	
										</div>
									</div>
								</div>
							
							
							<!-- 첨부파일[기존파일들 보여주는 부분] -->
							<div class="col-lg-6 text-center mypage_myinfo" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
								<div style="margin-bottom: 2px;">
									<h5 style="display: inline; float: left; color: black;"><span class="orange" style="background-color: none;">첨부파일</span></h5>
									&nbsp;
									
									<div class="col-lg-12" style="text-align: left; float: left; padding: 20px; margin:0px; background-color: #3f51b50d;">
										<c:forEach var="fileVO" items="${fileVO}" varStatus="status">
										<div style="margin-bottom: 10px;" id="${fileVO.fileDetailSeq}">
										${fileVO.fileRealName }
										<a href="${fileVO.filePath }">파일 열기</a>
										<img src="./resources/img/common/delete.png" class="div_img" style="display:none; width: 15px; height: 15x;margin-left: 5px; margin-bottom: 3px;"
										onclick="fn_del(${fileVO.fileDetailSeq})">
										</div>
										
										</c:forEach>
									</div>
								</div>

								<div class="input-group" style="margin-bottom: 30px;"></div>
							</div>
							
							
							<!-- 파일상세고유번호 hidden -->
							<div id="del_file" style="display: none;">
							
							</div>
							
							<!-- 파일고유번호 hidden -->
							<input type="hidden" name="fileSeq" value="${fileVO[0].fileSeq}">
							
							<!-- 아이디 hidden -->
							<input type="hidden" id="memberId" name="memberId" value="${detailVO.memberId }">
							
							<!-- 프로세스 시퀀스 hidden -->
							<input type="hidden" id="processSeq" name="processSeq" value="${detailVO.processSeq }">
							
							<!-- 파일추가하는 부분[파일업로드] -->
							<div class="col-lg-6 text-center mypage_myinfo" id="div_upload"
                              	style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto; display: none;">
                              <div style="margin-bottom: 2px;">
                                 <h5 style="display: inline; float: left; color: black;"><span class="orange" style="background-color: none;">파일업로드</span></h5>
                                 &nbsp;
                                 <div class="col-lg-12" style="text-align: right; float: left; padding: 0; margin: 0;">
                                      <input type="button" class="file_add" value="파일 추가" onClick="fn_addFile()">
                                      <input type="button" class="file_add" value="파일 삭제" onClick="fn_delFile()">
                                      <div id="d_file" style="text-align: left;">
                                      
                                      </div>
                                 </div>
                              </div>
                                 
                              <div class="input-group" style="margin-bottom: 5px;">
                              </div>
                           </div>
							
							
									
							<!-- 수정하기 버튼 -->	
							<div class="col-lg-12" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
		                         <input id="update" type="button" class="file_add" value="수정하기" style="width: 470px; display: block;" onclick="fn_update()">
		                         <input id="submit" type="button" class="file_add" value="수정완료" style="background:orange; width: 470px; display: none;" onclick="fn_submit()">
		                    </div>
							<br>
							
							
							<!-- 승인/보완/반려 -->
							<div class="col-lg-12" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;display: blcok" id="last_div">
								<input type="button" value="승인" class="site-btn" onclick="fn_updStatus('E')"
									style="display: inline-block; padding: 1px 6px; font-size: 1.1em; color: white; background-color: #5768AD; width: 31.5%; height: 48px; margin-right: 7px;">
								<input type="button" value="보완" class="site-btn" onclick="fn_updStatus('C')"
									style="display: inline-block; padding: 1px 6px; font-size: 1.1em; color: white; background-color: #5768AD; width: 31.5%; height: 48px; margin-right: 7px;">
								<input type="button" value="반려" class="site-btn" onclick="fn_updStatus('D')"
									style="display: inline-block; padding: 1px 6px; font-size: 1.1em; color: white; background-color: #5768AD; width: 31.5%; height: 48px; margin-right: 0px;">
							</div>
								
								
						</div>
					</form>
				</div><!-- 2번 div 끝 -->
				
				
			</div><!-- row div 끝 -->
		</div><!-- container div 끝 -->
	</section>


	<!-- Js Plugins -->
	<script src="./resources/js/bootstrap.min.js"></script>
	<script src="./resources/js/jquery.nice-select.min.js"></script>
	<script src="./resources/js/jquery.barfiller.js"></script>
	<script src="./resources/js/jquery.slicknav.js"></script>
	<script src="./resources/js/owl.carousel.min.js"></script>
	<script src="./resources/js/main.js"></script>
</body>
</html>