<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
#trainerAward::-webkit-input-placeholder, #trainerCareer::-webkit-input-placeholder{
        color:gray;
}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	$(function(){
		$("textarea[name=simpleIntro]").keyup(function() { 
			var simpleIntro = $('textarea[name=simpleIntro]').val();
			if(simpleIntro.length > 60){
				alert("60자 이하로 입력하세요."); 
				return;
			}
		});

	});
	
	var cnt = 1;
	function fn_addFile(){
		if(cnt == 1){
			
	    $("#d_file").append("<br>" + "<input type='file' id='file"+cnt+"' class='file_choice' name='file" + cnt + "'/>");
	    
		}
	    cnt++;
	}
	
	function fn_numberAlert(){
		 if(confirm("상담을 진행하면 이용권 하나가 차감됩니다. 계속 진행하시겠습니까?"))
		 {
		  	location.href="chatting.do";
		 }
	}
	
	function fn_submit(){
 		 var fileFlag = $("#file1").val();
		 if(fileFlag == null){
			 alert("파일을 첨부해주세요.");
			 return;
		 }
		
		 var fileValue = $("#file1").val().slice(-3);
		 
		 if(!(fileValue.toLowerCase() == "jpg" || fileValue.toLowerCase() == "png" || fileValue.toLowerCase() == "gif")){
			 alert("사진은 jpg / png / gif 형태만 가능합니다.");
			 return;
		 }
		 
		 var simpleIntro = $('textarea[name=simpleIntro]').val();
		 
		 if(simpleIntro == ""){
			 alert("간단 소개를 입력해주세요");
			 return;
		 }
		 var profileMemo = $('textarea[name=profileMemo]').val();
		 if(profileMemo == ""){
			 alert("프로필 메모를 입력해주세요");
			 return;
		 }
		 
         var apply = confirm("신청서를 제출하시겠습니까?");
         if(apply == true){
            send_file();
            
         }
         else{
            alert("신청이 취소되었습니다.")
         }
	 }
	
	function send_file(){
	       var formData = new FormData($('#frm')[0]);
	          $.ajax({
	             type : 'post',
	             url : 'chatProfileAddAjax.do',
	             data : formData,
	             processData : false,
	             contentType : false,
	             async:false,
	             dataType:"text",
	             success : function(data){
	             if(data=="ok"){
	                alert("프로필이 정상적으로 등록되었습니다.");
	                location.href="chatList.do";
	             }else if(data=="no"){
	                alert("프로필 등록에 실패하였습니다. 다시 시도해주세요");
	             }else{
	                alert("프로필 등록에 실패하였습니다. 다시 시도해주세요");
	             }
	          },
	             error : function(error){
	                alert("프로필 등록에 실패하였습니다. 다시 시도해 주세요.");
	                console.log(error);
	                console.log(error.status);
	             }
	             
	             
	          })
	    }

</script>
</head>

<body>
<!-- Breadcrumb Begin -->
    <section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h2>1:1 상담</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
<!-- Breadcrumb End -->
 <section class="appointment" style=" margin-bottom: 50px;">
      <div class="container">
         <div class="appointment__text" style="background-color: #9e9e9e0a">
<!--             <form class="appointment__form"  action="fileUpload" id="frm" method="post" enctype="multipart/form-data"> -->
               <div class="text-center">
                  <h4 style="font-family: DM Sans, sans-serif;color: #111111;font-weight: 400;">1:1 상담 프로필 등록</h4>
                  <br/>
                  <p style="font-family: DM Sans, sans-serif;font-size: 1.2em;color:#5768AD;">본인의 정보를 정확히 입력하여 신청해주세요. </p>
                  <p style="color:#5768AD;">▶ 프로필 사진은 <span style="color:#FC7F65;">jpg / png / gif </span>형태만 가능합니다.</p>
                  <p style="color:#5768AD;">▶ 간단 소개는  <span style="color:#FC7F65;">60자 이하</span>로 작성해주시기 바랍니다.</p>
                  <p style="color:#5768AD;">▶ 사실이 아닌 정보를 기입 하면 불이익을 받을 수 있습니다.</p>
                  <p style="color:#5768AD;">▶ 프로필 사진은 <span style="color:#FC7F65;">500 x 500 </span> 사이즈로 첨부해주세요.</p>
                  <p style="color:#5768AD;">▶ 고객이 상담 중 불만을 제기하면 관리자가 확인 후 절차대로 진행합니다.</p>
                  <br/><br/>
                  <form id="frm" class="appointment__form" method="post" 
                                            enctype="multipart/form-data">
							<div class="col-lg-6 text-center mypage_myinfo"
                              style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
                              <div style="margin-bottom: 2px;">
                                 <h5 style="display: inline; float: left; color: black;">프로필 사진 첨부</h5>
                                 &nbsp;
                                 <div class="col-lg-12" style=" float: left; padding: 0; margin: 0;">
                                       <input type="button" class="file_add" value="파일 추가" onClick="fn_addFile()" style="float: left;margin-top: 10px;">
                                       <div id="d_file" style="text-align: left;float: left">
                                       
                                       </div>
                                 </div>
                              </div>
                              <div class="input-group" style="margin-bottom: 5px;">
                                </div>
                           </div>
                           
                           <div class="col-lg-6 text-center mypage_myinfo"
                              style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
                              <div style="margin-bottom: 2px;">
                                 <h5 style="display: inline; float: left; color: black;">간단 소개</h5>
                                 &nbsp;
                              </div>
                              <div class="row">
                                 <div class="col-lg-12"></div>
                                 <div class="col-lg-12 text-center">
                                    <textarea  
                                       id="trainerAward" name="simpleIntro" style="background-color: #3f51b50d; color: black; margin-bottom: 20px;resize: none;padding: 15px;" placeholder="간단 소개를 입력하세요"></textarea>

                                 </div>
                              </div>
                           </div>
                           
                           <div class="col-lg-6 text-center mypage_myinfo"
                              style="margin-right: auto; max-width: 100%; width: 500px; margin-left: auto;">
                              <div style="margin-bottom: 2px;">
                                 <h5 style="display: inline; float: left; color: black;">프로필 메모</h5>
                                 &nbsp;
                              </div>
                              <div class="row">
                                 <div class="col-lg-12"></div>
                                 <div class="col-lg-12 text-center">
                                    <textarea  
                                       id="trainerAward" name="profileMemo" style="background-color: #3f51b50d; color: black; margin-bottom: 20px;resize: none;height: 200px;padding: 15px;" placeholder="프로필 메모를 입력하세요"></textarea>

                                 </div>
                              </div>
                              <div class="col-lg-12" style="text-align: right;padding: 0">
                                      <input type="button" class="file_add" value="신청" style="width: 100%;font-size: 1.1em;" onclick="fn_submit()">
                                 </div>
                           </div>
                           
                           <br>
                           
                  
                  </form>

               </div>
<!--             </form> -->
         </div>
      </div>
   </section>
   <!-- Appoinment Section End -->
</body>
<!-- Js Plugins -->
    <script src="./resources/js/jquery-3.3.1.min.js"></script>
    <script src="./resources/js/bootstrap.min.js"></script>
    <script src="./resources/js/jquery.nice-select.min.js"></script>
    <script src="./resources/js/jquery.barfiller.js"></script>
    <script src="./resources/js/jquery.slicknav.js"></script>
    <script src="./resources/js/owl.carousel.min.js"></script>
    <script src="./resources/js/main.js"></script>
</html>