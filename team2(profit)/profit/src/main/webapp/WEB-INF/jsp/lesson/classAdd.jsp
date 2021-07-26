<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
<script>
$(document).ready(function(){

});

function readURL(input) {
if (input.files && input.files[0]) {
 var reader = new FileReader();
 reader.onload = function (e) {
     $('#preview_img').attr('src', e.target.result);
 }
 reader.readAsDataURL(input.files[0]);
}
$("#exe_btn").show();
}


function fn_submit(){
	
	var lessonDetailTitle = $("#lessonDetailTitle").val();
	if(lessonDetailTitle==""){
		alert("상세강의 제목을 입력해주세요.");
		$("#lessonDetailTitle").focus();
		return;
	}
	
	var lessonDetailContent = $("#lessonDetailContent").val();
	if(lessonDetailContent==""){
		alert("상세강의 내용을 입력해주세요.");
		$("#lessonDetailContent").focus();
		return;
	}
	
	
	var fileCheck = document.getElementById("file").value;
	if(!fileCheck){
	 alert("썸네일 파일을 첨부해 주세요");
	 return false;
	}

	var fileCheck2 = document.getElementById("file_dong").value;
	if(!fileCheck2){
	 alert("강의 동영상을 첨부해 주세요");
	 return false;
	}
	
	
	var msg = "ok";
	if(msg=="ok"){
		var apply = confirm("상세강의를 등록하시겠습니까?");
		if(apply == true){
			send_file();
		}
		else{
			alert("신청이 취소되었습니다.")
		}
	}
}

function send_file(){
	var formData = new FormData($('#frm')[0]);
	formData.append("lessonSeq", $("input:hidden[name=lessonSeq]").val());
	$.ajax({
		type : 'post',
		url : 'class_insAjax.do',
		data : formData,
		processData : false,
		contentType : false,
		async:false,
		dataType:"text",
		success : function(data){
		if(data=="ok"){
			alert("등록이 정상적으로 완료되었습니다.");
			location.href="lessonDetail.do?lessonSeq="+$("input:hidden[name=lessonSeq]").val();
		}else if(data=="no"){
			alert("등록이 실패하였습니다. 다시 시도해주세요");
		}
	},
		error : function(error){
			alert("신청이 실패하였습니다. 다시 시도해 주세요.");
			console.log(error);
			console.log(error.status);
		}
		
		
	})
}
</script>
<style>
.blinking{
    animation:blinkingText 1.9s infinite;
}
 @keyframes blinkingText{ 
     0%{     color: #FF9614;    } 
     49%{    color: #FF9614; } 
     60%{    color: transparent; } 
     99%{    color:transparent;  } 
     100%{   color: #000;    } 
 }

summary {
    cursor: pointer;
    text-decoration: underline;
    float: left;
  }
summary {
    list-style: none;
  }
summary:hover{
	color : #FF9614;
}
  summary::-webkit-details-marker {
    display: none;
  }

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

.btn_file{
	font-size: 17px;
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
</style>
</head>
<body>
	<!-- Breadcrumb Begin -->
	<section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>상세 강의 등록</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->
	<div class="container">
		<section class="classes spad">
			<div style="text-align:center;">
				<h3 style="padding-left: 15px; color: #263246; font-family: DM Sans, sans-serif; font-weight: 400; font-size: 1.5em;">상세 강의를 등록해주세요 </h3><br/>
				<p style="color: #E84D4D;">※ 모든 사항은 반드시 입력해야 합니다.</p>
				<br />
				<p style="font-family: DM Sans, sans-serif; font-size: 1.2em; color: #5768AD;">영상/이미지 형식</p>
				<p style="color: #5768AD;">▶ 이미지 : 100 MB, 동영상 : 5GB</p>
				<p style="color: #5768AD;">
					▶ 이미지 : 700 x 500
					<span style="color: #FC7F65;">jpg</span>
					파일로 첨부해주세요.
				</p>
				<p style="color: #5768AD;">
					▶ 동영상 : 1280 x 720
					<span style="color: #FC7F65;">avi</span>
					파일로 첨부해주세요.
				</p>
				<br />
				
			</div>
			<form  id="frm" method="post"  style="text-align: center;"  enctype="multipart/form-data">
			<input type="hidden" value="${resultList.lessonSeq}" name="lessonSeq"}>
				<div class="write-title">
					<p>
						<div class="form-group">
							<h5 style="display: inline; float: left; color: black;">상세 강의명</h5>
						    &nbsp;
						    <input type="text" class="form-control" id="lessonDetailTitle" name="lessonDetailTitle" placeholder="ex)1강 전신스트레칭" style="border: none;border-bottom: 1px solid #D5D4D4;height: 54px;font-size: 15px;">
						</div>
					</p>
					<br/>
					
					<p>
						<div class="form-group">
							<h5 style="display: inline; float: left; color: black;">상세 강의내용</h5>
						    &nbsp;
						    <textarea class="form-control" rows="9" id="lessonDetailContent" name="lessonDetailContent" placeholder="ex)우리의 클래스를 시작하기전에 몸을 제대로 풀고 시작해봅니다....."  style="border: none;border-bottom: 1px solid #D5D4D4;font-size: 15px;"></textarea>
						</div>
					</p>
					<br/>
					
					<p>
						<div class="form-group">
						  <h5 style="display: inline; float: left; color: black;">썸네일 이미지</h5>
						  &nbsp;
						  <div class="file_pre" style="text-align: left;margin-top: 30px;">  
						    <input type="file" id="file" name="file" onchange="readURL(this);" class="btn_file"> 
						  </div>
						  <br/>
						  <span class="blinking" style="float:left;"> 미리보기로 확인해보세요 →&nbsp;&nbsp;&nbsp;&nbsp; </span>
						  <details>
						  <summary>썸네일 미리보기</summary>
						  <div>
						  <img id="preview_img" style="width:auto;height:auto;object-fit:cover;" />
							</div>
						</details>
					</div>
					</p>
				<br/>
				
					<p>
						<div class="form-group">
							<h5 style="display: inline; float: left; color: black;">강의 영상</h5>
						    &nbsp;
						    <div style="text-align: left;margin-top: 30px;">
								<input type="file" id="file_dong" name="file_dong" class="btn_file">
							</div>
							
						</div>
					</p>
				
				<div style="text-align: right;">
                      <button type="button" id="hover_btn"  class="site-btn_s" onclick="fn_submit()">등록</button>
                 </div>
				
				</div>
			</form>
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