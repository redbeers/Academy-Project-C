<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
<!-- include libraries(jQuery, bootstrap) -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.js"></script>
<script src="https://github.com/summernote/summernote/tree/master/lang/summernote-ko-KR.js"></script>

<!-- 서머노트를 위해 추가해야할 부분 -->
<script src="./resources/summernote/summernote-lite.js"></script>
<script src="./resources/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="./resources/summernote/summernote-lite.css">

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<title>bulletin_write</title>
<style type="text/css">
#hover_btn {
	font-size: 14px;
	font-weight: 700;
	color: #5768AD;
	display: inline-block;
	border: 1px solid rgba(155, 158, 163, 0.2);
	padding: 10px 20px 7px;
	border-radius: 2px;
	background-color: white;
}

#hover_btn:hover {
	background: #5768AD;
	border: 1px solid #5768AD;
	color: #ffffff;
}
</style>

<script type="text/javascript">
	//섬머노트
	$(function() {
		$('#loading').hide();
		$('.summernote').summernote({
			height : 600,
			fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
			fontNamesIgnoreCheck : [ '맑은고딕' ],
			focus : true,

			callbacks : {
				onImageUpload : function(files, editor, welEditable) {
					for (var i = files.length - 1; i >= 0; i--) {
						sendFile(files[i], this);
					}
				}
			}

		});

	})
	//파일업로드
	function sendFile(file, el) {
		var form_data = new FormData();
		form_data.append('file', file);
		$.ajax({
			data : form_data,
			type : "POST",
			url : 'qnaProfileImage.do',
			cache : false,
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			beforeSend : function() {
				$('#loading').show();
			},
			success : function(img_name) {
				console.log(img_name);
				setTimeout(function() {
					alert("파일첨부");
					$('#loading').hide();
					$(el).summernote('editor.insertImage', img_name);
				}, 5000);
			}
		});
	}
	//클릭시 파일 처음거 가지고가기
	$(function() {
		$('#hover_btn').click(function() {
			var tumnail = $("form img").first().attr("src");
			$('#hidden').val(tumnail);
		})
	})
</script>
</head>
<body>
	<c:set var="data" value="${data}" />
	<!-- Breadcrumb Begi -->
	<section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg" style="background-image: url(&quot;./resources/img/breadcrumb.jpg&quot;);">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>레시피 수정</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->

	<section class="classes spad">
		<main role="main" class="container">
		<h3>📑 레시피를 수정해주세요</h3>
		<br>
		<form class="container" name="form" method="POST" action="/recipeMod.do?communitySeq=${data.communitySeq}">
			<input type="hidden" id="hidden" name="tumnalil_img" value="none" />
			<div class="pt-1"></div>
			<input type="text" name="commonTitle" value="${data.commonTitle}" placeholder="제목을 입력하세요" style="border-radius: 5px; width: 100%; padding: 5px;">
			<div class="container" style="margin-top: 10px; margin-bottom: 20px; padding: 0; position: relative;">
				<textarea class="summernote" id="summernote" name="commonContent">
					${data.commonContent}
				</textarea>
				<div id="loading" style="position: absolute; top: 50%; left: 50%; margin: -150px 0 0 -150px">
					<img id="loading-image" src="./resources/img/common/loading.gif" alt="Loading..." />
				</div>
			</div>
			<div class="pt-1 text-right">
				<button id="hover_btn" class="btn btn btn-success" type="button" style="width: 10%; padding: 5px;" onclick="location.href='recipeList.do'">목록</button>
				<button id="hover_btn" class="btn btn btn-success" type="submit" style="width: 10%; padding: 5px;">수정</button>
			</div>
		</form>
		</main>
	</section>
</body>
</html>

