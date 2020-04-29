<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/qna.css">

<div class="qna_wrap">
	<div class="qna_nav">
		<div>
			<span>Q&amp;A&nbsp;</span> 
			<span class="qnaCnt"></span> 
			<input type="button" id="qBtn" value="문의 작성" />
		</div>
	</div>
	
	<div class="qna_reg">
	<br/>
	<!--  -->
		<form id="qna_registForm" action="/qna/regist" method="post">
			<input type="hidden" name="gno" value="${goods.gno}" />
			<input type="hidden" name="mno" value="3" /><!-- test용 -->
			<%-- <input type="hidden" name="mno" value="${memberInfo.mno}" /> --%>
			<%-- <input type="hidden" name="mid" value="${memberInfo.mid}" /> --%>
			<table class="qna_write">
				<tr>
					<td>제목</td>
					<td>
						<input type="text" id="qnaTitle" name="title" required/>
					</td>
				</tr>
				<tr class="qna_content">
					<td>내용</td>
					<td>
						<textarea id="qnaContent" name="content" placeholder="내용을 입력해 주세요" required></textarea>
					</td>
				</tr>
				<tr class="img_tr">
					<td>파일 첨부</td>
					<td>
						<span class="qnaimg1"><input type="file" id="qnaimg1" class="img" name="img1" /></span>
						<span class="qnaimg2"><input type="file" id="qnaimg2" class="img" name="img2" /></span>
					</td>
				</tr>
				<tr>
					<td>공개 여부</td>
					<td>
						<input type="checkbox" id="sec_status" value="Y" name="sec_status" />
						<span>비공개</span> 
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="button" id="qnaAddBtn" value="등록하기"/>
						<input type="button" id="cancleBtn" value="취소하기"/>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<div class="qna_list">
		<!-- list목록 출력 -->
		<div class='q_head'>
			
			<div>답변상태</div>
			<div>제목</div>
			<div>작성자</div>
			<div>작성일</div>
		</div>
		<ul id="q_list">

		</ul>
	</div>

	<div class="qna_paging">
		<!-- 페이징 처리 -->
	</div>
</div>

<script>
	var contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/resources/js/upload.js"></script>
