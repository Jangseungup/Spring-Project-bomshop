<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="common/seller_header.jsp" %>

<style>
	div#settlementStatus{
		float : left;
		width : 80%;
	}
	
	div#settlementStatus table#settlementStatusInfo{
		margin: 20px 50px 40px 50px;
		border-collapse:collapse;
		width : 800px;
	}
	
	#settlementManagePage{
		float:left;
		width:800px;
		background-color:#e2e2e2;
		margin-left: 50px;
		height: 420px;
		border-radius: 10px;
	}
	
	div#settlementStatus #btnWrap {
		height:25px;
		margin-top:10px;
	}
	div#settlementStatus #btnDiv1 {
		margin-left:25px;
		float:left;
		width: 60%
	}
	div#settlementStatus #btnDiv2 {
		float:right;
		width: 20%;
	}
	div#settlementStatus #tableDiv {
		padding-top: 10px;
		width:96%;
		background-color:white;
		margin: 0 auto;
		margin-top: 15px;
		height: 320px;
		border-radius: 10px;
	}
	div#settlementStatus #tableDiv table{
		border-collapse: collapse;
		margin: 0 auto;
		width: 95%;
	}
	div#settlementStatus table tr th {
		border:1px solid lightgray;
		background-color: #e2e2e2;
		text-align: center;
	}
	div#settlementStatus table tr td {
		border:1px solid lightgray;
		text-align: center;
	}
	
	table#settlementStatusInfo tr th{
		width: 199px;
	}
	
	table.history{
		text-align: center;
		border-collapse: collapse;
	}
	table.history thead tr th{
		border-top:1px solid lightgray;
		border-bottom:1px solid lightgray;
		background-color: #e2e2e2;
		padding: 5px;		
	}
	table.history tr td{
		padding: 5px;
		border-bottom:1px solid lightgray;		
	}
</style>

<div id="settlementStatus">
	<table id="settlementStatusInfo">
		<thead>
			<tr>
				<td style="border:0;text-align: left;">
					<h3>정산 관리</h3>
				</td>
			</tr>
			<tr>
				<th>정산예정 주문</th>
				<th>정산예정 금액</th>
				<th>금고보유액</th>
			</tr>
		</thead>
		<tr>
			<td>${unsettledCount} 건</td>
			<td><f:formatNumber pattern="#,###" value="${unsettledAmount}"/> 원</td>
			<td><f:formatNumber pattern="#,###" value="${holdingAmount}"/> 원</td>
		</tr>
	</table>
	
	<div id="settlementManagePage">
		<div id="btnWrap">
			<div id="btnDiv1">
				<input type="button" class="btn btn-warning" id="withdrawBtn" value="출금하기"/>
				<input type="button" class="btn btn-success" id="downloadExcelBtn" value="엑셀출력"/>
			</div>
			<div id="btnDiv2">
				<input type="button" class="btn btn-primary" id="settlementHistoryBtn" value="월별 정산내역 보기"/>
			</div>
		</div>
		<div id="tableDiv">
			<table id="settlementInfoTbl">
				<thead>
					<tr>
						<td style="border:0;background-color:#82b3ed;border-radius:5px 5px 0 0;">
							<label id="subTitle">미정산 리스트</label>
						</td>
					</tr>
					<tr>
						<th style="width:120px;">주문번호</th>
						<th>상품명</th>
						<th>색상</th>
						<th>사이즈</th>
						<th>수량</th>
						<th>가격</th>
						<th>구매완료일</th>
					</tr>
				</thead>
				<c:choose>
					<c:when test="${!empty settlementList}">
						<c:forEach var="settlement" items="${settlementList}">
							<tr>
								<td>${settlement.order.orderno}</td>
								<td>${settlement.gname}</td>
								<td>${settlement.option.color}</td>
								<td>${settlement.option.size}</td>
								<td>${settlement.order.count}</td>
								<td>${settlement.order.price}</td>
								<td><f:formatDate pattern="yyyy년 MM월 dd일" value="${settlement.order.order_com_date}"/></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<td colspan="7" style="text-align:center;">
							<label>미정산 리스트가 없습니다.</label>
						</td>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
		
		<div id="pagination">
			<c:if test="${pageMaker.prev}">
				<a href="settlement_manage${pageMaker.search(pageMaker.startPage-1)}">&laquo;</a>
			</c:if>
			<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<c:choose>
					<c:when test="${pageMaker.cri.page eq i}">
						<b style="color:red">${i}</b>
					</c:when>
					<c:otherwise>
						<a href="settlement_manage${pageMaker.search(i)}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<a href="settlement_manage${pageMaker.search(pageMaker.endPage+1)}">&raquo;</a>
			</c:if>
		</div>
		
	</div>
</div>
</div>

