<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="common/seller_header.jsp" %>

<style>
	div#advertisingStatus{
		float : left;
		width : 80%;
	}
	
	div#advertisingStatus table#advertisingStatusInfo{
		margin: 20px 50px 40px 50px;
		border-collapse:collapse;
		width : 800px;
	}
	
	#advertisingManagePage{
		float:left;
		width:800px;
		background-color:#e2e2e2;
		margin-left: 50px;
		height: 420px;
		border-radius: 10px;
	}
	
	div#advertisingStatus #btnWrap {
		height:25px;
		margin-top:10px;
	}
	div#advertisingStatus #btnDiv1 {
		margin-left:25px;
		float:left;
		width: 60%
	}
	div#advertisingStatus #btnDiv2 {
		float:right;
		width: 20%;
	}
	div#advertisingStatus #tableDiv {
		padding-top: 10px;
		width:96%;
		background-color:white;
		margin: 0 auto;
		margin-top: 15px;
		height: 320px;
		border-radius: 10px;
	}
	div#advertisingStatus #tableDiv table{
		border-collapse: collapse;
		margin: 0 auto;
		width: 95%;
	}
	div#advertisingStatus table tr th {
		border:1px solid lightgray;
		background-color: #e2e2e2;
		text-align: center;
	}
	div#advertisingStatus table tr td {
		border:1px solid lightgray;
		text-align: center;
	}
	
	table#advertisingStatusInfo tr th{
		width: 199px;
	}
	
	table.advertise{
		text-align: center;
		border-collapse: collapse;
	}
	table.advertise thead tr th{
		border-top:1px solid lightgray;
		border-bottom:1px solid lightgray;
		background-color: #e2e2e2;
		padding: 5px;		
	}
	table.advertise tr td{
		padding: 5px;
		border-bottom:1px solid lightgray;		
	}
	table#advertisingStatusInfo a{
		color : red;
	}
</style>

<div id="advertisingStatus">
	<table id="advertisingStatusInfo">
		<thead>
			<tr>
				<td style="border:0;text-align: left;">
					<h3>광고 관리</h3>
				</td>
			</tr>
			<tr>
				<th>전체</th>
				<th>광고중</th>
				<th>광고마감 3일전</th>
				<th>승인대기</th>
			</tr>
		</thead>
		<tr>
			<td><a href="advertising_request">${totalCount}</a> 건</td>
			<td><a href="advertising_request?searchType=advertising">${advertisingCount}</a> 건</td>
			<td><a href="advertising_request?searchType=advertisingEnd">${advertisingEndCount}</a> 건</td>
			<td><a href="advertising_request?searchType=awaiting">${awaitingAdvertisingCount}</a> 건</td>
		</tr>
	</table>
	
	<div id="advertisingManagePage">
		<div id="btnWrap">
			<div id="btnDiv1">
				<input type="button" class="btn btn-primary" id="goodsListForADBtn" value="광고신청"/>
				<input type="button" class="btn btn-danger" id="cancelADBtn" value="신청취소"/>
			</div>
		</div>
		<div id="tableDiv">
			<table>
				<thead>
					<tr>
						<td style="border:0;background-color:#82b3ed;border-radius:5px 5px 0 0;" colspan="2">
							<label id="subTitle">${subTitle}</label>
						</td>
					</tr>
					<tr>
						<th style="width:60px;">선택</th>
						<th style="width:90px;">신청번호</th>
						<th>상품번호</th>
						<th>상품명</th>
						<th>상태</th>
						<th>신청일(광고 종료일)</th>
						<th>배너 사진</th>
					</tr>
				</thead>
				<c:choose>
					<c:when test="${!empty advertisingList}">
						<c:forEach items="${advertisingList}" var="advertise">
							<tr>
								<td>
									<input type="radio" name="goods_radio"/>
								</td>
								<td>
									${advertise.ano}
								</td>
								<td>
									${advertise.gno}
								</td>
								<td>
									${advertise.gname_ko}
								</td>
								<td>
									<c:choose>	
										<c:when test="${advertise.astatus eq 0}">
											신청 대기
										</c:when>
										<c:otherwise>
											광고 중
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<f:formatDate value="${advertise.adate}" pattern="yyyy년 MM월 dd일"/>
								</td>
								<td>
									<input type="button" class="btn btn-primary btn-sm viewPictureBtn" value="사진보기"/>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan=7><b>광고 신청한 상품이 없습니다.</b></td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
		
		<div id="pagination">
			<c:if test="${pageMaker.prev}">
				<a href="advertising_request${pageMaker.search(pageMaker.startPage-1)}">&laquo;</a>
			</c:if>
			<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<c:choose>
					<c:when test="${pageMaker.cri.page eq i}">
						<b style="color:red">${i}</b>
					</c:when>
					<c:otherwise>
						<a href="advertising_request${pageMaker.search(i)}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<a href="advertising_request${pageMaker.search(pageMaker.endPage+1)}">&raquo;</a>
			</c:if>
		</div>
		
	</div>
