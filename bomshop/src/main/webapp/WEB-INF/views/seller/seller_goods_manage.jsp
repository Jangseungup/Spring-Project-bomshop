<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="common/seller_header.jsp" %>

<style>
	div#goodsStatus{
		float : left;
		width : 80%;
	}
	
	div#goodsStatus table#goodsStatusInfo{
		margin: 20px 50px 40px 50px;
		border-collapse:collapse;
		width : 800px;
	}
	
	#goodsManagePage{
		float:left;
		width:800px;
		background-color:#e2e2e2;
		margin-left: 50px;
		height: 420px;
		border-radius: 10px;
	}
	
	div#goodsStatus #btnWrap {
		height:25px;
		margin-top:10px;
	}
	div#goodsStatus #btnDiv1 {
		margin-left:25px;
		float:left;
		width: 60%
	}
	div#goodsStatus #btnDiv2 {
		float:right;
		width: 20%;
	}
	div#goodsStatus #tableDiv {
		padding-top: 10px;
		width:96%;
		background-color:white;
		margin: 0 auto;
		margin-top: 15px;
		height: 320px;
		border-radius: 10px;
	}
	div#goodsStatus #tableDiv table{
		border-collapse: collapse;
		margin: 0 auto;
		width: 95%;
	}
	div#goodsStatus table tr th {
		border:1px solid lightgray;
		background-color: #e2e2e2;
		text-align: center;
	}
	div#goodsStatus table tr td {
		border:1px solid lightgray;
		text-align: center;
	}
	
	#goodsStatusInfo a{
		color : red;
	}
	
	table#goodsStatusInfo tr th{
		width: 159px;
	}
</style>

<div id="goodsStatus">
	<table id="goodsStatusInfo">
		<thead>
			<tr>
				<td style="border:0;text-align: left;">
					<h3>상품 관리</h3>
				</td>
			</tr>
			<tr>
				<th>전체</th>
				<th>판매중</th>
				<th>재고 10개 이하</th>
				<th>판매종료 7일전</th>
				<th>판매중지</th>
			</tr>
		</thead>
		<tr>
			<td>
				<a href="goods_manage">${totalGoodsCount}</a> 건
			</td>
			<td>
				<a href="goods_manage?searchType=sales">${salesCount}</a> 건
			</td>
			<td>
				<a href="goods_manage?searchType=soldOut">${soldOutCount}</a> 건
			</td>
			<td>
				<a href="goods_manage?searchType=goodsExpiration">${goodsExpirationCount}</a> 건
			</td>
			<td>
				<a href="goods_manage?searchType=discontinued">${discontinuedCount}</a> 건
			</td>
		</tr>
	</table>
	
	<div id="goodsManagePage">
		<div id="btnWrap">
			<div id="btnDiv1">
				<input type="button" id="changeStatusBtn" class="btn btn-primary" value="판매상태 변경"/>
				<input type="button" id="extendSdateBtn" class="btn btn-primary" value="기간연장"/>
				<input type="button" id="countChangeBtn" class="btn btn-primary" value="재고변경"/>
				<input type="button" id="removeGoodsBtn" class="btn btn-danger" value="상품삭제"/>
			</div>
			<div id="btnDiv2">
				<input type="button" id="goodsModifyBtn" class="btn btn-primary" value="퍈매 상품정보 수정"/>
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
						<th style="width:90px;">상품번호</th>
						<th>상품명</th>
						<th>판매상태</th>
						<th>판매가격</th>
						<th>판매종료일</th>
					</tr>
				</thead>
				<c:choose>
					<c:when test="${!empty goodsList}">
						<c:forEach items="${goodsList}" var="goods">
							<tr>
								<td>
									<input type="radio" name="goods_radio"/>
								</td>
								<td>
									${goods.gno}
								</td>
								<td>
									${goods.gname_ko}
								</td>
								<td>
									<c:choose>	
										<c:when test="${goods.gstatus eq 'Y'}">
											판매중
										</c:when>
										<c:otherwise>
											판매중지
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:choose>	
										<c:when test="${!empty goods.cost}">
											${goods.cost}
										</c:when>
										<c:otherwise>
											${goods.cost_origin}
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<f:formatDate value="${goods.sdate}" pattern="yyyy년 MM월 dd일"/>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<th colspan=6>등록된 상품이 없습니다.</th>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
		
		<div id="pagination">
			<c:if test="${pageMaker.prev}">
				<a href="goods_manage${pageMaker.search(pageMaker.startPage-1)}">&laquo;</a>
			</c:if>
			<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<c:choose>
					<c:when test="${pageMaker.cri.page eq i}">
						<b style="color:red">${i}</b>
					</c:when>
					<c:otherwise>
						<a href="goods_manage${pageMaker.search(i)}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<a href="goods_manage${pageMaker.search(pageMaker.endPage+1)}">&raquo;</a>
			</c:if>
		</div>
		
	</div>
