<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>
	<div class="menuTitle">
			<h2>신고관리</h2>
	</div>
	<div id="memberManagementDiv">
		<div id="btnWrap">
			<div id="btnDiv1">
				<input type="button" class="btn btn-danger" id="blackIn" value="블랙리스트 등록"/>
				<input type="button" class="btn btn-warning" id="alert" value="경고"/>
				<input type="button" class="btn btn-success" id="parole" value="거절"/>
				<input type="button" class="btn btn-primary" id="showWritedBoard" value="작성글 확인"/>
			</div>
			<div id="btnDiv2">
				<!-- <button type="button" class="btn btn-dark btn-sm" onclick="blacklist(1);" id="blackListBtn" name="blackList" value="블랙리스트 확인" data-toggle="modal" data-target="#myModal">블랙리스트 확인</button> -->
				 <button type="button" class="btn btn-primary" onclick="blacklist(1);">블랙리스트 확인</button>
			</div>
		</div>
		<div id="memberManagementTable">
			<table id="table">
				<thead>
					<tr>
						<th>선택</th>
						<th>신고자ID</th>
						<th>신고ID</th>
						<th>신고내용</th>
						<th>신고날짜</th>
						<th>경고횟수</th>	
						<th>게시물 번호</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${!empty list}">
							<c:forEach var="report" items="${list}">
								<tr>
									<td><input type="radio" name="ban_check"/><input type="hidden" id="rno" value="${report.rno}"/></td>
									<td>${report.reporter_id}</td>
									<td>${report.report_id}</td>
									<td>${report.reason}</td>
									<td><f:formatDate value="${report.report_date}" pattern="YYYY-MM-dd hh:mm"/></td>
									<td>${report.alert}</td>
									<td>${report.qno}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="7">신고 요청이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<div class="paging">
			<ul class="pagination">
				<c:if test="${pageMaker.cri.page > 1}">
					<li><a
						href="memberManagement${pageMaker.makeQuery(pageMaker.cri.page- 1)}">&laquo;</a>
				</c:if>
	
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
					var="i">
					<li>
						<a href="memberManagement${pageMaker.makeQuery(i)}" style="${pageMaker.cri.page == i ? 'color:red' : '' }">${i}</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.cri.page < pageMaker.maxPage}">
					<li><a
						href="memberManagement${pageMaker.makeQuery(pageMaker.cri.page + 1)}">&raquo;</a>
				</c:if>
			</ul>
		</div>
	</div>
	<div class="container modal" id="showWritedModal" >
		<!-- Modal -->
		<div role="dialog" class="modal-content position">
			<div class="modal-dialog" >
	
				<!-- Modal content-->
				<div>
					<div class="modal-header">
						<div class="modal-title">
							<h3>작성글</h3>
						</div>
						<div class="modalCloseBtn" id="writedModalCloseBtn">&times;</div>
					</div>
					<div class="modal-body">
						<table id="wirtedBoardTable">
							<tr>
								<th>제목</th>
								<td id="qna_title"></td>
							</tr>
							<tr>
								<th>상품번호</th>
								<td id="qna_gno"></td>
							</tr>
							<tr>
								<th>상품명</th>
								<td id="qna_gname_ko"></td>
							</tr>
							<tr>
								<th>작성자</th>
								<td id="qna_mid"></td>
							</tr>
							<tr>
								<th>작성 시간</th>
								<td id="qna_regdate"></td>
							</tr>
							<tr>
								<th >작성 내용</th>
								<td id="qna_content"></td>
							</tr>
						</table>
						<div class="writedBoardCloseBtnDiv">
							<button type="button" class="btn btn-close" id="writedBoardCloseBtn">확인</button>
						</div>
					</div>
				</div>
	
			</div>
		</div>
	</div>
	<div class="container modal" id="blacklistModal">
	  <!-- Modal -->
	  <div role="dialog" class="modal-content">
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div>
	        <div class="modal-header">
	      	  <div class="modal-title"><h3>BLACKLIST</h3></div>
	      	  <div class="modalCloseBtn" id="blacklistCloseBtn">&times;</div>
	          <!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
	        </div>
	        <div class="modal-body">
	          <table id="blacklistTable">
					<thead>
						<tr>
							<th>신고ID</th>
							<th>사유</th>
							<th>등록일</th>
							<th>해제</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
				<div class="blackPaging">
					
				</div>
	        </div>
	      </div>
	      
	    </div>
	  </div>
	</div>
</div>
<script>
$("#memberManagementMenu").addClass("menu-background-color");

