<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="common/seller_header.jsp" %>    

<style>
	#sellerServiceCenter{
		float : left;
		width : 80%;
		margin: 20px 0px 40px 50px;
	}

	#Question_Div{
		display: inline-block;
		border-radius: 5px;
		padding : 10px;
		border-bottom: none;
		font-size : 20px;
		margin: 0 auto;
	}
   
   #Question_Div:hover{
      cursor: pointer;
   }
   
   .QR_contentDiv{
      width : 760px;
      border : 1px solid lightgray;
      border-radius: 5px;
      border-top : 2px solid black;
      text-align: center;
   }
   
   #QnATbl{
      width : 760px;
      text-align: center;
      padding : 10px;
      border-collapse: collapse;
      font-size : 15px;
   }
   
   #QnATbl tr th{
      border-bottom : 1px solid gray;
      padding-bottom : 10px;
      height : 35px;
   }
   
   #QnATbl tr td{
      border-bottom : 1px solid lightgray;
      padding : 10px;
   }
   
   #QnATbl tr:last-child td{
      border-bottom: none;
   }

   
   /* 페이징 */
   
   .QR_pagingDiv{
      text-align: center;
   }
   .reviewPaging{
      height : 30px;
      display : inline-block;
      text-align: center;
      
   }
   .reviewPagingUl{
      list-style: none;
      
   }
   .reviewPagingUl li{
      float : left;
      border: 1px solid gray;
      width:30px;
      height:30px;
      margin : 1px;
   }
   .reviewPagingUl li a{
      text-decoration: none;
      color : black;
      line-height: 30px;
   }
   
   #addQuestion{
		float : right;
   }
   
</style>
<div id="sellerServiceCenter">
	<div id="QnA">
		<div id="Question_Div">
			<span id="Question_MunuText">나의 문의</span>
			<input type="button" value="문의하기" class="btn btn-primary" id="addQuestion"/>
			<table id="QnATbl">
				<thead>
					<tr>
						<th style="width:100px;">문의번호</th>
						<th style="width:350px;">제목</th>
						<th style="width:150px;">작성일</th>
						<th style="width:100px;">답변여부</th>
					</tr>
				</thead>
				
				<c:choose>
					<c:when test="${!empty qnaList}">
						<c:forEach var="qna" items="${qnaList}">
							<tr onclick="location.href='${path}/seller/qnaDetail?qano=${qna.qano}'">
								<td>${qna.qano}</td>
								<td>${qna.title}</td>
								<td>
									<f:formatDate value="${qna.regdate}" pattern="yyyy/MM/dd HH:mm"/>
								</td>
								<td>
									<c:choose>
										<c:when test="${qna.re_check eq 'N'}">
											미답변
										</c:when>
										<c:otherwise>
											답변완료
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<th colspan=4>작성한 문의내용이 없습니다.</th>
						</tr>
					</c:otherwise>
				</c:choose>
				
			</table>
			
			<div id="pagination">
				<c:if test="${pageMaker.prev}">
					<a href="service_center${pageMaker.search(pageMaker.startPage-1)}">&laquo;</a>
				</c:if>
				<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<c:choose>
						<c:when test="${pageMaker.cri.page eq i}">
							<b style="color:red">${i}</b>
						</c:when>
						<c:otherwise>
							<a href="service_center${pageMaker.search(i)}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${pageMaker.next}">
					<a href="service_center${pageMaker.search(pageMaker.endPage+1)}">&raquo;</a>
				</c:if>
			</div>
		</div>
	</div>
</div>

<script>
	$("#addQuestion").click(function(){
		location.href="${path}/seller/addQuestion";
	});
</script>
