<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/order.css">

<div id="order_wrap">
	<form id="orderForm" action="order" method="post">
	
	<div class="clear"></div>
	<div class="pagetitle">
		<h1>구매하기</h1>
	</div>
	<div class="clear"></div>

	<div class="wishList wrapper">
		<!-- 구매 원하는 목록 -->
		
		<table>
			<tr>
				<th colspan="2"></th>
				<th>상품 금액</th>
			</tr>
			<c:forEach var="item" items="${list}">
				<input type="hidden" name="cart_no" value="${item.cart_no}"/>
				<input type="hidden" name="ono" value="${item.ono}"/>
				<input type="hidden" name="count" value="${item.count}"/>
				<input type="hidden" name="price" value="${item.price}"/>
				<tr>
					<td><img
						src="${pageContext.request.contextPath}/upload/${item.gno}/mainImg.jpg"
						width="95" height="95" /></td>
					<td><span> <a href="goods/detail?gno=${item.gno}">${item.gname_ko}</a>
					</span> <span> ${item.color} / ${item.size} </span></td>
					<td>
						<span class="item_price">${item.price}</span>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<div>
		<c:choose>
			<c:when test="${!empty memberInfo}">
				<!-- 회원일때 -->
				<!-- 주문자정보(이름,휴대폰,이메일), 배송지정보(수령인,휴대폰,주소,메모), 포인트사용여부,
                	쿠폰사용여부, 결제금액(포인트, 쿠폰사용 시 할인금액 출력), 적립포인트(등급별 %적용 포인트, 리뷰별 적립포인트) -->
				

					<div class="order_div wrapper">
						<h3>주문자 정보</h3>
						<table>
							<tr>
								<td>이름</td>
								<td><input type="text" name="order_name" class="order_name"
									placeholder="이름을 입력해 주세요." required /></td>
							</tr>
							<tr>
								<td>휴대폰</td>
								<td><input type="text" name="order_phone"
									class="order_phone" placeholder="전화번호를 입력해 주세요." required /></td>
							</tr>
							<tr>
								<td>이메일</td>
								<td><input type="text" name="order_email"
									class="order_email" placeholder="email을 입력해 주세요." required />
								</td>
							</tr>
						</table>
					</div>

					<div class="delivery_div wrapper">
						<div>
							<h3>배송지 정보</h3>
						</div>
						<table>
							<tr>
								<td>수령인</td>
								<td><input type="text" name="delivery_name"
									class="delivery_name" placeholder="이름을 입력해 주세요." required /></td>
							</tr>
							<tr>
								<td>휴대폰</td>
								<td><input type="text" name="delivery_phone" required /></td>
							</tr>
							<tr>
								<td>배송주소</td>
								<td>
									<div>
										<input type="text" id="delivery_post_code"
											name="delivery_post_code" readonly /> <input type="button"
											value="주소찾기" onclick="sample6_execDaumPostcode();" />
									</div> <input type="text" id="delivery_addr1" name="delivery_addr1"
									readonly /> <br /> <input type="text" id="delivery_addr2"
									name="delivery_addr2" />
								</td>
							</tr>
							<tr>
								<td>배송 메모</td>
								<td><select style="padding: 7px; border-radius: 5px;">
										<option value="0">배송시 요청사항을 선택해주세요.</option>
										<option value="1">배송전에 연락해 주세요.</option>
										<option value="2">부재시 문앞에 놓고 가 주세요.</option>
										<option value="3">부재시 관리(경비)실에 맡겨주세요</option>
								</select></td>
							</tr>
						</table>
					</div>

					<div class="point_div wrapper">
						<h3>포인트 사용</h3>
						<table>
							<tr>
								<td style="width:200px;">보유 포인트</td>
								<td style="width:200px;text-align: right;">${memberInfo.mpoint}</td>
								<td style="width:200px;">원</td>
							</tr>
							<tr>
								<td>사용할 포인트</td>
								<td style="text-align: right;">
									<span id="usePointText">0</span>
								</td>
								<td>원</td>
							</tr>
							<tr>
								<td>사용 포인트</td>
								<td colspan=2><input type="text" id="mpointInput"
									style="width: 200px; border-bottom: 1px solid gray;" /> <input
									type="button" id="allInBtn" value="전액 사용"
									style="margin-left: 20px; padding: 10px; border-radius: 5px; background-color: #343a40; color: white;" />
									<input type="button" id="UsePointBtn" value="사용하기"
									style="margin-left: 20px; padding: 10px; border-radius: 5px; background-color: #343a40; color: white;" />
								</td>
							</tr>
						</table>
					</div>

					<div class="coupon_div wrapper">
						<h3>쿠폰 적용</h3>
						<div style="border-top: 1px solid black; padding-top: 20px;">
							<select name="coupon" id="coupon"
								style="padding: 7px; border-radius: 5px;">
								<option value="0" data-cno="0" selected>--쿠폰 사용안함--</option>
								<c:choose>
									<c:when test="${!empty couponList}">
										<c:forEach var="coupon" items="${couponList}">
											<option data-cno="${coupon.cno}" value="${coupon.sale}">
												${coupon.cname}(${coupon.sale}원 할인)</option>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<option disabled>사용할 수 있는 쿠폰이 없습니다.</option>
									</c:otherwise>
								</c:choose>
							</select>
						</div>
					</div>


					<div class="calc_div wrapper">
						<h3>최종 결제 금액</h3>
						<table>
							<tr>
								<td style="width: 200px;">총 상품 금액</td>
								<td class="price_all" style="text-align: right;"><span
									id="totalPriceText"
									style="font-weight: bold; font-size: 1.3em;">${totalPrice}</span>
								</td>
							</tr>
							<tr>
								<td style="width: 200px;">쿠폰 할인</td>
								<td class="coupon_sale" style="text-align: right;"><span
									id="couponText" style="font-weight: bold; font-size: 1.3em;">0</span>
								</td>
							</tr>
							<tr>
								<td style="width: 200px;">포인트 할인</td>
								<td class="point_sale" style="text-align: right;"><span
									id="pointSaleText" style="font-weight: bold; font-size: 1.3em;">0</span>
								</td>
							</tr>
							<tr class="price_for_pay">
								<td style="width: 200px;">결제 예상 금액</td>
								<td style="text-align: right;"><span id="finalPriceText"
									style="font-weight: bold; font-size: 1.3em; color: red;">
										${totalPrice} </span></td>
							</tr>
						</table>
					</div>
					<!-- 넘어가야할 히든값 ^-^; -->
					<div>
						<input type="hidden" id="usePoint" name="mpoint" />
						<input type="hidden" id="useCouponNum" name="cno" />
						<input type="hidden" id="finalPrice" name="totalPrice" value="${totalPrice}"/>
					</div>

					<!-- 결제 수단 선택 -->
					<div class="payment_method wrapper">
						<input type="radio" name="pay_m1" value="">
					</div>

					<div>
						<input type="submit" value="결제하기"/>
						<!-- <a href="#" class="orderBtn">결제하기</a> -->
					</div>
				
			</c:when>
			<c:otherwise>
				<!-- 비회원일때 -->
				<!-- 주문자정보(이름,휴대폰,이메일), 배송지정보(수령인,휴대폰,주소,메모), 결제금액 -->

					<div class="order_div wrapper">
						<h3>주문자 정보</h3>
						<table>
							<tr>
								<td>이름</td>
								<td><input type="text" name="order_name" class="order_name"
									placeholder="이름을 입력해 주세요." required /></td>
							</tr>
							<tr>
								<td>휴대폰</td>
								<td><input type="text" name="order_phone"
									class="order_phone" placeholder="전화번호를 입력해 주세요." required /></td>
							</tr>
							<tr>
								<td>이메일</td>
								<td><input type="text" name="order_email"
									class="order_email" placeholder="email을 입력해 주세요." required />
								</td>
							</tr>
						</table>
					</div>

					<div class="delivery_div wrapper">
						<div>
							<h3>배송지 정보</h3>
						</div>
						<table>
							<tr>
								<td>수령인</td>
								<td><input type="text" name="delivery_name"
									class="delivery_name" placeholder="이름을 입력해 주세요." required /></td>
							</tr>
							<tr>
								<td>휴대폰</td>
								<td><input type="text" name="delivery_phone" required /></td>
							</tr>
							<tr>
								<td>배송주소</td>
								<td>
									<div>
										<input type="text" id="delivery_post_code"
											name="delivery_post_code" readonly /> <input type="button"
											value="주소찾기" onclick="sample6_execDaumPostcode();" />
									</div> <input type="text" id="delivery_addr1" name="delivery_addr1"
									readonly /> <br /> <input type="text" id="delivery_addr2"
									name="delivery_addr2" />
								</td>
							</tr>
							<tr>
								<td>배송 메모</td>
								<td><select style="padding: 7px; border-radius: 5px;">
										<option value="0">배송시 요청사항을 선택해주세요.</option>
										<option value="1">배송전에 연락해 주세요.</option>
										<option value="2">부재시 문앞에 놓고 가 주세요.</option>
										<option value="3">부재시 관리(경비)실에 맡겨주세요</option>
								</select></td>
							</tr>
						</table>
					</div>

					<div class="calc_div wrapper">
						<h3>최종 결제 금액</h3>
						<table>
							<tr class="price_for_pay">
								<td style="width: 200px;">결제 예상 금액</td>
								<td style="text-align: right;"><span id="finalPriceText"
									style="font-weight: bold; font-size: 1.3em; color: red;">
										${totalPrice} </span></td>
							</tr>
						</table>
					</div>
					<!-- 넘어가야할 히든값 ^-^; -->
					<div>
						<%-- <input type="hidden" id="finalPrice" name="totalPrice" value="${totalPrice}"/> --%>
					</div>

					<!-- 결제 수단 선택 -->
					<div class="payment_method wrapper">
						<input type="radio" name="pay_m1" value="">
					</div>

					<div>
						<input type="submit" value="결제하기"/>
						<!-- <a href="#" class="orderBtn">결제하기</a> -->
					</div>
			</c:otherwise>

		</c:choose>
	</div>
	</form>
