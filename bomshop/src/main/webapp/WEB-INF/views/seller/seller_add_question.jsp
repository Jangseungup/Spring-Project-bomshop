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
   
</style>
<div id="sellerServiceCenter">
	<div id="QnA">
		<div id="Question_Div">
			<span id="Question_MunuText">문의 작성</span>
			<form action="addQuestion" method="post">
				<table id="QnATbl">
					<tr>
					<tr>
						<td>제목</td>
						<td>
							<input name="title" type="text" class="form-control"/>
						</td>
					</tr>
					<tr>
						<td>내용</td>
						<td>
							<textarea name="content" class="form-control"></textarea>
						</td>
					</tr>
					<tr>
						<th colspan=2>
							<input type="submit" class="btn btn-success" value="문의하기"/>
						</th>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
