<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="common/header.jsp" %>
<div class="menuTitle">
	<h2>광고관리</h2>
</div>
<div id="advertiseStatus">
	<table>
		<tr>
			<th>전체</th>
			<th>광고 중</th>
			<th>승인 대기</th>
			<th>광고마감 3일 전</th>
		</tr>
		<tr>
			<td><a href="advertise">${advertiseTotal}</a>건</td>
			<td><a href="advertise?searchType=advertising">${advertising}</a>건</td>
			<td><a href="advertise?searchType=waiting">${waiting}</a>건</td>
			<td><a href="advertise?searchType=deadline">${deadline}</a>건</td>

		</tr>
	</table>
</div>
<div id="advertiseDiv">
	<div id="btnWrap">
		<div id="btnDiv1">
			<input type="button" id="acceptBtn" class="btn btn-success" value="광고 승인"/>
			<input type="button" id="checkGoodsBtn" class="btn btn-primary" value="상품 확인"/>
			<input type="button" id="cancleBtn" class="btn btn-danger" value="광고 취소"/>
		</div>
	</div>
	<div id="tableDiv">
		<table>
			<tr>
				<th>선택</th>
				<th>판매자ID</th>
				<th>상품명</th>
				<th>종료일</th>
				<th>상태</th>
				<th>남은기간</th>
				<th>배너이미지</th>
			</tr>
			<c:choose>
				<c:when test="${!empty advertiseList}">
					<c:forEach var="advertise" items="${advertiseList}">
						<tr>
							<td><input type="radio" name="advertise_radio"/><input type="hidden" id="ano" name="ano" value="${advertise.advertiseVO.ano}"/></td>
							<td>${advertise.mid}</td>
							<td data-gno="${advertise.advertiseVO.gno}">${advertise.gname_ko}</td>
							<td><f:formatDate value="${advertise.advertiseVO.adate}" pattern="YYYY-MM-dd"/></td>
							<td>
								<c:if test="${advertise.advertiseVO.astatus eq 0}">
									승인 대기
								</c:if>
								<c:if test="${advertise.advertiseVO.astatus eq 1}">
									광고 중
								</c:if>
							</td>
							<td>
								<c:if test="${advertise.advertiseVO.astatus eq 1}">
									${advertise.remaining_period}일
								</c:if>
								<c:if test="${advertise.advertiseVO.astatus eq 0}">	
									X
								</c:if>
							</td>
							<td>
								<input type="button" class="btn btn-primary btn-sm viewPictureBtn" value="배너 보기"/>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<td colspan="7">신청한 광고가 없습니다</td>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
	<div class="paging">
		<ul class="pagination">
			<c:if test="${pageMaker.cri.page > 1}">
				<li><a
					href="advertise${pageMaker.search(pageMaker.cri.page - 1)}">&laquo;</a>
			</c:if>

			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
				var="i">
				<li>
					<a href="advertise${pageMaker.search(i)}" style="${pageMaker.cri.page == i ? 'color:red' : '' }">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker.cri.page < pageMaker.maxPage}">
				<li><a
					href="advertise${pageMaker.search(pageMaker.cri.page + 1)}">&raquo;</a>
			</c:if>
		</ul>
	</div>
</div>
<!-- 배너사진 보기 버튼 클릭시 띄울 modal -->
<div id="viewPictureModal" class="modal">
   <div class="modal-content">
      <img src="" id="bannerImg"/>
   </div>
</div>
<script>
	$("#advertiseMenu").addClass("menu-background-color");
	
	$("#acceptBtn").click(function(){
		var checked =  $("input[name='advertise_radio']").is(":checked");
		if(checked){
			if(confirm("광고 신청 승인하시겠습니까?")==true){
				var tdArr = getadvertiseListRow();
				var ano = tdArr[0];
				var remain_day = tdArr[6];
				if(remain_day.indexOf('X') != -1) {
					$.ajax({
						url: "acceptAdvertise/"+ano,
			 			type: "patch",
			 			headers : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "PATCH"
						},
						dataType: "text",
						success: function(data) {
							alert(data);
							console.log(data);
							location.href="advertise${pageMaker.search(pageMaker.cri.page)}";
						}					
					});	
				}else {
					alert("이미 승인된 광고 입니다.");
				}
			}else {
		 		alert("취소되었습니다.");
		 		$("input[name='advertise_radio']").prop("checked",false);
		 	}
		}else {
			alert("체크해주세요");
		}
	});

	// 상품 확인
	$("#checkGoodsBtn").click(function(){
		var checked =  $("input[name='advertise_radio']").is(":checked");
		if(checked){
			var tdArr = getadvertiseListRow();
			window.open('${pageContext.request.contextPath}/goods/detail?gno='+tdArr[3]);
		}else {
			alert("체크해주세요");
		}
	});

	// 광고 신청 취소
	$("#cancleBtn").click(function(){
		var checked =  $("input[name='advertise_radio']").is(":checked");
		if(checked){
			if(confirm("신청 취소처리하시겠습니까?")==true){
				var tdArr = getadvertiseListRow();
				var ano = tdArr[0];
				var remain_day = tdArr[6];
				if(remain_day.indexOf('X') != -1){
					$.ajax({
			 			url: "deleteAdvertise/"+ano,
			 			type: "delete",
			 			headers: {
			 				"X-HTTP-Override" : "DELETE"
			 			},
			 			success: function(data){
			 				location.href="advertise${pageMaker.search(pageMaker.cri.page)}";
			 			}
			 		});
				}else {
					alert("승인된 광고 상품은 취소할 수 없습니다.");
				}
			}else {
		 		alert("취소되었습니다.");
		 		$("input[name='advertise_radio']").prop("checked",false);
		 	}
		}else {
			alert("체크해주세요");
		}
	});
   //  배너 사진 보기 클릭
   $(".viewPictureBtn").click(function(){
      var gno = $.trim($(this).parent().parent().children().eq(2).data("gno"));
      console.log(gno);
      var src_path = '${path}/upload/'+gno+'/AD.png';
      $("#bannerImg").attr("src", src_path);
      $("#viewPictureModal").css("display","flex");
   });
   
   //   배너 사진 클릭시 모달 닫기
   $("#bannerImg").click(function(){
      $("#viewPictureModal").css("display","none");
   });
	
	// 광고리스트 테이블 체크된 체크박스 값 가져오기
	function getadvertiseListRow(){
		var tdArr = new Array();
		var radio = $("input[name='advertise_radio']:checked");
		var tr = radio.parent().parent();
		var td = tr.children();
		var	ano = td.eq(0).find("#ano").val();
		console.log(ano);
		var buyerID = td.eq(1).text();
		console.log(buyerID);
		var gname_ko = td.eq(2).text();
		console.log(gname_ko);
		var gno = td.eq(2).data('gno');
		console.log(gno);
		var regdate = td.eq(3).text();
		console.log(regdate);
		var astatus = td.eq(4).text();
		console.log(astatus);
		var remaining_period_td = td.eq(5).text();
		console.log(remaining_period_td);
		var remaining_period_index = Number(remaining_period_td.indexOf("일"));
		console.log(remaining_period_index);
		var remaining_period = remaining_period_td.substring(0,remaining_period_index);
		console.log(remaining_period);

		tdArr.push(ano);
		tdArr.push(buyerID);
		tdArr.push(gname_ko);
		tdArr.push(gno);
		tdArr.push(regdate);
		tdArr.push(astatus);
		tdArr.push(remaining_period_td);
		
		return tdArr;
	}
</script>
</body>
</html>