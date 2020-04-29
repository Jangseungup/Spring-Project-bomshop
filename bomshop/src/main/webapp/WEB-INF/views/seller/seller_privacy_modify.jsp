<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="common/seller_header.jsp" %>

<style>
	div#sellerPrivacy{
		float : left;
		width : 80%;
	}

	div#sellerPrivacy div#businessCard{
		margin: 20px 50px 40px 50px;
		width : 800px;
		height: 400px;
		padding : 30px;
		border : 1px solid black;
		border-radius: 20px;
		background-color: #e2e2e2;
	}
	
	div#businessCard div#shopName{
		width: 200px;
		height : 250px;
		float : left;
		margin : 30px;
		font-size: 30px;
		text-align: center;
	}
	
	div#businessCard div#info{
		width: 450px;
		height : 250px;
		float : left;
		margin : 10px 0 30px 50px;
		font-size: 15px;
	}
	
	div#businessCard div#footer{
		clear:both;
		text-align:right;
		margin : 30px;
	}
	
	.bankBtn{
		padding : 7px;
		background-color: #343a40;
		color : white;
		border-radius: 5px;
		width : 100px;
		height : 42px;
	}
</style>

<div id="sellerPrivacy">
	<form action="privacyModify" method="post" id="privacyModifyForm">
		<div id="businessCard">
			<div id="shopName">
				<input type="text" name="shopname" id="shopname" placeholder="상호명을 입력해주세요."
						 class="form-control fc-sm" value="${memberInfo.shopname}"/>
			</div>
			
			<div id="info">
				<table>
					<tr>
						<td rowspan=3><label><img src="${path}/resources/img/seller/adress.png"/></label></td>
						<td>
							<input type="text" name="shop_post_code" id="shop_post_code" class="form-addr" value="${memberInfo.shop_post_code}"/>
							<input type="button" value="주소 찾기" onclick="execDaumPostcode();" class="btn btn-primary"/>
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" name="shopaddr1" id="shopaddr1" class="form-control" value="${memberInfo.shopaddr1}"/>
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" name="shopaddr2" id="shopaddr2" class="form-control" value="${memberInfo.shopaddr2}"/>
						</td>
					</tr>
				</table>
				<br/>
				<img src="${path}/resources/img/seller/phone.png"/>
				<input type="text" name="shopphone" id="shopphone" class="form-addr fc-md" placeholder="전화번호를 입력해주세요."
						 value="${memberInfo.shopphone}"/>
				<br/>
				<img src="${path}/resources/img/seller/bank.png"/>
				<input type="text" name="bankname" id="bankname" class="form-addr" placeholder="은행을 입력해주세요."
					 value="${memberInfo.bankname}" readonly/>
				<input type="button" value="은행 선택" id="bankBtn" class="btn btn-primary"/>
				<br/>
				<img src="${path}/resources/img/seller/account.png"/>
				<input type="text" name="maccount" class="form-addr fc-md" placeholder="계좌번호를 입력해주세요." value="${memberInfo.maccount}"/>
				<br/>
				<img src="${path}/resources/img/seller/page.png"/>
				&nbsp;&nbsp;bomshop.com / ${memberInfo.shopurl}
			</div>
			
			<div id="footer">
				<hr/><br/>
				<input type="button" id="modifyBtn" value="수정하기" class="btn btn-success btn-lg"/>
			</div>
		</div>
	</form>
</div>
</div>

