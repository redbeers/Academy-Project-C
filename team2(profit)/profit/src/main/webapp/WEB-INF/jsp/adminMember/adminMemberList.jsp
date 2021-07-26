<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./resources/datepicker/jquery-ui.css">
<script src="./resources/datepicker/jquery-3.5.1.js"></script>
<script src="./resources/datepicker/jquery-ui.js"></script>
<style type="text/css">
.class-btn {
	width: 50px;
	padding: 0;
	height: 30px;
	background-color: #ffc107c2;
	font-size: 14px;
	font-weight: 700;
	color: #ffffff;
	display: inline-block;
	border: 1px solid rgba(155, 158, 163, 0.2);
	border-radius: 2px;
	-webkit-transition: all 0.4s;
	-moz-transition: all 0.4s;
	-ms-transition: all 0.4s;
	-o-transition: all 0.4s;
	transition: all 0.4s;
}

.class-btn:hover {
	background: #ffffff;
	border: 1px solid #ffc107c2;
	color: #ffc107c2;
}

-ms-overflow-style
:
 
none
;
 
}
::-webkit-scrollbar {
	display: none;
}

.box {
	-ms-overflow-style: none;
}

.box::-webkit-scrollbar {
	display: none;
}

.kcalList tr td {
	padding-top: 10px;
	padding-bottom: 10px;
	border-bottom: 1px solid #6c7ae05c;
}

.kcalList tr:hover {
	background-color: #f8f6ff;
}

.kcal_span{
font-weight: bold;
}
.kcal_img{
width: 15px; 
height: 15px;
}


</style>


<script type="text/javascript">
//블랙리스트 추가
function fn_add(){
	var memberId = $("input:checkbox[name=checkbox]:checked").val();
	var blacklistFlag = $("input:checkbox[name=checkbox]:checked").attr('class');
	var blacklistReason = "";
	
	if(blacklistFlag == '정상회원'){
		if(confirm("현재 회원을 블랙리스트에 등록하시겠습니까?") == true){
			blacklistReason = prompt('블랙리스트 등록사유를 입력해주세요');
		}else{
			return;
		}
	}else{
		alert("이미 블랙리스트로 등록된 회원입니다.");
		 return;
	}
	
	$.ajax({
		type : "get",
		data : {memberId:memberId, blacklistReason:blacklistReason},
		url : "addBlacklistAjax.do",
		success : function(result) {
			if (result == "ok") {
				alert("블랙리스트에 정상적으로 등록되었습니다.")
				location.reload();
			} else {
				alert("등록도중 문제가 발생했습니다. 잠시 후 다시 시도해주세요.")
			}
		},
		error : function() {
			alert("오류발생");
		}
	});
	
}

//블랙리스트 제거
function fn_remove(){
	var memberId = $("input:checkbox[name=checkbox]:checked").val();
	var blacklistFlag = $("input:checkbox[name=checkbox]:checked").attr('class');
	
	if(blacklistFlag == '블랙리스트'){
		if(confirm("현재 회원을 블랙리스트에서 해제하시겠습니까?") == true){
			console.log("블랙리스트 해제")
		}else{
			return;
		}
	}else{
		alert("블랙리스트 회원이 아닙니다.");
		 return;
	}
	
	$.ajax({
		type : "get",
		data : {memberId:memberId},
		url : "removeBlacklistAjax.do",
		success : function(result) {
			if (result == "ok") {
				alert("블랙리스트에서 정상적으로 해제되었습니다.")
				location.reload();
			} else {
				alert("해제도중 문제가 발생했습니다. 잠시 후 다시 시도해주세요.")
			}
		},
		error : function() {
			alert("오류발생");
		}
	});
	
}

//checkbox 하나만 선택
function doOpenCheck(chk){
    var obj = document.getElementsByName("checkbox");
    for(var i=0; i<obj.length; i++){
        if(obj[i] != chk){
            obj[i].checked = false;
        }
    }
}

