<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="common/seller_header.jsp" %>

<style>
	div#goodsRegister{
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
<div id="goodsRegister">
	<form action="goodsRegister" id="goodsRegisterForm" method="post" enctype="multipart/form-data">
		<!-- 카테고리 -->
		<div id="goodsCat" class="registerValue">
			<div class="title">상품 카테고리</div>
			<div class="values">
				<select name="cat1" id="cat1" class="input-sm" onchange="cat1Change()">
					<option value="0">----</option>
					<option value="1">아우터</option>
					<option value="2">상의</option>
					<option value="3">하의</option>
					<option value="4">기타</option>
					<option value="5">악세사리</option>
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
							<input type="text" name="gname_ko" id="gname_ko" class="form-control" placeholder="최대 20글자" size="50"/>
						</td>
					</tr>
					<tr>
						<td>영어 상품명</td>
						<td>
							<input type="text" name="gname_en" id="gname_en" class="form-control" placeholder="최대 20글자" size="50"/>
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
							<input type="number" name="cost_origin" id="cost_origin" class="form-control" placeholder="상품 판매가"/>
						</td>
					</tr>
					<tr>
						<td>상품 할인가</td>
						<td>
							<input type="number" name="cost" id="cost" class="form-control" placeholder="상품 할인가"/>
						</td>
					</tr>
				</table>
			</div>		
		</div>
		
		<!-- 상품검색어 -->
		<div id="goodsTag" class="registerValue">
			<div class="title">상품 검색어</div>
			<div class="values">
				<input type="text" name="tag1" class="form-control fc-sm" placeholder="검색어1"/>
				<input type="text" name="tag2" class="form-control fc-sm" placeholder="검색어2"/>
				<input type="text" name="tag3" class="form-control fc-sm" placeholder="검색어3"/>
			</div>
		</div>
		
		<!-- 판매기간 -->
		<div id="goodsSaleDate" class="registerValue">
			<div class="title">판매 기간</div>
			<div class="values">
				<select name="setSdate" class="input-sm" id="setSdate">
					<option value="0">----</option>
					<option value="15">15일</option>
					<option value="30">30일</option>
					<option value="90">90일</option>
				</select>
			</div>
		</div>
		
		<!-- 주문옵션 -->
		<div id="goodsOption" class="registerValue">
			<div class="title">주문 옵션</div>
			<div class="values">
				<table>
					<tr>
						<td>색상</td>
						<td>
							<input type="text" id="gcolor" class="form-control" placeholder="색상"/>
						</td>
					</tr>
					<tr>
						<td>사이즈</td>
						<td>
							<input type="text" id="gsize" class="form-control" placeholder="사이즈"/>
						</td>
					</tr>
					<tr>
						<td>수량</td>
						<td>
							<input type="number" id="gcount" class="form-control" placeholder="수량"/>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<input type="button" id="optionAddBtn" class="btn btn-primary" value="추가"/>
							<input type="button" id="optionDelBtn" class="btn btn-danger" value="삭제"/>
						</td>
					</tr>
				</table>
				<hr/>
				<table id="optionTable">
					<thead>
						<tr>
							<th>Radio</th>
							<th>색상</th>
							<th>사이즈</th>
							<th>수량</th>
						</tr>
					</thead>
				</table>
			</div>
			<div id="hiddenValue">
			</div>
		</div>
		
		<!-- 상품이미지 -->
		<div id="goodsImg" class="registerValue">
			<div class="title">상품이미지</div>
			<div class="values">
				대표이미지
				<input type="file" name="mainImg" class="form-control img" id="mainImg" accept=".png,.gif,.jpg,.jpeg"/>
				<br/>
				서브이미지
				<input type="file" name="subImg" class="form-control img" accept=".png,.gif,.jpg,.jpeg"/>
				<input type="file" name="subImg" class="form-control img" accept=".png,.gif,.jpg,.jpeg"/>
				<input type="file" name="subImg" class="form-control img" accept=".png,.gif,.jpg,.jpeg"/>
			</div>
		</div>
		
		<!-- 상품상세내역 -->
		<div id="goodsDetail" class="registerValue">
			<div class="title">상품상세내역</div>
			<div class="values">
				<textarea name="gdetail" rows=20 cols="79" class="form-control" id="gdetail"></textarea>
				<script type="text/javascript">
					CKEDITOR.replace('gdetail',{
						filebrowserUploadUrl: '${path}/seller/uploadDetail'
					});
					CKEDITOR.on('dialogDefinition', function( ev ){
			            var dialogName = ev.data.name;
			            var dialogDefinition = ev.data.definition;
			         
			            switch (dialogName) {
			                case 'image': 
			                    dialogDefinition.removeContents('Link');
			                    dialogDefinition.removeContents('advanced');
			                    break;
			            }
			        });
				</script>
			</div>
		</div>
		
		<!-- 교환/반품정보 -->
		<div id="goodsExchange" class="registerValue">
			<div class="title">교환/반품정보</div>
			<div class="values">
				<textarea name="gexchange" rows=15 cols="79" class="form-control" id="gexchange"></textarea>
			</div>
		</div>
		
		<!-- 모델정보 -->
		<div id="goodsModel" class="registerValue">
			<div class="title">모델정보</div>
			<div class="values">
				<textarea name="gmodel" rows=10 cols="79" class="form-control" id="gmodel"></textarea>
			</div>
		</div>
		
		<div style="text-align: center;">
			<input type="button" id="goodsAddBtn" class="btn btn-success btn-lg" value="상품 등록"/>
		</div>
	</form>
