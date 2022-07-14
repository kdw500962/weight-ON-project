<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.WorkOutDTO"%>
<%@ page import="dao.WorkOutLibDAO" %>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="./resources/css/bootstrap.min.css"/>
		<meta charset="UTF-8">
		<title>운동라이브러리</title>
		<script type="text/javascript">
			function addToPlan(){
				if(confirm("운동을 추가 하시겠습니까?")){
					document.addForm.submit();
				}else{
					document.addForm.reset();
				}
			}
		</script>
	</head>
	<body>
		<jsp:include page="./menu.jsp"/>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">운동정보</h1>
			</div>
		</div>
		<%
			String Cat = request.getParameter("Cat");
			String workoutNum = request.getParameter("workoutNum");
			WorkOutLibDAO dao = WorkOutLibDAO.getInstance();
			dao.getWorkOutLibrary();
			WorkOutDTO workOut = dao.getWorkOutByNum(workoutNum);
		%>
		<div class="container">
			<div class="row">
				<div class="col-md-5">
					<img src="/upload/<%=workOut.getFilename()%>" style="width: 100%">
				</div>
				<div class="col-md-6">
					<h3><%=workOut.getName()%></h3>
					<p> <b>운동 코드 : </b><span class="badge badge-danger">
						<%=workOut.getWorkoutNum()%></span>
					</p>
					<p><b>카테고리</b> : <%=workOut.getCategory()%></p>
					<p><b>주요 근육</b> : <%=workOut.getMajorMuscle()%></p>
					<p><b>지지 근육</b> : <%=workOut.getSupportMuscle()%></p>
					<p><b> 도구 </b> : <%=workOut.getEquipment()%></p>
					<p><b>운동 방법</b> :<br><%=workOut.getDescription()%></p>		
					<form name="addForm" action="./addPlan.jsp?workoutNum=<%=workOut.getWorkoutNum()%>" method="post">
					<a href="#" class="btn btn-info" onclick="addToPlan()">운동 추가 &raquo;</a>
					<a href="./workOutLib.jsp?Cat=<%=Cat%>" class="btn btn-secondary">운동 목록 &raquo;</a>
					</form>					
				</div>
				<%
					
				%>
			</div>
			<hr>
		</div>
		<jsp:include page="./footer.jsp"/>
	</body>
</html>