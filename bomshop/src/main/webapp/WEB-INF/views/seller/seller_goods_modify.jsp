<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="common/seller_header.jsp" %>

<style>
	div#goodsModify{
		float : left;
		margin : 50px;
		width : 800px;
	}

	div.registerValue{
		float : left;
		width : 100%;
		display: flex;
		margin-bottom: 20px;
	}
	
	div.title{
		width : 13%;
		padding:20px;
		border : 1px solid gray;
		float : left;
		margin-right : 1px;
	}
	
	div.values{
		width : 75%;
		padding:20px;
		border : 1px solid gray;
		float : left;
	}
	
	div.values select{
		width : 100px;
		height : 25px;
		margin-left: 20px;
	}
	
	table#optionTable{
		border-collapse: collapse;
		width : 600px;
	}
	
	table#optionTable tr th{
		background-color: #cccccc;
		border : 1px solid gray;
	}
	
	table#optionTable tr td{
		border : 1px solid gray;
		text-align: center;
	}
	

</style>
<script type="text/javascript" src="${path}/resources/ckeditor/ckeditor.js"></script>

<!-- ${goods} -->
<div id="goodsModify">
	<form action="goodsModify" id="goodsModifyForm" method="post">
		<input type="hidden" name="gno" value="${goods.gno}"/>
		<input type="hidden" name="page" value="${cri.page}"/>
		<input type="hidden" name="perPageNum" value="${cri.perPageNum}"/>
		<input type="hidden" name="searchType" value="${cri.searchType}"/>
		<!-- 카테고리 -->
		<div id="goodsCat" class="registerValue">
			<div class="title">상품 카테고리</div>
			<div class="values">
				<select name="cat1" id="cat1" class="input-sm" onchange="cat1Change()">
					<option value="0">----</option>
					<option value="1" ${goods.cat1 == '1' ? 'selected' : ''}>아우터</option>
					<option value="2" ${goods.cat1 == '2' ? 'selected' : ''}>상의</option>
					<option value="3" ${goods.cat1 == '3' ? 'selected' : ''}>하의</option>
					<option value="4" ${goods.cat1 == '4' ? 'selected' : ''}>기타</option>
					<option value="5" ${goods.cat1 == '5' ? 'selected' : ''}>악세사리</option>
				</select>
				
				<select name="cat2" id="cat2" class="input-sm" required>
					<option value="0">------</option>
				</select>
			</div>		
		</div>
		
		<!-- 상품명 -->
		<div id="goodsTitle" class="registerValue">
			<div class="title">상품명</div>
			<div class="values">
				<table>
					<tr>
						<td>한글 상품명</td>
						<td>
							<input type="text" name="gname_ko" id="gname_ko" class="form-control"
							 	placeholder="최대 20글자" size="50" value="${goods.gname_ko}"/>
						</td>
					</tr>
					<tr>
						<td>영어 상품명</td>
						<td>
							<input type="text" name="gname_en" id="gname_en" class="form-control"
							 	placeholder="최대 20글자" size="50" value="${goods.gname_en}"/>
						</td>
					</tr>
				</table>
			</div>		
		</div>
		
		<!-- 상품가격 -->
		<div id="goodsTitle" class="registerValue">
			<div class="title">상품가격</div>
			<div class="values">
				<table>
					<tr>
						<td>상품 판매가</td>
						<td>
							<input type="number" name="cost_origin" id="cost_origin" class="form-control"
								 placeholder="상품 판매가" value="${goods.cost_origin}"/>
						</td>
					</tr>
					<tr>
						<td>상품 할인가</td>
						<td>
							<input type="number" name="cost" id="cost" class="form-control" placeholder="상품 할인가" value="${goods.cost}"/>
						</td>
					</tr>
				</table>
			</div>		
		</div>
		
		<!-- 상품검색어 -->
		<div id="goodsTag" class="registerValue">
			<div class="title">상품 검색어</div>
			<div class="values">
				<input type="text" name="tag1" class="form-control fc-sm" placeholder="검색어1" value="${goods.tag1}"/>
				<input type="text" name="tag2" class="form-control fc-sm" placeholder="검색어2" value="${goods.tag2}"/>
				<input type="text" name="tag3" class="form-control fc-sm" placeholder="검색어3" value="${goods.tag3}"/>
			</div>
		</div>

		<!-- 상품상세내역 -->
		<div id="goodsDetail" class="registerValue">
			<div class="title">상품상세내역</div>
			<div class="values">
				${goods.gdetail}
			</div>
		</div>
		
		<!-- 교환/반품정보 -->
		<div id="goodsExchange" class="registerValue">
			<div class="title">교환/반품정보</div>
			<div class="values">
				<textarea name="gexchange" rows=15 cols="79" class="form-control" id="gexchange">${goods.gexchange}</textarea>
			</div>
		</div>
		
		<!-- 모델정보 -->
		<div id="goodsModel" class="registerValue">
			<div class="title">모델정보</div>
			<div class="values">
				<textarea name="gmodel" rows=10 cols="79" class="form-control" id="gmodel">${goods.gmodel}</textarea>
			</div>
		</div>
		
		<div style="text-align: center;">
			<input type="button" id="goodsAddBtn" class="btn btn-success btn-lg" value="상품 수정"/>
		</div>
	</form>
