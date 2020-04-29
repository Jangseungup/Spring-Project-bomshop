<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="common/seller_header.jsp" %>

<style>
	#salesStatus{
		float : left;
		width : 80%;
	}
	
	#salesStatus table{
		margin: 50px;
		border-collapse:collapse;
		width : 800px;
	}
	
	#salesStatus table thead{
		background-color: #cccccc;
	}
	
	#salesStatus table thead tr{
		border-top: 1px solid gray;
		border-bottom: 1px solid gray;
	}
	
	#salesStatus table thead tr th{
		padding : 5px 10px 5px 10px;
	}
	
	#salesStatus table tbody tr th{
		border-bottom: 1px solid gray;
		padding : 5px 10px 5px 10px;
	}
	
	#salesStatus table tbody tr td{
		border-bottom: 1px solid gray;
		padding : 5px 10px 5px 10px;
	}
		
	#salesStatus a{
		color : red;
	}

	table#goodsInfo{
		width:500px;
	}
</style>

<div id="salesStatus">
	<table id="todayOrderInfo">
		<thead>
			<tr>
				<th rowspan=2>${today}</th>
				<th>미확인 주문 상품</th>
				<th>오늘 주문된 상품</th>
			</tr>
			<tr>
				<th><a href="order_manage?searchType=unconfirmed">${unconfirmedOrderCount}</a> 건</th>
				<th><a href="order_manage?searchType=today">${todayOrderCount}</a> 건</th>
			</tr>
		</thead>
	</table>
	
	<table id="totalOrderInfo">
		<thead>
			<tr>
				<th colspan="8">판매 현황</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th colspan="2">주문</th>
				<th colspan="2">클레임</th>
				<th colspan="2">고객문의</th>				
			</tr>
			<tr>
				<td>신규주문</td>
				<td><a href="order_manage?searchType=unconfirmed">${unconfirmedOrderCount}</a> 건</td>
				<td>반품요청</td>
				<td><a href="claim_manage?searchType=refund">${requestRefundCount}</a> 건</td>
				<td>질문미답변</td>
				<td><a href="customer_manage?searchType=question">${newQuestionCount}</a> 건</td>
			</tr>
			<tr>
				<td>발송예정</td>
				<td><a href="order_manage?searchType=awaiting">${awaitingDeliveryCount}</a> 건</td>
				<td>교환요청</td>
				<td><a href="claim_manage?searchType=exchange">${requestExchangeCount}</a> 건</td>
				<td>신규리뷰</td>
				<td><a href="customer_manage?searchType=review">${latestReviewsCount}</a> 건</td>
			</tr>
			<tr>
				<td>배송중</td>
				<td><a href="order_manage?searchType=shipping">${shippingCount}</a> 건</td>
				<td>취소요청</td>
				<td><a href="claim_manage?searchType=cancel">${requestCancelCount}</a> 건</td>
				<td></td>
				<td></td>
			</tr>
		</tbody>
		
	</table>
	
	<table id="goodsInfo">
		<thead>
			<tr>
				<th colspan="4">나의 상품 정보</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>재고 10개 이하</td>
				<td><a href="goods_manage?searchType=soldOut">${soldOutCount}</a> 건</td>
				<td>광고 등록대기</td>
				<td><a href="advertising_request?searchType=awaiting">${awaitingAdvertisingCount}</a> 건</td>
			</tr>
			<tr>
				<td>7일 이내 판매 중지</td>
				<td><a href="goods_manage?searchType=goodsExpiration">${goodsExpirationCount}</a> 건</td>
				<td>광고 마감 3일 전</td>
				<td><a href="advertising_request?searchType=advertisingEnd">${advertisingEndCount}</a> 건</td>
			</tr>
		</tbody>
	</table>
</div>
</div>

</body>
</html>