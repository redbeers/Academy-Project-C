<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html lang="en">
<head>
<title>bulletin_write</title>


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
			height : 300,
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
			enctype : 'text',
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
	//글 등록
	function fn_boardAdd() {
		var commonTitle = $("input[name='commonTitle']").val();
		var commonContent = $("textarea[name='commonContent']").val();
		var file = $("input[name='file']").val();


		if (!commonTitle) {
			alert("제목을 입력해주세요");
			return;
		}
		if (!commonContent) {
			alert("내용을 입력해주세요");
			return;
		}

		var formData = new FormData($('#form')[0]);

		$.ajax({
			type : 'post',
			url : 'noticeAdd.do',
			data : formData,
			processData : false,
			contentType : false,
			async : false,
			dataType : "text",
			success : function(data) {
				if (data == "ok") {
					alert("글이 정상적으로 등록되었습니다.");
					location.href = 'noticeList.do';
				} else if (data == "ng") {
					alert("등록이 실패하였습니다. 다시 시도해주세요");
				} else {
					alert("등록이 실패하였습니다. 다시 시도해주세요");
				}
			},
			error : function(error) {
				alert("등록이 실패하였습니다. 다시 시도해 주세요.");
			}
		})
	}
</script>
</head>
<body>
	<!-- Breadcrumb Begi -->
	<section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg" style="background-image: url(&quot;./resources/img/breadcrumb.jpg&quot;);">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>공지사항 등록</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->


	<section class="classes spad">
		<main role="main" class="container">
		<h3>👨‍🎓공지사항을 입력 해주세요</h3>
		<br>
		<form id="form" name="form" enctype="multipart/form-data">
			<div class="pt-1"></div>
			<label>
				<p style="font-weight: bold; margin-bottom: 0">
					제목<span style="color: red;"> *</span>
				</p>
			</label>
			<div class="pt-1"></div>

			<input type="text" name="commonTitle" placeholder="제목을 입력하세요" style="width: 99%; border: none; border-bottom: 1px solid #D5D4D4; height: 54px; font-size: 15px;">
			<div class="container" style="margin-top: 10px; margin-bottom: 20px; padding: 0; position: relative;">
				<textarea class="summernote" id="summernote" name="commonContent"></textarea>
				<div id="loading" style="position: absolute; top: 50%; left: 50%; margin: -150px 0 0 -150px">
					<img id="loading-image" src="./resources/img/common/loading.gif" alt="Loading..." />
				</div>
			</div>
			<br>
			<div>
				<input type="file" class="file" id="file" name="file" value="파일첨부" multiple="multiple"/>
			</div>
			<div class="pt-1 text-right">
				<button id="hover_btn" class="btn btn btn-success" type="button" style="width: 10%; padding: 5px;" onclick="fn_boardAdd()">등록</button>
			</div>
		</form>
		</main>
	</section>
</body>
</html>
