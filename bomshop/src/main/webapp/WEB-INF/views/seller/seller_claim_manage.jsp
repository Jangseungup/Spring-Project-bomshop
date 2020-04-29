<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="common/seller_header.jsp" %>

<style>
	div#claimStatus{
		float : left;
		width : 80%;
	}
	
	div#claimStatus table#claimStatusInfo{
		margin: 20px 50px 40px 50px;
		border-collapse:collapse;
		width : 800px;
	}
	
	#claimManagePage{
		float:left;
		width:800px;
		background-color:#e2e2e2;
		margin-left: 50px;
		height: 420px;
		border-radius: 10px;
	}
	
	div#claimStatus #btnWrap {
		height:25px;
		margin-top:10px;
	}
	div#claimStatus #btnDiv1 {
		margin-left:25px;
		float:left;
		width: 60%
	}

	div#claimStatus #tableDiv {
		padding-top: 10px;
		width:96%;
		background-color:white;
		margin: 0 auto;
		margin-top: 15px;
		height: 320px;
		border-radius: 10px;
	}
	div#claimStatus #tableDiv table{
		border-collapse: collapse;
		margin: 0 auto;
		width: 95%;
	}
	div#claimStatus table tr th {
		border:1px solid lightgray;
		background-color: #e2e2e2;
		text-align: center;
	}
	div#claimStatus table tr td {
		border:1px solid lightgray;
		text-align: center;
	}
	
	table#claimStatusInfo tr th{
		width: 166px;
	}
	
	table#claimStatusInfo a{
		color:red;
	}
</style>

<div id="claimStatus">
	<table id="claimStatusInfo">
		<thead>
			<tr>
				<td style="border:0;text-align: left;">
					<h3>클레임 관리</h3>
				</td>
			</tr>
			<tr>
				<th>전체</th>
				<th>반품요청</th>
				<th>교환요청</th>
				<th>취소요청</th>
				<th>반품 처리중</th>
				<th>교환 처리중</th>
			</tr>
		</thead>
		<tr>
			<td><a href="claim_manage">${totalClaimCount}</a> 건</td>
			<td><a href="claim_manage?searchType=refund">${requestRefundCount}</a> 건</td>
			<td><a href="claim_manage?searchType=exchange">${requestExchangeCount}</a> 건</td>
			<td><a href="claim_manage?searchType=cancel">${requestCancelCount}</a> 건</td>
			<td><a href="claim_manage?searchType=returning">${returningCount}</a> 건</td>
			<td><a href="claim_manage?searchType=inExchange">${inExchangeCount}</a> 건</td>
		</tr>
	</table>
	
	<div id="claimManagePage">
		<div id="btnWrap">
			<div id="btnDiv1">
				<input type="button" class="btn btn-primary" id="processingCompletedBtn" value="요청처리완료"/>
				<input type="button" class="btn btn-danger" id="refusalBtn" value="요청거절"/>
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
						<th>주문자ID</th>
						<th>요청상태</th>
					</tr>
				</thead>
				<c:choose>
					<c:when test="${!empty claimList}">
						<c:forEach var="claim" items="${claimList}">
							<tr>
								<td>
									<input type="radio" name="claim_radio"/>
								</td>
								<td>
									${claim.order.orderno}
								</td>
								<td>
									${claim.gname}
								</td>
								<td>
									${claim.option.color}
								</td>
								<td>
									${claim.option.size}
								</td>
								<td>
									${claim.order.count}
								</td>
								<td>
									${claim.mid}
								</td>
								<td>
									<c:choose>
										<c:when test="${claim.order.order_status eq 3}">
											반품요청
										</c:when>
										<c:when test="${claim.order.order_status eq 4}">
											교환요청
										</c:when>
										<c:when test="${claim.order.order_status eq 5}">
											취소요청
										</c:when>
										<c:when test="${claim.order.order_status eq 6}">
											반품처리중
										</c:when>
										<c:when test="${claim.order.order_status eq 7}">
											교환처리중
										</c:when>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td style="text-align:center;" colspan=8>
								<label>등록된 주문이 없습니다.</label>
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
		
		<div id="pagination">
			<c:if test="${pageMaker.prev}">
				<a href="claim_manage${pageMaker.search(pageMaker.startPage-1)}">&laquo;</a>
			</c:if>
			<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<c:choose>
					<c:when test="${pageMaker.cri.page eq i}">
						<b style="color:red">${i}</b>
					</c:when>
					<c:otherwise>
						<a href="claim_manage${pageMaker.search(i)}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<a href="claim_manage${pageMaker.search(pageMaker.endPage+1)}">&raquo;</a>
			</c:if>
		</div>
		
	</div>