</div>
</div>

<script>
	$("#menu_gr").addClass("currentPage");
	$("#cat1").focus();
	//	옵션 개수
	var optionNumber = 0;
	console.log(optionNumber);
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
			var option = "<option value='"+cat2ListValue[data][i]+"'>"+cat2ListText[data][i]+"</option>";
			$("#cat2").append(option);
		}
	}
	
	$("#cost_origin").change(function(){
		var cost = $("#cost_origin").val();
		$("#cost").val(cost);
	});
	
	//	옵션 추가 버튼 클릭
	$("#optionAddBtn").click(function(){
		var color = $("#gcolor").val();
		var size = $("#gsize").val();
		var count = $("#gcount").val();
		
		if(color == "" || color == null){
			alert("색상을 입력하세요.");
			$("#gcolor").focus();
			return;
		}else if(size == "" || size == null){
			alert("사이즈를 입력하세요.");
			$("#gsize").focus();
			return;
		}else if(count == "" || count == null){
			alert("수량을 입력하세요.");
			$("#gcount").focus();
			return;
		}
		
		var html = "<tr><td>";
			html += "<input type='radio' name='chk_option'/></td>";
			html += "<td>"+color+"</td>";
			html += "<td>"+size+"</td>";
			html += "<td>"+count+"</td>";
			html += "</tr></td>";
		$("#optionTable").append(html);
		
		var str = "<input type='hidden' name='color' value='"+color+"'/>";
			str += "<input type='hidden' name='size' value='"+size+"'/>";
			str += "<input type='hidden' name='count' value='"+count+"'/>";
		$("#hiddenValue").append(str);
		optionNumber++;
	});
	
	//	옵션 삭제 버튼 클릭
	$("#optionDelBtn").click(function(){
		if(checkRadio()){
			$("input[name='chk_option']:checked").parent().parent().remove();
			optionNumber--;	
		}		
	});
	
	//	체크된 라디오 값이 있는지 확인하는 메소드
	function checkRadio(){
		var tr = $("input[name='chk_option']:checked").parent().parent();
		if(tr.text() == null || tr.text() == "" || tr.text() == undefined){
			alert("선택된 상품이 없습니다.");
			return false;
		}
		return true;
	}
	
	//	상품등록 버튼 클릭
	$("#goodsAddBtn").click(function(){
		var cat1 = $("#cat1").val();
		var cat2 = $("#cat2").val();
		var gname_ko = $("#gname_ko").val();
		var gname_en = $("#gname_en").val();
		var setSdate = $("#setSdate").val();
		var cost_origin = Number($("#cost_origin").val());
		var cost = Number($("#cost").val());
		var img1 = $("#img1").val();
		var gdetail = $("#gdetail").val();
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
		}else if(setSdate == 0){
			alert("판매기간을 선택해 주세요.");
			$("#setSdate").focus();
			return false;
		}else if(cost_origin == null || cost_origin == "" || cost_origin == 0){
			alert("상품 판매가격을 입력해 주세요.");
			$("#cost_origin").focus();
			return false;
		}else if(cost != null && cost > cost_origin){
			alert("상품 할인가격이 상품 판매가보다 높습니다.");
			$("#cost").focus();
			return false;
		}else if(optionNumber == 0){
			alert("상품 옵션이 없습니다.");
			$("#gcolor").focus();
			return false;
		}else if(mainImg == "" || mainImg == null){
			alert("대표이미지가 없습니다.");
			$("#mainImg").focus();
			return false;
		}
/* 		else if(gdetail == "" || gdetail == null){
			alert("상품상세내역이 없습니다.");
			$("#gdetail").focus();
			return false;
		} */
		else if(gexchange == "" || gexchange == null){
			alert("교환/반품정보가 없습니다.");
			$("#gexchange").focus();
			return false;
		}else if(gmodel == "" || gmodel == null){
			alert("모델정보가 없습니다.");
			$("#gmodel").focus();
			return false;
		}
		
		$("#goodsRegisterForm").submit();
	});
	
	
	//	사진 업로드 체크
	$(".img").change(function(){
		var file_name = $(this).val();
		var file = this.files[0];
		var ext = $(this).val().split('.')[1].toLowerCase();
		var file_name_html = $("#file_name").html();
		
		//	확장자명 체크(.PNG)
		if(!(ext == "png" || ext == "gif" || ext == "jpg" || ext == "jpeg")){
			alert('PNG, JPG, GIF, JPEG 파일만 사용 할 수 있습니다.');
			$(this).val('');
		}else{	
			var maxSize = 1024 * 1024 * 5; 	//	5MB
			var fileSize = file.size;
			if(maxSize < fileSize){	//	파일 사이즈 체크(5MB)
				alert('10MB 이하의 용량만 가능합니다.');
				$(this).val('');
			}
		}
	});
</script>
</body>
</html>