<!-- 출금신청 버튼 클릭시 띄울 modal -->
<div id="withdrawModal" class="modal">
	<div class="modal-content">
		<form action="withdraw" method="post" id="withdrawForm">
			<h3>출금 신청</h3>
			<table>
				<tr>
					<td>은행</td>
					<td>
						<input type="text" name="bank" id="bank" class="form-control" value="${memberInfo.bankname}" required/>
					</td>
				</tr>
				<tr>
					<td>계좌번호</td>
					<td>
						<input type="text" name="account" id="account" class="form-control" value="${memberInfo.maccount}" required/>
					</td>
				</tr>
				<tr>
					<td>계좌주</td>
					<td>
						<input type="text" name="name" id="name" class="form-control" required/>
					</td>
				</tr>
				<tr>
					<td>환전금액</td>
					<td>
						<input type="number" name="money" min="0" max="${holdingAmount}" id="money" class="form-control" required/>
					</td>
				</tr>
				<tr>
					<td>환전비밀번호</td>
					<td>
						<input type="password" name="pass" id="pass" class="form-control" required/>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="button" id="withdrawSubmitBtn" class="btn btn-success" value="출금신청"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="withdrawCancleBtn" class="btn btn-danger" value="닫기"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>

<!-- 정산내역조회 버튼 클릭시 띄울 modal -->
<div id="downloadExcelModal" class="modal">
	<div class="modal-content">
		<form action="downloadExcel" method="post" id="downloadExcelForm">
			<h3>엑셀 다운로드</h3>
			<div style="text-align: center; margin:20px;">
				<select class="input-sm" id="downloadSelect">
					<option value="none">--------</option>
				</select>
				&nbsp;&nbsp;&nbsp;
				<input type="button" id="downloadExcelSubmitBtn" class="btn btn-success" value="다운받기"/>
				&nbsp;&nbsp;&nbsp;
				<input type="button" id="downloadExcelCancelBtn" class="btn btn-danger" value="닫기"/>
			</div>
		</form>
	</div>
</div>

<!-- 정산내역조회 버튼 클릭시 띄울 modal -->
<div id="settlementHistoryModal" class="modal">
	<div class="modal-content">
		<form action="settlementHistory" method="post" id="settlementHistoryForm">
			<h3>월별 정산내역 보기</h3>
			<div style="text-align: center; margin:20px;">
				<select class="input-sm" id="historySelect">
					<option value="none">--------</option>
				</select>
				&nbsp;&nbsp;&nbsp;
				<input type="button" id="settlementHistorySubmitBtn" class="btn btn-success" value="조회하기"/>
				&nbsp;&nbsp;&nbsp;
				<input type="button" id="settlementHistoryCancelBtn" class="btn btn-danger" value="닫기"/>
			</div>
			<!-- 정산내역 historyList -->
			<div id="historyDiv">
				
			</div>
			<!-- pagination -->
			<div id="historypm" style="text-align: center;">
				
			</div>
		</form>
	</div>
</div>

<form action="testSettlementHistoty" id="testSettlementHistotyForm">
</form>