</div>
</div>

<!-- 광고신청 버튼 클릭시 띄울 modal -->
<div id="goodsListForADModal" class="modal">
	<div class="modal-content">
		<h3>판매중인 상품 내역</h3>
		<div style="text-align: center; margin:20px;">
			&nbsp;&nbsp;&nbsp;
			<input type="button" id="goodsListForADSubmitBtn" class="btn btn-primary" value="선택"/>
			&nbsp;&nbsp;&nbsp;
			<input type="button" id="goodsListForADCancelBtn" class="btn btn-danger" value="닫기"/>
		</div>
		<!-- 판매상품내역 salesListDiv -->
		<div id="goodsListDiv">
			
		</div>
		<!-- pagination (goodsListPageMaker) -->
		<div id="goodsListpm" style="text-align: center;">
			
		</div>
	</div>
</div>

<!-- 광고신청-신청하기 버튼 클릭시 띄울 modal -->
<div id="applicationADModal" class="modal">
	<div class="modal-content">
		<form action="applicationAD" method="post" id="applicationADForm" enctype="multipart/form-data">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}"/>
			<h3></h3>
				<table>
				<tr>
					<td><label>상품번호</label></td>
					<td>
						<input type="text" name="gno" id="applicationADGno" class="form-control" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>상품명</label></td>
					<td>
						<input type="text" id="applicationADGname" class="form-control" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>배너 사진</label></td>
					<td>
						<input type="file" class="form-control" id="applicationADFile" name="file" accept=".png"/>
					</td>
				</tr>
				<tr>
					<th colspan="2" style="color:red;">
						1300*400 크기의 PNG 파일만 사용 가능(10MB 미만)
					</th>
				</tr>
				<tr>
					<th colspan=2>
						<input type="button" id="applicationADSubmitBtn" class="btn btn-success" value="신청하기"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="applicationADCancelBtn" class="btn btn-danger" value="닫기"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>	

<!-- 취소하기 버튼 클릭시 띄울 modal -->
<div id="cancelADModal" class="modal">
	<div class="modal-content">
		<h3>판매중인 상품 내역</h3>
		<form action="cancelAD" method="post" id="cancelADForm">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}"/>
			<table>
				<tr>
					<td><label>신청번호</label></td>
					<td>
						<input type="text" name="ano" id="cancelADAno" class="form-control" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>상품번호</label></td>
					<td>
						<input type="text" name="gno" id="cancelADGno" class="form-control" readonly/>
					</td>
				</tr>
				<tr>
					<td><label>상품명</label></td>
					<td>
						<input type="text" id="cancelADGname" class="form-control" readonly/>
					</td>
				</tr>
				<tr>
					<th colspan="2" style="color:red;">
						상품 삭제시 취소할수 없습니다.
					</th>
				</tr>
				<tr>
					<th colspan=2>
						<input type="button" id="cancelADSubmitBtn" class="btn btn-success" value="취소하기"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="cancelADCancelBtn" class="btn btn-danger" value="닫기"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>

<!-- 배너사진 보기 버튼 클릭시 띄울 modal -->
<div id="viewPictureModal" class="modal">
	<div class="modal-content">
		<img src="" id="bannerImg"/>
	</div>
</div>