</div>
</div>

<!-- 판매상태변경 버튼 클릭시 띄울 modal -->
<div id="changeStatusModal" class="modal">
	<div class="modal-content">
		<form action="changeStatus" method="post" id="changeStatusForm">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}"/>
			<table>
				<tr>
					<td><label>상품번호</label></td>
					<td>
						<input type="text" class="form-control" id="changeStatusGno" name="gno" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>상품명</label></td>
					<td>
						<input type="text" class="form-control" id="changeStatusGname" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>판매상태</label></td>
					<td>
						<input type="text" class="form-control" id="changeStatusValue" name="gstatusValue" readonly/>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="button" id="changeStatusSubmitBtn" class="btn btn-success" value="상태변경"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="changeStatusCancelBtn" class="btn btn-danger" value="닫기"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>

<!-- 기간연장 버튼 클릭시 띄울 modal -->
<div id="extendSdateModal" class="modal">
	<div class="modal-content">
		<form action="extendSdate" method="post" id="extendSdateForm">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}"/>
			<table>
				<tr>
					<td><label>상품번호</label></td>
					<td>
						<input type="text" name="gno" id="extendSdateGno" class="form-control" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>상품명</label></td>
					<td>
						<input type="text" id="extendSdateGname" class="form-control" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>추가일수</label></td>
					<td>
						<select name="addDate" class="input-sm">
							<option value="7">7</option>
							<option value="15">15</option>
							<option value="30">30</option>
							<option value="90">90</option>
						</select>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="button" id="extendSdateSubmitBtn" class="btn btn-success" value="기간수정"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="extendSdateCancelBtn" class="btn btn-danger" value="닫기"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>

<!-- 수량변경 버튼 클릭시 띄울 modal -->
<div id="countChangeModal" class="modal">
	<div class="modal-content">
		<form action="countChange" method="post" id="countChangeForm">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}"/>
			<table>
				<tr>
					<td><label>상품번호</label></td>
					<td>
						<input type="text" id="countChangeGno" class="form-control" name="gno" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>상품명</label></td>
					<td>
						<input type="text" id="countChangeGname" class="form-control" readonly/>
					</td>
				</tr>
			</table>
			<table id="ccOptionTbl">
				<thead>
					<tr>
						<th>사이즈</th>
						<th>색상</th>
						<th>수량</th>
					</tr>
				</thead>
			</table>
			<table>
				<tr>
					<td>
						<input type="button" id="countChangeSubmitBtn" class="btn btn-success" value="재고량 수정"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="countChangeCancelBtn" class="btn btn-danger" value="닫기"/>		
					</td>
				</tr>
			</table>
			
		</form>
	</div>
</div>

<!-- 상품삭제 버튼 클릭시 띄울 modal -->
<div id="removeGoodsModal" class="modal">
	<div class="modal-content">
		<form action="removeGoods" method="post" id="removeGoodsForm">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}"/>
			<table>
				<tr>
					<td><label>상품번호</label></td>
					<td>
						<input type="text" name="gno" id="removeGoodsGno" class="form-control" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>상품명</label></td>
					<td>
						<input type="text" id="removeGoodsGname" class="form-control" readonly/>
					</td>
				</tr>
				<tr>
					<th colspan="2" style="color:red;">
						상품 삭제시 취소할수 없습니다.
					</th>
				</tr>
				<tr>
					<th colspan="2">
						<input type="button" id="removeGoodsSubmitBtn" class="btn btn-success" value="상품삭제"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="removeGoodsCancelBtn" class="btn btn-danger" value="닫기"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>