// 블랙리스트 등록
$("#blackIn").click(function(){
	var checked =  $("input[name='ban_check']").is(":checked");
	if(checked){
	 	if(confirm("블랙리스트에 등록하시겠습니까?")==true){
	 		var tdArr = getReportRow();
	 		var rno = tdArr[0]
	 		$.ajax({
				url:"addBlacklist/",
				type: "post",
				headers: {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				data: JSON.stringify({
					rno: tdArr[0],
					report_id: tdArr[1],
					reporter_id: tdArr[2],
					bandate: tdArr[4],
					reason: tdArr[3],
					qno: tdArr[6]
				}),
				dataType: "text",
				success : function(data) {
					location.href="memberManagement?page=${pageMaker.cri.page}&perPageNum=${pageMaker.cri.perPageNum}";
				}
			});
	 	}else{
	 		alert("취소되었습니다.");
	 		$("input[name='ban_check']").prop("checked",false);
	 	}
	}else {
		alert("체크를 해주세요.");
	}
});

// 경고 
$("#alert").click(function() {
	var checked =  $("input[name='ban_check']").is(":checked");
	if(checked){
	 	if(confirm("경고 조치하시겠습니까?")==true){
	 		var tdArr = getReportRow();
	 		var rno = tdArr[0]; 
	 		$.ajax({
	 			url: "increaseAlert/"+rno,
	 			type: "patch",
	 			headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PATCH"
				},
				data : JSON.stringify({
					report_id: tdArr[2],
					alert: tdArr[5]
				}),
				dataType: "text",
				success: function(data) {
					alert(data);
					location.href="memberManagement?page=${pageMaker.cri.page}&perPageNum=${pageMaker.cri.perPageNum}";
				} 
	 		});
	 	}else {
	 		alert("취소되었습니다.");
	 		$("input[name='ban_check']").prop("checked",false);
	 	}
	}else {
		alert("체크를 해주세요.");
	}
});

// 신고 거절
$("#parole").click(function() {
	var checked =  $("input[name='ban_check']").is(":checked");
	if(checked){
	 	if(confirm("신고 처리 취소하시겠습니까?")==true){
	 		var tdArr = getReportRow();
	 		var rno = tdArr[0];
	 		$.ajax({
	 			url: "parole/"+rno,
	 			type: "delete",
	 			headers: {
	 				"X-HTTP-Override" : "DELETE"
	 			},
	 			success: function(data){
	 				location.href="memberManagement?page=${pageMaker.cri.page}&perPageNum=${pageMaker.cri.perPageNum}";
	 			}
	 		});
	 	}else {
	 		alert("취소되었습니다.");
	 		$("input[name='ban_check']").prop("checked",false);
	 	}
	}else {
		alert("체크를 해주세요.");
	}
});

// 작성글 확인
$("#showWritedBoard").click(function(){
	var checked =  $("input[name='ban_check']").is(":checked");
	if(checked){
		var tdArr = getReportRow();
 		var rno = tdArr[0];
		$.getJSON("showWirtedBoard/"+rno,function(data){
			$("#qna_title").html(data.wbv.title);
			$("#qna_gno").html(data.wbv.gno);
			$("#qna_gname_ko").html(data.wbv.gname_ko);
			$("#qna_mid").html(data.wbv.mid);
			$("#qna_regdate").html(getDate(data.wbv.regdate));
			$("#qna_content").html(data.wbv.content);
		});
		$("#showWritedModal").css("display","flex");
		return;
	}else {
		alert("체크를 해주세요.");
		$("input[name='ban_check']").prop("checked",false);
	}
});

// 작성글 닫기
$("#writedModalCloseBtn").click(function(){
	
	$("#showWritedModal").css("display","none");
});

$("#writedBoardCloseBtn").click(function(){
	$("#showWritedModal").css("display","none");
});