<script>
	$("#menu_ar").addClass("currentPage");
	
	if('${uploadMessage}' != ""){
		alert('${uploadMessage}');
	}
	
	//	광고신청 버튼 클릭
	$("#goodsListForADBtn").click(function(){
		$.get("getGoodsListForAD",function(data){
			var str = "";
			str += "<table class='advertise'>";
			str += "<thead>";
			str += "<tr>";
			str += "<th>선택</th>";
			str += "<th>상품번호</th>";
			str += "<th>상품명</th>";
			str += "</tr>";
			str += "</thead>";
			$(data.goodsList).each(function(){
				str += "<tr>";
				str += "<td>";
				str += "<input type='radio' name='goodsForAD' class='goodsForAD'/>";
				str += "</td>";
				str += "<td>"+this.gno+"</td>";
				str += "<td>"+this.gname_ko+"</td>";
				str += "</tr>";				
			});
			str += "</table>";
			$("#goodsListDiv").html(str);
		});
		$("#goodsListForADModal").css("display","flex");
	});
	//	modal 광고신청 신청하기 버튼 클릭
	$("#goodsListForADSubmitBtn").click(function(){
		if(checkADRadio()){
			var gno = $(".goodsForAD:checked").parent().parent().children().eq(1).text();
			var gname = $(".goodsForAD:checked").parent().parent().children().eq(2).text();
			$("#goodsListForADModal").css("display","none");
			$("#applicationADGno").val(gno);
			$("#applicationADGname").val(gname);
			$("#applicationADModal").css("display","flex");
		}
	});
	//	modal 광고신청 닫기 버튼 클릭
	$("#goodsListForADCancelBtn").click(function(){
		$("#goodsListForADModal").css("display","none");
	});
	//	modal 신청확인 신청 버튼 클릭
	$("#applicationADSubmitBtn").click(function(){
		$("#applicationADModal").css("display","none");
		$("#applicationADForm").submit();
	});
	//	modal 신청확인 닫기 버튼 클릭
	$("#applicationADCancelBtn").click(function(){
		$("#applicationADModal").css("display","none");
	});
	
	//	신청취소 버튼 클릭
	$("#cancelADBtn").click(function(){
		if(checkRadio()){
			var ano = $.trim($("input[type='radio']:checked").parent().parent().children().eq(1).text());
			var gno = $.trim($("input[type='radio']:checked").parent().parent().children().eq(2).text());
			var gname = $.trim($("input[type='radio']:checked").parent().parent().children().eq(3).text());
			var astatus = $.trim($("input[type='radio']:checked").parent().parent().children().eq(4).text());
			$("#cancelADAno").val(ano);
			$("#cancelADGno").val(gno);
			$("#cancelADGname").val(gname);
			console.log(astatus);
			if(astatus != '신청 대기'){
				alert('광고 중인 상품은 취소 할 수 없습니다.');
				return;
			}
			$("#cancelADModal").css("display","flex");	
		}		
	});
	//	modal 신청취소 취소하기 버튼 클릭
	$("#cancelADSubmitBtn").click(function(){
		$("#cancelADModal").css("display","none");
		$("#cancelADForm").submit();
	});
	//	modal 신청취소 닫기 버튼 클릭
	$("#cancelADCancelBtn").click(function(){
		$("#cancelADModal").css("display","none");
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
	//	체크된 라디오 값이 있는지 확인하는 메소드
	function checkADRadio(){
		var tr = $(".goodsForAD:checked").parent().parent();
		if(tr.text() == null || tr.text() == "" || tr.text() == undefined){
			alert("선택된 상품이 없습니다.");
			return false;
		}
		return true;
	}
	
	//	파일 업로드
	$("#applicationADFile").change(function(){
		var file_name = $(this).val();
		var file = this.files[0];
		var ext = $(this).val().split('.')[1].toLowerCase();
		var file_name_html = $("#file_name").html();
		
		//	확장자명 체크(.PNG)
		if(!(ext == "png")){
			alert('PNG 파일만 사용 할 수 있습니다.');
			$(this).val('');
		}else{	
			var maxSize = 1024 * 1024 * 10; 	//	10MB
			var fileSize = file.size;
			if(maxSize < fileSize){	//	파일 사이즈 체크(10MB)
				alert('10MB 이하의 용량만 가능합니다.');
				$(this).val('');
			}else{
				var img = new Image();
				var _URL = window.URL || window.webkitURL;
				img.src = _URL.createObjectURL(file);
				img.onload = function(){
					if(img.width != 1300 || img.height != 400){
						alert('1300 * 400 사이즈만 가능합니다.');
						$(this).val('');
					}
				}
			}
		}
	});
	
	//	배너 사진 보기 클릭
	$(".viewPictureBtn").click(function(){
		var gno = $.trim($(this).parent().parent().children().eq(2).text());
		var src_path = '${path}/upload/'+gno+'/AD.png';
		$("#bannerImg").attr("src", src_path);
		$("#viewPictureModal").css("display","flex");
	});
	//	배너 사진 클릭시 모달 닫기
	$("#bannerImg").click(function(){
		$("#viewPictureModal").css("display","none");
	});
</script>
</body>
</html>