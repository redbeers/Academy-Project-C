<!DOCTYPE html>
<html lang="zxx">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<style>
#submitBtn {
	font-size: 14px;
	color: #5768AD;
	text-transform: uppercase;
	display: inline-block;
	background: #ffffff;
	padding: 14px 35px 12px;
	border-radius: 2px;
	border: none;
	font-weight: 700;
	letter-spacing: 2px;
}
input:-webkit-autofill {
  -webkit-box-shadow: 0 0 0px 30px #7986bd inset !important;
  -webkit-text-fill-color: #FFFFFF !important;
}
</style>
<script type="text/javascript">
	function fn_findId() {
		var memberName = $.trim($("#memberName").val()); //현재 창에 입력된 값
		var memberEmail = $.trim($("#memberEmail").val()); //현재 창에 입력된 값
		if(memberName == "" || memberName == null){
			alert("이름을 입력해주세요")
			return false;
		}
		if(memberEmail == "" || memberEmail == null){
			alert("이메일을 입력해주세요")
			return false;
		}
		$.ajax({
			type : "get",
			async : false,
			data : {memberName:memberName, memberEmail:memberEmail}, 
			url : "findIdAjax.do",
			//전송 후 세팅
			success : function(data, textStatus) {
				var jsonInfo = JSON.parse(data);
				console.log(jsonInfo)
				if(jsonInfo.msg == "ok"){
					var txt = "";
					txt += "<div class='text-center'>";
					txt += "<h5 style='display: inline; color: white; font-size: 1.3em;'>회원님의 아이디는 [ "+jsonInfo.id+" ] 입니다</h5>";
					txt += "</div><br>";
					$("#ajax").html(txt);
				}else{
					alert("정보를 찾을 수 없습니다. 다시 입력해주세요")
				}
			},
			error : function() {
				alert("오류발생");
			}

		})
	}
</script>
<body>
	<!-- Breadcrumb Begin -->
	<section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>아이디 찾기</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->

	<!-- Appoinment Section Begin -->
	<section class="appointment" style="margin-top: 50px; margin-bottom: 50px;">
		<div class="container">
			<div class="appointment__text">
				
				<!-- ajax 결과 div -->
				<div id="ajax">
				</div>
					
				<form class="appointment__form" name="form" method="POST" action="/findId.do">
					<div class="col-lg-6 text-center" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
						<input name="memberName" type="text" placeholder="이름" id="memberName">
					</div>
					<div class="col-lg-6 text-center" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
						<input name="memberEmail" type="text" placeholder="이메일" id="memberEmail">
					</div>
					<div class="col-lg-6 text-center" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
						<input type="button" value="아이디 찾기" id="submitBtn" style="font-size: 1.1em; cursor: pointer;"
							onclick="fn_findId()">
					</div>
				</form>
				
				<br>
				<div class="text-center">
					<h5 style="display: inline; color: white; cursor: pointer;" onClick="location.href='login'">로그인</h5>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<h5 style="display: inline; color: white; cursor: pointer;" onClick="location.href='findPwd'">비밀번호 찾기</h5>
					&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
			</div>
		</div>
	</section>
	<!-- Appoinment Section End -->

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