<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html lang="en">
<head>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>bulletin_write</title>
<script>
$(document).ready(function(){
	$('#minus1').click(function(e){
		e.preventDefault();
		var stat = $('#count1').val();
		var num = parseInt(stat,10);
		num -=5;
		if(num<0){
		alert('더이상 줄일수 없습니다.');
		num =0;
		}
		$('#count1').val(num);
		});
		$('#plus1').click(function(e){
		e.preventDefault();
		var stat = $('#count1').val();
		var num = parseInt(stat,10);
		num +=5;
	
		if(num>=100){
		alert('더이상 늘릴수 없습니다.');
		num=100;
		}
		$('#count1').val(num);
	});
	
	$('#minus2').click(function(e){
		e.preventDefault();
		var stat = $('#count2').val();
		var num = parseInt(stat,10);
		num -=5;
		if(num<0){
		alert('더이상 줄일수 없습니다.');
		num =0;
		}
		$('#count2').val(num);
		});
		$('#plus2').click(function(e){
		e.preventDefault();
		var stat = $('#count2').val();
		var num = parseInt(stat,10);
		num +=5;

		if(num>=100){
		alert('더이상 늘릴수 없습니다.');
		num=100;
		}
		$('#count2').val(num);
	});
		
	$('#minus3').click(function(e){
		e.preventDefault();
		var stat = $('#count3').val();
		var num = parseInt(stat,10);
		num -=5;
		if(num<0){
		alert('더이상 줄일수 없습니다.');
		num =0;
		}
		$('#count3').val(num);
		});
		$('#plus3').click(function(e){
		e.preventDefault();
		var stat = $('#count3').val();
		var num = parseInt(stat,10);
		num +=5;

		if(num>=100){
		alert('더이상 늘릴수 없습니다.');
		num=100;
		}
		$('#count3').val(num);
	});
		
	$('#minus4').click(function(e){
		e.preventDefault();
		var stat = $('#count4').val();
		var num = parseInt(stat,10);
		num -=5;
		if(num<0){
		alert('더이상 줄일수 없습니다.');
		num =0;
		}
		$('#count4').val(num);
		});
		$('#plus4').click(function(e){
		e.preventDefault();
		var stat = $('#count4').val();
		var num = parseInt(stat,10);
		num +=5;

		if(num>=100){
		alert('더이상 늘릴수 없습니다.');
		num=100;
		}
		$('#count4').val(num);
	});
		
// 		$("#exe_btn").hide();
// 	  	var fileTarget = $('#file'); 
// 	  	fileTarget.on('change', function(){ // 값이 변경되면
// 	     	var cur=$(".filebox input[type='file']").val();
	  	
// 	     	var curSplit  = cur.split("\\");    //   "\" 로 전체 url 을 나눈다
// 	     	var nameLength = curSplit.length;
// 	     	var fileName         = curSplit[nameLength-1];   // 나누어진 배열의 맨 끝이 파일명이다

// 	    	$(".upload-name").val(fileName);
// 	  	});
});

// function readURL(input) {
//     if (input.files && input.files[0]) {
//         var reader = new FileReader();
//         reader.onload = function (e) {
//             $('#preview_img').attr('src', e.target.result);
//         }
//         reader.readAsDataURL(input.files[0]);
//     }
//     $("#exe_btn").show();
// }

