<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--     Page Preloder
    <div id="preloder">
        <div class="loader"></div>
    </div> -->

    <!-- Offcanvas Menu Begin -->
    <div class="offcanvas-menu-overlay"></div>
    <div class="offcanvas-menu">
        <div class="offcanvas__logo">
        </div>
        <div id="mobile-menu-wrap"></div>
        <div class="offcanvas__widget dropdown">
			<p><a style="color:gray">송하나님</a></p>                
			<p><a style="color:gray" href="myinfo">마이페이지</a></p>                
			<p><a style="color:gray">로그아웃</a></p>                
        </div>
        <nav class="header__menu">
            <ul class="mobile-menu">
                <li class="active"><a href="home">Home</a></li>
				<li><a href="aiTeachList">AI교정</a></li>                
                <li><a href="#">식단관리</a>
                    <ul class="dropdown">
                        <li><a href="chatList">1:1 상담</a></li>
                        <li><a href="">칼로리 계산기</a></li>
                    </ul>
                </li> 
                <li><a href="lessonList">온라인클래스</a></li>
                <li><a href="#">커뮤니티</a>
                    <ul class="dropdown">
                        <li><a href="recipeList">레시피</a></li>
                        <li><a href="boardList">자유게시판</a></li>
                    </ul>
                </li> 
                <li><a href="noticeList">공지사항</a></li>
                <li><a href="qnaList">문의하기</a></li>
            </ul>
        </nav>
        <div class="offcanvas__social">
            <a href="#"><i class="fa fa-facebook"></i></a>
            <a href="#"><i class="fa fa-twitter"></i></a>
            <a href="#"><i class="fa fa-instagram"></i></a>
            <a href="#"><i class="fa fa-linkedin"></i></a>
        </div>
    </div>
    <!-- Offcanvas Menu End -->

    <!-- Header Section Begin -->
    <header class="header">
        <div class="header__top">
            <div class="container">
                <div class="row">
<!--                     <div class="col-lg-3 col-md-3"> -->
<!--                         <div class="header__logo"> -->
<!--                             <a href="home"><img src="./resources/img/logo.png" alt=""></a> -->
<!--                         </div> -->
<!--                     </div> -->
                    
                </div>
                <div class="canvas__open">
                    <i class="fa fa-bars"></i>
                </div>
            </div>
