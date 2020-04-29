<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="common/seller_header.jsp" %>

<style>
	div#customerStatus{
		float : left;
		width : 80%;
	}
	
	div#customerStatus table#customerStatusInfo{
		margin: 20px 50px 40px 50px;
		border-collapse:collapse;
		width : 800px;
	}
	
	#customerManagePage{
		float:left;
		width:800px;
		background-color:#e2e2e2;
		margin-left: 50px;
		height: 420px;
		border-radius: 10px;
	}
	
	div#customerStatus #btnWrap {
		height:25px;
		margin-top:10px;
	}
	div#customerStatus #btnDiv1 {
		margin-left:25px;
		float:left;
		width: 60%
	}
	div#customerStatus #btnDiv2 {
		float:right;
		width: 20%;
	}
	div#customerStatus #tableDiv {
		padding-top: 10px;
		width:96%;
		background-color:white;
		margin: 0 auto;
		margin-top: 15px;
		height: 320px;
		border-radius: 10px;
	}
	div#customerStatus #tableDiv table{
		border-collapse: collapse;
		margin: 0 auto;
		width: 95%;
	}
	div#customerStatus table tr th {
		border:1px solid lightgray;
		background-color: #e2e2e2;
		text-align: center;
	}
	div#customerStatus table tr td {
		border:1px solid lightgray;
		text-align: center;
	}
		
	table#customerStatusInfo tr th{
		width: 199px;
	}
	
	table#customerStatusInfo a{
		color : red;
	}
		
	table.banlist{
		text-align: center;
		border-collapse: collapse;
	}
	table.banlist thead tr th{
		border-top:1px solid lightgray;
		border-bottom:1px solid lightgray;
		background-color: #e2e2e2;
		padding: 5px;		
	}
	table.banlist tr td{
		padding: 5px;
		border-bottom:1px solid lightgray;		
	}
</style>

<div id="customerStatus">
	<table id="customerStatusInfo">
		<thead>
			<tr>
				<td style="border:0;text-align: left;">
					<h3>고객 관리</h3>
				</td>
			</tr>
			<tr>
				<th>신규문의</th>
				<th>신규리뷰</th>
				<th>단골 고객</th>
			</tr>
		</thead>
		<tr>
			<td><a href="customer_manage?searchType=question">${newQuestionCount}</a> 건</td>
			<td><a href="customer_manage?searchType=review">${latestReviewsCount}</a> 건</td>
			<td>${regularCustomerCount} 명</td>
		</tr>
	</table>
	
	<div id="customerManagePage">
		<div id="btnWrap">
			<div id="btnDiv1">
				<input type="button" class="btn btn-danger" id="blockBtn" value="고객차단"/>
				<input type="button" class="btn btn-primary" id="rejectReplyBtn" value="답변거부"/>
			</div>
			<div id="btnDiv2">
				<input type="button" class="btn btn-primary" id="showBlackListBtn" value="블랙리스트 목록"/>
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
						<c:choose>
							<c:when test="${!empty questionList}">
								<th style="width:60px;">선택</th>
								<th style="width:90px;">글번호</th>
								<th>상품명</th>
								<th>작성자ID</th>
								<th>제목</th>
								<th>작성일</th>
								<th>작성내용</th>
							</c:when>
							<c:otherwise>
								<th style="width:60px;">선택</th>
								<th style="width:90px;">글번호</th>
								<th>상품명</th>
								<th>작성자ID</th>
								<th>별점</th>
								<th>작성일</th>
								<th>작성내용</th>
							</c:otherwise>
						</c:choose>
						
					</tr>
				</thead>
				<c:choose>
					<c:when test="${!empty questionList}">
						<c:forEach var="question" items="${questionList}">
							<tr>
								<td>
									<input type="radio" name="questionRadio" class="questionRadio" data-mno="${question.qna.mno}"/>
								</td>
								<td>${question.qna.qno}</td>
								<td>${question.gname}</td>
								<td>${question.mid}</td>
								<td>${question.qna.title}</td>
								<td>
									<f:formatDate value="${question.qna.regdate}" pattern="yyyy/MM/dd"/>
								</td>
								<td>
									<input type="button" class="btn btn-primary btn-sm qnaDetailBtn" value="보기"/>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:when test="${!empty reviewList}">
						<c:forEach var="review" items="${reviewList}">
							<tr>
								<td>
									<input type="radio" name="reviewRadio"/>
								</td>
								<td>${review.review.rno}</td>
								<td>${review.gname}</td>
								<td>${review.mid}</td>
								<td>
									<c:forEach step="1" begin="1" end="${review.review.grade}">
									★
									</c:forEach>									
								</td>
								<td>
									<f:formatDate value="${review.review.regdate}" pattern="yyyy/MM/dd"/>
								</td>
								<td>
									<input type="button" class="btn btn-primary btn-sm reviewDetailBtn" value="보기"/>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan=7 style="text-align:center;"><label>등록된 글이 없습니다.</label></td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
		
		<div id="pagination">
			<c:if test="${pageMaker.prev}">
				<a href="customer_manage${pageMaker.search(pageMaker.startPage-1)}">&laquo;</a>
			</c:if>
			<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<c:choose>
					<c:when test="${pageMaker.cri.page eq i}">
						<b style="color:red">${i}</b>
					</c:when>
					<c:otherwise>
						<a href="customer_manage${pageMaker.search(i)}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<a href="customer_manage${pageMaker.search(pageMaker.endPage+1)}">&raquo;</a>
			</c:if>
		</div>
		
	</div>
