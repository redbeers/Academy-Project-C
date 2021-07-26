<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<style>
.out_div {
	margin-right: auto;
	max-width: 100%;
	width: 500px;
	margin-left: auto;
}

.inner_input {
	margin-bottom: 17px;
	margin-top: 4px;
}

.form-control:focus {
	color: white;
}

input:-webkit-autofill {
  -webkit-box-shadow: 0 0 0px 30px #7986bd inset !important;
  -webkit-text-fill-color: #FFFFFF !important;
}
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
</style>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	
	function fn_email_number(){
		
		var memberEmail = $.trim($("#memberEmail").val()); //현재 창에 입력된 값
		var emailReg = /.+@[a-z]+(\.[a-z]+){1,2}$/;
		if (!emailReg.test($("input[name=memberEmail]").val())) {
			alert("올바른 이메일 형식이 아닙니다");
			$("#msgEmail").html("");
			return false;
		}
		
		if($("input[name=checked_email]").val() == 'n'){
			alert("사용중인 이메일입니다.")
			return false;
		}
		
		emailNum = generateRandomCode(5)
		
		function generateRandomCode(n) {
			var str = ''
		  	for (let i = 0; i < n; i++) {
		    	str += Math.floor(Math.random() * 10)
		  	}
		  return str;
		}
		
		alert("해당 이메일로 인증번호가 발송되었습니다.\n이메일을 확인해주세요");
		
 		$.ajax({
			type : "POST",
			data : "memberEmail=" + memberEmail +"&emailNum=" + emailNum, 
			url : "sendmailAjax.do",
			dataType : "text", 

			success : function(result) {
				if (result == "ok") {
					
				} else {
					alert("오류가 발생했습니다. 다시 한 번 시도해주세요");
				}
			},
			error : function() {
				alert("오류발생");
			}

		}) 
	}
	


	$(function() {
		$("#frm").submit(function() {
			var idReg = /^[A-za-z]+[a-z0-9]{5,19}$/g;
			if (!idReg.test($("input[name=memberId]").val())) {
				alert("아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.");
				return false;
			}
			
			if ($("input[name=checked_id]").val() == 'n') {
				alert("중복되는 아이디입니다. 다른 아이디를 사용해주세요");
				return false;
			}
			
			var pwdReg = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
			if (!pwdReg.test($("input[name=memberPwd]").val())) {
				alert("비밀번호는 특수문자/영문자/숫자 포함 형태의 8~20자 형태이어야 합니다");
				return false;
			}
			
			if ($("input[name=checked_pwd]").val() == 'n') {
				alert("비밀번호가 일치하지않습니다");
				return false;
			}
            
            var nameReg = /^[가-힣]{2,10}$/;
			if (!nameReg.test($("input[name=memberName]").val())) {
				alert("이름은 10글자 이내의 한글만 입력 가능합니다");
				return false;
			}
			
			var nicknameReg = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,20}$/
			if (!nicknameReg.test($("input[name=memberNickname]").val())) {
				alert("닉네임은 20글자 내로 가능합니다.");
				return false;
			}
			
			if ($("input[name=checked_nickname]").val() == 'n') {
				alert("중복되는 닉네임입니다. 다른 닉네임을 사용해주세요");
				return false;
			}
			
			var mobileReg = /^01\d\d{3,4}\d{4}$/;
			if (!mobileReg.test($("input[name=memberMobile]").val())) {
				alert("올바른 전화번호 형식이 아닙니다");
				return false;
			}
            
			var emailReg = /.+@[a-z]+(\.[a-z]+){1,2}$/;
			if (!emailReg.test($("input[name=memberEmail]").val())) {
				alert("올바른 이메일 형식이 아닙니다");
				return false;
			}
			
			if ($("input[name=checked_email]").val() == 'n') {
				alert("중복되는 이메일입니다. 다른 이메일을 사용해주세요");
				return false;
			}
			console.log(emailNum)
			
			if ($("input[name=confirmEmailNum]").val() != emailNum) {
				alert("인증번호가 일치하지 않습니다. 정확히 입력해주세요");
				return false;
			}
			
			
			if($.trim($("#memberId").val()) !== $("#memberId").val() || 
					$.trim($("#memberPwd").val()) !== $("#memberPwd").val() || 
					$.trim($("#memberName").val()) !== $("#memberName").val() || 
					$.trim($("#memberNickname").val()) !== $("#memberNickname").val() || 
					$.trim($("#memberMobile").val()) !== $("#memberMobile").val() || 
					$.trim($("#memberEmail").val()) !== $("#memberEmail").val()) {
				alert("공백은 입력이 불가능합니다.");
				return false;
			}
			
			alert("회원가입이 완료되었습니다! ")
			
		})

		
		$("#memberId").blur(function() {
			var memberId = $.trim($("#memberId").val()); //현재 창에 입력된 값
			var idReg = /^[A-za-z]+[a-z0-9]{5,19}$/g;
			if (!idReg.test($("input[name=memberId]").val())) {
				alert("아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.");
				$("#msgId").html("");
				return false;
			}
			//checkMemberId로 데이터 전송 - 비동기 전송방식
			$.ajax({
				type : "POST",
				data : "memberId=" + memberId, //json
				url : "idcheckAjax.do",
				dataType : "text", //리턴타입

				//전송 후 세팅
				success : function(result) {
					if (result == "ok") {
						$("#msgId").html("사용가능한 아이디 입니다");
						$("input[name=checked_id]").val('y');
					} else {
						$("#msgId").html("사용중인 아이디입니다");
						$("input[name=checked_id]").val('n');
					}
				},
				error : function() {
					alert("오류발생");
				}

			})
		});
		
		
		
		$("#memberNickname").blur(function() {
			var memberNickname = $.trim($("#memberNickname").val()); //현재 창에 입력된 값
			var nicknameReg =  /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,20}$/
			if (!nicknameReg.test($("input[name=memberNickname]").val())) {
				alert("닉네임은 20글자내로 가능합니다. 밑에");
				$("#msgNickname").html("");
				return false;
			}

			$.ajax({
				type : "POST",
				data : "memberNickname=" + memberNickname, //json
				url : "nicknamecheckAjax.do",
				dataType : "text", //리턴타입

				//전송 후 세팅
				success : function(result) {
					if (result == "ok") {
						$("#msgNickname").html("사용가능한 닉네임입니다");
						$("input[name=checked_nickname]").val('y');
					} else {
						$("#msgNickname").html("사용중인 닉네임입니다");
						$("input[name=checked_nickname]").val('n');
					}
				},
				error : function() {
					alert("오류발생");
				}

			})
		});
		
		
		$("#memberEmail").blur(function() {
			var memberEmail = $.trim($("#memberEmail").val()); //현재 창에 입력된 값
			var emailReg = /.+@[a-z]+(\.[a-z]+){1,2}$/;
			if (!emailReg.test($("input[name=memberEmail]").val())) {
				alert("올바른 이메일 형식이 아닙니다");
				$("#msgEmail").html("");
				return false;
			}

			$.ajax({
				type : "POST",
				data : "memberEmail=" + memberEmail, //json
				url : "emailcheckAjax.do",
				dataType : "text", //리턴타입

				//전송 후 세팅
				success : function(result) {
					if (result == "ok") {
						$("#msgEmail").html("사용가능한 이메일입니다");
						$("input[name=checked_email]").val('y');
					} else {
						$("#msgEmail").html("사용중인 이메일입니다");
						$("input[name=checked_email]").val('n');
					}
				},
				error : function() {
					alert("오류발생");
				}

			})
		});
		
		
		$("#confirmPwd").blur(function() {

			if ($("#memberPwd").val() !== $("#confirmPwd").val()) {
				$("#msgPwd").html("비밀번호가 일치하지않습니다!");
				$("input[name=checked_pwd]").val('n');
				return false;
			} else {
				$("#msgPwd").html("비밀번호가 일치합니다!");
				$("input[name=checked_pwd]").val('y');

			}

		});
		
		$("#memberPwd").blur(function() {

			if ($("#memberPwd").val() !== $("#confirmPwd").val()) {
				$("#msgPwd").html("비밀번호가 일치하지않습니다!");
				$("input[name=checked_pwd]").val('n');
				return false;
			} else {
				$("#msgPwd").html("비밀번호가 일치합니다!");
				$("input[name=checked_pwd]").val('y');

			}

		});

	})
