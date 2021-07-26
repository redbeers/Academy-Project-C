<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>

<!-- <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.css" rel="stylesheet"> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.js"></script> -->
<!-- <script src="https://github.com/summernote/summernote/tree/master/lang/summernote-ko-KR.js"></script> -->

<script src="./resources/summernote/summernote-lite.js"></script>
<script src="./resources/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="./resources/summernote/summernote-lite.css">
  
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script type="text/javascript">
$(function(){
	$('#loading').hide();
	$('.summernote').summernote({
		height: 600,
		fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
		fontNamesIgnoreCheck : [ '맑은고딕' ],
		focus: true,

		callbacks: {
		onImageUpload: function(files, editor, welEditable) {
	            for (var i = files.length - 1; i >= 0; i--) {
	             sendFile(files[i], this);
	            }
	        }
		}

	});

})

function sendFile(file, el) {
var form_data = new FormData();
       form_data.append('file', file);
       $.ajax({
         data: form_data,
         type: "POST",
         url: 'testImage.do',
         cache: false,
         contentType: false,
         enctype: 'multipart/form-data',
         processData: false,
         beforeSend: function() {
        	 $('#loading').show(); 
	     },
         success: function(img_name) {
            console.log(img_name);
            setTimeout(function() {
            	alert("파일이 첨부되었습니다.");
            	$('#loading').hide(); 
				$(el).summernote('editor.insertImage', img_name);
			}, 4000);
         }
       });
}
</script>
</head>
<body>

<div class="container" style="margin-top:10px;margin-bottom:20px;padding:0;position: relative;">
  <textarea class="summernote" name="editordata">
  </textarea>   
  <div id="loading" style="position: absolute;top: 50%;left: 50%;margin:-150px 0 0 -150px">
  	<img id="loading-image" src="./resources/img/common/loading.gif" alt="Loading..." />
  </div> 
</div>

</body>
</html>