<!DOCTYPE html>
<html lang="zxx">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<body>


    <!-- Breadcrumb Begin -->
    <section class="breadcrumb-option set-bg" data-setbg="./resources/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h2>이용권 구매</h2>
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
                    <div class="section-title normal-title">
                        <h2>이용권 가격</h2>
                        <p>다이어트의 중요한 요소중의 하나인 식단입니다.<br />전문가와 심도있는 상담을 통하여 당신의 다이어트를 성공시키세요.</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 p-0 col-md-6">
                    <div class="pricing__item set-bg" data-setbg="./resources/img/pricing/price-bg-1.png">
                        <h4>1회권</h4>
                        <div class="pricing__item__price">
                            <h2>4,000원</h2>
                            <span>/1회</span>
                        </div>
                        <ul>
                            <li>1:1 상담을 처음으로 체험하고 싶으신 분</li>
                            <li>나의 식단이 맞는 지 확인하고 싶으신 분</li>
                            <li>부담없는 가격</li>
                        </ul>
                        <a href="buyTicketDetail.do?ticketCategorySeq=1" class="primary-btn" style="font-size: 1.1em;">구매하기</a>
                    </div>
                </div>
                <div class="col-lg-4 p-0 col-md-6">
                    <div class="pricing__item active set-bg" data-setbg="./resources/img/pricing/price-bg-2.png">
                        <div class="pricing__item__star">
                            <i class="fa fa-star"></i>
                        </div>
                        <h4>3회권</h4>
                        <div class="pricing__item__price">
                            <h2>1,100원</h2>
                            <span>/3회</span>
                        </div>
                        <ul>
                            <li>단기간에 점진적인 상담을 원하시는 분</li>
                            <li>1회권이 부족하다고 생각하시는 분</li>
                            <li>원가보다 1000원 할인된 가격</li>
                        </ul>
                        <a href="buyTicketDetail.do?ticketCategorySeq=2" class="primary-btn" style="font-size: 1.1em;">구매하기</a>
                    </div>
                </div>
                <div class="col-lg-4 p-0 col-md-6">
                    <div class="pricing__item set-bg" data-setbg="./resources/img/pricing/price-bg-3.png">
                        <h4>5회권</h4>
                        <div class="pricing__item__price">
                            <h2>17,500원</h2>
                            <span>/5회</span>
                        </div>
                        <ul>
                            <li>기간을 두고 순차적인 상담을 원하시는 분</li>
                            <li>다양한 트레이너의 상담을 원하시는 분</li>
                            <li>원가보다 2500원 할인된 가격</li>
                            
                        </ul>
                        <a href="buyTicketDetail.do?ticketCategorySeq=3" class="primary-btn" style="font-size: 1.1em;">구매하기</a>
                    </div>
                </div>
	                <div class="classes__item__text"  style="text-align: center;padding-top: 0px;margin-left: auto;margin-right: auto;">
				         <a href="chatList.do" class="class-btn_w" style="font-size: 1.1em;">&nbsp;&nbsp;뒤로가기&nbsp;&nbsp;</a>
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