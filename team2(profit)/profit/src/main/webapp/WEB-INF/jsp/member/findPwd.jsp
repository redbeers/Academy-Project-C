<!DOCTYPE html>
<html lang="zxx">
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
	function fn_findPwd() {
		var memberId = $.trim($("#memberId").val()); //현재 창에 입력된 값
		var memberEmail = $.trim($("#memberEmail").val()); //현재 창에 입력된 값
		if(memberId == "" || memberId == null){
			alert("아이디를 입력해주세요")
			return false;
		}
		if(memberEmail == "" || memberEmail == null){
			alert("이메일을 입력해주세요")
			return false;
		}
		$.ajax({
			type : "get",
			async : true,
			data : {memberId:memberId, memberEmail:memberEmail}, 
			url : "findPwdAjax.do",
			//전송 후 세팅
			success : function(data, textStatus) {
				var jsonInfo = JSON.parse(data);
				console.log(jsonInfo)
				if(jsonInfo.msg == "ok"){
					alert("해당 이메일로 임시 비밀번호가 발송되었습니다!")
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
	<section class="breadcrumb-option set-bg"
		data-setbg="./resources/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>비밀번호 찾기</h2>
						<!-- <div class="breadcrumb__widget">
                            <a href="./index.html">Home</a>
                            <span>Our Classes</span>
                        </div> -->
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
				<form action="#" class="appointment__form">
					<div class="text-center" >
						<div class="col-lg-6 text-center" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto; ">
							<input type="text" placeholder="아이디" name="memberId" id="memberId">
						</div>
						<div class="col-lg-6 text-center" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto; ">
							<input type="text" placeholder="이메일" name="memberEmail" id="memberEmail">
						</div>
						<div class="col-lg-6 text-center" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto; ">
							<input type="button" value="비밀번호 찾기" id="submitBtn" style="font-size: 1.1em;" onclick="fn_findPwd()"><br>
						</div><br>
							<div class="text-center">
								<h5 style="display: inline; color: white; cursor: pointer;" onClick="location.href='login'">로그인</h5>&nbsp;&nbsp;&nbsp;&nbsp;
								<h5 style="display: inline; color: white; cursor: pointer;" onClick="location.href='findId'">아이디 찾기</h5>&nbsp;&nbsp;&nbsp;&nbsp;
							</div>
						
					</div>
				</form>
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