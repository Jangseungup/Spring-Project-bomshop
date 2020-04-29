<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>
<div class="menuTitle">
	<h2>쿠폰관리</h2>
</div>
<div id="couponDiv">
	<div id="btnWrap">
		<div id="btnDiv1">
			<input type="button" id="couponEnrollModal" class="btn btn-success" value="쿠폰 등록" /> 
			<input type="button" id="couponUpdateModal" onclick="update_coupon();" class="btn btn-primary" value="쿠폰 수정" /> 
			<input type="button" onclick="delete_coupon();" class="btn btn-danger" value="쿠폰 삭제" />
		</div>
	</div>
	<div id="couponTableDiv">
		<table>
			<tr>
				<th>선택</th>
				<th>쿠폰코드</th>
				<th>쿠폰명</th>
				<th>제한금액</th>
				<th>할인금액</th>
				<th>유효기간</th>
			</tr>
			<c:choose>
				<c:when test="${!empty couponList}">
					<c:forEach var="coupon" items="${couponList}">
						<tr>
							<td><input type="radio" name="coupon_radio"/><input type="hidden" id="cno" name="cno" value="${coupon.cno}"/></td>
							<td>${coupon.coupon_code}</td>
							<td>${coupon.cname}</td>
							<td>${coupon.climit}원 이상</td>
							<td>${coupon.sale}원</td>
							<td>${coupon.limit_date}일</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<td colspan="8">등록된 쿠폰이 없습니다</td>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
	<div class="paging">
		<ul class="pagination">
			<c:if test="${pageMaker.cri.page > 1}">
				<li><a
					href="coupon${pageMaker.makeQuery(pageMaker.cri.page- 1)}">&laquo;</a>
			</c:if>

			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
				var="i">
				<li>
					<a href="coupon${pageMaker.makeQuery(i)}" style="${pageMaker.cri.page == i ? 'color:red' : '' }">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker.cri.page < pageMaker.maxPage}">
				<li><a
					href="coupon${pageMaker.makeQuery(pageMaker.cri.page + 1)}">&raquo;</a>
			</c:if>
		</ul>
	</div>
	<div class="container modal" id="enrollModal">
		<!-- Modal -->
		<div role="dialog" class="modal-content">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div>
					<div class="modal-header">
						<div class="modal-title">
							<h3>COUPON</h3>
						</div>
						<div class="modalCloseBtn" id="couponCloseBtn">&times;</div>
						<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
					</div>
					<div class="modal-body">
						<table id="couponModalTable">
							<thead>
								<tr>
									<th>쿠폰코드</th>
									<th>쿠폰명</th>
									<th>제한금액</th>
									<th>할인금액</th>
									<th>유효기간</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type="text" class="coupon_code" id="enroll_coupon_code"/></td>
									<td><input type="text" name="cname" id="enroll_cname" value=""/></td>
									<td><input type="number" step="1000" min="0" name="climit" id="enroll_climit" value=""/>원 이상</td>
									<td><input type="number" step="1000" min="1000" max="50000" name="sale" id="enroll_sale" value=""/>원</td>
									<td><input type="number" min="1" max="31"  name="limit_date" id="enroll_limit_day" value=""/>일 후</td>
								</tr>
							</tbody>
						</table>
						<div class="couponCloseBtnDiv">
							<button type="button" class="btn btn-close" onclick="enroll_coupon();">등록</button>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<div class="container modal" id="updateModal">
		<!-- Modal -->
		<div role="dialog" class="modal-content">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div>
					<div class="modal-header">
						<div class="modal-title">
							<h3>COUPON UPDATE</h3>
						</div>
						<div class="modalCloseBtn" id="updateCloseBtn">&times;</div>
						<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
					</div>
					<div class="modal-body">
						<table id="couponModalTable">
							<thead>
								<tr>
									<th>쿠폰코드</th>
									<th>쿠폰명</th>
									<th>제한금액</th>
									<th>할인금액</th>
									<th>유효기간</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type="hidden" name="cno" id="update_coupon_cno" value=""><input type="text" class="coupon_code" id="update_coupon_code" readonly/></td>
									<td><input type="text" name="cname" id="update_cname" value=""/></td>
									<td><input type="number" step="1000" min="0" name="climit" id="update_climit" value=""/>원 이상</td>
									<td><input type="number" step="1000" min="1000" max="50000" name="sale" id="update_sale" value=""/>원</td>
									<td><input type="number" step="1" min="1" max="31" name="limit_day" id="update_limit_date"/>일</td>
								</tr>
							</tbody>
						</table>
						<div class="couponCloseBtnDiv">
							<button type="button" class="btn btn-close" onclick="update()">수정</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="${path}/resources/admin/js/coupon.js"></script>
<script>
$("#couponMenu").addClass("menu-background-color");

// 쿠폰 등록 모달
$("#couponEnrollModal").click(function(){
	//var code = randomCode();
	$("input[type='text']").val("");
	$("#enroll_coupon_code").val("");
	$("input[type='number']").val("");
	$("#enrollModal").css("display","flex");
});

$("#couponCloseBtn").click(function(){
	$("#enrollModal").css("display","none");
});

