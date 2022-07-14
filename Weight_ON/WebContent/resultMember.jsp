<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<script type="text/javascript" src="./resources/js/bootstrap.bundle.min.js"></script>
<title>회원 정보</title>
</head>
<body>
	<jsp:include page="./menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원정보</h1>
		</div>
	</div>

	<div class="container" align="center">
		<%
			String msg = request.getParameter("msg");

			if (msg != null) {
				if (msg.equals("0")){
					out.println(" <h2 class='alert alert-danger'>회원정보가 수정되었습니다.</h2>");
				}else if (msg.equals("1")){
					out.println(" <h2 class='alert alert-danger'>회원가입을 축하드립니다.</h2>");
				}else if (msg.equals("2")) {
					response.sendRedirect("./Weight-ON_home.jsp");
				}				
			} else {
				out.println("<h2 class='alert alert-danger'>회원정보가 삭제되었습니다.</h2>");
			}
		%>
	</div>
	<jsp:include page="./footer.jsp"/>
</body>
</html>