<script>
	var withdrawMessage = '${withdrawMessage}';
	console.log(withdrawMessage);
	
	if(withdrawMessage != ''){
		alert(withdrawMessage);
	}

	$("#menu_sm").addClass("currentPage");
	//	환전신청 버튼 클릭
	$("#withdrawBtn").click(function(){
		$("#account").val("");
		$("#name").val("");
		$("#money").val("");
		$("#pass").val("");
		$("#withdrawModal").css("display","flex");
	});
	//	modal 환전신청 버튼 클릭
	$("#withdrawSubmitBtn").click(function(){
		//	submit 하기전에 입력내용 확인(금액 등)
		var boolAccount = false;
		var boolName = false;
		var boolMoney = false;
		var boolPass = false;
		
  		var holdingAmount = Number('${holdingAmount}');
		var money = Number($("#money").val());
		
		if($("#account").val() != ""){
			boolAccount = true;
		}
		if($("#name").val() != ""){
			boolName = true;
		}
		if(money < 1000){
			alert('잘못된 금액입니다.');
			$("#money").val("0");
			return;
		}else if(money > holdingAmount){
			alert('금고보유액 보다 큰 금액은 환전할 수 없습니다.');
			$("#money").val(holdingAmount);
			return;
		}else if(money != ""){
			boolMoney = true;
		}
		if($("#pass").val() != ""){
			boolPass = true;
		}
		
		if(!boolAccount){
			alert("계좌번호를 확인해주세요.");
			$("#account").focus();
		}else if(!boolName){
			alert("이름을 확인해주세요");
			$("#name").focus();
		}
		else if(!boolMoney){
			alert("금액을 확인해주세요");
			$("#money").focus();
		}			
		else if(!boolPass){
			alert("비밀번호를 확인해주세요");
			$("#pass").focus();
		}else{
			$("#withdrawModal").css("display","none");
			$("#withdrawForm").submit();	
		}
	});
	//	modal 환전신청 취소 버튼 클릭
	$("#withdrawCancleBtn").click(function(){
		$("#withdrawModal").css("display","none");
	});
	
	//	월별 정산내역보기 버튼 클릭
	$("#settlementHistoryBtn").click(function(){
		$("#settlementHistoryModal").css("display","flex");
		$.get("settlementHistotyOpen", function(monthList){
			var str = "";
			str += "<option value='none' selected disabled>-----------</option>"
			for(var i = 0; i < monthList.length; i++){
				str += "<option value='"+monthList[i]+"'>";
				str += monthList[i]+"</option>";
			}
			$("#historySelect").html(str);
		});
	});
	//	modal 정산내역보기 조회하기 버튼 클릭
	$("#settlementHistorySubmitBtn").click(function(){
		var selectValue = $("#historySelect").val();
		gethistoryList(1, selectValue);
	});
	//	값 불러오기
	function gethistoryList(page, selectValue){
		$.get("getSettlementHistoty",{page, perPageNum:10, searchType:selectValue},function(data){
			printList(data.historyList, data.settlementPageMaker.cri.searchType, data.totalAmount);
			printPagination(data.settlementPageMaker);
		});
	}
	//	modal 정산내역보기 취소 버튼 클릭
	$("#settlementHistoryCancelBtn").click(function(){
		$("#settlementHistoryModal").css("display","none");
		$("#historyDiv").html("");
		$("#historypm").html("");
	});
	//	월정산내역 그리기
	function printList(historyList, searchType, totalAmount){
		var str = "";
		str += "<table class='history'>";
		str += "<thead>";
		str += "<tr>";
		str += "<th>날짜</th>";
		str += "<th>주문번호</th>";
		str += "<th>상품명</th>";
		str += "<th>색상</th>";
		str += "<th>사이즈</th>";
		str += "<th>수량</th>";
		str += "<th>가격</th>";
		str += "</tr>";
		str += "</thead>";
		$(historyList).each(function(){
			str += "<tr>";
			str += "<td>";
			str += getDate(this.order.order_com_date);
			str += "</td>";
			str += "<td>";
			str += this.order.orderno;
			str += "</td>";
			str += "<td>";
			str += this.gname;
			str += "</td>";
			str += "<td>";
			str += this.option.color;
			str += "</td>";
			str += "<td>";
			str += this.option.size;
			str += "</td>";
			str += "<td>";
			str += this.order.count;
			str += "</td>";
			str += "<td>";
			str += this.order.price;
			str += "</td>";
			str += "</tr>";
		});
		str += "<tr>";
		str += "<td colspan=6 style='text-align:right;'>";
		str += searchType + " 총 판매액 : ";
		str += "</td>";
		str += "<td style='color:red;'>";
		str += "<label>"+totalAmount+"</label>";
		str += "</td>";
		str += "</tr>";
		str += "</table>";
		$("#historyDiv").html(str);
	}
	//	정산내역용 pagination
	function printPagination(pm){
		var str = "";
		if(pm.prev){
			str += "<a href='javascript:void(0);' onclick='gethistoryList("+(pm.startPage-1)+",\""+encodeURI(pm.cri.searchType)+"\")';>&laquo;</a>";
			str += "&nbsp;&nbsp;";
		}
		for(var i=pm.startPage; i<=pm.endPage;i++){
			if(i == pm.cri.page){
				str += "<b style='color:red'>"+i+"</b>";
			}else{
				str += "<a href='javascript:void(0);' onclick='gethistoryList("+i+",\""+encodeURI(pm.cri.searchType)+"\")';>"+i+"</a>";
			}
			str += "&nbsp;&nbsp;";
		}
		if(pm.next){
			str += "<a href='javascript:void(0);' onclick='gethistoryList("+(pm.endPage+1)+",\""+encodeURI(pm.cri.searchType)+"\")';>&raquo;</a>";
		}
		$("#historypm").html(str);
	}
	//	날짜 세팅
	function getDate(date){
		var order_date = new Date(date);
		var year = order_date.getFullYear();
		var month = order_date.getMonth()+1;
		var day = order_date.getDate();
		return year+"/"+month+"/"+day;
	}
	
	//	엑셀 다운로드 버튼 클릭
	$("#downloadExcelBtn").click(function(){
		$("#downloadExcelModal").css("display","flex");
		$.get("settlementHistotyOpen", function(monthList){
			var str = "";
			str += "<option value='none' selected disabled>-----------</option>"
			for(var i = 0; i < monthList.length; i++){
				str += "<option value='"+monthList[i]+"'>";
				str += monthList[i]+"</option>";
			}
			$("#downloadSelect").html(str);
		});
	});
	//	modal 정산내역보기 조회하기 버튼 클릭
	$("#downloadExcelSubmitBtn").click(function(){
		var selectValue = $("#downloadSelect").val();
		$("#downloadExcelModal").css("display","none");
		$.get("downloadExcel",{searchType:selectValue},function(){
			alert('C:\\Temp\\' + selectValue + ".Xlsx 다운이 완료되었습니다.");
		});
	});
	//	modal 정산내역보기 취소 버튼 클릭
	$("#downloadExcelCancelBtn").click(function(){
		$("#downloadExcelModal").css("display","none");
	});
</script>

</body>
</html>