</div>
</div>

<!-- 요청처리완료 버튼 클릭시 띄울 modal -->
<div id="processingCompletedModal" class="modal">
	<div class="modal-content">
		<form action="processingCompleted" method="post" id="processingCompletedForm">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}"/>
			<h3>요청 승인</h3>
			<table>
				<tr>
					<td><label>주문번호</label></td>
					<td>
						<input type="text" class="form-control" id="processingCompletedOrderno" name="orderno" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>상품명</label></td>
					<td>
						<input type="text" class="form-control" id="processingCompletedGname" readonly/>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="button" id="processingCompletedSubmitBtn" class="btn btn-success" value="처리완료"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="processingCompletedCancleBtn" class="btn btn-danger" value="닫기"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>

<!-- 요청거절 버튼 클릭시 띄울 modal -->
<div id="refusalModal" class="modal">
	<div class="modal-content">
		<form action="refusal" method="post" id="refusalForm">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}"/>
			<h3>요청 거절</h3>
			<table>
				<tr>
					<td><label>주문번호</label></td>
					<td>
						<input type="text" class="form-control" id="refusalOrderno" name="orderno" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>상품명</label></td>
					<td>
						<input type="text" class="form-control" id="refusalGname" readonly/>
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<textarea cols=30 rows=5 name="rcontent" class="form-control" placeholder="거절 이유를 입력해주세요."></textarea>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="button" id="refusalSubmitBtn" class="btn btn-success" value="확인"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="refusalCancleBtn" class="btn btn-danger" value="닫기"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>

<script>
	$("#menu_clm").addClass("currentPage");
	//	요청거절 버튼 클릭
	$("#refusalBtn").click(function(){
		//	라디오 버튼 클릭이 되었는지 체크
		if(checkRadio()){
			var orderno = $("input[type='radio']:checked").parent().parent().children().eq(1).text();
			var gname = $("input[type='radio']:checked").parent().parent().children().eq(2).text();
			var order_status = $.trim($("input[type='radio']:checked").parent().parent().children().eq(7).text());
			if(order_status == '반품처리중' || order_status == '교환처리중'){
				alert("요청 거절을 할 수 없는 상태 입니다.");
				return;
			}
			$("#refusalOrderno").val($.trim(orderno));
			$("#refusalGname").val($.trim(gname));
			$("#refusalModal").css("display","flex");	
		}
	});
	//	modal 요청거절 버튼 클릭
	$("#refusalSubmitBtn").click(function(){
		$("#refusalForm").submit();
		$("#refusalModal").css("display","none");
	});
	//	modal 요청거절 취소 버튼 클릭
	$("#refusalCancleBtn").click(function(){
		$("#refusalModal").css("display","none");
	});
	
	//	요청처리완료 버튼 클릭
	$("#processingCompletedBtn").click(function(){
		//	라디오 버튼 클릭이 되었는지 체크
		if(checkRadio()){
			var orderno = $("input[type='radio']:checked").parent().parent().children().eq(1).text();
			var gname = $("input[type='radio']:checked").parent().parent().children().eq(2).text();
			$("#processingCompletedOrderno").val($.trim(orderno));
			$("#processingCompletedGname").val($.trim(gname));
			$("#processingCompletedModal").css("display","flex");	
		}
	});
	//	modal 요청거절 버튼 클릭
	$("#processingCompletedSubmitBtn").click(function(){
		$("#processingCompletedForm").submit();
		$("#processingCompletedModal").css("display","none");
	});
	//	modal 요청거절 취소 버튼 클릭
	$("#processingCompletedCancleBtn").click(function(){
		$("#processingCompletedModal").css("display","none");
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
</script>

</body>
</html>