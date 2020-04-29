<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="common/header.jsp" %>
<div class="menuTitle">
	<h2>상품관리</h2>
</div>
<div id="reportGoodsDiv">
	<div id="btnWrap">
		<div id="btnDiv1">
			<input type="button" class="btn btn-primary" onclick="check_goods();" name="check_goodsBtn" value="상태 확인"/>
			<input type="button" class="btn btn-success" id="check_completeBtn" name="check_completeBtn" value="확인 완료"/>
			<input type="button" class="btn btn-danger" onclick="send_to_buyer();" name="buyer_sendBtn" value="판매자 문의"/>
		</div>
		<div id="btnDiv2">
			<select id="select_status" style="padding:3px;">
				<option value="3" ${cri.searchType == 'null' ? 'selected' : ''}>---------전체--------</option>
				<option value="0" ${cri.searchType == '0' ? 'selected' : ''}>신고 미처리</option>
				<option value="1" ${cri.searchType == '1' ? 'selected' : ''}>판매자 문의 중</option>
				<option value="2" ${cri.searchType == '2' ? 'selected' : ''}>판매자 처리 완료</option>
			</select>
		</div>
	</div>
	<div id="reportGoodsTableDiv">
		<table id="reportGoodsTable">
			<tr>
				<th>선택</th>
				<th>신고자ID</th>
				<th>신고상품</th>
				<th>신고내용</th>
				<th>신고날짜</th>
				<th>처리상태</th>
			</tr>
			<c:choose>
					<c:when test="${!empty reportGoodsList}">
						<c:forEach var="report" items="${reportGoodsList}">
						<tr>
							<td><input type="radio" name="reportGoods_radio"/><input type="hidden"  id="rgno" value="${report.rgv.rgno}"></td>
							<td>${report.reporterID}</td>
							<td data-gno="${report.rgv.gno}" data-buyer="${report.buyerID}">${report.goodsName}</td>
							<td>${report.rgv.reason}</td>
							<td><f:formatDate value="${report.rgv.report_date}" pattern="YYYY-MM-dd"/></td> 
							<td data-report_status="${report.rgv.report_status}">
								<c:if test="${report.rgv.report_status eq 0}">
									신고 미처리
								</c:if>
								<c:if test="${report.rgv.report_status eq 1}">
									판매자 문의 중
								</c:if>
								<c:if test="${report.rgv.report_status eq 2}">
									판매자 처리 완료
								</c:if>
							</td>
						</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:if test="${pageMaker.cri.searchType eq null}">
							<td colspan="6">신고한 상품이 없습니다.</td>
						</c:if>
						<c:if test="${pageMaker.cri.searchType eq 0}">
							<td colspan="6">신고한 상품이 없습니다.</td>
						</c:if>
						<c:if test="${pageMaker.cri.searchType eq 1}">
							<td colspan="6">문의 중인 상품이 없습니다</td>
						</c:if>
						<c:if test="${pageMaker.cri.searchType eq 2}">
							<td colspan="6">처리할 상품이 없습니다.</td>
						</c:if>
					</c:otherwise>
				</c:choose>
			
		</table>
	</div>
	<div class="paging">
		<ul class="pagination">
			<c:if test="${pageMaker.cri.page > 1}">
				<li><a
					href="reportGoods${pageMaker.search(pageMaker.cri.page - 1)}">&laquo;</a>
			</c:if>

			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
				var="i">
				<li>
					<a href="reportGoods${pageMaker.search(i)}" style="${pageMaker.cri.page == i ? 'color:red' : '' }">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker.cri.page < pageMaker.maxPage}">
				<li><a
					href="reportGoods${pageMaker.search(pageMaker.cri.page + 1)}">&raquo;</a>
			</c:if>
		</ul>
	</div>
	<div class="container modal" id="sendToBuyer">
		<!-- Modal -->
		<div role="dialog" class="modal-content position">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div>
					<div class="modal-header">
						<div class="modal-title">
							<h3>판매자 문의</h3>
						</div>
						<div class="modalCloseBtn" id="sendToBuyerCloseBtn">&times;</div>
						<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
					</div>
					<div class="modal-body">
						<table id="sendToBuyerTable">
							<tr>
								<th>판매자</th>
								<td id="reportID"></td>
							</tr>
							<tr>
								<th>상품명</th>
								<td id="goodsName"></td>
							</tr>
							<tr>
								<td colspan=2>
									<textarea id="reason" class="reason" placeholder="사유를 적어주세요." rows="10" cols="50"></textarea>
									<br />
									<span style="color:#25323e;font-size:13px;float:right" id="counter">(0 / 500자)</span>
								</td>
							</tr>
						</table>
						<div class="sendToBuyerCloseBtnDiv" id="sendBtn">
							<button type="button" class="btn btn-close">확인</button>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>
