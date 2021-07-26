<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
	box-sizing: border-box;
}

.que:first-child {
	border-top: 1px solid black;
}

.que {
	position: relative;
	padding: 17px 0;
	cursor: pointer;
	font-size: 20px;
	border-bottom: 1px solid #dddddd;
}

.que::before {
	display: inline-block;
	content: 'Q';
	font-size: 16px;
	font-family: "DM Sans";
	color: #006633;
	margin-right: 5px;
}

.que.on>span {
	font-weight: bold;
	color: #006633;
}

.anw {
	display: none;
	overflow: hidden;
	font-family: "DM Sans";
	font-size: 16px;
	background-color: #f4f4f2;
	padding: 27px 0;
}

.anw::before {
	display: inline-block;
	font-size: 16px;
	font-weight: bold;
	color: #666;
	margin-right: 5px;
}

.table tr:hover {
	background-color: #f8f6ff;
}

.accordion {
  background-color: #EFF7FD;
  color: #444;
  cursor: pointer;
  padding: 18px;
  width: 100%;
  text-align: left;
  outline: none;
  font-size: 15px;
  transition: 0.4s;
  border-bottom:1px solid #D1D2D3;
  border-left-style: none;
  border-right-style: none;
  border-top-style: none;
}

.accordion:hover {
  background-color: #D4EAFB;
}

.accordion:after {
  content: '\002B';
  color: #777;
  font-weight: bold;
  float: right;
  margin-left: 5px;
}

.panel {
  padding: 0 18px;
  background-color: white;
  max-height: 0;
  overflow: hidden;
/*   t/*  */ransition: max-height 0.2s ease-out; */
}

#detail_a{
	color: #5768AD;
}
a:hover, a:focus {
    text-decoration: none;
    outline: none;
    color: #ffffff;
}
</style>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	function fn_detail(communitySeq) {
		// 	alert("wjdtkd")
		location.href = "qnaDetail.do?communitySeq=" + communitySeq;
	}
	$(function(){
		var acc = document.getElementsByClassName("accordion");
		var i;

		for (i = 0; i < acc.length; i++) {
		  acc[i].addEventListener("click", function() {
		    this.classList.toggle("active");
		    var panel = this.nextElementSibling;
		    if (panel.style.maxHeight) {
		      panel.style.maxHeight = null;
		    } else {
		      panel.style.maxHeight = panel.scrollHeight + "px";
		    } 
		  });
		}
	})
	