//모달 오픈
function fn_modalOpen(memberId){
	$.ajax({
		type : "get",
		url : "adminMemberDetailAjax.do",
		data : {memberId:memberId}, 
		async : false,
		dataType : "JSON", 
		contentType : "application/json; charset:UTF-8",
		//전송 후 세팅
		success : function(data, textStatus) {
			var inDate = data.vo.inDate.substring(0,4)+"-"+data.vo.inDate.substring(5,7)+"-"+data.vo.inDate.substring(8,10);
			var bDate = data.vo.bDate.substring(0,4)+"-"+data.vo.bDate.substring(5,7)+"-"+data.vo.bDate.substring(8,10);
 			if(data.msg == "ok"){
				$("#memberId").text(data.vo.memberId);
				$("#memberName").text(data.vo.memberName);
				$("#memberNickname").text(data.vo.memberNickname);
				$("#memberMobile").text(data.vo.memberMobile);
				$("#memberGender").text(data.vo.memberGender);
				$("#memberEmail").text(data.vo.memberEmail);
				$("#memberGubun").text(data.vo.memberGubun);
				$("#memberRoute").text(data.vo.memberRoute);
				$("#inDate").text(inDate);
				$("#blacklistFlag").text(data.vo.blacklistFlag);
				console.log(data.vo.blacklistReason)
				if(data.vo.blacklistReason != ""){
					var txt = "";
					txt += "<th style='font-weight: bold;padding:20px;background-color: #f5f6fa'>블랙리스트 사유</th>";
					txt += "<td style='padding-right: 20px;'><span id='blacklistReason' style='margin-left: 20px;'>"+data.vo.blacklistReason+"</span></td>";
					$("#firstTr").html(txt);
					
					var txt2 = "";
					txt2 += "<th style='font-weight: bold;padding:10px;background-color: #f5f6fa'>블랙리스트 등록일</th>";
					txt2 += "<td><span id='bDate'>"+bDate+"</span></td>";
					$("#secondTr").html(txt2);
				}
			}else{
				alert("정보를 찾을 수 없습니다.")
			} 
		},
		error : function() {
			alert("오류발생");
		}

	});
	
	$("#myModal").modal('show');
	
}


function fn_close(){
	$("#firstTr").html("");
	$("#secondTr").html("");
	
	$("#myModal").modal('hide');
}

</script>
</head>
<style>
.classes__filter form .class__filter__btn_re {
	padding-right: 125px;
}

.table tr:hover {
	background-color: #f8f6ff;
}

