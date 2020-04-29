<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.mypage_menu{
		display : inline-block;
		width:19%;
		border-left: 1px solid gray;
	}
	.mypage_menu:first-child{
		border-left : none;
	}
	
	.mypage_menu:nth-child(8){
		border-left : none;
	}
	
	.mypage_menu:hover {
		cursor: pointer;
	}
	
	.mypage_menu:hover span{
		font-weight: bold;
	}
	
	#mypage_section{
		text-align: center;
		margin-top : 50px;
		margin-bottom : 100px;
	}
	#mypage_text1{
		font-size : 30px;	
	}
	
	#mypage_text2{
		font-size : 15px;
	}
	
	#bodyContents{
		margin-top : 40px;
		text-align : center;
	}
</style>
</head>
<body>
	<%@include file="../common/header.jsp" %>
	<section id="mypage_section">
		<div style="border:1px solid lightgray;width:750px;display: inline-block; padding-top:20px; padding-bottom:20px;">
			<div class="mypage_menu" onclick="javascript:acyncMovePage('memberGradePage');">
				<img src="${pageContext.request.contextPath}/resources/img/crown.png" width="50px;" height="50px;"><br/>
				<span>회원등급</span>
			</div>
			
			<div class="mypage_menu" onclick="javascript:acyncMovePage('memberCashPage');">
				<img src="${pageContext.request.contextPath}/resources/img/cash.png" width="50px;" height="50px;"><br/>
				<span>캐쉬</span><span> ></span>
			</div>
			<div class="mypage_menu" onclick="javascript:acyncMovePage('memberPointPage');">
				<img src="${pageContext.request.contextPath}/resources/img/point.png" width="50px;" height="50px;"><br/>
				<span>포인트</span><span> ></span>
			</div>
			<div class="mypage_menu" onclick="javascript:acyncMovePage('memberCouponPage');">
				<img src="${pageContext.request.contextPath}/resources/img/coupon.png" width="50px;" height="50px;"><br/>
				<span>쿠폰</span>&nbsp;<span style="color:red;">${couponCnt}</span><span> ></span>
			</div>
			<div class="mypage_menu" onclick="javascript:acyncMovePage('purchaseListPage');">
				<img src="${pageContext.request.contextPath}/resources/img/question_mark.png" width="50px;" height="50px;"><br/>
				<span>구매내역</span>
			</div><br/><br/>
			<div class="mypage_menu" onclick="javascript:acyncMovePage('orderDeliveryPage');">
				<img src="${pageContext.request.contextPath}/resources/img/express_car3.png" width="60px;" height="65px;"><br/>
				<span>주문/배송조회</span>
			</div>
			<div class="mypage_menu" onclick="javascript:acyncMovePage('interestGoodsPage');">
				<img src="${pageContext.request.contextPath}/resources/img/star.png" width="50px;" height="50px;"><br/>
				<span>관심상품</span>
			</div>
			<div class="mypage_menu" onclick="javascript:acyncMovePage('memberInfoExchangePage');">
				<img src="${pageContext.request.contextPath}/resources/img/exchange.png" width="45px;" height="45px;"><br/>
				<span>개인정보 변경</span>
			</div>
			<div class="mypage_menu" onclick="javascript:acyncMovePage('myQuestionReviewPage');">
				<img src="${pageContext.request.contextPath}/resources/img/speech_bubble.png" width="50px;" height="50px;"><br/>
				<span>나의 문의/리뷰</span>
			</div>
				<div class="mypage_menu" id="exchangeEventDiv" onclick="javascript:acyncMovePage('exchangeSellerPage');">
					<img src="${pageContext.request.contextPath}/resources/img/exchange_seller.png" width="50px;" height="50px;"><br/>
					<span>판매자 전환</span>
				</div>
		</div>
		<br/><br/>
		<div id="bodyContents">
			<div>
				<span id="mypage_text1">MYPAGE 메인화면입니다.</span><br/><br/>
				<span id="mypage_text2">상단의 원하시는 메뉴를 선택해주세요!</span>
			</div>
		</div>
	</section>
	<%@include file="../common/footer.jsp" %>
</body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function(){
	var mtype = '${memberInfo.mtype}';
	if(mtype == 2){
		$("#exchangeEventDiv").attr("onclick","alert('해당 아이디는 이미 판매자로 등록된 아이디입니다.');");
	}
});

function acyncMovePage(url){
    $.ajax({
    	type : "POST",
    	url : url,
    	dataType : "html",
    	cache : false,
    	async : true,
    	success : function(data){
    		 // Contents 영역 삭제
            $('#bodyContents').children().remove();
            // Contents 영역 교체
            $('#bodyContents').html(data);
    	}
    });
}
</script>
</html>