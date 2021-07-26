<!DOCTYPE html>
<html lang="zxx">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge" charset="utf-8">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
function go_time(){
	 
	 var now = new Date();
	 
	 var year = now.getFullYear(); //년
	 var month = now.getMonth(); //월
	 var day = now.getDay();  //일
	 var hour = now.getHours();  //시
	 var min = now.getMinutes();  //분
	 var sec = now.getSeconds();  //초
	 
	 document.getElementById("clock").innerHTML 
	 = year+"년 "+ month+"월 "+day+"일 "+hour+":"+min+":"+sec
	 //id가 clock인 html에 현재시각을 넣음
	 
	 setTimeout("go_time()", 1000);
	 //1초마다 해당 펑션을 실행함.
}


function paybtn() {
	INIStdPay.pay('SendPayForm_id');
}


function fn_pay(lessonTitle, lessonPrice, lessonSeq, lessonMonth) {
	var IMP = window.IMP; // 생략가능
	IMP.init('imp68072883');
	// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
	IMP.request_pay({
	pg: 'html5_inicis', // version 1.1.0부터 지원.
	/*
	'kakao':카카오페이,
	html5_inicis':이니시스(웹표준결제)
	'nice':나이스페이
	'jtnet':제이티넷
	'uplus':LG유플러스
	'danal':다날
	'payco':페이코
	'syrup':시럽페이
	'paypal':페이팔
	*/
	pay_method: 'card',
	/*
	'samsung':삼성페이,
	'card':신용카드,
	'trans':실시간계좌이체,
	'vbank':가상계좌,
	'phone':휴대폰소액결제
	*/
	merchant_uid: 'merchant_' + new Date().getTime(),
	/*
	merchant_uid에 경우
	https://docs.iamport.kr/implementation/payment
	위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
	참고하세요.
	나중에 포스팅 해볼게요.
	*/
	name: 'Profit : ' + lessonTitle,
	//결제창에서 보여질 이름
// 	amount: ticketPrice,
	amount: 100,
	//가격
	buyer_email: 'iamport@siot.do',
	buyer_name: '구매자이름',
	buyer_tel: '010-1234-5678',
	buyer_addr: '대전광역시 서구 대흥동 대덕인재개발원',
	buyer_postcode: '123-456',
	m_redirect_url: 'https://www.yourdomain.com/payments/complete'
	/*
	모바일 결제시,
	결제가 끝나고 랜딩되는 URL을 지정
	(카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
	*/
	}, function (rsp) {
	console.log(rsp);
	if (rsp.success) {
		alert("결제가 완료되었습니다.");
		buyLessonAddAjax(lessonTitle, lessonPrice, lessonSeq, lessonMonth);
		location.href="lessonDetail.do?lessonSeq="+lessonSeq;
	} else {
		alert('결제를 취소하였습니다.');
	}
	
	});
	
	
	
	
}

function buyLessonAddAjax(lessonTitle, lessonPrice, lessonSeq, lessonMonth){
	var params = "lessonTitle="+ lessonTitle;
	params += "&lessonPrice=" + lessonPrice;
	params += "&lessonSeq=" + lessonSeq;
	params += "&lessonMonth=" + lessonMonth;
	console.log(params);
	
	$.ajax({
		type:"POST",
		async:false,
		url:"buyLessonAddAjax.do",
		data:params,
		success : function(data){
		},
		error : function(error){
			alert("구매가 실패하였습니다. 다시 시도해 주세요.");
			console.log(error);
			console.log(error.status);
		}
	});
}

</script>
<body onload="go_time()">


    <!-- Breadcrumb Begin -->
    <section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h2>강의 구매</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb End -->
	