function fn_submitMod(){
	var chk_radio = document.getElementsByName('cate_type');
	var sel_type = null;
	for(var i=0;i<chk_radio.length;i++){
		if(chk_radio[i].checked == true){ 
			sel_type = chk_radio[i].value;
		}
	}
	if(sel_type == null){
		alert("카테고리를 선택하세요."); 
	return;
	}
	
	var lessonTitle = $("#lessonTitle").val();
	if(lessonTitle==""){
		alert("제목을 입력해주세요.");
		$("#lessonTitle").focus();
		return;
	}
	
	var lessonTitleComment = $("#lessonTitleComment").val();
	if(lessonTitleComment==""){
		alert("강의코멘트를 입력해주세요.");
		$("#lessonTitleComment").focus();
		return;
	}
	
	var lessonMonth = $("#lessonMonth").val();
	if(lessonMonth==""){
		alert("강의일수를 입력해주세요.");
		$("#lessonMonth").focus();
		return;
	}
	
	var lessonIntro = $("#lessonIntro").val();
	if(lessonIntro==""){
		alert("강의소개를 입력해주세요.");
		$("#lessonIntro").focus();
		return;
	}	

	var lessonPrice = $("#lessonPrice").val();
	if(lessonPrice==""){
		alert("강의 가격을 입력해주세요.");
		$("#lessonPrice").focus();
		return;
	}
	
	var fileCheck = document.getElementById("file").value;
	if(!fileCheck){
	 alert("파일을 첨부해 주세요");
	 return false;
	}
	
	var month_reg = /^(0[0-9]|1[0-2])$/;
	if (!month_reg.test(lessonMonth)) {
		alert("수강기간은 01월부터 12월까지의 숫자만 가능합니다. \n ex) 01, 02, 03 ... 12");
		$("#lessonMonth").focus();
		return false;
	}
	
	var price_reg = /^[0-9]*$/;
	if (!price_reg.test(lessonPrice)) {
		alert("가격은 (특수기호없이)숫자만 입력해주세요. \n ex) 300000");
		$("#lessonPrice").focus();
		return false;
	}
	
	var balance = $("#count1").val();
	var num = parseInt(balance);
	console.log("balance" +balance);
	console.log(num);
	
	var flex = $("#count2").val();
	var num2 = parseInt(flex);
	console.log("flex" +flex);
	console.log(num2);
	
	var strong = $("#count3").val();
	var num3 = parseInt(strong);
	console.log("strong" +strong);
	console.log(num3);
	
	var core = $("#count4").val();
	var num4 = parseInt(core);
	console.log("core" +core);
	console.log(num4);
	
	if(num >100){
		alert("Balance 값은 100을 넘길 수 없습니다.");
		$("#count1").focus();
		return;
	}
	if(num2 > 100){
		alert("flex 값은 100을 넘길 수 없습니다.");
		$("#count2").focus();
		return;
	}
	if(num3 > 100){
		alert("strong 값은 100을 넘길 수 없습니다.");
		$("#count3").focus();
		return;
	}
	if(num4 > 100){
		alert("core 값은 100을 넘길 수 없습니다.");
		$("#count4").focus();
		return;
	}
	
	
	var msg = "ok";
	if(msg=="ok"){
		var save = confirm("정말 강의를 수정하시겠습니까?");
		if(save == true){
			send_updateLesson();
		}
		else{
			alert("수정이 취소되었습니다.")
		}
	}
}


function send_updateLesson(){
	var formData = new FormData($('#frm')[0]);
	var lessonSeq = $("input:hidden[name=lessonSeq]").val();
	formData.append("lessonCategorySeq", $("input:radio[name=cate_type]:checked").val());
	
	$.ajax({
		type : 'post',
		url : 'lesson_modAjax.do',
		data : formData,
		processData : false,
		contentType : false,
		async:false,
		dataType:"text",
		success : function(data){
		if(data=="ok"){
			alert("수정이 정상적으로 완료되었습니다.");
			location.href="lessonDetail.do?lessonSeq=" + $("input:hidden[name=lessonSeq]").val();
		}else if(data=="no"){
			alert("수정에 실패하였습니다. 다시 시도해주세요");
		}
	},
		error : function(error){
			alert("수정에 실패하였습니다. 다시 시도해 주세요.");
			console.log(error);
			console.log(error.status);
		}
		
		
	})
	
}

// function fn_check(){

// 	if($("#lessonTitle").val()==""){
// 		alert("제목을 입력해주세요.");
// 		$("#lessonTitle").focus();
// 		return;
// 	}
	
