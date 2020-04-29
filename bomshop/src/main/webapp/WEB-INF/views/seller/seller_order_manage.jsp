<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="common/seller_header.jsp" %>

<style>
	div#orderStatus{
		float : left;
		width : 80%;
	}
	
	div#orderStatus table#orderStatusInfo{
		margin: 20px 50px 40px 50px;
		border-collapse:collapse;
		width : 800px;
	}
	
	#orderManagePage{
		float:left;
		width:800px;
		background-color:#e2e2e2;
		margin-left: 50px;
		height: 420px;
		border-radius: 10px;
	}
	
	div#orderStatus #btnWrap {
		height:25px;
		margin-top:10px;
	}
	div#orderStatus #btnDiv1 {
		margin-left:25px;
		float:left;
		width: 60%
	}

	div#orderStatus #tableDiv {
		padding-top: 10px;
		width:96%;
		background-color:white;
		margin: 0 auto;
		margin-top: 15px;
		height: 320px;
		border-radius: 10px;
	}
	div#orderStatus #tableDiv table{
		border-collapse: collapse;
		margin: 0 auto;
		width: 95%;
	}
	div#orderStatus table tr th {
		border:1px solid lightgray;
		background-color: #e2e2e2;
		text-align: center;
	}
	div#orderStatus table tr td {
		border:1px solid lightgray;
		text-align: center;
	}
		
	table#orderStatusInfo tr th{
		width: 199px;
	}
	
	table#orderStatusInfo a{
		color : red;
	}
</style>

<div id="orderStatus">
	<table id="orderStatusInfo">
		<thead>
			<tr>
				<td style="border:0;text-align: left;">
					<h3>주문 관리</h3>
				</td>
			</tr>
			<tr>
				<th>전체</th>
				<th>오늘 주문된 상품</th>
				<th>발송대기 상품</th>
				<th>배송중</th>
				<th>배송완료</th>
			</tr>
		</thead>
		<tr>
			<td>
				<a href="order_manage">${totalOrderCount}</a> 건
			</td>
			<td>
				<a href="order_manage?searchType=today">${todayOrderCount}</a> 건
			</td>
			<td>
				<a href="order_manage?searchType=awaiting">${awaitingDeliveryCount}</a> 건
			</td>
			<td>
				<a href="order_manage?searchType=shipping">${shippingCount}</a> 건
			</td>
			<td>
				<a href="order_manage?searchType=completed">${completedCount}</a> 건
			</td>
		</tr>
	</table>
	
	<div id="orderManagePage">
		<div id="btnWrap">
			<div id="btnDiv1">
				<input type="button" class="btn btn-primary" id="changeInfoBtn" value="배송지 정보수정"/>
				<input type="button" class="btn btn-warning" id="sendCancelBtn" value="발송취소"/>
				<input type="button" class="btn btn-danger" id="cancelOrderBtn" value="거래취소"/>
			</div>
		</div>
		<div id="tableDiv">
			<table id="goodsInfoTbl">
				<thead>
					<tr>
						<td style="border:0;background-color:#82b3ed;border-radius:5px 5px 0 0;" colspan="2">
							<label id="subTitle">${subTitle}</label>
						</td>
					</tr>
					<tr>
						<th style="width:60px;">선택</th>
						<th style="width:90px;">주문번호</th>
						<th>상품명</th>
						<th>색상</th>
						<th>사이즈</th>
						<th>수량</th>
						<th>주문자</th>
						<th>배송상태</th>
						<th>배송지정보</th>
					</tr>
				</thead>
				<c:choose>
					<c:when test="${!empty orderList}">
						<c:forEach var="idx" begin="0" end="${orderList.size()-1}" step="1">
							<tr>
								<td>
									<input type="radio" name="order_radio"/>
								</td>
								<td>
									${orderList.get(idx).order.orderno}
								</td>
								<td>
									${orderList.get(idx).gname}
								</td>
								<td>
									${orderList.get(idx).option.color}
								</td>
								<td>
									${orderList.get(idx).option.size}
								</td>
								<td>
									${orderList.get(idx).order.count}
								</td>
								<td>
									${orderList.get(idx).order.order_name}
								</td>
								<td>
									<c:choose>	
										<c:when test="${orderList.get(idx).order.order_status eq 0}">
											발송대기
										</c:when>
										<c:when test="${orderList.get(idx).order.order_status eq 1}">
											배송중
										</c:when>
										<c:otherwise>
											배송완료
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<input type="button" value="주문정보 자세히"
										 onclick="detailOrderInfo('${orderList.get(idx).order.orderno}');" class="btn btn-sm btn-primary"/>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan=9 style="text-align:center">
								<label>등록된 주문이 없습니다.</label>
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
		
		<div id="pagination">
			<c:if test="${pageMaker.prev}">
				<a href="order_manage${pageMaker.search(pageMaker.startPage-1)}">&laquo;</a>
			</c:if>
			<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<c:choose>
					<c:when test="${pageMaker.cri.page eq i}">
						<b style="color:red">${i}</b>
					</c:when>
					<c:otherwise>
						<a href="order_manage${pageMaker.search(i)}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<a href="order_manage${pageMaker.search(pageMaker.endPage+1)}">&raquo;</a>
			</c:if>
		</div>
		
	</div>
	