</script>
</head>
<body>
	<!-- Breadcrumb Begi -->
	<section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg" style="background-image: url(&quot;./resources/img/breadcrumb.jpg&quot;);">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2>문의하기 목록</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->


	<!-- Faq Begin -->
	<section class="classes spad">
		<div class="container">
			<div class="classes__filter">
				<div class="faq spad" style="padding-top: 10px;">
				<h3>🙋‍♀자주 묻는 질문</h3>
				<br>
					<button class="accordion">
					<span style="font-size: 1.1em; font-weight: bold;">
					카카오로그인을 하고 싶은데 카카오톡 계정이 없어도 되나요?
					</span>
					</button>
					<div class="panel" >
					  <p style="padding-top: 15px;">
					  저희는 카카오톡 로그인이 가능합니다.<br>
					  카카오톡 로그인을 위해서는 반드시 카카오톡 계정이 필요합니다. <br>
					  카카오톡 계정이 없으면  카카오로그인을 할 수 없습니다.<br>
					  다소 번거로우시더라도 카카오톡 계정 생성 후 편리한 카카오 로그인 기능을 이용해 주시기 바랍니다.<br>
					  </p>
					</div>
					
					<button class="accordion">
					<span style="font-size: 1.1em; font-weight: bold;">
					개인정보 유출이 문제가 되는 요즘, 저의 개인정보가 유출될까봐 걱정이 됩니다.
					</span>
					</button>
					<div class="panel" >
					  <p style="padding-top: 15px;">
					  요즘 정보화 시대인 만큼 개인정보 보안이 중요한데요, 개인정보 유출 부분은 걱정하지 않으셔도 됩니다.<br>
					  저희 홈페이지 같은 경우에는 일단 회원 수가 많지 않습니다. <br>
					  그리고 우리밖에 홈페이지 이용을 안합니다. 관리자 밖에 이 홈페이지를 이용하는 사람이 없습니다.<br>
					  최대한 빨리 홈페이지를 만들고 완성하고 싶습니다. 그러한 부분은 걱정하지 않으셔도 됩니다. 수고하세요.<br>
					  </p>
					</div>
					
					<button class="accordion">
					<span style="font-size: 1.1em; font-weight: bold;">
					저는 세븐틴 팬인데요 버논 악개인데 어쩌죠?
					</span>
					</button>
					<div class="panel" >
					  <p style="padding-top: 15px;">
					  짝짝짝짝 저기저기 이리 오지 우리끼리 신이 나지 이노래 끝까지 쳐 박수 우 짝짝짝짝<br>
					  이럴때가 있잖아 내가 작아지는 기분 말야 하라는데로 했는데,,,,, 왜 나한테만 이러나 싶고!! 이리이리 이리 모여봐~~<br>
					  지금부터 손에 불 날때까지 박수~ 이때다 싶으면 쳐 박수 ㅋ 이노래 끝까지 쳐 박수<br>
					  </p>
					</div>
					
					<button class="accordion">
					<span style="font-size: 1.1em; font-weight: bold;">
					카카오로그인을 하고 싶은데 카카오톡 계정이 없어도 되나요?
					</span>
					</button>
					<div class="panel" >
					  <p style="padding-top: 15px;">
					  저희는 카카오톡 로그인이 가능합니다.<br>
					  카카오톡 로그인을 위해서는 반드시 카카오톡 계정이 필요합니다. <br>
					  카카오톡 계정이 없으면  카카오로그인을 할 수 없습니다.<br>
					  다소 번거로우시더라도 카카오톡 계정 생성 후 편리한 카카오 로그인 기능을 이용해 주시기 바랍니다.<br>
					  </p>
					</div>
					
					<button class="accordion">
					<span style="font-size: 1.1em; font-weight: bold;">
					개인정보 유출이 문제가 되는 요즘, 저의 개인정보가 유출될까봐 걱정이 됩니다.
					</span>
					</button>
					<div class="panel" >
					  <p style="padding-top: 15px;">
					  요즘 정보화 시대인 만큼 개인정보 보안이 중요한데요, 개인정보 유출 부분은 걱정하지 않으셔도 됩니다.<br>
					  저희 홈페이지 같은 경우에는 일단 회원 수가 많지 않습니다. <br>
					  그리고 우리밖에 홈페이지 이용을 안합니다. 관리자 밖에 이 홈페이지를 이용하는 사람이 없습니다.<br>
					  최대한 빨리 홈페이지를 만들고 완성하고 싶습니다. 그러한 부분은 걱정하지 않으셔도 됩니다. 수고하세요.<br>
					  </p>
					</div>
				</div>

				<!-- Faq End -->

				<!-- Classes Section Begin -->
				<div class="container">
					<h3>🙋‍♂문의하기</h3>
					<br>
					<table class="table" style="text-align: center;">
						<thead>
							<tr style="background: #6d7ab0; color: white; font-size: 1.1em;">
								<th>번호</th>
								<th style="width: 50%">제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>진행상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${qnaList}" varStatus="status">
							<tr>
								<td>${result.rn}</td>
								<td><a id="detail_a" href="qnaDetail.do?communitySeq=${result.communitySeq}">${result.commonTitle}</a></td>
								<td>${result.inUserId}</td>
								<td>${result.inDate}</td>
								<td>
								<c:if test="${result.cnt eq '0'}">
								<span id="payResult" style="background-color: #D16666;color: white;font-weight: bold;padding: 7px;">답변준비중</span>
								</c:if>
								<c:if test="${result.cnt != '0'}">
								<span id="payResult" style="background-color: #6ABD66;color: white;font-weight: bold;padding: 7px;">&nbsp;&nbsp;답변완료&nbsp;&nbsp;</span>
								</c:if>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- 페이징처리 -->
				<div class="col-lg-12">
					<div class="classes__pagination">
						<c:if test="${pageMaker.prev}">
							<a href="boardList.do${pageMaker.makeQuery(pageMaker.startPage - 1)}">
								<span class="arrow_carrot-left"></span>
							</a>
						</c:if>

						<c:set var="page" value="${pageMaker.cri.page}" />
						<c:set var="idx" value="${idx}" />
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
							<a href="qnaList.do${pageMaker.makeQuery(idx)}" <c:if test="${page == idx }">style="background: #5768AD;color:#FFFFFF;"</c:if>>${idx}</a>
						</c:forEach>

						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<a href="qnaList.do${pageMaker.makeQuery(pageMaker.endPage + 1)}">
								<span class="arrow_carrot-right"></span>
							</a>
						</c:if>
					</div>
				</div>
				<c:if test="${memberGubun != 'A'}">
				<div class="classes__item__text" style="text-align: right;padding-top: 0;">
	                 <a href="qnaAdd.do" class="class-btn_w" style="font-size: 1.1em">문의 작성하기</a>
	   		 	</div>
	   		 	</c:if>


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