<script>
	var gno = "${goods.gno}";
	var qnaPage = 1;

	getListPage(qnaPage);

	function getListPage(page) {
		console.log("get qna list");

		$.getJSON(contextPath + "/qna/" + gno + "/" + page, function(data) {
			// data == Map<String, Object>
			// data.qnaList = List<QnA_goodsVO>
			// data.pageMaker = PageMaker
			
			if($(".qnaCnt").text() == ''){
				$(".qnaCnt").append(data.pageMaker.totalCount);
			}

			var str = "";

			$(data.qnaList).each(
					function() {
						str += "<li class='ql' id='"+this.qno+"' >";
						str += "<div>";
						if (this.re_check == 'Y') {
							str += "답변 완료";
						} else if (this.re_check == 'N') {
							str += "미답변 질문";
						}
						str += "</div>";
						if (this.sec_status == 'Y') {
							str += "<div>";
							str += "비밀글 입니다.";
							str += "</div>";
						} else if (this.sec_status == 'N') {
							str += "<div class='qna_title' onclick='show(this)'>";
							str += "<span>" + this.title + "</span>";
							str += "</div>";
						}
						str += "<div>" + this.mid + "</div>";
						str += "<div>" + getDate(this.regdate) + "</div>";
						str += "<div class='ql_content'>";
						str += "<hr/>";
						str += "<span>"+this.content+"</span>";
						str += "</div>";
						str += "</li>";
					});
			$("#q_list").html(str);
			
			printPage(data.pageMaker);
		});
	}
	
	function show(obj){
		if($(obj).parent().find(".ql_content").css("display") == "none"){
			$(obj).parent().find(".ql_content").css("display","block");
		}else{
			$(obj).parent().find(".ql_content").css("display","none");
		}
		
		console.log($(obj).parent().attr("id"));
		var qno = Number($(obj).parent().attr("id"));
		if($(".ql_content img").length <= 0){
			$.getJSON(contextPath + "/qna/display/"+ qno, function(data){
				console.log(data);
				
				var html = "";
					html += "<br/>";
				 $(data).each(function(){
					var imgInfo = getFileInfo(this);
						html += "<span>";
						html += "<img src='"+imgInfo.imgSrc+"' />";
						html += "</span>";
				}); 
				 $(obj).parent().find(".ql_content").append(html);
			});
		}
	}
	
	function printPage(pm) {
		var strp = "";

		if (pm.cri.page > 1) {
			strp += "<a href='javascript:getListPage(1)'>&lt;&lt;</a>";
			if (pm.prev) {
				strp += "<a href='javascript:getListPage("+(pm.startPage-1)+")'>&lt;</a>";
			}
		}

		for (var i = pm.startPage; i <= pm.endPage; i++) {
			var strClass = pm.cri.page == i ? ' class=active' : '';
			strp += "<a href='javascript:getListPage(" + i + ")' "+strClass+">" + i + "</a>";
		}

		if (pm.cri.page < pm.maxPage) {
			if (pm.next) {
				strp += "<a href='javascript:getListPage("+(pm.endPage+1)+")'>&gt;</a>"
			}
			strp += "<a href='javascript:getListPage("+pm.maxPage+")'>&gt;&gt;</a>";
		}
		$(".qna_paging").html(strp);
	}

	function getDate(timeValue) {
		var dateObj = new Date(timeValue);

		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		if (month < 10) {
			month = "0" + month;
		}
		var date = dateObj.getDate();
		var hour = dateObj.getHours();
		var minute = dateObj.getMinutes();
		var seconds = dateObj.getSeconds();

		return year + "-" + month + "-" + date + " " + hour + ":" + minute;
	}
	
	$("#qBtn").on("click",function(){
		/* 
		if(${memberInfo != null}){
			$(".qna_reg").toggle("slow");
			$("#qnaTitle").focus();
		}else if(${memberInfo == null}){
			confirm("로그인이 필요한 서비스 입니다. \n로그인 페이지로 이동하시겠습니까?");
		} 
		*/
		$(".qna_reg").toggle("slow");
		$("#qnaTitle").focus();
	});
	
	$("#cancleBtn").click(function(){
		$(".qna_reg").toggle("slow");
	});
	
	$(".img").on("change",function(e){
		
		var file_name = $(this).val();
		var file = this.files[0].size;
		
		var img1 = $(".qnaImg input");
		
		console.log("file_name : "+file_name);
		console.log("size : "+file)
		
		if(file > 0){
			var ext = $(this).val().split('.')[1].toLowerCase();
		}
		
		//   확장자명 체크(.PNG)
		if(!(ext == "png" || ext == "gif" || ext == "jpg" || ext == "jpeg")){
		   alert('이미지 파일만 업로드 가능합니다.');
		   $(this).val('');
		}else{   
		   var maxSize = 1024 * 1024 * 5;    
		   var fileSize = file.size;
		   if(maxSize < fileSize){   
		      alert('10MB 이하의 용량만 가능합니다.');
		      $(this).val('');
		   }
		}
		
		if($(this == img1) && $(this).val() != ''){
			$(".qnaImg2").attr("style","display:block");
		}else if($(this == img1) && $(this).val() == ''){
			$(".qnaImg2").attr("style","display:none");
		}
	});
	
	$("#qnaAddBtn").on("click",function(){
		
		var formData = new FormData();
		
		if($("#qnaimg1").val() != null){
			$(".img").each(function(index){
				formData.append("qna_img",$(this)[0].files[0]);
			});
			
			$.ajax({
				type : "POST",
				url : "/uploadQnAFile",
				data : formData,
				processData : false,
				contentType : false,
				dataType : "json",
				success : function(data){
					console.log(data);
					console.log(data.length);
					
					for(var i=0; i<data.length; i++){
						var imgInfo = getFileInfo(data[i]);
						
						console.log("imgInfo.fileN : "+imgInfo.fileName);
						console.log("imgInfo.fullN : "+imgInfo.fullName);
						
						var str = "";
							str += "<div>";
							str += "<input type='hidden' name='img"+(i+1)+"' value='"+imgInfo.fullName+"'/>";
							str += "</div>";
						$("#qna_registForm").append(str);
					}
					$(".img_tr").remove();
					
					$("#qna_registForm").submit();
					
					clear();
				},
				error : function(error){
					console.log(error);
					console.log(error.status);
				}
			});
			
		}else{
			$("#qna_registForm").submit();
		}
	});
	
	function clear(){
		$("#qnaTitle").val('');
		$("#qnaContent").val('');
		var str = "";
			str += "<tr class='img_tr'>";
			str += "<td>파일 첨부</td>";
			str += "<td>";
			str += "<span class='qnaimg1'><input type='file' id='qnaimg1' class='img' name='img1' /> </span>";
			str += "<span class='qnaimg2'><input type='file' id='qnaimg2' class='img' name='img2' /> </span>";
			str += "</td>";
			str += "</tr>";
		$(".qna_content").atfer(str);
	}
</script>