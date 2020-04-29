<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/cart.css">

<div id="cart_wrap">
	<div class="clear"></div>
	<div class="pagetitle">
		<h1>장바구니</h1>
	</div>
	<div class="clear"></div>
	
	<div>
		<div>
			<!-- 목록 테이블 -->
			<div class="cart_list">
				<c:choose>
					<c:when test="${!empty cart}">
					<div class="cart_sel">
						<!-- 전체 선택   /  선택 삭제 -->
						<div class="select_all">
							<input type="checkbox" id="selectAll" class="cart_checkbox" checked />
							<label>전체 선택</label>
						</div>
						<input type="button" id="select_del" class="cart_sel_del"
							value="전체 삭제" />
					</div>
						<table>
							<tr>
								<th colspan="3"></th>
								<th>수량</th>
								<th>상품 금액</th>
							</tr>
							<c:forEach var="list" items="${cart}">
								<tr>
									<td class="cb"><input type="checkbox"
										data-price="${list.price}" data-cart_no="${list.cart_no}"
										checked class="item" /></td>
									<td class="mi"><img
										src="${pageContext.request.contextPath}/upload/${list.gno}/mainImg.jpg"
										width="95" height="95" /></td>
									<td class="opt">
										<span class="name"> 
											<a href="goods/detail?gno=${list.gno}">${list.gname_ko}</a>
											<span class="delBtn"><input onclick="deleteCart('${list.cart_no}');"  type="button" value="X"/></span>
										</span> 
										<span class="cs_opt">${list.color} / ${list.size}</span></td>
									<td class="count">${list.count}</td>
									<td class="price">${list.price}</td>
								</tr>
							</c:forEach>
						</table>
						
						<div>
							<!-- 선택된 물품 총 개수 및 가격 -->
							<div class="price_title">총 결제 예상 금액</div>
							<div class="pay">
								<div class="pay_price">
									총 결제 예상 금액 <span></span>원
								</div>
							</div>
						</div>

						<div>
							<!-- 구매하기 버튼 -->
							<input type="button" id="orderBtn" class="orderBtn" value="구매하기" />
						</div>
				
						<form action="orderCart" id="orderForm"></form>
						<form action="deleteCart" id="delForm" method="post"></form>
					</c:when>
					<c:otherwise>
						<div class="clear"></div>
						<div style="text-align:center;">
							<h3>장바구니에 등록된 상품이 없습니다.</h3>
						</div>
						<div class="clear"></div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>

<script>
	var totalCount = 0;
	getPrice();
	
	function getPrice() {
		var checkedBox = $(".item:checked");
		$(checkedBox).each(function() {
			totalCount += $(this).data("price");
		});
		$(".pay_price span").html(totalCount);
	};

	$(".item").change(function() {
		if ($(this).is(":checked")) {
			totalCount += $(this).data("price");
		} else {
			totalCount -= $(this).data("price");
		}
		$(".pay_price span").html(totalCount);
	});

	$("#orderBtn").click(function() {
		var checkedBox = $(".item:checked");
		var str = "";
		$(checkedBox).each(function() {
			str += "<input type='hidden' name='cart_no' value='"
					+ $(this).data("cart_no")
					+ "'/>";
		});
		$("#orderForm").html(str);
		$("#orderForm").submit();
	});
	
	$("#selectAll").change(function(){
		if($(this).is(":checked")){
			$(".item").prop("checked",true);
			getPrice();
		}else{
			$(".item").attr("checked",false);
			totalCount = 0;
			$(".pay_price span").html(totalCount);
		}
	});
	
	function deleteCart(cart_no){
		var str = "<input type='hidden' name='cart_no' value='"
					+ cart_no
					+ "'/>";
		$("#delForm").html(str);
		$("#delForm").submit();
	};
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>