<!-- 은행선택 모달 -->
<div id="bankInputModal" class="modal">
   <div class="modal-content">
      <div id="bankInputText">
         <span style="font-size:30px; font-weight: bold;">은행 선택</span>
      </div>
      <div class="input_wraps" id="input_wrap">
         <table style="display: inline-block;" class="banktable">
            <tr>
               <td><button class="bankBtn" onclick="javascript:bankInput('하나은행')">하나은행</button></td>
               <td><button class="bankBtn" onclick="javascript:bankInput('국민은행')">국민은행</button></td>
               <td><button class="bankBtn" onclick="javascript:bankInput('기업은행')">기업은행</button></td>
               <td><button class="bankBtn" onclick="javascript:bankInput('부산은행')">부산은행</button></td>
               <td><button class="bankBtn" onclick="javascript:bankInput('우리은행')">우리은행</button></td>
            </tr>
            <tr>
               <td><button class="bankBtn" onclick="javascript:bankInput('외환은행')">외환은행</button></td>
               <td><button class="bankBtn" onclick="javascript:bankInput('새마을금고')">새마을금고</button></td>
               <td><button class="bankBtn" onclick="javascript:bankInput('전북은행')">전북은행</button></td>
               <td><button class="bankBtn" onclick="javascript:bankInput('신한은행')">신한은행</button></td>
               <td><button class="bankBtn" onclick="javascript:bankInput('NH농협')">NH농협</button></td>
            </tr>
            <tr>
               <td><button class="bankBtn" onclick="javascript:bankInput('수협은행')">수협은행</button></td>
               <td><button class="bankBtn" onclick="javascript:bankInput('대구은행')">대구은행</button></td>
               <td><button class="bankBtn" onclick="javascript:bankInput('산업은행')">산업은행</button></td>
               <td><button class="bankBtn" onclick="javascript:bankInput('신협')">신협</button></td>
               <td><button class="bankBtn" onclick="javascript:bankInput('우체국')">우체국</button></td>
            </tr>
         </table>
      </div>
   </div>
</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function execDaumPostcode(){
		//alert('click');
		new daum.Postcode({
			oncomplete : function(data){
				var fullAddr = "";	//	최종 주소
				var extraAddr = "";	//	조합형 주소
				
				if(data.userSelectedType == 'R'){	//	도로명 주소
					fullAddr = data.roadAddress;
				}else{
					fullAddr = data.jibunAddress;	//	지번 주소
				}
				console.log(data);
				if(data.userSelectedType == 'R'){
					//	법정동명
					if(data.bname != ""){
						extraAddr += data.bname;
					}
					console.log(data.buildingName);
					//	건물명
					if(data.buildingName != ""){
						extraAddr += (extraAddr != "" ? ', '+data.buildingName : data.buildingName);
					}
					
					fullAddr += (extraAddr != "" ? '('+extraAddr+')' : '');
				}
				
				$("#shop_post_code").val(data.zonecode);
				$("#shopaddr1").val(fullAddr);
				$("#shopaddr2").focus();
			}
		}).open();
	}
	
	$("#modifyBtn").click(function(){
		var shopname = $("#shopname").val();
		var shop_post_code = $("#shop_post_code").val();
		var shopaddr1 = $("#shopaddr1").val();
		var shopaddr2 = $("#shopaddr2").val();
		var shopphone = $("#shopphone").val();
		console.log(shopphone);
		
		if(shopname == null || shopname == ""){					//	상호명
			alert("상호명을 입력해 주세요.");
			$("#shopname").focus();
			return false;
		}else if(shop_post_code == null || shop_post_code == ""){		//	우편번호
			alert("우편번호를 입력주세요.");
			$("#shop_post_code").focus();
			return false;
		}else if(shopaddr1 == null || shopaddr1 == ""){			//	주소1
			alert("주소를 입력해 주세요.");
			$("#shopaddr1").focus();
			return false;
		}else if(shopaddr2 == null || shopaddr2 == ""){			//	주소2
			alert("주소를 입력해 주세요.");
			$("#shopaddr2").focus();
			return false;
		}else if(shopphone == null || shopphone == ""){			//	전화번호
			alert("전화번호를 입력해 주세요.");
			$("#shopphone").focus();
			return false;
		}
		$("#privacyModifyForm").submit();
	});
	
	//	상품 삭제 버튼 클릭
	$("#bankBtn").click(function(){
		$("#bankInputModal").css("display","flex");
	});	

	function bankInput(bankInputText){
	   $("#bankname").val(bankInputText);
	   $("#bankInputModal").css("display","none");
	}
</script>
</body>
</html>