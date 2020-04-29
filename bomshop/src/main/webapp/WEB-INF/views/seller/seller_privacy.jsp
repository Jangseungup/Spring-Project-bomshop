<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="common/seller_header.jsp" %>

<style>
	div#sellerPrivacy{
		float : left;
		width : 80%;
	}
	
	div#sellerPrivacy div#businessCard{
		margin: 20px 0px 40px 50px;
		width : 800px;
		height: 400px;
		padding : 30px;
		padding-right:0px;
		border : 1px solid black;
		border-radius: 20px;
		background-color: #e2e2e2;
	}
	
	div#businessCard div#shopName{
		width: 230px;
		height : 250px;
		float : left;
		margin : 30px 0 0 30px;
		font-size: 30px;
		text-align: center;
	}
	
	div#businessCard div#info{
		width: 500px;
		height : 250px;
		float : left;
		margin : 30px 0 30px 30px;
		font-size: 15px;
	}
	
	div#businessCard div#footer{
		text-align:right;
		margin : 30px;
	}
</style>

<div id="sellerPrivacy">
	<div id="businessCard">
		<div id="shopName">
			${memberInfo.shopname}
		</div>
		
		<div id="info">
			<table>
				<tr>
					<td rowspan=3><label><img src="${path}/resources/img/seller/adress.png"/></label></td>
					<td>
						&nbsp;&nbsp;(${memberInfo.shop_post_code})
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;&nbsp;${memberInfo.shopaddr1}&nbsp;${memberInfo.shopaddr2}
					</td>
				</tr>
			</table>
			<br/>
			<img src="${path}/resources/img/seller/phone.png"/>
			&nbsp;&nbsp;${memberInfo.shopphone}
			<br/><br/>
			<img src="${path}/resources/img/seller/bank.png"/>
			&nbsp;&nbsp;${memberInfo.bankname}
			<br/><br/>
			<img src="${path}/resources/img/seller/account.png"/>
			&nbsp;&nbsp;${memberInfo.maccount}
			<br/><br/>
			<img src="${path}/resources/img/seller/page.png"/>
			&nbsp;&nbsp;bomshop.com / ${memberInfo.shopurl}
		</div>
		
		<div id="footer">
			<hr/><br/>
			<input type="button" value="상점 정보 수정" id="modifyBtn" class="btn btn-primary btn-lg"/>
		</div>
	</div>
</div>
</div>
<script>
	$("#modifyBtn").click(function(){
		location.href="${path}/seller/privacyModify";
	});
</script>
</body>
</html>