</script>
<body>
	<!-- Breadcrumb Begin -->
	<section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>회원가입</h2>
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
				<!-- <form class="appointment__form" action="#"> -->
				<form class="appointment__form" action="joinAjax.do" id="frm" method="post">
					<div class="text-center">

						<!-- 1. 아이디 // 1) 아이디 중복검사 -->
						<div class="col-lg-6 text-center out_div">
							<div style="margin-bottom: 5px;">
								<h5 style="display: inline; float: left; color: white;">아이디 *&nbsp;&nbsp;</h5>
								<h5 style="display: inline; float: left; color: orange;" id="msgId"></h5>
							</div>
							<input class="inner_input" type="text" placeholder="영문자로 시작하는 6~20자 영문자 또는 숫자" id="memberId" name="memberId"> 
							<input class="inner_input" type="hidden" name="checked_id" value="n">
						</div>


						<!-- 2. 비밀번호 입력 -->
						<div class="col-lg-6 text-center out_div">
							<div style="margin-bottom: 2px;">
								<h5 style="display: inline; float: left; color: white;">비밀번호 *&nbsp;&nbsp;</h5>
							</div>
							<input class="inner_input" type="text" placeholder="Password" id="memberPwd" name="memberPwd">
						</div>

						<!-- 3. 비밀번호 확인 // 2) 비밀번호 일치여부 검사 -->
						<div class="col-lg-6 text-center out_div">
							<div style="margin-bottom: 2px;">
								<h5 style="display: inline; float: left; color: white;">비밀번호 확인 *&nbsp;&nbsp;</h5>
								<h5 style="display: inline; float: left; color: orange;" id="msgPwd"></h5>
							</div>
							<input class="inner_input" type="text" placeholder="Password" id="confirmPwd" name="confirmPwd"> 
							<input class="inner_input" type="hidden" name="checked_pwd" value="n">
						</div>

						<!-- 4. 이름 -->
						<div class="col-lg-6 text-center out_div">
							<div style="margin-bottom: 2px;">
								<h5 style="display: inline; float: left; color: white;">이름 *&nbsp;&nbsp;</h5>
							</div>
							<input class="inner_input" type="text" placeholder="Name" id="memberName" name="memberName">
						</div>

						<!-- 5. 닉네임 // 3) 닉네임 중복검사 -->
						<div class="col-lg-6 text-center out_div">
							<div style="margin-bottom: 2px;">
								<h5 style="display: inline; float: left; color: white;">닉네임 *&nbsp;&nbsp;</h5>
								<h5 style="display: inline; float: left; color: orange;" id="msgNickname"></h5>
							</div>
							<input class="inner_input" type="text" placeholder="Nickname" id="memberNickname" name="memberNickname">
							<input class="inner_input" type="hidden" name="checked_nickname" value="n">
						</div>

						<!-- 6. 핸드폰번호 -->
						<div class="col-lg-6 text-center out_div">
							<div style="margin-bottom: 2px;">
								<h5 style="display: inline; float: left; color: white;">핸드폰번호 *&nbsp;&nbsp;</h5>
							</div>
							<input class="inner_input" type="text" placeholder="숫자만 입력해주세요" id="memberMobile" name="memberMobile">
						</div>

						<!-- 7. 성별 선택 -->
						<div class="col-lg-6 text-center mypage_myinfo out_div">
							<div style="margin-bottom: 2px;">
								<h5 style="display: inline; float: left; color: white;">성별 *&nbsp;&nbsp;</h5>
								&nbsp;&nbsp;
							</div>
							<div class="join_gender">
								<input type="radio" name="memberGender" id="male" value="M" autocomplete="off" style="opacity: 0; margin-bottom: 5px;"> 
								<label for="male" style="float: left; margin-bottom: 5px;">남자</label>
								<input type="radio" name="memberGender" id="female" value="F" autocomplete="off" style="opacity: 0; margin-bottom: 5px;"> 
								<label for="female" style="float: left; margin-bottom: 5px;">여자</label>
							</div>
						</div>

						<br>
						<br>
						<br>
						<!-- 8. 키 입력 -->
						<div class="col-lg-6 text-center out_div">
							<div style="margin-bottom: 2px;">
								<h5 style="display: inline; float: left; color: white;">키&nbsp;&nbsp;</h5>
							</div>
							<input class="inner_input" type="text" placeholder="" id="memberHeight" name="memberHeight">
						</div>

						<!-- 9. 몸무게 입력 -->
						<div class="col-lg-6 text-center out_div">
							<div style="margin-bottom: 2px;">
								<h5 style="display: inline; float: left; color: white;">몸무게&nbsp;&nbsp;</h5>
							</div>
							<input class="inner_input" type="text" placeholder="" id="memberWeight" name="memberWeight">
						</div>

						<!-- 10. 이메일 & 이메일 인증 버튼 -->
						<div class="col-lg-6 text-center out_div" style="margin-bottom: 20px;">
							<div style="margin-bottom: 2px;">
								<h5 style="display: inline; float: left; color: white; margin-bottom: 4px;">이메일 *&nbsp;&nbsp;</h5>
								<h5 style="display: inline; float: left; color: orange;" id="msgEmail"></h5>
								
							</div>
							<div class="input-group" style="margin-bottom: 5px;">
								<input type="text" class="form-control" placeholder="Email" id="memberEmail" name="memberEmail" style="font: white;">
								<input class="inner_input" type="hidden" name="checked_email" value="n"> 
								<span class="input-group-addon" style="border: 1px solid #5768AD; border-radius: 4px;">
									<button type="button" onclick="fn_email_number()" class="input-group-addon"
										style="font-size: 1.0em; padding: 12.5px; margin-left: 5px;">인증번호전송</button>
								</span>
							</div>
						</div>


						<!-- 11. 이메일인증번호 입력칸 -->
						<div class="col-lg-6 text-center out_div">
							<div style="margin-bottom: 2px;">
								<h5 style="display: inline; float: left; color: white;">이메일 인증번호 *&nbsp;&nbsp;</h5>
							</div>
							<input class="inner_input" type="text" placeholder="인증번호" name="confirmEmailNum">
						</div>
						<br>


						<!-- 끝! 회원가입 버튼 -->
						<div class="col-lg-6 text-center out_div">
							<input type="submit" value="회원가입" id="submitBtn" style="font-size: 1.1em;"><br>
						</div>

					</div>
				</form>
			</div>
		</div>
	</section>
	<!-- Appoinment Section End -->


	<!-- Js Plugins -->

	<script src="./resources/js/bootstrap.min.js"></script>
	<script src="./resources/js/jquery.nice-select.min.js"></script>
	<script src="./resources/js/jquery.barfiller.js"></script>
	<script src="./resources/js/jquery.slicknav.js"></script>
	<script src="./resources/js/owl.carousel.min.js"></script>
	<script src="./resources/js/main.js"></script>
</body>

</html>