<!--             id="header_info"  -->

            <div style="width: 100%; ">
            		<div class="header__logo header_info" style="display: inline-block;padding-left: 15%;">
                            <a href="home.do"><img src="./resources/img/logo.png" alt=""></a>
                    </div>
                    <div class="header_info" style="vertical-align: bottom;text-align: right;float: right;height: 100%;padding-top: 70px;padding-right: 50px;">
                    <c:set var="memberId" value="${sessionScope.memberId}"/>
                    <c:set var="memberGubun" value="${sessionScope.memberGubun}"/>
                    <c:if test="${memberId == null }">
                    	<a href="login.do" style="color: gray;font-size: 0.9em;padding-left: 10px;">로그인</a>
                    	<a href="join.do" style="color: gray;font-size: 0.9em;padding-left: 10px;">회원가입</a>
                    </c:if>
                    <c:if test="${memberId != null }">
                    	<c:if test="${memberGubun == 'U' }">
                    	<img src="./resources/img/header/user.png" width="16px" height="19px" style="padding-bottom: 3px;">
	                    <a style="color: gray;font-size: 0.9em;padding-left: 0px; padding-right: 10px;">${sessionScope.memberNickname }님 (회원)</a>&nbsp;
	                    
	                    <img src="./resources/img/header/lock.png" width="16px" height="19px" style="padding-bottom: 3px;">
	                    <a href="myinfo.do" style="color: gray;font-size: 0.9em;padding-left: 0px;">마이페이지</a>
	                    </c:if>
                    	
	                    <c:if test="${memberGubun == 'T' }">	
                    	<img src="./resources/img/header/check-mark.png" width="16px" height="18px" style="padding-bottom: 3px;">
	                    <a href="myClassInfo.do" style="color: gray;font-size: 0.9em;padding-left: 0px; padding-right: 10px;">${sessionScope.memberNickname }님 (트레이너)</a>&nbsp;
	                    
	                    <img src="./resources/img/header/lock.png" width="16px" height="19px" style="padding-bottom: 3px;">
	                    <a href="myinfo.do" style="color: gray;font-size: 0.9em;padding-left: 0px;">마이페이지</a>
	                    </c:if>
	                    
	                    <c:if test="${memberId == '1' }">	
                    	<img src="./resources/img/header/user.png" width="16px" height="19px" style="padding-bottom: 3px;">
	                    <a style="color: gray;font-size: 0.9em;padding-left: 0px; padding-right: 5px;">관리자님</a>
	                    </c:if>
	                    
                    	<a href="logout.do" style="color: gray;font-size: 0.9em;padding-left: 10px;cursor: pointer;">로그아웃</a>
                    </c:if>
                    
                    </div>
      	    </div>
        </div>
        
        
        
        <div class="header__nav">
            <div class="container" style="text-align: center;">
                <div class="row" style="flex-wrap: nowrap;display: inline-block;">
        
                    <div class="col-lg-9 col-md-9" style="max-width: 100%;margin: 0;">
                        <nav class="header__menu" >
                        	
                        	<!-- 일반탭 -->
                        	<c:if test="${memberGubun == 'T'||memberGubun == 'U'|| memberId == null}">
                            <ul>
                                <li class="active"><a href="home">Home</a></li>
                                <li><a href="aiTeachList.do">AI교정</a></li>
								<li><a href="#">식단관리</a>
                                    <ul class="dropdown">
                                        <li><a href="chatList.do">1:1 상담</a></li>
                                        <li><a href="kcalList.do">칼로리 계산기</a></li>
                                    </ul>
                                </li>
                                <li><a href="lessonList.do">온라인클래스</a></li>
                                <li><a href="#">커뮤니티</a>
                                    <ul class="dropdown">
                                        <li><a href="recipeList.do">레시피</a></li>
                                        <li><a href="boardList.do">자유게시판</a></li>
                                    </ul>
                                </li>
                                <li><a href="noticeList.do">공지사항</a></li>
                                <li><a href="qnaList.do">문의하기</a></li>
                            </ul>
                           </c:if> 
                           
                           <!-- 관리자탭 -->
                           <c:if test="${memberId == '1' }">
                            <ul>
                                <li><a href="home.do">HOME</a></li>
                                
                                <li><a href="#">회원관리</a>
                                    <ul class="dropdown">
                                        <li><a href="trainerPermitList.do">트레이너 승인</a></li>
                                        <li><a href="adminMemberList.do">회원조회</a></li>
                                    </ul>
                                </li>
                                
                                <li><a href="#">강좌관리</a>
                                    <ul class="dropdown">
                                        <li><a href="adminLessonList.do">강좌리스트</a></li>
                                        <li><a href="adminLessonPayList.do">결제/환불내역</a></li>
                                        <li><a href="adminLessonStat.do">강좌통계</a></li>
                                    </ul>
                                </li>
                                
                                <li><a href="#">채팅관리</a>
                                    <ul class="dropdown">
                                        <li><a href="adminTicketPayList.do">이용권 구매내역</a></li>
                                        <li><a href="adminChatList.do">결제/환불내역</a></li>
                                        <li><a href="adminChatStat.do">채팅통계</a></li>
                                    </ul>
                                </li>
                                
                                <li><a href="#">매출관리</a>
                                    <ul class="dropdown">
                                        <li><a href="adminSalesList.do">정산하기</a></li>
                                        <li><a href="aiTeachList.do">매출통계</a></li>
                                    </ul>
                                </li>
                                
                                <li><a href="noticeList.do">공지사항</a></li>
                                
                                <li><a href="qnaList.do">문의하기</a></li>
                                
                            </ul>
                           </c:if> 
                           
                           
                            
                            
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- Header Section End -->
    