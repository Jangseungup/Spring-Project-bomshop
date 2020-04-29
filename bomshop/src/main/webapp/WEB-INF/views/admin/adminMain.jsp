<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp"%>
	<div id="declarationStatus">
		<table>
			<tr>
				<th>유저신고</th>
				<th>쿠폰</th>
				<th>물품신고</th>
				<th>광고신청</th>
				<th>고객문의</th>
			</tr>
			<tr>
				<td><a href="${path}/admin/memberManagement">${reportCount}</a>건</td>
				<td><a href="${path}/admin/coupon">${couponCount}</a>건</td>
				<td><a href="${path}/admin/reportGoods">${goodsCount}</a>건</td>
				<td><a href="${path}/admin/advertise">${advertiseCount}</a>건</td>
				<td><a href="${path}/admin/serviceCenter">${serviceCount}</a>건</td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>