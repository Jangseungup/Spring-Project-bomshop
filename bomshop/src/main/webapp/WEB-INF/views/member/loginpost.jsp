<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="loginPost" id="postForm" method="post">
		<input type="hidden" name="mid" value="${mid}"/>
		<input type="hidden" name="mpw" value="${mpw}"/>
	</form>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		$(function(){
			$("#postForm").submit();
		});
	</script>
</body>
</html>