</div>
</div>

<!-- 문의답변 버튼 클릭시 띄울 modal -->
<div id="qnaDetailModal" class="modal">
	<div class="modal-content">
		<h3>고객 문의 내용</h3>
		<input type="hidden" id="qnaDetailQno"/>
		<input type="hidden" id="qnaDetailGno"/>
		<table>
			<tr>
				<td>상품명</td>
				<td>
					<input type="text" class="form-control" id="qnaDetailGname" readonly/>
				</td>
			</tr>
			<tr>
				<td>고객ID</td>
				<td>
					<input type="text" class="form-control" id="qnaDetailMid" readonly/>
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" class="form-control" id="qnaDetailTitle" readonly/>
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea cols="22" rows="5" class="form-control" id="qnaDetailContent" readonly></textarea>
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="button" id="qnaDetailImg1Btn" class="btn btn-warning"
						 value="이미지1" style="visibility:hidden;" data-url=""/>
					&nbsp;&nbsp;&nbsp;
					<input type="button" id="qnaDetailImg2Btn" class="btn btn-warning"
						 value="이미지2" style="visibility:hidden;" data-url=""/>
				</th>
			</tr>
			<tr>
				<th colspan="2">
					<input type="button" id="qnaDetailSubmitBtn" class="btn btn-primary" value="답변하기"/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" id="qnaDetailCancleBtn" class="btn btn-danger" value="취소"/>
				</th>
			</tr>
		</table>
	</div>
</div>

<!-- 유저차단 버튼 클릭시 띄울 modal -->
<div id="blockModal" class="modal">
	<div class="modal-content">
		<form action="addBlackList" method="post" id="blockForm">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}"/>
			<h3>유저차단</h3>
			<input type="hidden" name="ban_mno" id="blockMno"/>
			<table>
				<tr>
					<td>차단유저ID</td>
					<td>
						<input type="text" id="blockMid" class="form-control"/>
					</td>
				</tr>
				<tr>
					<td>차단 사유</td>
					<td>
						<textarea cols="22" rows="5" placeholder="차단 사유를 작성해주세요." name="reason" class="form-control"></textarea>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="button" id="blockSubmitBtn" class="btn btn-primary" value="차단하기"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="blockCancleBtn" class="btn btn-danger" value="취소"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>

<!-- 사진 보기 버튼 클릭시 띄울 modal -->
<div id="viewPictureModal" class="modal">
	<div class="modal-content">
		<img src="" id="bannerImg" style="max-height:900px;max-width:1300px;"/>
	</div>
</div>

<!-- qna상세보기 - 답변하기 버튼 클릭시 띄울 modal -->
<div id="answerModal" class="modal">
	<div class="modal-content">
		<form action="answer" method="post" id="answerForm">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}"/>
			<h3>답변하기</h3>
			<input type="hidden" name="qno" id="answerQno"/>
			<input type="hidden" name="gno" id="answerGno"/>
			<table>
				<tr>
					<td>제목</td>
					<td>
						<input type="text" name="title" placeholder="답변 제목을 작성해주세요." id="answerTitle" class="form-control"/>
					</td>
				</tr>
				<tr>
					<td>답변 내용</td>
					<td>
						<textarea cols="22" rows="5" placeholder="답변 내용을 작성해주세요." name="content" id="answerContent" class="form-control"></textarea>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="button" id="answerSubmitBtn" class="btn btn-success" value="답변하기"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="answerCancleBtn" class="btn btn-danger" value="닫기"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>

