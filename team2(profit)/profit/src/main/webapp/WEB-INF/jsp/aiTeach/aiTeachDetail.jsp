<!DOCTYPE html>
<html lang="zxx">
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){ 
	$("#exe_btn").hide();
  	var fileTarget = $('#file'); 
  	fileTarget.on('change', function(){ // 값이 변경되면
     	var cur=$(".filebox input[type='file']").val();
  	
     	var curSplit  = cur.split("\\");    //   "\" 로 전체 url 을 나눈다
     	var nameLength = curSplit.length;
     	var fileName         = curSplit[nameLength-1];   // 나누어진 배열의 맨 끝이 파일명이다

    	$(".upload-name").val(fileName);
  	}); 
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
</script>
<body>

	<!-- Breadcrumb Begin -->
	<section class="breadcrumb-option set-bg"
		data-setbg="./resources/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>AI 자세교정</h2>
						<div class="breadcrumb__widget">
							<span>나의 운동자세를 AI가 평가합니다</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->

	<!-- Classes Section Begin -->
	<section class="classes spad">
		<div class="container">
			<div class="classes__filter">
				<div class="row">
					<form method="post"
							action=${pageContext.request.contextPath}/upload
							enctype="multipart/form-data">
						<div class="col-lg-12">
							<div class="leave__comment__text" style="text-align: center;">
								<br>
								<h3>📸 자신의 자세가 담긴 사진을 첨부해주세요</h3><br>
							</div>
							
								<div class="filebox" style="text-align: center;margin-top: 30px;"> 
								  <label for="file">파일첨부</label> 
								  <input type="file" id="file" onchange="readURL(this);"> 
								  <input class="upload-name" value="첨부파일이 없습니다." readonly="readonly">
								</div>
								<div class="ai-thumnail-wrapper" style="width: 100%; height: autox;">
							        <div class="img_wrap ai-thumbnail" style="text-align: center;">
							            <img id="preview_img" />
							        </div>
							    </div>
								<div class="classes__item__text"
									style="text-align: center; padding-top: 30px;">
									<a id="exe_btn" href="aiTeachDetail" class="class-btn_w"
										style="width: 158px; ">자세 평가받기</a> 
								</div>
						</div>
					</form>
				</div>
			</div>
		</div>


	</section>
	<!-- Classes Section End -->


	<!-- Js Plugins -->
	
	<script src="./resources/js/bootstrap.min.js"></script>
	<script src="./resources/js/jquery.nice-select.min.js"></script>
	<script src="./resources/js/jquery.barfiller.js"></script>
	<script src="./resources/js/jquery.slicknav.js"></script>
	<script src="./resources/js/owl.carousel.min.js"></script>
	<script src="./resources/js/main.js"></script>
</body>

</html>