// 블랙리스트 확인
function blacklist(page){
	$.getJSON("blacklist/"+page,function(data){
		
		var str = "";
		var paging = "";
		$('#blacklistTable > tbody').empty();
		if(data.blacklist.length == 0 && page != 1) {
			blacklist(page-1);
			return;
		}
		if(data.blacklist.length == 0 && page == 1) {
			alert("등록된 블랙리스트가 없습니다.");
			$("#blacklistModal").css("display","none");
			return;
		}
		$(data.blacklist).each(function(data){
			str += "<tr>";
			str += "<td>";
			str += this.mid;
			str += "</td>";
			str += "<td>";
			str += this.black_content;
			str += "</td>";
			str += "<td>";
			str += getDate(this.black_date);
			str += "</td>";
			str += "<td>";
			str += "<input type='button' id='cancle' data-black_no='"+this.black_no+"' data-page='"+page+"' class='btn btn-danger btn-sm' value='해제'/>";
			str += "</td>";
			str += "</tr>";
			
		});
		$("#blacklistTable").append(str);
		paging += "<ul class='blackPagination'>";
		if(data.page.prev){
			paging += "<li>";
			paging += "<a href='javascript:blacklist("+ pageCalcurator(data.page.startPage,-1)+");'>&laquo;</a>";
			paging += "</li>";
		}
		for(var i=data.page.startPage; i<=data.page.endPage; i++){
			if(data.page.cri.page == i) {
				paging += "<li>";
				/* paging += "<a href='blacklist"+data.page.makeQuery(i)+"'>"+i+"</a>"; */
				paging += "<a href='javascript:blacklist("+i+")' style='color:red'>"+i+"</a>";
				paging += "</li>";
			}else {
				paging += "<li>";
				/* paging += "<a href='blacklist"+data.page.makeQuery(i)+"'>"+i+"</a>"; */
				paging += "<a href='javascript:blacklist("+i+")'>"+i+"</a>";
				paging += "</li>";
			}		
		}
		if(data.page.next){
			paging += "<li>";
			paging += "<a href='javascript:blacklist("+pageCalcurator(data.page.endPage,1)+");'>&raquo;</a>";
			paging += "</li>";
		}	
		paging += "</ul>";
		$(".blackPaging").html(paging);
		$("#blacklistModal").css("display","flex");
	});
}

$("#blacklistCloseBtn").click(function(){
	$("#blacklistModal").css("display","none");
});

// 시작,끝 페이지 숫자로 변환
function pageCalcurator(data,num) {
	var dataNum = Number(data);
	var number = Number(num);
	return dataNum + number;
}

// 블랙리스트 해제
$(document).on("click","#cancle",function(){
	var btn = $(this);
		var tr = btn.parent().parent();
	var td = tr.children();
	var mid = td.eq(0).text();
	var black_content = td.eq(1).text();
	var black_date = td.eq(2).text();
	var page = $(this).data("page");
		var black_no = $(this).data("black_no");
	if(confirm("블랙리스트  해제하시겠습니까?")==true){
 		$.ajax({
 			url: "deleteBlacklist/"+black_no,
 			type: "delete",
 			headers: {
 				"X-HTTP-Override" : "DELETE"
 			},
 			dtatType: "text",
 			success: function(data){
 				blacklist(page);
 			}
 		});
 	}else {
 		alert("취소되었습니다.");
 		$("input[name='black_radio']").prop("checked",false);
 	}
});

// 신고 테이블 체크된 체크박스 값 가져오기
function getReportRow(){
	var tdArr = new Array();
	var radio = $("input[name='ban_check']:checked");
	var tr = radio.parent().parent();
	var td = tr.children();
	var rno = td.eq(0).find("#rno").val();
	console.log(rno);
	var reporter = td.eq(1).text();
	var report = td.eq(2).text();
	var content = td.eq(3).text();
	var date = td.eq(4).text();
	var alert = td.eq(5).text();
	var qno = td.eq(6).text();
	tdArr.push(rno);
	tdArr.push(reporter);
	tdArr.push(report);
	tdArr.push(content);
	tdArr.push(date);
	tdArr.push(alert);
	tdArr.push(qno);
	
	return tdArr;
}

// 블랙리스트 테이블 체크된 체크박스 값 가져오기
function getBlacklistRow(){
	var radio = $("input[name='black_radio']:checked");
	var tr = radio.parent().parent();
	var td = tr.children();
	var mid = td.eq(0).text();
	var black_content = td.eq(1).text();
	var black_date = td.eq(2).text();
	tdArr.push(mid);
	tdArr.push(black_content);
	tdArr.push(black_date);

	return tdArr;
}

function getDate(timeValue) {
	var dateObj = new Date(timeValue);
	var year = dateObj.getFullYear();
	var month = dateObj.getMonth()+1;
	if(month < 10) {
		month = "0" + month;
	}
	var date = dateObj.getDate();
	var hour = dateObj.getHours();
	var minute = dateObj.getMinutes();
	if(minute < 10) {
		minute = "0" + minute;
	}
	var seconds = dateObj.getSeconds();
	
	return year + "-" + month + "-" + date + " " + hour + ":" + minute;  
}
</script>
</body>
</html>