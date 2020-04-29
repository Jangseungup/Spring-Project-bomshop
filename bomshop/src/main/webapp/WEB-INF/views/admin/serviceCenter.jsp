<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="common/header.jsp" %>
<div class="menuTitle">
	<h2>고객센터</h2>
</div>
<div id="seviceDiv">
	<div id="btnWrap">
		<div id="btnDiv1">
			<input type="button" class="btn btn-primary" id="answerBtn" value="답변하기"/>
		</div>
	</div>
	<div id="tableDiv">
		<table>
			<tr>
				<th>선택</th>
				<th>요청ID</th>
				<th>제목</th>
				<th>문의내용</th>
				<th>요청날짜</th>
			</tr>
			<c:choose>
				<c:when test="${!empty questionList}">
					<c:forEach var="question" items="${questionList}">
						<tr>
							<td><input type="radio" name="question_radio" /><input type="hidden" name="qano" id="qano" value="${question.questionVO.qano}"/></td>
							<td>${question.questionID}</td>
							<td>${question.questionVO.title}</td>
							<td>${question.questionVO.content}</td>
							<td><f:formatDate value="${question.questionVO.regdate}" pattern="YYYY-MM-dd"/></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<td colspan="8">문의사항이 없습니다</td>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
	<div class="paging">
		<ul class="pagination">
			<c:if test="${pageMaker.cri.page > 1}">
				<li><a
					href="serviceCenter${pageMaker.makeQuery(pageMaker.cri.page- 1)}">&laquo;</a>
			</c:if>

			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
				var="i">
				<li>
					<a href="serviceCenter${pageMaker.makeQuery(i)}" style="${pageMaker.cri.page == i ? 'color:red' : '' }">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker.cri.page < pageMaker.maxPage}">
				<li><a
					href="serviceCenter${pageMaker.makeQuery(pageMaker.cri.page + 1)}">&raquo;</a>
			</c:if>
		</ul>
	</div>
</div>
<div class="container modal" id="answerModal">
  <!-- Modal -->
	<div role="dialog" class="modal-content position">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div>
				<div class="modal-header">
					<div class="modal-title">
						<h3>ANSWER</h3>
					</div>
					<div class="modalCloseBtn" id="answerCloseBtn">&times;</div>
					<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
				</div>
				<div class="modal-body">
					<input type="hidden" id="questionQano" />
					<table id="answerTable">
						<tr>
							<th>회원ID</th>
							<td id="questionID"></td>
						</tr>
						<tr>
							<th>제목</th>
							<td id="questionTitle"></td>
						</tr>
						<tr>
							<th>문의내용</th>
							<td><textarea id="questionContent" rows="10"
									cols="50" readonly></textarea></td>
						</tr>
						<tr>
							<th>답변내용</th>
							<td><textarea id="answerContent" rows="10"
									cols="50" placeholder="답변을 작성해주세요."></textarea></td>
						</tr>
					</table>
				</div>
				<div class="answerCloseBtnDiv" id="sendBtn">
					<button type="button" class="btn btn-close">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$("#serviceCenterMenu").addClass("menu-background-color");
	// 문의 답변하기
	$("#answerBtn").click(function(){
		var checked =  $("input[name='question_radio']").is(":checked");
		if(checked){
			var tdArr = getQuestionListRow();
			console.log(tdArr[0]);
			console.log(tdArr[1]);
			console.log(tdArr[2]);
			console.log(tdArr[3]);
			$("#questionQano").val(tdArr[0]);
			$("#questionID").html(tdArr[1]);
			$("#questionTitle").html(tdArr[2]);
			$("#questionContent").val(tdArr[3]);
			
			$("#answerModal").css("display","flex");
			$("#sendBtn").click(function(){
				var qano = $("#questionQano").val();
				var answer = $("#answerContent").val();
				if(answer == null || answer == "") {
					alert("답변을 작성해주세요.");
				}else {
					$.ajax({
						url: "sendAnswer/"+qano,
			 			type: "patch",
			 			headers : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "PATCH"
						},
						data : JSON.stringify({
							content: answer
						}),
						success: function(data) {
							location.href="serviceCenter?page=${pageMaker.cri.page}&perPageNum=${pageMaker.cri.perPageNum}";
						}
						
					});
				}
			});
		}else {
			alert("체크해주세요.");
		}	
	});
	
	$("#answerCloseBtn").click(function(){
		$("#answerModal").css("display","none");
	});
	
	
	
	// 쿠폰리스트 테이블 체크된 체크박스 값 가져오기
	function getQuestionListRow(){
		var tdArr = new Array();
		var radio = $("input[name='question_radio']:checked");
		var tr = radio.parent().parent();
		var td = tr.children();
		var	qano = td.eq(0).find("#qano").val();
		console.log(qano);
		var questionID = td.eq(1).text();
		console.log(questionID);
		var title = td.eq(2).text();
		console.log(title);
		var content = td.eq(3).text();
		console.log(content);
		var regdate = td.eq(4).text();
		console.log(regdate);
		tdArr.push(qano);
		tdArr.push(questionID);
		tdArr.push(title);
		tdArr.push(content);
		tdArr.push(regdate);
		return tdArr;
	}
</script>
</body>
</html>