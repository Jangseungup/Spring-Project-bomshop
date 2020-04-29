<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.deliveryTopText{
	font-size : 20px;
	font-weight: bold;
}
.deliveryTopExplain{
	border-top : 2px solid black;
		padding-top : 10px;
		margin-bottom : 50px;
		margin-top : 7px;
}
.deliveryExplainText{
	font-size : 13px;
		color : gray;
}
.deliveryListDiv{
	border-top : 2px solid black;
		margin-top : 7px;
		text-align: center;
		min-height: 300px;
}

.NonMemberOrderListTable{
	width : 760px;
	text-align: center;
}

.NonMemberOrderListTable tr th{
	border-bottom : 1px solid gray;
	height : 30px;
}

/* 테이블 내 버튼 (반품/교환/구매확정 버튼)*/
.tablebtn{
	border : 1px solid lightgray;
	colir : gray;
	font-size : 14px;
	padding : 5px;
	text-align: center;
}

.tablebtn:hover{
	cursor: pointer;
}

.tablebtn:active {
	background-color: lightgray;
}

/* 주문배송모달 */
.modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            text-align: center;
        }
    
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 40%; /* Could be more or less, depending on screen size */                          
        }
        .input_wrap{
        	margin-top : 50px;
        }
        .refundcloseBtn {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .refundcloseBtn:hover,
        .refundcloseBtn:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        
        .exchangecloseBtn {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .exchangecloseBtn:hover,
        .exchangecloseBtn:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
         .cancelcloseBtn {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .cancelcloseBtn:hover,
        .cancelcloseBtn:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        
         .confirmcloseBtn {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .confirmcloseBtn:hover,
        .confirmcloseBtn:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

.submitBtn{
	width : 100px;
	height : 35px;
	font-size : 15px;
	background-color: #343a40;
	border-color: #343a40;
	border-radius: 5px;
	color : white;
}

#refund_reason, #exchange_reason{
	width : 250px;
	height : 40px;
	border-radius: 10px;
	font-size : 15px;
}

.inTableBtn{
	border : 1px solid lightgray;
	colir : gray;
	font-size : 14px;
	padding : 5px;
}
.orderInfoTable{
	width:760px;
	text-align: center;
}
.orderInfoTable  tr td{
	padding-top : 5px;
	padding-bottom:5px;
}
</style>
<%@include file="../common/header.jsp" %>
	<%-- ${orderNonList} --%>
	<div style="text-align: center; margin-top : 80px; min-height: 720px;">
	<div style="display: inline-block;">
	<span class="deliveryTopText">비회원 주문/배송 조회</span><br/>
	<div class="deliveryTopExplain">
		<span class="deliveryExplainText">
			비회원 주문/배송 조회입니다. 구매확정으로 얻을 수 있는 포인트는 회원가입을 통해 로그인 후 구매하시면 적립가능합니다.<br/>
			판매자가 아직 확인하지 않는 상품은 '주문취소'가 가능합니다. (배송준비/배송중인 상품만 해당합니다.)<br/>
		</span>
	</div>
	
	<span class="deliveryTopText">주문/배송 조회</span><br/>
	<div class="deliveryListDiv" id="deliveryListDiv">
		<!-- 주문/배송 리스트  -->
		<c:choose>
			<c:when test="${empty orderNonList}">
				<div style="margin-top:20px;">
					<span>주문/배송 내역이 없습니다.</span>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach var="i" items="${orderNonList}">
					<table class="NonMemberOrderListTable" id="NonMemberOrderListTable">
						<tr>
							<th>주문번호</th>
							<th>이미지</th>
							<th>상품명</th>
							<th>가격</th>
							<th>주문날짜</th>
							<th>상태</th>
							<th>비고</th>		
						</tr>
						<tr>
							
							<td>${i.orderno}</td>
							<td><img src="${pageContext.request.contextPath}/upload/${i.gno}/mainImg.jpg" width="250px"/></td>
							<td><span style="font-weight: bold;font-size:17px;">${i.gname_ko}</span><br/><span style="font-size:0.8em;">(사이즈 :${i.size},<br/>색상 : ${i.color},<br/>수량:${i.count})</span></td>
							<td><f:formatNumber value="${i.price}" pattern="#,###"/>원</td>
							<td><f:formatDate value="${i.orderdate}" pattern="yyyy-MM-dd"/></td>
							<c:choose>
								<c:when test="${i.order_status eq 0}">
									<td>배송준비</td>
									<td>
										<input type="button" id="orderCancleBtn" class="inTableBtn" onclick="javascript:cancelModal('${i.orderno}','${i.order_email}','${i.order_phone}');" value="주문취소"/>
									</td>
								</c:when>
								<c:when test="${i.order_status eq 1}">
									<td>배송중</td>
									<td>
										<input type="button" id="orderCancleBtn"  class="inTableBtn" onclick="javascript:cancelModal('${i.orderno}','${i.order_email}','${i.order_phone}');" value="주문취소"/>
									</td>
								</c:when>
								<c:when test="${i.order_status eq 2}">
									<td>배송완료</td>
									<td>
										<input type="button" id="orderCancleBtn"  class="inTableBtn" onclick="javascript:cancelModal('${i.orderno}','${i.order_email}','${i.order_phone}');" value="주문취소"/><br/>
										<input type="button" id="orderRefundBtn" class="inTableBtn" onclick="javascript:refundModal('${i.orderno}','${i.order_email}','${i.order_phone}');" value="반품신청"/><br/>
										<input type="button" id="orderExchangeBtn" class="inTableBtn" onclick="javascript:exchangeModal('${i.orderno}','${i.order_email}','${i.order_phone}');" value="교환신청"/>
									</td>
								</c:when>
								<c:when test="${i.order_status eq 3}">
									<td>환불요청</td>
									<td></td>
								</c:when>
								<c:when test="${i.order_status eq 4}">
									<td>교환요청</td>
									<td></td>
								</c:when>
								<c:when test="${i.order_status eq 5}">
									<td>거래취소</td>
									<td></td>
								</c:when>
								<c:when test="${i.order_status eq 6}">
									<td>반품처리</td>
									<td></td>
								</c:when>
								<c:when test="${i.order_status eq 7}">
									<td>교환중</td>
									<td></td>
								</c:when>
								
							</c:choose>
						</tr>
					</table>
					<div style="margin-top:30px;">
						<div style="border-bottom : 2px solid black;padding-bottom:10px;">
							<span style="display:block; font-size:20px;font-weight: bold;">주문자 정보</span>
						</div>
						<table class="orderInfoTable">
							<tr>
								<td style="border-right:1px solid lightgray; font-weight: bold; width:186.67px;">주문자</td>
								<td>${i.order_name}</td>
							</tr>
							<tr>
								<td style="border-right:1px solid lightgray; font-weight: bold;">주문자 이메일</td>
								<td>${i.order_email}</td>
							</tr>
							<tr>
								<td style="border-right:1px solid lightgray; font-weight: bold;">주문자 전화번호</td>
								<td>${i.order_phone}</td>
							</tr>
						</table>
					</div>
					
					<div style="margin-top:30px;">
						<div style="border-bottom : 2px solid black;padding-bottom:10px;">
							<span style="display:block; font-size:20px;font-weight: bold;">배송지 정보</span>
						</div>
						<table class="orderInfoTable">
							<tr>
								<td style="border-right:1px solid lightgray; font-weight: bold;">수령인</td>
								<td>${i.delivery_name}</td>
							</tr>
							<tr>
								<td style="border-right:1px solid lightgray; font-weight: bold;">수령지</td>
								<td>(${i.delivery_post_code})${i.delivery_addr1}&nbsp;${i.delivery_addr2}</td>
							</tr>
							<tr>
								<td style="border-right:1px solid lightgray; font-weight: bold;">수령인 전화번호</td>
								<td>${i.delivery_phone}</td>
							</tr>
						</table>
					</div>
				</c:forEach>
				<div>
					<c:forEach var="i" items="${orderNonList}">
						<!-- 주문자정보, 배송자 정보 -->
					</c:forEach>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	</div>
	</div>
	
	<!-- 반품신청 모달 -->
<div id="refundModal" class="modal">
	<div class="modal-content">
		<div>
			<span class="refundcloseBtn">&times;</span>
		</div>
		<div id="modal_headText">
			<span style="font-size:30px; font-weight: bold;">반품신청</span>
		</div>
		<div class="input_wrap" id="input_wrap">
			<select id="refund_reason">
				<option disabled selected>사유를 선택해주세요</option>
				<option value="1">단순변심</option>
				<option value="2">상품불량</option>
				<option value="3">사이즈변경</option>
				<option value="4">기타</option>
			</select>
			<br/><br/><br/><br/><br/><br/>
			<input type="button" id="refundSubmitBtn" class="submitBtn" value="신청"/>
		</div>
		<div class="result" id="result">
		</div>
	</div>
</div>

<!-- 교환신청 모달 -->
<div id="exchangeModal" class="modal">
	<div class="modal-content">
		<div>
			<span class="exchangecloseBtn">&times;</span>
		</div>
		<div id="modal_headText">
			<span style="font-size:30px; font-weight: bold;">교환신청</span>
		</div>
		<div class="input_wrap" id="input_wrap">
			<select id="exchange_reason">
				<option disabled selected>사유를 선택해주세요</option>
				<option value="1">단순변심</option>
				<option value="2">상품불량</option>
				<option value="3">사이즈변경</option>
				<option value="4">기타</option>
			</select>
			<br/><br/><br/><br/><br/><br/>
			<input type="button" id="ExchangeSubmitBtn" class="submitBtn" value="신청"/>
		</div>
		<div class="result" id="result">
		</div>
	</div>
</div>

<!-- 거래취소 모달 -->
<div id="cancelModal" class="modal">
	<div class="modal-content">
		<div>
			<span class="cancelcloseBtn">&times;</span>
		</div>
		<div id="modal_headText">
			<span style="font-size:30px; font-weight: bold;">거래취소</span>
		</div>
		<div class="input_wrap" id="input_wrap">
			<span style= "font-size:13px; color : gray;">
				※주의※ <br/>
				아직 주문자가 확인하지 않은 주문건에 대해 거래취소를 요청합니다.<br/>
				하단의 '확인' 버튼을 누르시면 해당 주문이 '즉시' 취소되며 '거래취소'상태로 변경됩니다.
			</span><br/><br/><br/><br/>
			<input type="button" id="cancelSubmitBtn" class="submitBtn" value="확인"/>
		</div>
		<div class="result" id="result">
		</div>
	</div>
</div>
<script>
var orderNo;
var orderEmail;
var orderPhone;
function cancelModal(orderno,order_email,order_phone){
	$("#cancelModal").show();
	orderNo = orderno;
	orderEmail = order_email;
	orderPhone = order_phone;
}

function refundModal(orderno,order_email,order_phone){
	$("#refundModal").show();
	orderNo = orderno;
	orderEmail = order_email;
	orderPhone = order_phone;
}

function exchangeModal(orderno,order_email,order_phone){
	$("#exchangeModal").show();
	orderNo = orderno;
	orderEmail = order_email;
	orderPhone = order_phone;
}

$(".confirmcloseBtn").click(function(){
	$("#confirmModal").hide();
});

$(".refundcloseBtn").click(function(){
	$("#refundModal").hide();
});

$(".exchangecloseBtn").click(function(){
	$("#exchangeModal").hide();
});

$(".cancelcloseBtn").click(function(){
	$("#cancelModal").hide();
});

$("#refundSubmitBtn").click(function(){
	var refund_reason = $("#refund_reason option:selected").val();
	$.ajax({
		type : "POST",
		url : "mypage/refundSetReason",
		data : {
			status_reason : refund_reason,
			orderno : orderNo
			},
		success : function(data){
			alert(data);
			$("#refundModal").hide();
			location.href="${pageContext.request.contextPath}/mypage/nonMemberOrderCheck?orderno="+orderNo+"&order_email="+orderEmail+"&order_phone="+orderPhone;
		}
	});
});

$("#ExchangeSubmitBtn").click(function(){
	var exchange_reason = $("#exchange_reason option:selected").val();
	$.ajax({
		type : "POST",
		url : "mypage/exchangeSetReason",
		data : {
			status_reason : exchange_reason,
			orderno : orderNo
			},
		success : function(data){
			alert(data);
			$("#exchangeModal").hide();
			location.href="${pageContext.request.contextPath}/mypage/nonMemberOrderCheck?orderno="+orderNo+"&order_email="+orderEmail+"&order_phone="+orderPhone;
		}
	});
});

$("#cancelSubmitBtn").click(function(){
	$.ajax({
		type : "POST",
		url : "mypage/cancelTransaction",
		data : {orderno : orderNo},
		success : function(data){
			alert(data);
			$("#cancelModal").hide();
			location.href="${pageContext.request.contextPath}/mypage/nonMemberOrderCheck?orderno="+orderNo+"&order_email="+orderEmail+"&order_phone="+orderPhone;
		}
	});
});
</script>
<%@include file="../common/footer.jsp" %>