// 	if($("#lessonTitleComment").val()==""){
// 		alert("강의소개를 입력해주세요.");
// 		$("#lessonTitleComment").focus();
// 		return;
// 	}

// 	if($("#lessonMonth").val()==""){
// 		alert("강의일수를 입력해주세요.");
// 		$("#lessonMonth").focus();
// 		return;
// 	}


// 	if($("#lessonIntro").val()==""){
// 		alert("강의소개를 입력해주세요.");
// 		$("#lessonIntro").focus();
// 		return;
// 	}	


// 	if($("#lessonPrice").val()==""){
// 		alert("강의 가격을 입력해주세요.");
// 		$("#lessonPrice").focus();
// 		return;
// 	}

// 	var price_reg = /^[0-9]*$/;
// 	if (!price_reg.test($("#lessonPrice").val())) {
// 		alert("가격은 (특수기호없이)숫자만 입력해주세요. \n ex) 300000");
// 		$("#lessonPrice").focus();
// 		return false;
// 	}

// 	var month_reg = /^(0[1-9]|1[012])$/;
// 	if (!month_reg.test($("#lessonMonth").val())) {
// 		alert("수강기간은 1월부터 12월까지의 숫자만 가능합니다. \n ex) 01, 02, 03 ... 12");
// 		$("#lessonMonth").focus();
// 		return false;
// 	}
	
// 	var fileCheck = document.getElementById("file").value;
// 	 if(!fileCheck){
// 	     alert("파일을 첨부해 주세요");
// 	     return false;
//  	}
	
// 	 fn_submitMod();
// }


function fn_delFile(){
	var msg = "ok";
	if(msg=="ok"){
		var save = confirm("파일을 삭제 하시겠습니까?");
		$("#fileRealName").val("");
		$("#d_file").html("<input type='file' id='file' name='file'>");
	}
		else{
			alert("수정이 취소되었습니다.")
		}
	
	
}