</div>
</div>

<script>
	console.log('${cri}');
	//	카테고리용 배열
	var cat2ListText = new Array();
	var cat2ListValue = new Array();
	
	//	아우터(1)
	cat2ListText[0] = new Array('패딩','코트','재킷');
	cat2ListValue[0] = new Array('1','2','3');
	
	//	상의(2)
	cat2ListText[1] = new Array('긴팔티셔츠','반팔티셔츠','맨투맨','후드');
	cat2ListValue[1] = new Array('4','5','6','7');
	
	//	하의(3)
	cat2ListText[2] = new Array('청바지','반바지','캐주얼바지','트레이닝바지');
	cat2ListValue[2] = new Array('8','9','10','11');
	
	//	기타(4)
	cat2ListText[3] = new Array('정장','한복','작업복','수영복');
	cat2ListValue[3] = new Array('12','13','14','15');
	
	//	악세사리(5)
	cat2ListText[4] = new Array('가방','신발','벨트','넥타이');
	cat2ListValue[4] = new Array('16','17','18','19');
	
	$(document).ready(function() {
		cat1Change();
	});
	
	//	카테고리 1번값 변경
	var cat1Change = function(){
		$("#cat2").children("option").remove();	
		var cat1Value = $("#cat1").val();
		
		if(cat1Value != 0){
			setCat2(cat1Value-1);
		}
	}
	//	카테고리 2번 값 출력
	var setCat2 = function(data){
		for(var i=0; i < cat2ListText[data].length; i++){
			var cat2 = '${goods.cat2}';
			var option = "";
			if(cat2 == cat2ListValue[data][i]){
				option = "<option value='"+cat2ListValue[data][i]+"' selected>"+cat2ListText[data][i]+"</option>";	
			}else{
				option = "<option value='"+cat2ListValue[data][i]+"'>"+cat2ListText[data][i]+"</option>";
			}
			$("#cat2").append(option);
		}
	}
	
	$("#cost_origin").change(function(){
		var cost = $("#cost_origin").val();
		$("#cost").val(cost);
	});
	
	//	상품등록 버튼 클릭
	$("#goodsAddBtn").click(function(){
		var cat1 = $("#cat1").val();
		var cat2 = $("#cat2").val();
		var gname_ko = $("#gname_ko").val();
		var gname_en = $("#gname_en").val();
		var gexchange = $("#gexchange").val();
		var gmodel = $("#gmodel").val();
		
		if(cat1 == 0){			//	카테고리 1
			alert("카테고리를 선택해 주세요.");
			$("#cat1").focus();
			return false;
		}else if(cat2 == 0){	//	카테고리 2
			alert("카테고리를 선택해 주세요.");
			$("#cat2").focus();
			return false;
		}else if(gname_ko == null || gname_ko == ""){	//	한글 상품명
			alert("한글 상품명이 없습니다.");
			$("#gname_ko").focus();
			return false;
		}else if(gname_en == null || gname_en == ""){	//	영어 상품명
			alert("영어 상품명이 없습니다.");
			$("#gname_en").focus();
			return false;
		}else if(gexchange == "" || gexchange == null){
			alert("교환/반품정보가 없습니다.");
			$("#gexchange").focus();
			return false;
		}else if(gmodel == "" || gmodel == null){
			alert("모델정보가 없습니다.");
			$("#gmodel").focus();
			return false;
		}
		
		$("#goodsModifyForm").submit();
	});
	
	$(function(){
		$(".values img").css("width","100%");
		$(".values img").css("height","auto");
	});
</script>
</body>
</html>