<!-- 유저차단 버튼 클릭시 띄울 modal -->
<div id="rejectReplyModal" class="modal">
	<div class="modal-content">
		<form action="rejectReply" method="post" id="rejectReplyForm">
			<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}"/>
			<h3>답변거부</h3>
			<input type="hidden" name="qno" id="rejectReplyQno"/>
			<table>
				<tr>
					<th colspan="2" style="color:red;">
						답변 거부하면 다시는 답변을 다실 수 없습니다.
					</th>
				</tr>
				<tr>
					<th colspan="2">
						<input type="button" id="rejectReplySubmitBtn" class="btn btn-success" value="확인"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="rejectReplyCancleBtn" class="btn btn-danger" value="닫기"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>

<!-- 블랙리스트 목록 버튼 클릭시 띄울 modal -->
<div id="showBlackListModal" class="modal">
	<div class="modal-content" style="text-align:center;">
		<h3>블랙리스트 목록</h3>
		<!-- 정산내역 historyList -->
		<div id="blackListDiv">
			
		</div>
		<!-- pagination -->
		<div id="blackListpm" style="text-align: center;">
			
		</div>
		<br/>
		<input type="button" class="btn btn-danger" id="showBlackListCloseBtn" value="닫기"/>
	</div>
</div>

<script>
	$("#menu_cum").addClass("currentPage");
	
	//	작성내용 보기 버튼 클릭
	$(".qnaDetailBtn").click(function(){
		var qno = $.trim($(this).parent().parent().children().eq(1).text());
		$.get("getQnAbyQno/"+qno,function(data){
			$("#qnaDetailQno").val(data.qna.qno);
			$("#qnaDetailGno").val(data.qna.gno);
			$("#qnaDetailGname").val(data.gname);
			$("#qnaDetailMid").val(data.mid);
			$("#qnaDetailTitle").val(data.qna.title);
			$("#qnaDetailContent").val(data.qna.content);
			if(data.qna.img1 != null && data.qna.img1 != ""){
				$("#qnaDetailImg1Btn").attr("data-url","${path}/upload"+data.qna.img1);
				$("#qnaDetailImg1Btn").css("visibility","visible");
			}
			if(data.qna.img2 != null && data.qna.img2 != ""){
				$("#qnaDetailImg2Btn").attr("data-url","${path}/upload"+data.qna.img2);
				$("#qnaDetailImg2Btn").css("visibility","visible");
			}
		});
		$("#qnaDetailModal").css("display","flex");
	});
	//	이미지1 버튼 클릭
	$("#qnaDetailImg1Btn").click(function(){
		$("#bannerImg").attr("src", $("#qnaDetailImg1Btn").attr("data-url"));
		$("#viewPictureModal").css("display","flex");
	});
	//	이미지 2버튼 클릭
	$("#qnaDetailImg2Btn").click(function(){
		$("#bannerImg").attr("src", $("#qnaDetailImg2Btn").attr("data-url"));
		$("#viewPictureModal").css("display","flex");
	});
	//	사진 클릭시 모달 닫기
	$("#bannerImg").click(function(){
		$("#viewPictureModal").css("display","none");
	});
	//	modal 작성내용 보기 - 답변하기 버튼 클릭
	$("#qnaDetailSubmitBtn").click(function(){
		$("#qnaDetailModal").css("display","none");
		$("#qnaDetailImg1Btn").css("visibility","hidden");
		$("#qnaDetailImg2Btn").css("visibility","hidden");
		$("#answerQno").val($.trim($("#qnaDetailQno").val()));
		$("#answerGno").val($.trim($("#qnaDetailGno").val()));
		$("#answerModal").css("display","flex");
		
	});
	//	modal 작성내용 보기 - 닫기 버튼 클릭
	$("#qnaDetailCancleBtn").click(function(){
		$("#qnaDetailModal").css("display","none");
		$("#qnaDetailImg1Btn").css("visibility","hidden");
		$("#qnaDetailImg2Btn").css("visibility","hidden");
	});
	
	//	modal 작성내용 보기 - 답변하기 버튼 클릭
	$("#answerSubmitBtn").click(function(){
		$("#answerModal").css("display","none");
		$("#answerForm").submit();
	});
	//	modal 작성내용 보기 - 닫기 버튼 클릭
	$("#answerCancleBtn").click(function(){
		$("#answerModal").css("display","none");
		$("#answerTitle").val("");
		$("#answerContent").val("");
	});
	
	//	차단하기 버튼 클릭
	$("#blockBtn").click(function(){
		//	라디오 버튼 클릭이 되었는지 체크
		if(checkADRadio()){
			$("#blockMno").val($("input[type=radio]:checked").attr('data-mno'));
			$("#blockMid").val($.trim($('input[type=radio]:checked').parent().parent().children().eq(3).text()));
			$("#blockModal").css("display","flex");	
		}
	});
	//	modal 차단하기 차단 버튼 클릭
	$("#blockSubmitBtn").click(function(){
		$("#blockForm").submit();
		$("#blockModal").css("display","none");
	});
	//	modal 차단하기 닫기 버튼 클릭
	$("#blockCancleBtn").click(function(){
		$("#blockModal").css("display","none");
	});
	
	//	답변거부 버튼 클릭
	$("#rejectReplyBtn").click(function(){
		//	라디오 버튼 클릭이 되었는지 체크
		if(checkADRadio()){
			$("#rejectReplyQno").val($.trim($('input[type=radio]:checked').parent().parent().children().eq(1).text()));
			$("#rejectReplyModal").css("display","flex");	
		}
	});
	//	modal 답변거부 - 확인 버튼 클릭
	$("#rejectReplySubmitBtn").click(function(){
		$("#rejectReplyForm").submit();
		$("#rejectReplyModal").css("display","none");
	});
	//	modal 답변거부 - 닫기 버튼 클릭
	$("#rejectReplyCancleBtn").click(function(){
		$("#rejectReplyModal").css("display","none");
	});
	
	//	체크된 라디오 값이 있는지 확인하는 메소드
	function checkADRadio(){
		var tr = $("input[type=radio]:checked").parent().parent();
		if(tr.text() == null || tr.text() == "" || tr.text() == undefined){
			alert("선택된 상품이 없습니다.");
			return false;
		}
		return true;
	}
	
	//	블랙리스트 목록 버튼 클릭
	$("#showBlackListBtn").click(function(){
		getbanList(1);
		$("#showBlackListModal").css("display","flex");	
	});
	//	값 불러오기
	function getbanList(page){
		$.get("getBlackList",function(data){
			printList(data.banList);
			printPagination(data.banPageMaker);
		});
	}
	//	월정산내역 그리기
	function printList(list){
		var str = "";
		str += "<table class='banlist'>";
		str += "<thead>";
		str += "<tr>";
		str += "<th>차단된ID</th>";
		str += "<th>차단 사유</th>";
		str += "<th>차단날짜</th>";
		str += "</tr>";
		str += "</thead>";
		$(list).each(function(){
			str += "<tr>";
			str += "<td>";
			str += this.mid;
			str += "</td>";
			str += "<td>";
			str += this.reason;
			str += "</td>";
			str += "<td>";
			str += getDate(this.bandate);
			str += "</td>";
			str += "</tr>";
		});
		str += "</table>";
		$("#blackListDiv").html(str);
	}
	//	정산내역용 pagination
	function printPagination(pm){
		var str = "";
		if(pm.prev){
			str += "<a href='javascript:void(0);' onclick='getbanList("+(pm.startPage-1)+")';>&laquo;</a>";
			str += "&nbsp;&nbsp;";
		}
		for(var i=pm.startPage; i<=pm.endPage;i++){
			if(i == pm.cri.page){
				str += "<b style='color:red'>"+i+"</b>";
			}else{
				str += "<a href='javascript:void(0);' onclick='getbanList("+i+")';>"+i+"</a>";
			}
			str += "&nbsp;&nbsp;";
		}
		if(pm.next){
			str += "<a href='javascript:void(0);' onclick='getbanList("+(pm.endPage+1)+")';>&raquo;</a>";
		}
		$("#blackListpm").html(str);
	}
	//	날짜 세팅
	function getDate(date){
		var order_date = new Date(date);
		var year = order_date.getFullYear();
		var month = order_date.getMonth()+1;
		var day = order_date.getDate();
		return year+"/"+month+"/"+day;
	}
	$("#showBlackListCloseBtn").click(function(){
		$("#showBlackListModal").css("display","none");	
	});
</script>

</body>
</html>