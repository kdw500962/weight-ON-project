<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Weight-ON-접속</title>
		<link rel="stylesheet" href="./resources/css/Weight-ON_connect.css"/>
	    <script type="text/javascript" src="./resources/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
        <div class="login-form">
            <p>Weight-ON</p>
            <h1>LOG-IN</h1>
            <form action="loginMember_Process.jsp">
                <div class="int-area">
                    <input type="text" name="id" id="id" autocomplete="off" required>
                    <label for="id">USER ID</label>
                </div>
                <div class="int-area">
                    <input type="password" name="password" id="password" autocomplete="off" required>
                    <label for="password">PASSWORD</label>
                </div>
                <%
					String error = request.getParameter("error");
					if (error != null) {
						out.println("<div class='danger'>");
						out.println("아이디와 비밀번호를 확인해 주세요");
						out.println("</div>");
					}
				%>
                <div class="btn-area">
                    <button type="submit" id="btn">LOG-IN</button>
                </div>
            </form>
            <div class="link-area">
                <a href="./addMember.jsp">Sign-Up</a>
            </div>
            <div class="link-area">       
                <a href="./findMember.jsp">Find ID/PW</a>
            </div>
        </div>
        <jsp:include page="./footer.jsp"/>
	</body>
</html>