</script>
<style>
.site-btn_s{
font-size: 14px;
	color: #5768AD;
	font-weight: 700;
	text-transform: uppercase;
	display: inline-block;
	padding: 14px 50px;
	background: #ffffff;
	border: none;
	letter-spacing: 2px;
	border-radius: 2px;
	cursor: pointer;
}
.site-btn_s:hover{
background: #ffffff;
	border: 1px solid #5768AD;
	color: #5768AD;
	cursor: pointer;
}
</style>
</head>
<body>
	<!-- Breadcrumb Begi -->
	<section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg" style="background-image: url(&quot;./resources/img/breadcrumb.jpg&quot;);">
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
	<div class="container">
		<section class="classes spad">
			<div>
				<h3 style="padding-left: 15px; color: #263246; font-family: DM Sans, sans-serif; font-weight: 400;">강의를 수정해주세요 </h3>
			</div>
			<br />
			<br />
			<main role="main" class="container">
				<form id="frm" method="post" style="text-align: center;" enctype="multipart/form-data">
				<input type="hidden" name="lessonSeq" value="${resultList.lessonSeq}"/>
				<input type="hidden" name="fileSeq" value="${resultList.fileSeq}"/>
					<div class="write-title">
						<label>
							<p>
								카테고리 선택
								<span style="color: red;"> *</span>
							</p>
						</label>
						<div class="c_radio">
						<c:if test="${resultList.lessonCategorySeq eq '1'}">
							<div style="display: inline-block;">
								<input type="radio" name="cate_type" id="gym" value="1" autocomplete="off" style="opacity: 0;" checked>
								<label for="gym">헬스</label>
								<input type="radio" name="cate_type" id="yoga" value="2" autocomplete="off" style="opacity: 0">
								<label for="yoga">요가</label>
							</div>
							<div style="display: inline-block;">
								<input type="radio" name="cate_type" id="filates" value="3" autocomplete="off" style="opacity: 0">
								<label for="filates">필라테스</label>
								<input type="radio" name="cate_type" id="exercise" value="4" autocomplete="off" style="opacity: 0">
								<label for="exercise">맨몸운동</label>
							</div>
						</c:if>
						
						<c:if test="${resultList.lessonCategorySeq eq '2'}">
							<div style="display: inline-block;">
								<input type="radio" name="cate_type" id="gym" value="1" autocomplete="off" style="opacity: 0;" >
								<label for="gym">헬스</label>
								<input type="radio" name="cate_type" id="yoga" value="2" autocomplete="off" style="opacity: 0" checked>
								<label for="yoga">요가</label>
							</div>
							<div style="display: inline-block;">
								<input type="radio" name="cate_type" id="filates" value="3" autocomplete="off" style="opacity: 0">
								<label for="filates">필라테스</label>
								<input type="radio" name="cate_type" id="exercise" value="4" autocomplete="off" style="opacity: 0">
								<label for="exercise">맨몸운동</label>
							</div>
						</c:if>
						
						<c:if test="${resultList.lessonCategorySeq eq '3'}">
							<div style="display: inline-block;">
								<input type="radio" name="cate_type" id="gym" value="1" autocomplete="off" style="opacity: 0;">
								<label for="gym">헬스</label>
								<input type="radio" name="cate_type" id="yoga" value="2" autocomplete="off" style="opacity: 0">
								<label for="yoga">요가</label>
							</div>
							<div style="display: inline-block;">
								<input type="radio" name="cate_type" id="filates" value="3" autocomplete="off" style="opacity: 0" checked>
								<label for="filates">필라테스</label>
								<input type="radio" name="cate_type" id="exercise" value="4" autocomplete="off" style="opacity: 0">
								<label for="exercise">맨몸운동</label>
							</div>
						</c:if>
						
						<c:if test="${resultList.lessonCategorySeq eq '4'}">
							<div style="display: inline-block;">
								<input type="radio" name="cate_type" id="gym" value="1" autocomplete="off" style="opacity: 0;">
								<label for="gym">헬스</label>
								<input type="radio" name="cate_type" id="yoga" value="2" autocomplete="off" style="opacity: 0">
								<label for="yoga">요가</label>
							</div>
							<div style="display: inline-block;">
								<input type="radio" name="cate_type" id="filates" value="3" autocomplete="off" style="opacity: 0">
								<label for="filates">필라테스</label>
								<input type="radio" name="cate_type" id="exercise" value="4" autocomplete="off" style="opacity: 0" checked>
								<label for="exercise">맨몸운동</label>
							</div>
						</c:if>
						
						</div>
					</div>
					<p>
						<div class="form-group">
							<label for="lessonPrice" style="float:left;">제목 : </label>
						    <input type="text" class="form-control" id="lessonTitle" name="lessonTitle" value="${resultList.lessonTitle}" placeholder="ex)1강 전신스트레칭">
						</div>
					</p>
					<p>	
						<div class="form-group">
							<label for="lessonPrice" style="float:left;">강의코멘트(부제목) : </label>
						    <input type="text" class="form-control" id="lessonTitleComment" name="lessonTitleComment" value="${resultList.lessonTitleComment}" placeholder="ex)운동시작전 몸을 풀기위한 스트레칭 강의입니다...">
						</div>
					</p>
					
					<p>	
						<div class="form-group">
							<label for="lessonPrice" style="float:left;">강의기간 : </label>
						    <input type="text" class="form-control" id="lessonMonth" name="lessonMonth" value="${resultList.lessonMonth}" placeholder="ex)01">
						</div>
					</p>
					
					<p>
						<div style="display: flex; width: auto;">
							<div style="display: inline-block;flex:1;margin-right:5px; float:left;border:1px solid #D4D5D8; border-radius: 5px;height: 65px; background: white;">
								<div>
									<span style="color: #001943;">Balance</span>
								</div>
								<div class="qty mt-5">
									<span class="minus bg-dark" id="minus1">-</span>
	                                <input type="number" class="count" id="count1" name="lessonBalance" name="qty" value="${resultList.lessonBalance}">
	                                <span class="plus bg-dark" id="plus1">+</span>
	                            </div>
							</div>
							
							<div style="display: inline-block;flex:1;margin-right:5px; float:left;border:1px solid #D4D5D8; border-radius: 5px;height: 65px; background: white;">
								<div>
									<span style="color: #001943;">Flex</span>
								</div>
								<div class="qty mt-5">
									<span class="minus bg-dark" id="minus2">-</span>
	                                <input type="number" class="count" id="count2" name="lessonFlex" name="qty"  value="${resultList.lessonFlex}">
	                                <span class="plus bg-dark" id="plus2">+</span>
	                            </div>
							</div>
							
							<div style="display: inline-block;flex:1;margin-right:5px; float:left;border:1px solid #D4D5D8; border-radius: 5px;height: 65px; background: white;">
								<div>
									<span style="color: #001943;">Strong</span>
								</div>
								<div class="qty mt-5">
									<span class="minus bg-dark" id="minus3">-</span>
	                                <input type="number" class="count" id="count3" name="lessonStrong" name="qty" value="${resultList.lessonStrong}">
	                                <span class="plus bg-dark" id="plus3">+</span>
	                            </div>
							</div>
							
							<div style="display: inline-block;flex:1;float:right;border:1px solid #D4D5D8; border-radius: 5px;height: 65px; background: white;">
								<div>
									<span style="color: #001943">Core</span>
								</div>
								<div class="qty mt-5">
									<span class="minus bg-dark" id="minus4">-</span>
	                                <input type="number" class="count" id="count4" name="lessonCore" name="qty" value="${resultList.lessonCore}">
	                                <span class="plus bg-dark" id="plus4">+</span>
	                            </div>
							</div>
						
						</div>
						</p>
						
						<p>
							<label for="lessonPrice" style="float:left;">강의소개 : </label>
							<textarea class="form-control" rows="9" id="lessonIntro" name="lessonIntro" placeholder="ex)우리의 클래스를 시작하기전에 몸을 제대로 풀고 시작해봅니다....." style="">
