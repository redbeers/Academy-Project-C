<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>bulletin_write</title>
<script>
// var uploadPath = "Y:/profit/";

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
	
		if(num>100){
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

		if(num>100){
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

		if(num>100){
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

		if(num>100){
		alert('더이상 늘릴수 없습니다.');
		num=100;
		}
		$('#count4').val(num);
	});
		
		
});


function fn_submit(){
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
		var save = confirm("강의를 등록하시겠습니까?");
		if(save == true){
			send_file();
		}
		else{
			alert("등록이 취소되었습니다.")
		}
	}
}


function send_file(){
	var formData = new FormData($('#frm')[0]);
	
	formData.append("lessonCategorySeq", $("input:radio[name=cate_type]:checked").val());

	console.log(formData);

	
	$.ajax({
		type : 'post',
		url : 'lesson_insAjax.do',
		data : formData,
		processData : false,
		contentType : false,
		async:false,
		dataType:"text",
		success : function(data){
		if(data=="ok"){
			alert("등록이 정상적으로 완료되었습니다.");
			location.href="lessonList.do";
			window.loacation.reload();
		}else if(data=="no"){
			alert("등록이 실패하였습니다. 다시 시도해주세요");
		}else{
			alert("등록이 실패하였습니다. 다시 시도해주세요");
		}
	},
		error : function(error){
			alert("등록이 실패하였습니다. 다시 시도해 주세요.");
			console.log(error);
			console.log(error.status);
		}
		
		
	})
	
	
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
	border: 1px solid #5768AD;
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
						<h2>강의 등록</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->
	<div class="container">
		<section class="classes spad">
			<div style="text-align:center;">
				<h3 style="padding-left: 15px; color: #263246; font-family: DM Sans, sans-serif; font-weight: 400; font-size: 1.5em;">강의를 등록해주세요 </h3><br/>
				<p style="color: #E84D4D;">※ 모든 사항은 반드시 입력해야 합니다.</p>
			</div>
			<br />
			<main role="main" class="container">
				<form  id="frm" method="post"  style="text-align: center;"  enctype="multipart/form-data">
					<div class="write-title">
						<label>
							<p>
								카테고리 선택
							</p>
						</label>
						<div class="c_radio">
							<div style="display: inline-block;">
								<input type="radio" name="cate_type" id="gym" value="1" autocomplete="off" style="opacity: 0;">
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
						</div>
					</div>
					<p>
						<div class="form-group">
							<label for="lessonPrice" style="float:left;">제목 </label>
						    <input type="text" class="form-control" id="lessonTitle" name="lessonTitle" placeholder="ex)제목을 입력하세요" style="border: none;border-bottom: 1px solid #D5D4D4;height: 54px;font-size: 15px;">
						</div>
					</p>
					<p>	
						<div class="form-group">
							<label for="lessonPrice" style="float:left;">강의코멘트(부제목)</label>
						    <input type="text" class="form-control" id="lessonTitleComment" name="lessonTitleComment" placeholder="ex)강의코멘트 (부제목)을 입력하세요" style="border: none;border-bottom: 1px solid #D5D4D4;height: 54px;font-size: 15px;">
						</div>
					</p>
					
					<p>	
						<div class="form-group">
							<label for="lessonPrice" style="float:left;">강의기간 </label>
						    <input type="text" class="form-control" id="lessonMonth" name="lessonMonth" placeholder="ex)1,2,3,4..." style="border: none;border-bottom: 1px solid #D5D4D4;height: 54px;font-size: 15px;">
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
	                                <input type="number" class="count" id="count1" name="lessonBalance" name="qty" value="0">
	                                <span class="plus bg-dark" id="plus1">+</span>
	                            </div>
							</div>
							
							<div style="display: inline-block;flex:1;margin-right:5px; float:left;border:1px solid #D4D5D8; border-radius: 5px;height: 65px; background: white;">
								<div>
									<span style="color: #001943;">Flex</span>
								</div>
								<div class="qty mt-5">
									<span class="minus bg-dark" id="minus2">-</span>
	                                <input type="number" class="count" id="count2" name="lessonFlex" name="qty" value="0">
	                                <span class="plus bg-dark" id="plus2">+</span>
	                            </div>
							</div>
							
							<div style="display: inline-block;flex:1;margin-right:5px; float:left;border:1px solid #D4D5D8; border-radius: 5px;height: 65px; background: white;">
								<div>
									<span style="color: #001943;">Strong</span>
								</div>
								<div class="qty mt-5">
									<span class="minus bg-dark" id="minus3">-</span>
	                                <input type="number" class="count" id="count3" name="lessonStrong" name="qty" value="0">
	                                <span class="plus bg-dark" id="plus3">+</span>
	                            </div>
							</div>
							
							<div style="display: inline-block;flex:1;float:right;border:1px solid #D4D5D8; border-radius: 5px;height: 65px; background: white;">
								<div>
									<span style="color: #001943">Core</span>
								</div>
								<div class="qty mt-5">
									<span class="minus bg-dark" id="minus4">-</span>
	                                <input type="number" class="count" id="count4" name="lessonCore" name="qty" value="0">
	                                <span class="plus bg-dark" id="plus4">+</span>
	                            </div>
							</div>
						
						</div>
						</p>
						
						<p>
							<label for="lessonPrice" style="float:left;">강의소개 </label>
							<textarea class="form-control" rows="9" id="lessonIntro" name="lessonIntro" placeholder="강의소개를 입력하세요" style="border: none;border-bottom: 1px solid #D5D4D4;"></textarea>
						</p>
						
						<p>
							<div class="form-group">
								<label for="lessonPrice" style="float:left;">강의가격 </label>
							    <input type="text" class="form-control" id="lessonPrice" name="lessonPrice"  placeholder="ex)530000" style="border: none;border-bottom: 1px solid #D5D4D4;height: 54px;font-size: 15px;background-color: none;">
							</div>
						</p>
						
						<p>
<!-- 							<div class="filebox" style="text-align: left;margin-top: 30px;">  -->
<!-- 							  <label for="file">파일첨부</label>  -->
<!-- 							  <input type="file" id="file" onchange="readURL(this);">  -->
<!-- 							  <input class="upload-name" value="첨부파일이 없습니다." readonly="readonly"> -->
<!-- 							</div> -->
<!-- 							<div class="ai-thumnail-wrapper" style="width: 100%; height: autox;"> -->
<!-- 						        <div class="img_wrap ai-thumbnail" style="text-align: center;"> -->
<!-- 						            <img id="preview_img" /> -->
<!-- 						        </div> -->
<!-- 						    </div> -->

								<div style="float: left;">
									<input type="file" id="file" name="file" value="파일첨부">
								</div>
						</p>
						
					<br /><br/><br/>
					<div style="text-align: right;">
                             <button type="button" id="hover_btn"  class="site-btn_s" onclick="fn_submit()">등록</button>
                    </div>
					</form>
					
			</main>
		</section>
	</div>
</body>
</html>