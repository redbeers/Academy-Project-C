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
</style>
<script type="text/javascript">
function fn_login(){
	
    var memberId = $.trim($("#memberId").val());
    var memberPwd = $.trim($("#memberPwd").val());
   
    if(memberId == ""){
    	alert("아이디를 입력해주세요");
      	$("#memberId").focus();
      	return false;
   	}
   	if(memberPwd == ""){
      	alert("비밀번호를 입력해주세요");
      	$("#memberPwd").focus();
      	return false;
   	}
   	sessionStorage.clear();
   	$.ajax({
      	type : "POST",
      	data : "memberId=" + memberId +"&memberPwd=" + memberPwd,
      	url : "loginSubmitAjax.do",
      
      	success : function(result) {
	 	  	var jsonInfo = JSON.parse(result);
			if (jsonInfo.sts == "OK") {
				if(memberId == '1'){
					alert("관리자님 안녕하세요");
				}else{
					alert(memberId+"님 로그인 되었습니다")
				}
				if(jsonInfo.returnUrl == null){
					location.href= "home.do";
				}else{
					location.href= jsonInfo.returnUrl;
				}
			} else {
			   alert("로그인 정보를 다시 확인해주세요");
			}
      	},
      	error : function() {
         	alert("오류발생");
      	}

   	});
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
                  <h2>로그인</h2>
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
            <!-- <div class="row">
               <div class="col-lg-12">
                  <div class="section-title">
                     <h2 style="font-size: 35px;"></h2>
                  </div>
               </div>
            </div> -->
            <form class="appointment__form">
               <div class="text-center" >
                  <div class="col-lg-6 text-center" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto; ">
                     <input type="text" placeholder="아이디" name="memberId" id="memberId">
                  </div>
                  <div class="col-lg-6 text-center" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto; ">
                     <input type="text" placeholder="비밀번호" name="memberPwd" id="memberPwd">
                  </div>
                  <div class="col-lg-6 text-center" style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto; ">
                     <input type="button" value="로그인" id="submitBtn" style="font-size: 1.1em;" onclick="fn_login()"><br>
                     <input type="button" value="카카오로그인" id="submitBtn" style="background: yellow;font-size: 1.1em;" 
                     onclick="location.href='https://kauth.kakao.com/oauth/authorize?client_id=489bf5bfcd8cd45e45a5eb837d76e305&redirect_uri=http://localhost:9999/kakaoCallback.do&response_type=code'">
                  </div><br>
                     <div class="text-center">
                        <h5 style="display: inline; color: white; cursor: pointer;" onClick="location.href='findId.do'">아이디 찾기</h5>&nbsp;&nbsp;&nbsp;&nbsp;
                        <h5 style="display: inline; color: white; cursor: pointer;" onClick="location.href='findPwd.do'">비밀번호 찾기</h5>&nbsp;&nbsp;&nbsp;&nbsp;
                        <h5 style="display: inline; color: white; cursor: pointer;" onClick="location.href='join.do'">회원가입</h5>
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