</div>
</div>

<!-- 배송지 정보 수정 버튼 클릭시 띄울 modal -->
<div id="changeInfoModal" class="modal">
	<div class="modal-content">
		<form action="changeInfo" method="post" id="changeInfoForm">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}"/>
			<table>
				<tr>
					<td><label>주문번호</label></td>
					<td>
						<input type="text" class="form-control" id="changeInfoOrderno" name="orderno" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>받는사람</label></td>
					<td>
						<input type="text" class="form-control" name="delivery_name" required/>
					</td>
				</tr>
				<tr>
					<td><label>전화번호</label></td>
					<td>
						<input type="text" class="form-control" name="delivery_phone" required/>
					</td>
				</tr>
				<tr>
					<td rowspan=3><label>주소</label></td>
					<td>
						<input type="text" class="form-addr" name="delivery_post_code" id="delivery_post_code" required/>
						<input type="button" value="주소 찾기" onclick="execDaumPostcode();" class="btn btn-primary"/>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" class="form-control" name="delivery_addr1" id="delivery_addr1" required/>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" class="form-control" name="delivery_addr2" id="delivery_addr2" required/>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="button" id="changeInfoSubmitBtn" class="btn btn-success" value="배송지정보 수정"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="changeInfoCancelBtn" class="btn btn-danger" value="닫기"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>

<!-- 발송취소 버튼 클릭시 띄울 modal -->
<div id="sendCancelModal" class="modal">
	<div class="modal-content">
		<form action="sendCancel" method="post" id="sendCancelForm">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}"/>
			<table>
				<tr>
					<td><label>주문번호</label></td>
					<td>
						<input type="text" class="form-control" id="sendCancelOrderno" name="orderno" readonly/>
					</td>
				</tr>
				<tr>
					<th colspan=2 style="color:red">해당 상품의 발송상태를 변경하시겠습니까?</th>
				</tr>
				<tr>
					<th colspan="2">
						<input type="button" id="sendCancelSubmitBtn" class="btn btn-success" value="발송취소"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="sendCancelCancelBtn" class="btn btn-danger" value="닫기"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>

<!-- 거래취소 버튼 클릭시 띄울 modal -->
<div id="cancelOrderModal" class="modal">
	<div class="modal-content">
		<form action="cancelOrder" method="post" id="cancelOrderForm">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}"/>
			<table>
				<tr>
					<td><label>주문번호</label></td>
					<td>
						<input type="text" class="form-control" id="cancelOrderOrderno" name="orderno" readonly/>
					</td>
				</tr>
				<tr>
					<th colspan=2 style="color:red">
						주문을 취소 하면 되돌릴수 없습니다.
					</th>
				</tr>
				<tr>
					<th colspan="2">
						<input type="button" id="cancelOrderSubmitBtn" class="btn btn-success" value="주문취소"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="cancelOrderCancelBtn" class="btn btn-danger" value="닫기"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>