</style>
<body>

	<!-- Breadcrumb Begin -->
	<section class="breadcrumb-option set-bg"
		data-setbg="./resources/img/hero/hero-11.jpg" style="padding-bottom: 0px; padding-top: 70px;">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<!-- <h2>트레이너 승인</h2> -->

					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb End -->
				
	<section class="classes spad">
		<div class="container">
			<h3 style="text-align: center; cursor: pointer;" onclick="location.href='adminMemberList.do'">회원조회</h3>
			<br>
			    <div class="classes__filter" style="margin-bottom: 0px;">
				<br>
                <div class="row">
                    <div class="col-lg-12">
                        <form action="adminMemberList.do" method="get">
                            <div class="class__filter__select" style="width: 150px;">
                                <p>회원구분</p>
                                <select name="selGubun">
                                    <option value="" <c:if test="${pageMaker.cri.selGubun eq '전체'}">selected</c:if>>전체</option>
                                    <option value="U" <c:if test="${pageMaker.cri.selGubun eq 'U'}">selected</c:if>>일반회원</option>
                                    <option value="T" <c:if test="${pageMaker.cri.selGubun eq 'T'}">selected</c:if>>트레이너</option>
                                </select>
                            </div>
                            <div class="class__filter__select" style="width: 150px;">
                                <p>회원상태</p>
                                <select name="selStatus">
                                    <option value="" <c:if test="${pageMaker.cri.selStatus eq '전체'}">selected</c:if>>전체</option>
                                    <option value="N" <c:if test="${pageMaker.cri.selStatus eq 'N'}">selected</c:if>>정상회원</option>
                                    <option value="B" <c:if test="${pageMaker.cri.selStatus eq 'B'}">selected</c:if>>블랙리스트</option>
                                </select>
                                
                            </div>
							<div class="class__filter__select" style="width: 150px;">
                                <p>검색조건</p>
                                <select name="selIdentity">
                                    <option value="" <c:if test="${pageMaker.cri.selIdentity eq '전체'}">selected</c:if>>전체</option>
                                    <option value="이름" <c:if test="${pageMaker.cri.selIdentity eq '이름'}">selected</c:if> >이름</option>
                                    <option value="아이디" <c:if test="${pageMaker.cri.selIdentity eq '아이디'}">selected</c:if>>아이디</option>
                                </select>
                            </div>
							<div id="searchDiv" class="class__filter__input"  style="margin-right: 20px;width: 350px;">
								<p>검색어</p>
								<input type="text" name="searchKeyword" placeholder="검색" style="width: 100%;" value="${pageMaker.cri.searchKeyword}">
								<div class="class__filter__btn">
                                <button><i class="fa fa-search"></i></button>
                            </div>
							</div>
                        </form>
                    </div>
                </div>
            </div>
			<div class="classes__filter" style="padding-top: 20px;">
			
			
			<input onclick="fn_remove()" class="site-btn" type="button" value="블랙리스트 해제" style="font-size:1.1em;height: 40px; padding : 8px 30px; background-color: #6ABD66;opacity: 85%;float: right;"/>
			<input onclick="fn_add()" class="site-btn" type="button" value="블랙리스트 등록" style="font-size:1.1em;height: 40px; padding : 8px 30px; background-color: #D16666;opacity: 88%;float: right; margin-right: 15px;"/>
			
			<br><br>
			<table class="table" style="text-align: center;">
				<thead>
					<tr style="background: #6d7ab0; color: white;font-size: 1.1em;"><!-- 8개 -->
						<th scope="col"></th>
						<th scope="col">번호</th>
						<th scope="col">아이디</th>
						<th scope="col">이름</th>
						<th scope="col">성별</th>
						<th scope="col">회원구분</th>
						<th scope="col">가입일</th>
						<th scope="col">회원상태</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty memberList}">
						<tr>
							<td colspan="8" style="text-align: center;">회원내역이 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty memberList}">
					<c:forEach var="list" items="${memberList}" varStatus="status">
					<tr onclick="fn_modalOpen('${list.memberId }')">
						<td onclick="event.cancelBubble=true"><input type="checkbox" name="checkbox" onclick="doOpenCheck(this);" value="${list.memberId }" class="${list.blacklistFlag }"/></td>
						<td>${ (pageMaker.cri.page-1)*10 + (status.count)}</td>
						<td>${list.memberId }</td>
						<td>${list.memberName }</td>
						<td>${list.memberGender }</td>
						<c:if test="${list.memberGubun eq 'U' }">
						<td>일반회원</td>
						</c:if>
						<c:if test="${list.memberGubun eq 'T' }">
						<td>트레이너</td>
						</c:if>
						<td>${fn:substring(list.inDate,0,10) }</td>
						<td>${list.blacklistFlag }</td>
					</tr>
					
					</c:forEach>
					</c:if>
				</tbody>
			</table>
			
			
			<!-- 모달시작 -->
			<div class="modal" id="myModal" tabindex="-1" role="dialog">
			    <div class="modal-dialog" role="document" style="margin-left: 550px; margin-right: auto;">
			        <div class="modal-content" style="width : 800px;">
			            <div class="modal-header">
			                <h3 class="modal-title">📌회원 정보 상세보기</h3>
			                <button type="button" class="close" aria-label="Close" onclick="fn_close()">
			                    <span aria-hidden="true">&times;</span>
			                </button>
			            </div>
			            <div class="modal-body">
			            	<!-- 테이블 시작 -->
			                <table style="border: 1px solid #d5d6d6;width: 600px;text-align: center;margin-left: auto;margin-right: auto;">
			                	<tr style="border: 1px solid #d5d6d6;">
				                	<th style="width: 30%;font-weight: bold;padding:10px;background-color: #f5f6fa">이름</th>
			                		<td style="width: 60%;"><span id="memberName"></span></td>
			                	</tr>
			                	<tr style="border: 1px solid #d5d6d6;">
				                	<th style="font-weight: bold;padding:10px;background-color: #f5f6fa">아이디</th>
			                		<td><span id="memberId"></span></td>
			                	</tr>
			                	<tr style="border: 1px solid #d5d6d6;">
				                	<th style="font-weight: bold;padding:10px;background-color: #f5f6fa">닉네임</th>
			                		<td><span id="memberNickname"></span></td>
			                	</tr>
			                	<tr style="border: 1px solid #d5d6d6;">
				                	<th style="font-weight: bold;padding:10px;background-color: #f5f6fa">회원구분</th>
			                		<td><span id="memberGubun"></span></td>
			                	</tr>
			                	<tr style="border: 1px solid #d5d6d6;">
				                	<th style="font-weight: bold;padding:10px;background-color: #f5f6fa">핸드폰번호</th>
			                		<td><span id="memberMobile"></span></td>
			                	</tr>
			                	<tr style="border: 1px solid #d5d6d6;">
				                	<th style="font-weight: bold;padding:10px;background-color: #f5f6fa">이메일</th>
			                		<td><span id="memberEmail"></span></td>
			                	</tr>
			                	<tr style="border: 1px solid #d5d6d6;">
				                	<th style="font-weight: bold;padding:10px;background-color: #f5f6fa">성별</th>
			                		<td><span id="memberGender"></span></td>
			                	</tr>
			                	<tr style="border: 1px solid #d5d6d6;">
				                	<th style="font-weight: bold;padding:10px;background-color: #f5f6fa">가입경로</th>
			                		<td><span id="memberRoute"></span></td>
			                	</tr>
			                	<tr style="border: 1px solid #d5d6d6;">
				                	<th style="font-weight: bold;padding:10px;background-color: #f5f6fa">가입일</th>
			                		<td><span id="inDate"></span></td>
			                	</tr>
			                	<tr style="border: 1px solid #d5d6d6;">
				                	<th style="font-weight: bold;padding:10px;background-color: #f5f6fa">회원상태</th>
			                		<td><span id="blacklistFlag"></span></td>
			                	</tr>
			                	
			                	
			                	<tr style="border: 1px solid #d5d6d6;" id="firstTr">

			                	</tr>
			                	<tr style="border: 1px solid #d5d6d6;" id="secondTr">

			                	</tr>
			                </table>
			                <!-- 테이블 끝 -->
			        	</div>
			            <div class="modal-footer">
			                <button type="button" class="btn btn-secondary" onclick="fn_close()">Close</button>
			            </div>
			        </div>
			    </div>
			</div>
			<!-- 모달 끝 -->
			
			
			<!-- 페이징처리 -->
            	<div class="col-lg-12">
					<div class="classes__pagination">
					<c:if test="${pageMaker.prev}">
						<a href="adminMemberList.do${pageMaker.makeQueryAdminMember(pageMaker.startPage - 1)}">
							<span class="arrow_carrot-left"></span>
						</a>
					</c:if> 
					
					<c:set var="page" value="${pageMaker.cri.page}"/>
					<c:set var="idx" value="${idx}"/>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
            			<a href="adminMemberList.do${pageMaker.makeQueryAdminMember(idx)}" <c:if test="${page == idx }">style="background: #5768AD;color:#FFFFFF;"</c:if>>${idx}</a>
					</c:forEach>
					
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<a href="adminMemberList.do${pageMaker.makeQueryAdminMember(pageMaker.endPage + 1)}"><span class="arrow_carrot-right"></span></a>
					</c:if>
					</div>
				</div>
			
			</div>
		</div>
	</section>
				

	<!-- Js Plugins -->
				
	<script src="./resources/js/bootstrap.min.js"></script>
	<script src="./resources/js/jquery.nice-select.min.js"></script>
	<script src="./resources/js/jquery.barfiller.js"></script>
	<script src="./resources/js/jquery.slicknav.js"></script>
	<script src="./resources/js/owl.carousel.min.js"></script>
	<script src="./resources/js/main.js"></script>
</body>
</html>