${resultList.lessonIntro}
							</textarea>
						</p>
						
						<p>
							<div class="form-group">
								<label for="lessonPrice" style="float:left;">강의가격 : </label>
							    <input type="text" class="form-control" id="lessonPrice" name="lessonPrice" value="${resultList.lessonPrice}" placeholder="ex)530000">
							</div>
						</p>
						
						<p>
<!-- 							<div class="filebox" style="text-align: left;margin-top: 30px;">  -->
<!-- 							  <label for="file">파일첨부</label>  -->
<!-- 							  <input type="file" id="file" onchange="readURL(this);">  -->
<%-- 							  <input class="upload-name" value="${resultList.fileRealName}" readonly="readonly"> --%>
<!-- 							</div> -->
<!-- 							<div class="ai-thumnail-wrapper" style="width: 100%; height: autox;"> -->
<!-- 						        <div class="img_wrap ai-thumbnail" style="text-align: center;"> -->
<!-- 						            <img id="preview_img" /> -->
<!-- 						        </div> -->
<!-- 						    </div> -->
						    
						    
<!-- 						    <div> -->
<!-- 									<input type="file" id="file" name="file" value="파일첨부"> -->
<!-- 								</div> -->

							<div class="form-group" style="float: left;">
							<div id="d_file">
								<div style="display:inline-block;">
									<span>첨부파일 : </span>
								</div>
								<div style="display:inline-block;">
							    <input type="text" class="form-control" id="fileRealName" style="width:auto;" value="${resultList.fileRealName}">
								</div>
								<div style="display:inline-block;">
									<input type="button" value="X" id="btn_x" onclick="fn_delFile()">
								</div>
								
							</div>
							</div>
						</p>
						
					<br />
					<div style="text-align: right;">
                             <button type="button" id="hover_btn"  class="site-btn_s" onclick="fn_submitMod()">수정완료</button>
                    </div>
					</form>
					
					
			</main>
		</section>
	</div>
</body>
</html>
