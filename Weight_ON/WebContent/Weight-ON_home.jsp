<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Weight-ON_home</title>
		<link rel="stylesheet" href="./resources/css/bootstrap.min.css"/>
		<script type="text/javascript" src="./resources/js/bootstrap.bundle.min.js"></script>
		<style>
		.dot {
		  vertical-align: middle;
		  text-align:center;
		  height: 200px;
		  width: 200px;
		  font-size:30px;
		  font-weight:900;
		  background-color: #666666;
		  border-radius: 50%;
		  display: table-cell;
		}
		</style>
	</head>
	<body>
		<%@ include file = "menu.jsp" %>
		<%
			String loginId = (String) session.getAttribute("sessionId");
		%>
		<h2 class="alert alert-success" align="center"><%=loginId %>님 환영합니다</h2>
		<div class="container">
		<h2 class="alert alert-primary" align="center">오늘의 운동을 선택하세요</h2>
		<div class="row justify-content-md-center">
			<div style="text-align:center" align="center">
			  <div class="dot">
			  	<a href="./workOutLib.jsp?Cat=가슴">가슴 운동</a>
			  </div>
			  <div class="dot">
			  	<a href="./workOutLib.jsp?Cat=등">등 운동</a>
			  </div>
			  <div class="dot">
			  	<a href="./workOutLib.jsp?Cat=하체">하체 운동</a>
			  </div>
			</div>
			<div style="text-align:center" align="center">
			  <div class="dot">
			  	<a href="./workOutLib.jsp?Cat=어깨">어깨 운동</a>
			  </div>
			  <div class="dot">
			  	<a href="./workOutLib.jsp?Cat=팔">팔운동</a></div>
			  <div class="dot">
			  	<a href="./workOutLib.jsp?Cat=복근">코어 운동</a>
			  </div>
			</div>
		</div>
		</div>
		<jsp:include page="./footer.jsp"/>
	</body>
</html>