<script>
	$("#reportGoodsMenu").addClass("menu-background-color");
	
	$("#select_status").on("change",function(){
		var report_status = $("#select_status").val();
		console.log(report_status);
		if(report_status == 0) {
			location.href="reportGoods?searchType=0";
		}
		else if(report_status == 1) {
			location.href="reportGoods?searchType=1";
		}
		else if(report_status == 2) {
			location.href="reportGoods?searchType=2";
		}else if(report_status == 3) {	
			location.href="reportGoods";
		}
	});
	
	// 신고 상품 확인
	function check_goods(){
		var checked =  $("input[name='reportGoods_radio']").is(":checked");
		if(checked){
			var tdArr = getReportGoodsListRow();
			window.open('${pageContext.request.contextPath}/goods/detail?gno='+tdArr[3]);
		}else {
			alert("체크해주세요");
		}
	}
	
	// 신고 처리 완료
	$("#check_completeBtn").click(function(){
		var checked =  $("input[name='reportGoods_radio']").is(":checked");
		if(checked){
			var tdArr = getReportGoodsListRow();
			if(confirm("신고 완료처리하시겠습니까?")==true){
		 		var rgno = tdArr[0];
		 		console.log(rgno);
		 		var report_status = tdArr[7];
		 		console.log(report_status);
		 		if(report_status == 1){
		 			alert("아직 처리 중입니다.");
		 			return;
		 		}
		 		$.ajax({
		 			url: "deleteReportGoods/"+rgno,
		 			type: "delete",
		 			headers: {
		 				"X-HTTP-Override" : "DELETE"
		 			},
		 			success: function(data){
		 				location.href="reportGoods?page=${pageMaker.cri.page}&perPageNum=${pageMaker.cri.perPageNum}";
		 			}
		 		});
		 	}else {
		 		alert("취소되었습니다.");
		 		$("input[name='reportGoods_radio']").prop("checked",false);
		 	}
		}else {
			alert("체크해주세요");
		}
	});
	
	// 판매자 문의
	function send_to_buyer() {
		var checked =  $("input[name='reportGoods_radio']").is(":checked");
		if(checked){
			var tdArr = getReportGoodsListRow();
			var rgno = tdArr[0];
			var gno = tdArr[3];
			$.ajax({
				url: "getBuyerInfo/" + gno,
	 			type: "get",
	 			headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "GET"
				},
				success: function(data) {
					$("#reportID").html(data.buyerID);
					$("#goodsName").html(tdArr[2]);
					$("#sendToBuyer").css("display","flex");
				}
				
			});
			
			// 사유 작성 완료
			$("#sendBtn").click(function(){
				var buyerID = $("#reportID").html();
				var goodsName = $("#goodsName").html();
				var reason = $("#reason").val();
				if(reason == null || reason == "") {
					alert("문의사항을 작성해 주세요.");	
				}else {
					$.ajax({
						url: "sendBuyer/"+rgno,
			 			type: "patch",
			 			headers : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "PATCH"
						},
						data : JSON.stringify({
							buyerID,
							goodsName,
							reason
						}),
						success: function(data) {
							location.href="reportGoods?page=${pageMaker.cri.page}&perPageNum=${pageMaker.cri.perPageNum}";
						}
						
					});
				}
			});
			
		}else {
			alert("체크해주세요");
		}
	}
	
	//서류사항 textarea 체크
	$('.reason').keyup(function (e){
	    var content = $(this).val();
	    $('#counter').html("("+content.length+" / 500자)");    //글자수 실시간 카운팅

	    if (content.length > 500){
	        alert("최대 500자까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 500));
	        $('#counter').html("(500 / 500자)");
	    }
	});
	
	$("#sendToBuyerCloseBtn").click(function(){
		$("#sendToBuyer").css("display","none");
	});

	// 상품리스트 테이블 체크된 체크박스 값 가져오기
	function getReportGoodsListRow(){
		var tdArr = new Array();
		var radio = $("input[name='reportGoods_radio']:checked");
		var tr = radio.parent().parent();
		var td = tr.children();
		var	rgno = td.eq(0).find("#rgno").val();

		var reporterID = td.eq(1).text();

		var goodsName = td.eq(2).text();

		var gno = td.eq(2).data('gno');

		var buyerID = td.eq(2).data('buyer');

		var reason = td.eq(3).text();

		var report_date = td.eq(4).text();

		var report_status = td.eq(5).data('report_status');
	
		tdArr.push(rgno);
		tdArr.push(reporterID);
		tdArr.push(goodsName);
		tdArr.push(gno);
		tdArr.push(buyerID);
		tdArr.push(reason);
		tdArr.push(report_date);
		tdArr.push(report_status);
		return tdArr;
	}
</script>
</body>
</html>