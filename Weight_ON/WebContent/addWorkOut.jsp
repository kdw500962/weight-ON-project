<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.WorkOutDTO"%>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("UTF-8");
	String sessionId = (String) session.getAttribute("sessionId");
	String sessionId_group  = (String) session.getAttribute("sessionId_group");
	
	if(sessionId == null){
		response.sendRedirect("./connect.jsp");
	}
	if(sessionId_group == "일반회원"){
		response.sendRedirect("./Weight-ON_home.jsp");
	}
%>
<html>
	<head>
		<link rel="stylesheet" href="./resources/css/bootstrap.min.css"/>
		<meta charset="UTF-8">
		<title>운동 등록</title>
	</head>
	<body>
		<jsp:include page="./menu.jsp"/>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">운동 등록</h1>
			</div>
		</div>
		<div class="container">
			<form name="newWorkOut" action="addWorkOut_Process.jsp" class="form-
			horizontal" method="post" enctype="multipart/form-data">
				<div class="form-group row">
					<label class="col-sm-2">운동 코드</label>
					<div class="col-sm-3">
						<input type="text" name="workoutNum" class="form-control">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">운동명</label>
					<div class="col-sm-3">
						<input type="text" name="name" class="form-control">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">운동 카테고리</label>
					<div class="col-sm-3">
						<input type="radio" name="category" value="가슴">
						가슴
						<input type="radio" name="category" value="등">
						등
						<input type="radio" name="category" value="어깨">
						어깨<br>
						<input type="radio" name="category" value="하체">
						하체
						<input type="radio" name="category" value="팔">
						팔
						<input type="radio" name="category" value="복근">
						복근
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">운동 도구</label>
					<div class="col-sm-3">
						<input type="radio" name="equipment" value="바벨">
						바벨
						<input type="radio" name="equipment" value="덤벨">
						덤벨
						<input type="radio" name="equipment" value="머신">
						머신
						<input type="radio" name="equipment" value="맨몸">
						맨몸
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">주요 근육</label>
					<div class="col-sm-3">
						<input type="text" name="majorMuscle" class="form-control">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">지지 근육</label>
					<div class="col-sm-3">
						<input type="text" name="supportMuscle" class="form-control">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">운동 설명</label>
					<div class="col-sm-5">
						<textarea name="description" cols="50" rows="2" class="form-control"></textarea>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">이미지</label>
					<div class="col-sm-5">
						<input type="file" name="workOutImage" class="form-control">
					</div>
				</div> 
				<div class="form-group row">
					<div class="col-sm-offset-2 col-sm-10">
						<input type="submit"class="btn btn-primary" value="등록">
					</div>
				</div>
			</form>
		</div>
		<jsp:include page="./footer.jsp"/>
	</body>
</html>