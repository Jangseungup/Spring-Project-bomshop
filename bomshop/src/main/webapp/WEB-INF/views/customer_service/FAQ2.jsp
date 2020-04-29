<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.FAQ_topText{
		font-size : 21px;
		font-weight: bold;
	}
	.FAQ_content_wrap{
		margin-top : 6px;
		border-top : 2px solid black;
	}
	.FAQ_content{
		padding : 20px;
	}
	#FAQ_content_head:hover{
		cursor : pointer;
	}	
	.FAQ_content{
		padding-bottom : 20px;
		border-bottom : 1px solid lightgray;
	}
	
	#FAQ_content_target{
		margin-top : 10px;
		padding : 10px;
		background-color : #f1f1f1;
	}
</style>
<div class="FAQ_topText_wrap">
	<span class="FAQ_topText">FAQ / 주문/결제/배송 관련</span>
</div>
<div class="FAQ_content_wrap">
	<div class="FAQ_contents">
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 주문내역을 확인하고 싶어요.</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				<span>
					BOMSHOP 회원일 경우 마이페이지 > 주문/배송내역에서 확인 가능합니다.<br/>
					비회원 구매일 경우 상단의 '비회원 주문조회'를 통해 확인 가능합니다.
				</span>
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 배송지 변경은 어디서 하나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				<span>
					배송지 변경은 '마이페이지 > 배송지 편집'에서 기본배송지 설정 및 추가가 가능합니다.
				</span>
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶  결제방식은 어떻게 되나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				사이트 특성상 모든 결제는 사전에 충전한 캐쉬를 사용합니다.
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 배송조회는 어디서 하나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				BOMSHOP 회원일 경우 마이페이지 > 주문/배송내역에서 확인 가능합니다.<br/>
				비회원 구매일 경우 상단의 '비회원 주문조회'를 통해 확인 가능합니다.
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 주문한 상품과 다른 상품이 배송되었어요.(오배송)</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				물품이 오배송된 경우, '고객센터 > 1:1문의'를 통해 문의 주시면 빠른 조치가 가능합니다.
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 포인트는 어떻게 사용하나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				포인트는 상품을 구매하실 때 결제 페이지에서 사용가능하며 현금처럼 사용가능합니다.
			</div>
		</div>
		<div class="FAQ_content">
			<div id="FAQ_content_head" onclick="javascript:toggleContent(this);">
				<span>▶ 쿠폰은 어떻게 사용하나요?</span>
			</div>
			<div id="FAQ_content_target" class="FAQ_content_target">
				쿠폰은 상품을 구매하실 때 결제 페이지에서 사용가능하며 해당 쿠폰의 금액만큼 할인된 금액으로 상품을 구입하실 수 있습니다.
			</div>
		</div>
	</div>
</div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function(){
		$(".FAQ_content_target").hide();
	});
	
	function toggleContent(obj){
		var target = $(obj).parent().find('#FAQ_content_target');
		target.toggle();
	}
	
	
</script>