<!-- 상품 상세정보 클릭시 띄울 modal -->
<div id="orderInfoDetailModal" class="modal">
	<div class="modal-content">
		<form action="startDelivery" method="post" id="startDeliveryForm">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}"/>
			<table>
				<tr>
					<td><label>주문번호</label></td>
					<td>
						<input type="text" class="form-control" id="orderInfoDetailOrderno" name="orderno" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>상품명</label></td>
					<td>
						<input type="text" class="form-control" id="orderInfoDetailGname" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>색상</label></td>
					<td>
						<input type="text" class="form-control" id="orderInfoDetailColor" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>사이즈</label></td>
					<td>
						<input type="text" class="form-control" id="orderInfoDetailSize" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>수량</label></td>
					<td>
						<input type="text" class="form-control" id="orderInfoDetailCount" readonly/>
					</td>
				</tr>
				<tr>
					<th colspan=2>주문자 정보</th>
				</tr>
				<tr>
					<td><label>이름</label></td>
					<td>
						<input type="text" class="form-control" id="orderInfoDetailOrderName" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>전화번호</label></td>
					<td>
						<input type="text" class="form-control" id="orderInfoDetailOrderPhone" readonly/>
					</td>
				</tr>
				<tr>
					<th colspan=2>배송지 정보</th>
				</tr>
				<tr>
					<td><label>이름</label></td>
					<td>
						<input type="text" class="form-control" id="orderInfoDetailDeliveryName" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>전화번호</label></td>
					<td>
						<input type="text" class="form-control" id="orderInfoDetailDeliveryPhone" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>우편번호</label></td>
					<td>
						<input type="text" class="form-control" id="orderInfoDetailDeliveryCode" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>주소</label></td>
					<td>
						<input type="text" class="form-control" id="orderInfoDetailDeliveryAddr1" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>상세 주소</label></td>
					<td>
						<input type="text" class="form-control" id="orderInfoDetailDeliveryAddr2" readonly/>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="button" id="orderInfoDetailSubmitBtn" class="btn btn-success" value="발송완료"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="orderInfoDetailCancelBtn" class="btn btn-danger" value="닫기"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$("#menu_om").addClass("currentPage");
	
	//	배송지 정보 변경 버튼 클릭
	$("#changeInfoBtn").click(function(){
		if(checkRadio()){
			var td = $("input[type='radio']:checked").parent().parent().children();
			var orderno = $.trim(td.eq(1).text());
			$("#changeInfoOrderno").val(orderno);
			$("#changeInfoModal").css("display","flex");
		}
	});
	//	modal 상태변경 확인 버튼 클릭
	$("#changeInfoSubmitBtn").click(function(){
		$("#changeInfoModal").css("display","none");
		$("#changeInfoForm").submit();
	});
	//	modal 상태변경 취소 버튼 클릭
	$("#changeInfoCancelBtn").click(function(){
		$("#changeInfoModal").css("display","none");
	});
	
	//	배송취소 버튼 클릭
	$("#sendCancelBtn").click(function(){
		if(checkRadio()){
			var td = $("input[type='radio']:checked").parent().parent().children();
			var orderno = $.trim(td.eq(1).text());
			var status = $.trim(td.eq(7).text());
			if(status!='배송중'){
				alert('발송취소를 할 수 없는 상태입니다.');
				return;
			}
			$("#sendCancelOrderno").val(orderno);
			$("#sendCancelModal").css("display","flex");
		}
	});
	//	modal 상태변경 확인 버튼 클릭
	$("#sendCancelSubmitBtn").click(function(){
		$("#sendCancelModal").css("display","none");
		$("#sendCancelForm").submit();
	});
	//	modal 상태변경 취소 버튼 클릭
	$("#sendCancelCancelBtn").click(function(){
		$("#sendCancelModal").css("display","none");
	});
	
	
	//	거래취소 변경 버튼 클릭
	$("#cancelOrderBtn").click(function(){
		if(checkRadio()){
			var td = $("input[type='radio']:checked").parent().parent().children();
			var orderno = $.trim(td.eq(1).text());
			var status = $.trim(td.eq(7).text());
			if(status!='발송대기'){
				alert('거래취소를 할 수 없는 상태입니다.');
				return;
			}
			$("#cancelOrderOrderno").val(orderno);
			$("#cancelOrderModal").css("display","flex");
		}
	});
	//	modal 상태변경 확인 버튼 클릭
	$("#cancelOrderSubmitBtn").click(function(){
		$("#cancelOrderModal").css("display","none");
		$("#cancelOrderForm").submit();
	});
	//	modal 상태변경 취소 버튼 클릭
	$("#cancelOrderCancelBtn").click(function(){
		$("#cancelOrderModal").css("display","none");
	});
	
	//	주문정보 자세히 클릭
	function detailOrderInfo(num){
		$("#orderInfoDetailSubmitBtn").prop("disabled", false);
		$("#orderInfoDetailSubmitBtn").val("발송완료");
		//	주문정보 비동기로 가져오기
		$.getJSON("${path}/seller/getDetailOrderInfo/"+num,function(data){
			var orderno = data.order.orderno;
			var gname = data.gname;
			var color = data.option.color;
			var size = data.option.size;
			var count = data.order.count;
			var ordername = data.order.order_name;
			var orderphone = data.order.order_phone;
			var deliveryname = data.order.delivery_name;
			var deliveryphone = data.order.delivery_phone;
			var deliveryPostCode = data.order.delivery_post_code;
			var deliveryaddr1 = data.order.delivery_addr1;
			var deliveryaddr2 = data.order.delivery_addr2;
			$("#orderInfoDetailOrderno").val(orderno);
			$("#orderInfoDetailGname").val(gname);
			$("#orderInfoDetailColor").val(color);
			$("#orderInfoDetailSize").val(size);
			$("#orderInfoDetailCount").val(count);
			$("#orderInfoDetailOrderName").val(ordername);
			$("#orderInfoDetailOrderPhone").val(orderphone);
			$("#orderInfoDetailDeliveryName").val(deliveryname);
			$("#orderInfoDetailDeliveryPhone").val(deliveryphone);
			$("#orderInfoDetailDeliveryCode").val(deliveryPostCode);
			$("#orderInfoDetailDeliveryAddr1").val(deliveryaddr1);
			$("#orderInfoDetailDeliveryAddr2").val(deliveryaddr2);
			
			if(data.order.order_status != 0){
				$("#orderInfoDetailSubmitBtn").prop("disabled", true);
				$("#orderInfoDetailSubmitBtn").val("이미 배송되었습니다.");
			}
		});

		$("#orderInfoDetailModal").css("display","flex");
	}
	//	modal 주문정보 자세히 발송완료 버튼 클릭
	$("#orderInfoDetailSubmitBtn").click(function(){
		$("#orderInfoDetailModal").css("display","none");
		$("#startDeliveryForm").submit();
	});
	//	modal 주문정보 자세히 취소 버튼 클릭
	$("#orderInfoDetailCancelBtn").click(function(){
		$("#orderInfoDetailModal").css("display","none");
	});
	
	
	//	체크된 라디오 값이 있는지 확인하는 메소드
	function checkRadio(){
		var tr = $("input[type='radio']:checked").parent().parent();
		if(tr.text() == null || tr.text() == "" || tr.text() == undefined){
			alert("선택된 상품이 없습니다.");
			return false;
		}
		return true;
	}
	
	function execDaumPostcode(){
		new daum.Postcode({
			oncomplete : function(data){
				var fullAddr = "";	//	최종 주소
				var extraAddr = "";	//	조합형 주소
				
				if(data.userSelectedType == 'R'){	//	도로명 주소
					fullAddr = data.roadAddress;
				}else{
					fullAddr = data.jibunAddress;	//	지번 주소
				}
				console.log(data);
				if(data.userSelectedType == 'R'){
					//	법정동명
					if(data.bname != ""){
						extraAddr += data.bname;
					}
					console.log(data.buildingName);
					//	건물명
					if(data.buildingName != ""){
						extraAddr += (extraAddr != "" ? ', '+data.buildingName : data.buildingName);
					}
					
					fullAddr += (extraAddr != "" ? '('+extraAddr+')' : '');
				}
				
				$("#delivery_post_code").val(data.zonecode);
				$("#delivery_addr1").val(fullAddr);
				$("#delivery_addr2").focus();
			}
		}).open();
	}
</script>
</body>
</html>