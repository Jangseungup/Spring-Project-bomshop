<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/review.css">

<div class="review_wrap">
	<div class="review_tabs">
		<div>
			리뷰
			<span></span>
		</div>
		<!-- review nav -->
		<ul class="re_tab">
			<li data-tab="re_tab3">텍스트리뷰</li>
			<li data-tab="re_tab2">포토리뷰</li>
			<li class="current" data-tab="re_tab1">전체</li>
		</ul>
	</div>
	
	<!-- The Modal -->
	<div id="reModal" class="reModal">
	  <!-- The Close Button -->
	  <span class="close" onclick="document.getElementById('reModal').style.display='none'">&times;</span>
	
	  <!-- Modal Content (The Image) -->
	  <img class="reModal-content" id="img02" class="modalImg">
	</div>
	
	<div id="re_tab1" class="review_container allReview current">
		<!-- 전체 리뷰 -->
	</div>
	
	<div id="re_tab2" class="review_container pReview">
		<!-- 포토리뷰? -->
	</div>
	
	<div id="re_tab3" class="review_container tReview">
		<!-- 텍스트 리뷰 -->
	</div>
</div>

<script>var contextPath = "${pageContext.request.contextPath}";</script>
<script>
	$(document).ready(function(){
		var gno = "${goods.gno}";
		
		console.log(contextPath+"/review/"+gno);
		
		allList(gno);
		
		function allList(gno){
			// data == Map<String, Object>
			// data.allList == List<ReviewVO>
			// data.pList == List<ReviewVO>
			// data.tList == List<ReviewVO>
			$.getJSON(contextPath+"/review/"+gno,function(data){
				console.log("reviewCnt : "+data.reviewCnt);
				$(".reviewCnt").append(data.reviewCnt);
				$(".review_tabs div span").append(data.reviewCnt);
				
				var str = "";
					str += "<h3>";
					str += "포토리뷰 ";
					str += "<span>"+data.pCount+"</span>";
					str += "</h3>";
					
				$(data.pList).each(function(){
					console.log(this.mid);
					console.log(this.regdate);
					str += "<ul class='p_rev'>";
					str += "<li class='re_mname re_profile'>"+this.mid+"</li>";
					str += "<li class='re_date re_profile'>"+getDate(this.regdate)+"</li>";
					switch(this.grade){
						case 1 : 
							str += "<li class='mgrade'>";
							str += "★";
							str += "</li>";
								break;
						case 2 : 
							str += "<li class='mgrade'>";
							str += "★★";
							str += "</li>";
								break;
						case 3 : 
							str += "<li class='mgrade'>";
							str += "★★★";
							str += "</li>";
								break;
						case 4 : 
							str += "<li class='mgrade'>";
							str += "★★★★";
							str += "</li>";
								break;
						case 5 : 
							str += "<li class='mgrade'>";
							str += "★★★★★";
							str += "</li>";
								break;
					}
					str += "<li class='re_content'>"+this.content+"</li>";
					str += "<li class='re_img'><img class='reImg' src='"+contextPath+"/resources/img/i1.jpg'/></li>";
					str += "</ul>";
				});
				
				str += "<div class='more_plist'>";
				str += "<input type='button' class='morePBtn btn btn-default btn-lg btn-block' value='더보기'/>";
				str += "</div>";
				
				str += "<h3>";
				str += "텍스트리뷰 ";
				str += "<span>"+data.tCount+"</span>";
				str += "</h3>";
				
				$(data.tList).each(function(){
					str += "<ul class='t_rev'>";
					str += "<li class='re_mname'>'"+this.mid+"'</li>";
					str += "<li class='re_date'>'"+getDate(this.regdate)+"'</li>";
					switch(this.grade){
						case 1 : 
							str += "<li class='mgrade'>";
							str += "★";
							str += "</li>";
								break;
						case 2 : 
							str += "<li class='mgrade'>";
							str += "★★";
							str += "</li>";
								break;
						case 3 : 
							str += "<li class='mgrade'>";
							str += "★★★";
							str += "</li>";
								break;
						case 4 : 
							str += "<li class='mgrade'>";
							str += "★★★★";
							str += "</li>";
								break;
						case 5 : 
							str += "<li class='mgrade'>";
							str += "★★★★★";
							str += "</li>";
								break;
					}
					str += "<li class='re_content'>'"+this.content+"'</li>";
					str += "</ul>";
				});
				str += "<div class='more_tlist'>";
				str += "<input type='button' class='moreTBtn btn btn-default btn-lg btn-block' value='더보기'/>";
				str += "</div>";
				
				$("#re_tab1").html(str);
				
				$(".p_rev").slice(0,3).show();
				$(".t_rev").slice(0,3).show();
				
				$(".morePBtn").on("click",function(){
					console.log("click");
					$(".p_rev:hidden").slice(0,3).show();
					
					if($(".p_rev:hidden").length == 0){
						$(".more_plist").attr("style","display:none");
					}
				});
				
				$(".moreTBtn").on("click",function(){
					$(".t_rev:hidden").slice(0,3).show();
					
					if($(".t_rev:hidden").length == 0){
						$(".more_tlist").attr("style","display:none");
					}
				});
				
				// Get the modal
				var modal2 = $("#reModal");

				// Get the image and insert it inside the modal - use its "alt" text as a caption
				var img2 = $(".reImg");
				var modalImg2 = $("#img02");
				
				img2.on("click",function(){
					console.log("click");
					modal2.attr("style","display:block");
					modalImg2.attr("src",this.src);
				})
				
				modal2.on("click",function(){
					modal2.attr("style","display:none");	
				})
				
				// Get the <span> element that closes the modal
				var span = document.getElementsByClassName("close")[0];

				// When the user clicks on <span> (x), close the modal
				span.onclick = function() {
				  modal2.style.display = "none";
				}
			});
		}
		
		$("ul.re_tab li").click(function(){
			var activeReTab = $(this).attr("data-tab");
			$("ul.re_tab li").removeClass("current");
			$(".review_container").removeClass("current");
			$(this).addClass("current");
			$("#" + activeReTab).addClass("current");
			
			if(activeReTab == "re_tab2"){
				console.log(activeReTab);
				pList(gno);
			}else if(activeReTab == "re_tab3"){
				console.log(activeReTab);
				tList(gno);
			}
			
			function pList(gno){
				console.log("pList 호출");
				
				$.getJSON(contextPath+"/review/"+gno,function(data){
						var str = "";
						str += "<h3>";
						str += "포토리뷰 ";
						str += "<span>"+data.pCount+"</span>";
						str += "</h3>";
						
					$(data.pList).each(function(){
						console.log(this.mid);
						console.log(this.regdate);
						str += "<ul class='p_rev'>";
						str += "<li class='re_mname re_profile'>'"+this.mid+"'</li>";
						str += "<li class='re_date re_profile'>'"+getDate(this.regdate)+"'</li>";
						switch(this.grade){
							case 1 : 
								str += "<li class='mgrade'>";
								str += "★";
								str += "</li>";
									break;
							case 2 : 
								str += "<li class='mgrade'>";
								str += "★★";
								str += "</li>";
									break;
							case 3 : 
								str += "<li class='mgrade'>";
								str += "★★★";
								str += "</li>";
									break;
							case 4 : 
								str += "<li class='mgrade'>";
								str += "★★★★";
								str += "</li>";
									break;
							case 5 : 
								str += "<li class='mgrade'>";
								str += "★★★★★";
								str += "</li>";
									break;
						}
						str += "<li class='re_content'>'"+this.content+"'</li>";
						str += "<li class='re_img'><img class='reImg' src='"+contextPath+"/resources/img/i1.jpg'/></li>";
						str += "</ul>";
					});
					
					str += "<div class='more_plist'>";
					str += "<input type='button' class='morePBtn btn btn-default btn-lg btn-block' value='더보기'/>";
					str += "</div>";
					
					$("#re_tab2").html(str);
					$("#re_tab2 .p_rev").slice(0,3).show();
					
					$("#re_tab2 .morePBtn").on("click",function(){
						console.log("click");
						$("#re_tab2 .p_rev:hidden").slice(0,3).show();
						
						if($("#re_tab2 .p_rev:hidden").length == 0){
							$("#re_tab2 .more_plist").attr("style","display:none");
						}
					});
					
					// Get the modal
					var modal2 = $("#reModal");

					// Get the image and insert it inside the modal - use its "alt" text as a caption
					var img2 = $(".reImg");
					var modalImg2 = $("#img02");
					
					img2.on("click",function(){
						console.log("click");
						modal2.attr("style","display:block");
						modalImg2.attr("src",this.src);
					})
					
					modal2.on("click",function(){
						modal2.attr("style","display:none");	
					})
					
					// Get the <span> element that closes the modal
					var span = document.getElementsByClassName("close")[0];

					// When the user clicks on <span> (x), close the modal
					span.onclick = function() {
					  modal2.style.display = "none";
					}
				});
			}
			
			function tList(gno){
				console.log("tList 호출");
				
				$.getJSON(contextPath+"/review/"+gno,function(data){
					var str = "";
					str += "<h3>";
					str += "텍스트리뷰 ";
					str += "<span>"+data.tCount+"</span>";
					str += "</h3>";
					
					$(data.tList).each(function(){
						str += "<ul class='t_rev'>";
						str += "<li class='re_mname'>'"+this.mid+"'</li>";
						str += "<li class='re_date'>'"+getDate(this.regdate)+"'</li>";
						switch(this.grade){
							case 1 : 
								str += "<li class='mgrade'>";
								str += "★";
								str += "</li>";
									break;
							case 2 : 
								str += "<li class='mgrade'>";
								str += "★★";
								str += "</li>";
									break;
							case 3 : 
								str += "<li class='mgrade'>";
								str += "★★★";
								str += "</li>";
									break;
							case 4 : 
								str += "<li class='mgrade'>";
								str += "★★★★";
								str += "</li>";
									break;
							case 5 : 
								str += "<li class='mgrade'>";
								str += "★★★★★";
								str += "</li>";
									break;
						}
						str += "<li class='re_content'>'"+this.content+"'</li>";
						str += "</ul>";
					});
					str += "<div class='more_tlist'>";
					str += "<input type='button' class='moreTBtn btn btn-default btn-lg btn-block' value='더보기'/>";
					str += "</div>";
					
					$("#re_tab3").html(str);
					$("#re_tab3 .t_rev").slice(0,3).show();
					
					$("#re_tab3 .moreTBtn").on("click",function(){
						console.log("click");
						$("#re_tab3 .t_rev:hidden").slice(0,3).show();
						
						if($("#re_tab3 .t_rev:hidden").length == 0){
							$("#re_tab3 .more_tlist").attr("style","display:none");
						}
					});
				});
			}
		});
	});
	
	function getDate(timeValue) {
		var dateObj = new Date(timeValue);
		
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth()+1;
		if(month < 10) {
		   month = "0" + month;
		}
		var date = dateObj.getDate();
		var hour = dateObj.getHours();
		var minute = dateObj.getMinutes();
		var seconds = dateObj.getSeconds();
		
		return year + "-" + month + "-" + date + " " + hour + ":" + minute;  
	}
	
	
</script>