</div>

<!-- 다음 주소 api -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(document).ready(function(){
		totalPrice();
	});
	
	function sample6_execDaumPostcode() {
		//alert('click'); 클릭이벤트 확인
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 주소 검색 결과
						console.log(data);

						var fullAddr = ""; // 최종 주소
						var extraAddr = ""; // 조합형 주소

						if (data.userSelectedType == 'R') {
							fullAddr = data.roadAddress;
						} else {
							fullAddr = data.jibunAddress;
						}

						if (data.userSelectedType == 'R') {

							if (data.bname !== '') {
								// 법정 동명이 존재할때
								extraAddr += data.bname;
							}

							if (data.buildingName !== '') {
								extraAddr += (extraAddr !== '' ? ','
										+ data.buildingName : data.buildingName);
							}

							fullAddr += (extraAddr !== '' ? '(' + extraAddr
									+ ')' : '');
						}
						$("#delivery_post_code").val(data.zonecode);

						$("#delivery_addr1").val(fullAddr);

						$("#delivery_addr2").focus();
					}
				}).open();
	}

	$("#allInBtn").click(function() {
		var totalPoint = "${memberInfo.mpoint}";

		$("#mpointInput").val(totalPoint);
	});

	$("#UsePointBtn").click(function() {
		var totalPoint = Number("${memberInfo.mpoint}");
		var inputPoint = Number($("#mpointInput").val());
		if (totalPoint < inputPoint) {
			alert("보유포인트보다 많은 금액은 사용할 수 없습니다.");
			$("#mpointInput").val('');
			return;
		} else {
			$("#pointSaleText").html(inputPoint);
			$("#usePointText").html(inputPoint);
			$("#usePoint").val(inputPoint);
			calcFinalPrice();
		}
	});

	function calcFinalPrice() {
		var totalPrice = Number("${totalPrice}");
		var couponText = $("#couponText").text();
		var pointText = $("#pointSaleText").text();
		var couponNum = 0;
		var pointNum = 0;

		if (couponText != "" && couponText != null) {
			couponNum = Number(couponText);
		}

		if (pointText != "" && pointText != null) {
			pointNum = Number(pointText);
		}

		var finalPriceText = totalPrice - couponNum - pointNum;
		$("#finalPriceText").html(finalPriceText);
		$("#finalPrice").val(finalPriceText);
	}

	$("#coupon").change(function() {
		var couponPrice = $(this).val();
		$("#couponText").html(couponPrice);
		console.log($("#coupon option:selected").data("cno"));
		$("#useCouponNum").val($("#coupon option:selected").data("cno"));
		calcFinalPrice();
	});
	
	function totalPrice(){
		var totalPrice = 0;
		$(".item_price").each(function(){
			totalPrice += Number($(this).text());
			console.log($(this).text());
		});
		console.log(totalPrice);
		$("#finalPriceText").html(totalPrice);
	}
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>