<script>
	$("#menu_gm").addClass("currentPage");
	
	if("${message}" != null && "${message}" != ""){
		alert("${message}");
	}
	
	//	상태변경 버튼 클릭
	$("#changeStatusBtn").click(function(){
		if(checkRadio()){
			var gno = $("input[type='radio']:checked").parent().parent().children().eq(1).text();
			var gname = $("input[type='radio']:checked").parent().parent().children().eq(2).text();
			var gstatus = $("input[type='radio']:checked").parent().parent().children().eq(3).text();
			$("#changeStatusGno").val($.trim(gno));
			$("#changeStatusGname").val($.trim(gname));
			$("#changeStatusValue").val($.trim(gstatus));	
			$("#changeStatusModal").css("display","flex");
		}
	});
	//	modal 상태변경 확인 버튼 클릭
	$("#changeStatusSubmitBtn").click(function(){
		$("#changeStatusModal").css("display","none");
		$("#changeStatusForm").submit();
	});
	//	modal 상태변경 취소 버튼 클릭
	$("#changeStatusCancelBtn").click(function(){
		$("#changeStatusModal").css("display","none");
	});

	
	//	기간연장 버튼 클릭
	$("#extendSdateBtn").click(function(){
		//	라디오 버튼 클릭이 되었는지 체크
		if(checkRadio()){
			var gno = $("input[type='radio']:checked").parent().parent().children().eq(1).text();
			var gname = $("input[type='radio']:checked").parent().parent().children().eq(2).text();
			$("#extendSdateGno").val($.trim(gno));
			$("#extendSdateGname").val($.trim(gname));
			$("#extendSdateModal").css("display","flex");
		}
	});	
	//	modal 기간수정 버튼 클릭
	$("#extendSdateSubmitBtn").click(function(){
		$("#extendSdateModal").css("display","none");
		$("#extendSdateForm").submit();
	});	
	//	modal 기간수정 취소 버튼 클릭
	$("#extendSdateCancelBtn").click(function(){
		$("#extendSdateModal").css("display","none");
	});
	
	
	//	수량수정 버튼 클릭
	$("#countChangeBtn").click(function(){
		//	라디오 버튼 클릭이 되었는지 체크
		if(checkRadio()){
			var gno = $("input[type='radio']:checked").parent().parent().children().eq(1).text();
			var gname = $("input[type='radio']:checked").parent().parent().children().eq(2).text();
			$("#countChangeGno").val($.trim(gno));
			$("#countChangeGname").val($.trim(gname));
			
			//	비동기로 옵션정보값 불러오기(no page)
			$.getJSON("${path}/seller/getOptionList/"+$.trim(gno),function(data){
				//	data == Map<String,Object>
				//	data.list = List<CommentVO>
				//	data.pageMaker = PageMaker
			
				var str = "";
				$(data.list).each(function(){
					str += "<tr>";
					str += "<td>";
					str += "<input type='hidden' name='ono' value='"+this.ono+"'/>";
					str += "<input type='text' name='size' class='form-control fc-sm' value='"+this.size+"' readonly/>";
					str += "</td>";
					str += "<td>";
					str += "<input type='text' name='color' class='form-control fc-sm' value='"+this.color+"' readonly/>";
					str += "</td>";
					str += "<td>";
					str += "<input type='text' name='count' class='form-control fc-sm' value='"+this.count+"'/>";
					str += "</td>";
					str += "</tr>";
				});
				$("#ccOptionTbl").append(str);	
			});
			$("#countChangeModal").css("display","flex");
		}
	});	
	//	modal 수량수정 버튼 클릭
	$("#countChangeSubmitBtn").click(function(){
		
		$("#countChangeModal").css("display","none");
		$("#countChangeForm").submit();
		$("#ccOptionTbl").children().eq(1).remove();
	});	
	//	modal 수량수정 취소 버튼 클릭
	$("#countChangeCancelBtn").click(function(){
		$("#countChangeModal").css("display","none");
		$("#ccOptionTbl").children().eq(1).remove();
	});
	
	
	//	상품 삭제 버튼 클릭
	$("#removeGoodsBtn").click(function(){
		//	라디오 버튼 클릭이 되었는지 체크
		if(checkRadio()){
			var gno = $("input[type='radio']:checked").parent().parent().children().eq(1).text();
			var gname = $("input[type='radio']:checked").parent().parent().children().eq(2).text();
			var status = $.trim($("input[type='radio']:checked").parent().parent().children().eq(3).text());
			if(status == '판매중'){
				alert("판매 중인 상품은 삭제 할 수 없습니다.");
				return;
			}
			$("#removeGoodsGno").val($.trim(gno));
			$("#removeGoodsGname").val($.trim(gname));
			$("#removeGoodsModal").css("display","flex");
		}
	});	
	//	modal 수량수정 버튼 클릭
	$("#removeGoodsSubmitBtn").click(function(){
		$("#removeGoodsModal").css("display","none");
		$("#removeGoodsForm").submit();
	});	
	//	modal 수량수정 취소 버튼 클릭
	$("#removeGoodsCancelBtn").click(function(){
		$("#removeGoodsModal").css("display","none");
	});
	
	//	판매 상품정보 수정 버튼 클릭
	$("#goodsModifyBtn").click(function(){
		if(checkRadio()){
			var gno = $.trim($("input[type='radio']:checked").parent().parent().children().eq(1).text());
			var status = $.trim($("input[type='radio']:checked").parent().parent().children().eq(3).text());
			if(status == '판매중'){
				alert("판매 중인 상품은 수정 할 수 없습니다.");
				return;
			}
			location.href="goodsModify?gno="+gno;
		}
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