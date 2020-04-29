<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/detail.css">


<div id="Wrap" class="Wrap">
<div class="main_wrap">
	<div id="info_wrap">
		<div id="img_slide" class="detail_img">
			<!-- 이미지 슬라이드 들어갈곳 -->
			<!-- The Modal -->
			<div id="myModal" class="modal">
			  <!-- The Close Button -->
			  <span class="close" onclick="document.getElementById('myModal').style.display='none'">&times;</span>
			
			  <!-- Modal Content (The Image) -->
			  <img class="modal-content" id="img01" class="modalImg">
			</div>
			
			<!-- img1(대표이미지) 기본, 있을때만-> img2, img3, img4 -->
			<img src="${pageContext.request.contextPath}/resources/img/left.png" class="btn prev" role="button"/>
			
			<div class="slideshow-container">
				<!-- img1 대표이미지 -->
				<div class="mySlides">
					<img class="gImg" src="${pageContext.request.contextPath}/upload${goods.img1}" width="548" height="450"/>
				</div>
				
				<c:if  test="${goods.img2 != null && goods.img2 != ''}">
					<div class="mySlides">
						<img class="gImg" src="${pageContext.request.contextPath}/upload${goods.img2}" width="548" height="450" />
					</div>
				</c:if>
				
				<c:if  test="${goods.img3 != null && goods.img3 != ''}">
					<div class="mySlides">
						<img class="gImg" src="${pageContext.request.contextPath}/upload${goods.img3}" width="548" height="450" />
					</div>
				</c:if>
				
				<c:if  test="${goods.img4 != null && goods.img4 != ''}">
					<div class="mySlides">
						<img class="gImg" src="${pageContext.request.contextPath}/upload${goods.img4}" width="548" height="450" />
					</div>
				</c:if>
				<%--  --%>
				
			</div>	
			<img src="${pageContext.request.contextPath}/resources/img/right.png" class="btn next" role="button"/>
		</div>
		<div id="infomation" class="detail_info">
			<!-- 판매 정보 들어갈 곳 ( 판매자명, 상품명, 적립포인트, 옵션 선택, 장바구니버튼, 바로구매버튼, 관심상품 버튼 )-->
			<div class="detail_header">
				<div class="seller_box">
					<ul>
						<li class="shopname">
							<p><a href="${goods.shopurl}" class="ms_shop">${goods.shopname}</a></p><!-- ${seller.shopname} -->
						</li>
						<li class="msBtn">
							<a href="${goods.shopurl}" class="ms_btn">더보기</a>
						</li>
					</ul>
				</div>
				<div class="basic_info">
					<h3>${goods.gname_ko}</h3>
					<p>
						<c:choose>
							<c:when test="${goods.cost == 0}">
								<span class="cost">판매가
									<span class="unit price">${goods.cost_origin}</span>원
								</span>
							</c:when>
							<c:otherwise>
								<span class="cost_original">${goods.cost_origin}
									<span class="uint">원</span>
								</span>
							
								<span class="cost">판매가
									<span class="unit price">${goods.cost}</span>원
								</span>	
							</c:otherwise>
						</c:choose>
					</p>
				</div>
				<hr/>
			</div>
			<div class="detail_content">
				<p>
					적립포인트 
					<!-- 회원등급 -> n% 적립인지 알려주기 -->
					<c:choose>
						<c:when test="${member.mgrade == 2}">
							&nbsp; 1%
						</c:when>
						<c:when test="${member.mgrade == 3}">
							&nbsp; 2%
						</c:when>
						<c:when test="${member.mgrade == 4}">
							&nbsp; 3%
						</c:when>
						<c:when test="${member.mgrade == 5}">
							&nbsp; 5%
						</c:when>
						<c:when test="${member.mgrade == 6}">
							&nbsp; 7%
						</c:when>
						<c:when test="${member.mgrade == 7}">
							&nbsp; 10%
						</c:when>
						<c:otherwise>
							&nbsp; 없음
						</c:otherwise>
					</c:choose>
				</p>
				<span>
					<!-- 적립 포인트 결과 출력 -->
					<c:choose>
						<c:when test="${member.mgrade == 2}">
							<c:if test="${!empty goods.cost}">
								${goods.cost/100}&nbsp;POINT&nbsp;(1% 적립)
							</c:if>
							<c:if test="${empty goods.cost}">
								${goods.cost_origin/100}&nbsp;POINT&nbsp;(1% 적립)
							</c:if>
						</c:when>
						<c:when test="${member.mgrade == 3}">
							<c:if test="${!empty goods.cost}">
								${goods.cost*2/100}&nbsp;POINT&nbsp;(2% 적립)
							</c:if>
							<c:if test="${empty goods.cost}">
								${goods.cost_origin*2/100}&nbsp;POINT&nbsp;(2% 적립)
							</c:if>
						</c:when>
						<c:when test="${member.mgrade == 4}">
							<c:if test="${!empty goods.cost}">
								${goods.cost*3/100}&nbsp;POINT&nbsp;(3% 적립)
							</c:if>
							<c:if test="${empty goods.cost}">
								${goods.cost_origin*3/100}&nbsp;POINT&nbsp;(3% 적립)
							</c:if>
						</c:when>
						<c:when test="${member.mgrade == 5}">
							<c:if test="${!empty goods.cost}">
								${goods.cost*5/100}&nbsp;POINT&nbsp;(5% 적립)
							</c:if>
							<c:if test="${empty goods.cost}">
								${goods.cost_origin*5/100}&nbsp;POINT&nbsp;(5% 적립)
							</c:if>
						</c:when>
						<c:when test="${member.mgrade == 6}">
							<c:if test="${!empty goods.cost}">
								${goods.cost*7/100}&nbsp;POINT&nbsp;(7% 적립)
							</c:if>
							<c:if test="${empty goods.cost}">
								${goods.cost_origin*7/100}&nbsp;POINT&nbsp;(7% 적립)
							</c:if>
						</c:when>
						<c:when test="${member.mgrade == 7}">
							<c:if test="${!empty goods.cost}">
								${goods.cost/10}&nbsp;POINT&nbsp;(10% 적립)
							</c:if>
							<c:if test="${empty goods.cost}">
								${goods.cost_origin/10}&nbsp;POINT&nbsp;(10% 적립)
							</c:if>
						</c:when>
						<c:otherwise>
							0&nbsp;POINT
						</c:otherwise>
					</c:choose>
				</span>
			</div>
			
			<hr/>
			
			<div class="detail_footer">
				<div class="detail_option" >
					<!-- 옵션 선택창 들어갈 곳 -->
					<div>
						<span>색상</span>
						<select class="selectbox color form-control" >
							<option disabled selected>색상을 선택하세요</option>
							<c:forEach var="color" items="${color}">
								<option value="${color.color}">${color.color}</option>
							</c:forEach>
						</select>
					</div>
					<div>
						<span>사이즈</span>
						<select class="selectbox size form-control" disabled="disabled"><!--  disabled -->
							<option disabled selected>사이즈를 선택하세요</option>
							<c:forEach var="size" items="${size}">
								<option value="${size.size}">${size.size}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				
				<form method="post" id="addForm">
				
				<input type="hidden" name="gno" value="${goods.gno}"/>
					<div class="selected" style="display:none;" >
						<!-- 선택한 옵션 들어갈 곳 -->
						
					</div>
					
				</form>
				
				<hr/>
				
				<form id="goodsForm" method="post">	
					<input type="hidden" name="gno" value="${goods.gno}"/>
					<c:if test="${!empty memberInfo}">
						<input type="hidden" name="mno" value="${memberInfo.mno}" />
					</c:if>
					<div class="cost_calc">
						<!-- 선택한 상품 cost계산해서 출력 -->
						<span class="calc_goods">총 <span>0</span>개의 상품</span>
						<span class="calc_cost">총 금액
							<span style="color:red;">0</span>원
						</span>
					</div>
				</form>
			</div>
			
			<div id="loginModal" class="modal">
				<div class="confirm_modal">
					<h2>구매하기</h2>
					<div class="text">
						회원가입 후 구매시면 
						<br/>
						바로 사용가능한 쿠폰이 지급됩니다.
						<br/>
						가입 후 구매하시겠습니까?
					</div>
					<div class="modal_btns">
						<input type="button" class="order_non" value="비회원 구매하기" />
						<input type="button" class="login" value="로그인" />
	 				</div>
 				</div>
			</div>
			
			<div class="detail_btns">
				<a id="btn_cart" class="btn btn-primary" role="button">장바구니</a>
				<a id="btn_buy" class="btn btn-success" role="button">바로 구매하기</a>
				<a id="btn_report" class="btn btn-danger" role="button">신고하기</a>
				<a id="favor_btn" href="#">
					<!-- 관심상품 등록버튼( aka. 좋아요 버튼) -->
					<img id="heart_icon" src="${pageContext.request.contextPath}/resources/img/icon2.png"  width="50" height="35"/>
				</a>
			</div>
		</div>
	</div>

	<div id="detail_wrap" class="detail_wrap" role="tabpane1">
		<!-- 상품 정보 -->
		<div id="detail_nav" class="detail_tabs">
			<!-- 상품정보, 리뷰, qna, 판매정보(모델, 교환/환불, 판매자 상세정보)  비동기 처리 -->
			<ul class="tab">
				<li class="current" data-tab="tab1"><span>상품정보</span></li>
				<li data-tab="tab2">리뷰&nbsp;<span class="reviewCnt"></span></li>
				<li data-tab="tab3"><span>Q&amp;A</span></li>
				<li data-tab="tab4"><span>주문정보</span></li>
			</ul>		
		</div>
		
		<div id="tab1" class="tabcontent gdetail current">
			<!-- 상품정보 -->
			<h3>${goods.gdetail}</h3>
		</div>
	
		<div id="tab2" class="tabcontent review">
			<!-- 리뷰 목록 -->
			<jsp:include page="../review/review.jsp" />
		</div>
		
		<div id="tab3" class="tabcontent qna_goods">
			<!-- qna목록 -->
			<jsp:include page="../qna/qna.jsp" />
		</div>
		
		<div id="tab4" class="tabcontent gexchange">
			<%-- <!-- 판매정보  -->
			<h3>${goods.gexchange}</h3>
			<!-- 모델 정보 -->
			<h3>${goods.gmodel}</h3> --%>
			<h1>판매자 정보</h1>
			<table class="shop">
				<tr>
					<td>상호명</td>
					<td>${goods.shopname}</td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td>
						<c:choose>
							<c:when test="${goods.shopphone ne null && goods.shopphone eq ''}">
								${goods.shopphone}
							</c:when>
							<c:otherwise>
								없음
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td>
						<c:choose>
							<c:when test="${goods.shopaddr1 ne null && goods.shopaddr2 ne null}">
								${goods.shopaddr1}
								${goods.shopaddr2}
								${goods.shop_post_code}
							</c:when>
							<c:otherwise>
								없음
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td>미니샾 URL</td>
					<td>${goods.shopurl}</td>
				</tr>
			</table>
			

			<h1>주문정보</h1>
			<table class="orderInfo">
				<tr>
					<th>판매 정보</th>
					<td>${goods.gexchange}</td>
				</tr>
				<tr>
					<th>모델 정보</th>
					<td>${goods.gmodel}</td>
				</tr>
			</table>
		</div>
	</div>
	</div>
	<div class="container modal" id="sendToBuyer">
		<!-- Modal -->
		<div role="dialog" class="modal-content position">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div>
					<div class="modal-header">
						<div class="modal-title">
							<h3>상품신고</h3>
						</div>
						<div class="modalCloseBtn" id="sendToBuyerCloseBtn">&times;</div>
						<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
					</div>
					<div class="modal-body">
						<table id="sendToBuyerTable">
							<tr>
								<th>상품명</th>
								<td id="goodsName">${goods.gname_ko}</td>
							</tr>
							<tr>
								<td colspan=2>
									<textarea id="reason" class="reason" placeholder="사유를 적어주세요." rows="10" cols="50"></textarea>
									<br />
									<span style="color:#25323e;font-size:13px;float:right" id="counter">(0 / 500자)</span>
								</td>
							</tr>
						</table>
						<div class="sendToBuyerCloseBtnDiv" id="sendBtn">
							<button type="button" class="btn btn-close">확인</button>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</div>