<!-- Pricing Section Begin -->
    <section class="pricing spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                    	<div style="background-color: #F6F6F9;padding: 60px;">
                        <h2 style="color:#404041; font-weight: bold;">구매 하기</h2>
	                        <br>
	                        <span style="color: gray;font-size: 1em;font-weight: bold;">※ 본 상품은 고객의 단순 변심으로 환불이 불가한 상품입니다.</span><br>
	                        <span style="color: gray;font-size: 1em;font-weight: bold;">※ 구매정보를 확인하시고 결제를 진행해주세요.</span>
	                        <br>
	                        <br>
	                        <hr style="color: gray;width: 80%;">
	                        <br>
	                        <section class="content content_content" style="width: 70%; margin: auto;">
                    <section class="invoice">
                        <!-- title row -->
                        <div class="row">
                        </div>
                        <!-- info row -->
                        <div class="row invoice-info">
                            <div class="col-sm-4 invoice-col">
                                <address>
                                    <strong>
                                                                            </strong>
                                </address>
                            </div><!-- /.col -->
                            <div class="col-sm-4 invoice-col">
                                <address>
                                    <strong>
                                        #구매정보                                   </strong>
                                    <br>
                                      결제사이트 : PROFIT                                  <br>
					   대표자 : JAYPARK<br>
					                                      <br>
                                                                  </address>
                            </div><!-- /.col -->
                            <div class="col-sm-4 invoice-col">
                            </div><!-- /.col -->
                        </div><!-- /.row -->

                        <!-- Table row -->
<!--                        <form id="payForm" method="POST" accept-charset="UTF-8"> -->
                        <div class="row">
                            <div class="col-xs-12 table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                </tr>
                                        <tr>
                                            <th style="display:table-cell; vertical-align: middle;">구매자</th>
                                            <th colspan="2" style="display:table-cell; vertical-align: middle;">상품명</th>
                                            <th>수강기간<br><span style="font-size: 0.8em">(개월)</span></th>
                                             <th>가격<br><span style="font-size: 0.8em">(원(&#8361;))</span></th>
                                        </tr>
                                        
                                    </thead>
                                    <tbody>
                                        
                                        
                                                                                <tr>
                                            <td style="display:table-cell; vertical-align: middle;">${memberId}</td>
                                            <td colspan="2">
                                            	<img src="http://192.168.41.6:9999/upload/profit/${result.fileSaveName}" style="width:100px;height: 70px;object-fit: cover; ">&nbsp;&nbsp;&nbsp;
                                            	${result.lessonTitle}
                                            </td>
                                            <td style="display:table-cell; vertical-align: middle;">${result.lessonMonth}</td>
                                            <td style="display:table-cell; vertical-align: middle;"><fmt:formatNumber type="number" maxFractionDigits="0"  value="${result.lessonPrice}" /></td>
                                        </tr>
                                                                            </tbody>
                                </table>
                            </div><!-- /.col -->
                        </div><!-- /.row -->
<!-- 						</form> -->
                        <div class="row">
                            <!-- accepted payments column -->
                            <div class="col-md-12">
                                <p class="lead" style="font-size: 1.1em">🛒구매일시<div id="clock"></div></p>
                                <div class="table-responsive">
                                    <table class="table">
                                        <tbody>
                                            
                                            
                                            <tr style="text-align: right;">
                                                <td>총 합계 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="background-color: #FBEDB5;padding: 3px;"><fmt:formatNumber type="number" maxFractionDigits="0"  value="${result.lessonPrice}" /> 원(&#8361;)</span></td>
                                            </tr>
                                        </tbody>
                                        
                                    </table>
                                     <div class="classes__item__text"  style="text-align: center;padding-top: 0px;margin-left: auto;margin-right: auto;">
									         <a class="class-btn_w" style="font-size: 1.1em;cursor:pointer;" onclick="fn_pay('${result.lessonTitle}','${result.lessonPrice}', '${result.lessonSeq}', '${result.lessonMonth}')">&nbsp;&nbsp;결제하기&nbsp;&nbsp;</a>
									         <a href="lessonDetail.do?lessonSeq=${result.lessonSeq}" class="class-btn_w" style="font-size: 1.1em;">&nbsp;&nbsp;뒤로가기&nbsp;&nbsp;</a>

								    </div>
                                </div>
                            </div><!-- /.col -->
                        </div><!-- /.row -->

                    </section>
                </section>
                        </div>
                    </div>
                </div>
            
            </div>
        </div>
        
    </section>
    
    <!-- Pricing Section End -->

    


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