// 빈값 체크
function nullCheck(value) {
	if(value == null || value == ""){
		return true;
	}
	return false;
}

// 랜덤코드
/* function randomCode(){
	var code="";
	for(var i=0;i<19;i++){
		if(i==4 || i==9 || i==14){
			code += "-";
		}
		else{
			var random = String.fromCharCode(((Math.random()*26)+65));
			code += random;
	 	}
	}
	return code;
} */

// 쿠폰 등록
function enroll_coupon() {
	var coupon_code = $("#enroll_coupon_code").val();
	var cname = $("#enroll_cname").val();
	var climit = $("#enroll_climit").val();
	var sale = $("#enroll_sale").val();
	var limit_date = $("#enroll_limit_day").val();
	if(nullCheck(coupon_code) || nullCheck(cname) || nullCheck(climit) || nullCheck(sale)){
		alert("값을 다 입력해주세요.");
	}else {
		$.ajax({
			url: "enrollCoupon",
			type: "post",
			headers: {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			data: JSON.stringify({
				coupon_code,
				cname,
				climit,
				sale,
				limit_date
			}),
			dataType: "text",
			success: function(data) {
				location.href="coupon?page=${pageMaker.cri.page}&perPageNum=${pageMaker.cri.perPageNum}";
			}
		}); 	
	}
}

$("#updateCloseBtn").click(function(){
	$("#updateModal").css("display","none");
});

// 쿠폰 수정 모달
function update_coupon() {
	var checked =  $("input[name='coupon_radio']").is(":checked");
	if(checked){
		var couponArr = getCouponListRow();
		var climit_arr = couponArr[3];
		var climit_index = Number(climit_arr.indexOf("원"));
		var climit = climit_arr.substring(0,climit_index);
		var sale_arr = couponArr[4];
		var sale_index = Number(sale_arr.indexOf("원"));
		var sale = sale_arr.substring(0,sale_index);
		var limit_day_arr = couponArr[5];
		var limit_day_index = Number(limit_day_arr.indexOf("일"));
		var limit_day = limit_day_arr.substring(0,limit_day_index);
		$("#update_coupon_cno").val(couponArr[0]);
		$("#update_coupon_code").val(couponArr[1]);
		$("#update_cname").val(couponArr[2]);
		$("#update_climit").val(Number(climit));
		$("#update_sale").val(Number(sale));
		$("#update_limit_date").val(Number(limit_day));
		$("#updateModal").css("display","flex");
	}else {
		alert("체크해 주세요");
	}
}

// 쿠폰 수정 버튼
function update() { 
	var coupon_code = $("#update_coupon_code").val();
	var cname = $("#update_cname").val();
	var climit = $("#update_climit").val();
	var sale = $("#update_sale").val();
	var limit_date = $("#update_limit_date").val();
	if(nullCheck(coupon_code) || nullCheck(cname) || nullCheck(climit) || nullCheck(sale) || nullCheck(limit_date)){
		alert("값을 다 입력해주세요.");
	}else {
		$.ajax({
 			url: "updateCoupon",
 			type: "patch",
 			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "PATCH"
			},
			data : JSON.stringify({
				cno: $("#update_coupon_cno").val(),
				coupon_code,
				cname,
				climit,
				sale,
				limit_date
			}),
			dataType: "text",
			success: function(data) {
				location.href="coupon?page=${pageMaker.cri.page}&perPageNum=${pageMaker.cri.perPageNum}";
			}
 		});
	}
}

// 쿠폰 삭제
function delete_coupon(){
	var checked =  $("input[name='coupon_radio']").is(":checked");
	if(checked){
	 	if(confirm("쿠폰 삭제하시겠습니까?")==true){
	 		var couponArr = getCouponListRow();
	 		var cno = couponArr[0];
	 		$.ajax({
	 			url: "deleteCoupon/"+cno,
	 			type: "delete",
	 			headers: {
	 				"X-HTTP-Override" : "DELETE"
	 			},
	 			success: function(data){
	 				location.href="coupon?page=${pageMaker.cri.page}&perPageNum=${pageMaker.cri.perPageNum}";
	 			}
	 		});
	 	}else {
	 		alert("취소되었습니다.");
	 		$("input[name='coupon_radio']").prop("checked",false);
	 	}
	}else {
		alert("체크를 해주세요.");
	}
}

// 쿠폰리스트 테이블 체크된 체크박스 값 가져오기
function getCouponListRow(){
	var tdArr = new Array();
	var radio = $("input[name='coupon_radio']:checked");
	var tr = radio.parent().parent();
	var td = tr.children();
	var	cno = td.eq(0).find("#cno").val();
	console.log(cno);
	var coupon_code = td.eq(1).text();
	var cname = td.eq(2).text();
	var climit = td.eq(3).text();
	var sale = td.eq(4).text();
	var limit_date = td.eq(5).text();
	tdArr.push(cno);
	tdArr.push(coupon_code);
	tdArr.push(cname);
	tdArr.push(climit);
	tdArr.push(sale);
	tdArr.push(limit_date);
	return tdArr;
}
</script>
</body>
</html>