<script>
	var contextPath = "${pageContext.request.contextPath}";
</script>
<script>
	if("${memberInfo}" != ""){
		checkFavorite();
	}
	

	var message = "${message}";
	
	if(message != ""){
		alert(message);
		 // confirm 받고 화면이동 or 그대로
        var check = confirm("성공적으로 장바구니에 담았습니다. \n장바구니로 이동하시겠습니까?");
        if(check){
       	 location.href=contextPath+"/goods/cart";
        }
	}
	//src="${pageContext.request.contextPath}/resources/img/icon.png" 
	function checkFavorite(){
		$.get("favorite",{gno:"${goods.gno}",mno:"${memberInfo.mno}"},function(data){
			if(data){
				$("#heart_icon").attr("src",contextPath+"/resources/img/icon.png");
			}else{
				$("#heart_icon").attr("src",contextPath+"/resources/img/icon2.png");
			}
		});
	}

	$(document).ready(function(){
		/* 이미지 슬라이드  */
		var slideIndex = 1;
		showSlides(slideIndex);
		
		var memberInfo = "${memberInfo}";
		var mno = "${memberInfo.mno}";
		
		/* if(memberInfo != null){
			likeGoods(mno);
		} */
		
		$(".prev").on("click",function(){
			console.log("?");
			showSlides(slideIndex -= 1);
		});
		
		$(".next").on("click",function(){
			console.log("?");	
			showSlides(slideIndex += 1);
		});
		
		/* function likeGoods(mno){
			var gno = "${goods.gno}";
			$.getJSON(contextPath+"/goods/favorite/"+gno+"/"+mno,function(data){
				if(data == "true"){
					$("#favor_btn").html("<img id='heart_icon' src='${pageContext.request.contextPath}/resources/img/red_heart.png' width='50' height='35' />");
				}else if(data == "false"){
					$("#favor_btn").html("<img id='heart_icon' src='${pageContext.request.contextPath}/resources/img/black_heart.png' width='50' height='35' />");
				}
			});
		} */
		
		function showSlides(n){
			var i;
			var gno = "${goods.gno}";
			var slides = $(".mySlides");
			
			/* $.getJSON(contextPath+"/goods/display/"+gno,function(data){
				var str = "";
				
				$(data).each(function(){
					var gImgInfo = getFileInfo(this);
					
					str += "<div class='myslides'>";
					str += "<img class='gImg' src='"+gImgInfo.imgSrc+"' width='548' height='450' />";
					str += "</div>";
				});
				$(".slideshow-container").append(str);
			});
			 */
			if(n > slides.length){slideIndex = 1}
			if(n < 1){slideIndex = slides.length}

			for(i = 0; i < slides.length; i++){
				slides[i].style.display = "none";
			}
			slides[slideIndex-1].style.display = "block";
		}
		
		var color = "";
		var size = "";
		var price = $("span .price").val();
		var cost = 0;
		var total = Number($(".calc_cost span").text());
		
		/* 옵션 선택처리 */
		$(".color").on("change",function(){
			color = $(".color option:selected").val();
				$(".size").removeAttr("disabled");
		});
		
		$(".size").change(function(){
				size = $(".size option:selected").val();
			var html = "<div class='selected_opt'>"
				html += "<span class='color' name='color'>"+color+"</span>";  	
				html += "<input type='hidden' name='color' value='"+color+"'/>";
				html += "<span> / </span>";
				html += "<span class='size' name='size'>"+size+"</span>";		
				html += "<input type='hidden' name='size' value='"+size+"'/>";
				html += "<div class='selected_cost'>";
				html += "<div class='cost_text'>";
				html += "<span>"+price+"</span>"								
				html += "<input type='hidden' name='price' value='"+price+"'/>";
				html += "<a href='#' class='btnDel'>X</a>";
				html += "</div>";
				html += "<div class='calc_btn'>";
				html += "<img src='${pageContext.request.contextPath}/resources/img/minus.png' class='num_minus'/>";
				html += "<input type='text' class='input_num' name='count' value='1'/>";	
				html += "<img src='${pageContext.request.contextPath}/resources/img/plus.png' class='num_plus'/>";
				html += "</div>";
				html += "</div>";
				html += "</div>";
			$(".size").attr("disabled","disabled");
			$(".selected").css("display","block");
			$(".selected").append(html);
			
			var n = $(".selected").find(".selected_opt").length;
			var str = n;
			$(".calc_goods span").html(str);
			
			cost = Number($(".calc_cost span").text());
			
			cost += Number(price);
			console.log("cost : "+cost);
			
			$(".calc_cost span").html(cost);
		});
		
		/* 선택 상품 삭제 버튼 */
		$(".selected").on("click",".btnDel",function(event){
			event.preventDefault();
			alert("선택한 상품을 삭제 하시겠습니까?");
			
			/* total 값 */
			total = Number($(".calc_cost span").text());
			console.log("del total : "+total);
			
			var parentDiv = $(this).closest(".selected_opt");
			var parent_cost = parentDiv.find(".cost_text span").text();
			console.log("parent_cost : "+parent_cost);
			
			total -= parent_cost;
			console.log("-total : "+total)
			$(".calc_cost span").html(total);
			
			$(this).closest(".selected_opt").remove();
			
			var n = $(".selected").find(".selected_opt").length;
			var str = $(".calc_goods").val();
				str = "총"+n+"개의 상품";
			$(".calc_goods").html(str);
		});
		
		var currentVal = $(".input_num").val();
		var price = Number($(".price").text());
		
		var allPrice = 0;
		
		function printPrice(){
			$(".calc_cost span").html(allPrice);
		}
		
		/* 수량 조절 버튼 */
		/* plus */
		$(".selected").on("click",".num_plus",function(){
			currentVal = $(this).closest(".calc_btn").find(".input_num").val(); 
			price = Number($(".price").text());
			console.log("plus price : "+price);
			currentVal++;
			
			$(this).closest(".calc_btn").find(".input_num").val(currentVal);
			allPrice = Number($(".calc_cost span").text());
			console.log("plus allPrice : "+allPrice);
			allPrice = allPrice + price;
			price = currentVal * price;
			
			$(this).closest(".selected_cost").find(".cost_text span").html(price)
			printPrice();
			price = Number($(".price").text());
		});
		
		/* minus */
		$(".selected").on("click",".num_minus",function(){
			if($(this).closest(".calc_btn").find(".input_num").val() == 1){
				alert("최소 주문 수량은 1개 입니다.");
				return;
			}
			currentVal = $(this).closest(".calc_btn").find(".input_num").val();
			price = Number($(".price").text());
			currentVal--;
			
			$(this).closest(".calc_btn").find(".input_num").val(currentVal);
			allPrice = Number($(".calc_cost span").text());
			allPrice = allPrice - price;
			price = currentVal * price;
			
			$(this).closest(".selected_cost").find(".cost_text span").html(price);
			printPrice();
			price = Number($(".price").text());
			console.log(price);
		});
	});
	
	// Get the modal
	var modal = document.getElementById('myModal');

	// Get the image and insert it inside the modal - use its "alt" text as a caption
	var img = document.getElementsByClassName("gImg");
	var modalImg = document.getElementById("img01");
	
	$(img).on("click",function(){
		modal.style.display = "block";
	    modalImg.src = this.src;
	});
	
	modal.onclick = function(){
		modal.style.display = "none";
	}
	
	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];

	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
	  modal.style.display = "none";
	}
	
	/* 세부정보 이동 */
	$(function(){
		$("ul.tab li").click(function(){
			var activeTab = $(this).attr("data-tab");
			$('ul.tab li').removeClass('current');
			$('.tabcontent').removeClass('current');
			$(this).addClass('current');
			$('#' + activeTab).addClass('current');
		});
	});
	
	/* 좋아요 이미지 변경 */
	   $("#heart_icon").on("click",function(){
		   var member = "${memberInfo}";
	      if(member != ""){
	         $.ajax({
	            type : "POST",
	            url : "favorite",
	            data : {
	               gno : "${goods.gno}",
	               mno : "${memberInfo.mno}"
	            },
	            success : function(data){
	            	if(data){
	            		alert("관심상품에 추가 되었습니다.");
	    				$("#heart_icon").attr("src",contextPath+"/resources/img/icon.png");
	    			}else{
	    				alert("관심상품에서 삭제 되었습니다.");
	    				$("#heart_icon").attr("src",contextPath+"/resources/img/icon2.png");
	    			}
	            }
	         });
	      }else{
	         var result = confirm("로그인이 필요한 서비스입니다. \n로그인 하시겠습니까?");
	         if(result){
	            location.href=contextPath+"/member/login";
	         }else{
	            return;
	         }
	      }
	   });
	   
	   /* 장바구니 버튼 */
	   $("#btn_cart").on("click",function(){
	      // form tag id='bgForm'있는 정보 넘기기 -> views/goods/cart.jsp
	      var check = $(".calc_cost span").text();
	      var member = "${memberInfo}";
	      
	      console.log(check);
	      
	      if(check == 0){
	         alert("선택한 상품이 존재하지 않습니다.\n상품을 선택해 주세요.");
	      }else{
	         var gno = ${goods.gno};
	         var sel_list = new Array();
	         
	         $(".selected_opt").each(function(){
	            var color = $(this).find(".color").text();
	            var size = $(this).find(".size").text();
	            var count = Number($(this).find(".input_num").val());
	            var price = Number($(this).find(".cost_text span").text());
	            console.log("color : "+color);
	            console.log("size : "+size);
	            console.log("count : "+count);
	            console.log("price : "+price);
	            
	            sel_list.push(gno + "," + color + "," + size + "," + count + "," + price);
	         });
	         
	         console.log(sel_list);
	         $("#addForm").attr("action","cart");
	         
	         $("#addForm").submit();
	      }
	   });
	   
	   /* 바로 구매 버튼 */
	   $("#btn_buy").on("click",function(){
	      // form tag id='bgForm'있는 정보 넘기기 -> view/goods/order.jsp
	      console.log($(".calc_cost span").text());
	      if($(".calc_cost span").text() == 0){
	         alert("선택한 상품이 존재하지 않습니다.\n상품을 선택해 주세요.");
	      }else{
	    	  var memberInfo = "${memberInfo}";
	    	  console.log(memberInfo);
	         // 정보들고 페이지 이동
	         if(memberInfo == ""){
	            // 비회원일때 로그인 모달창?
	            var modal2 = $("#loginModal");
	            modal2.attr("style","display:block");
	            
	            modal2.on("click",function(){
	               modal2.attr("style","display:none");
	            });
	             
	            $(".order_non").on("click",function(){
	               /* modal창 비회원구매 버튼 */
	              
	               $("#addForm").attr("action","orderDirect");
	  	         
	               $("#addForm").submit();
	            });
	            
	            $(".login").on("click",function(){
	            	location.href=contextPath+"/member/login?gno="+gno;
	            });
	                        
	         }else{
	            // 회원
	          
	            $("#addForm").attr("action","orderDirect");
		         
		        $("#addForm").submit();
	         }   
	      }
	   });
		
	   $("#btn_report").on("click",function(){
		   var memberInfo = "${memberInfo}";
		   if(memberInfo == '' || memberInfo == null) {
			   alert("로그인 후 이용가능합니다.");
		   }else {
			   $("#sendToBuyer").css("display","flex");
		   }
		   
	   });
	 	
	   //서류사항 textarea 체크
	   $('.reason').keyup(function(e) {
		 var content = $(this).val();
		 $('#counter').html("(" + content.length + " / 500자)"); //글자수 실시간 카운팅

		 if (content.length > 500) {
			alert("최대 500자까지 입력 가능합니다.");
			$(this).val(content.substring(0, 500));
			$('#counter').html("(500 / 500자)");
		 }
	   });

	   $("#sendToBuyerCloseBtn").click(function() {
		 $("#sendToBuyer").css("display", "none");
	   });
	   
	   $("#sendBtn").click(function(){
		   	var gno = "${goods.gno}";
		   	console.log(gno);
			var goodsName = $("#goodsName").html();
			console.log(goodsName);
			var reportId = "${memberInfo.mid}";
			console.log("id : " + reportId);
			var reason = $("#reason").val();
			if(reason == null || reason == "") {
				alert("문의사항을 작성해 주세요.");	
			}else {
				$.ajax({
					url: "reportGoods",
		 			type: "post",
		 			headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					},
					data : JSON.stringify({
						gno : "${goods.gno}",
						reportId,
						goodsName,
						reason
					}),
					success: function(data) {
						$("#sendToBuyer").css("display", "none");
						$("#reason").val("");
					}
				}); 
			}
		});
</script>



















