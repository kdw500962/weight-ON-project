<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="./resources/css/bootstrap.min.css"/>
		<meta charset="UTF-8">
		<%
			String workoutNum = request.getParameter("workoutNum");
		%>
		<sql:setDataSource var="dataSource"
			url="jdbc:mysql://localhost:3306/Weight_OnDB"
			driver="com.mysql.jdbc.Driver" user="root" password="1234" />
		<sql:query dataSource="${dataSource}" var="resultSet">
		   SELECT * FROM workoutlib WHERE w_num = ?
		   <sql:param value="<%=workoutNum%>" />
		</sql:query>
		<title>운동 수정</title>
	</head>
	<body>
		<jsp:include page="./menu.jsp"/>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">운동 수정</h1>
			</div>
		</div>
		<c:forEach var="row" items="${resultSet.rows}">		
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<img src="/upload/${row.w_fileName}" style="width: 100%">
				</div>
				<div class="col-md-8">
					<form name="newWorkOut" action="updateWorkOut_Process.jsp"
						class="form-horizontal" method="post" enctype="multipart/form-data">
						<div class="form-group row">
							<label class="col-sm-3">운동 코드</label>
							<div class="col-sm-3">
								<input type="text" id="workoutNum" name="workoutNum" class="form-control"
								value="${row.w_num}">
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3">운동명</label>
							<div class="col-sm-5">
								<input type="text" id="name" name="name" class="form-control"
								value="${row.w_name}">
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3">운동 카테고리</label>
							<div class="col-sm-5">
								<c:set var="category" value="${row.w_category}" />
								
								<input type="radio" name="category" value="가슴"
								 <c:if test="${category.equals('가슴')}"> <c:out value="checked" /> </c:if>>
								가슴
								<input type="radio" name="category" value="등"
								 <c:if test="${category.equals('등')}"> <c:out value="checked" /> </c:if>>
								등
								<input type="radio" name="category" value="어깨"
								 <c:if test="${category.equals('어깨')}"> <c:out value="checked" /> </c:if>>
								어깨<br>
								<input type="radio" name="category" value="하체"
								 <c:if test="${category.equals('하체')}"> <c:out value="checked" /> </c:if>>
								하체
								<input type="radio" name="category" value="팔"
								 <c:if test="${category.equals('팔')}"> <c:out value="checked" /> </c:if>>
								팔
								<input type="radio" name="category" value="복근" 
								 <c:if test="${category.equals('복근')}"> <c:out value="checked" /> </c:if>>
								복근
								
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3">운동 도구</label>
							<div class="col-sm-5">
								<c:set var="equipment" value="${row.w_equipment}" />
								
								<input type="radio" name="equipment" value="바벨"
								 <c:if test="${equipment.equals('바벨')}"> <c:out value="checked" /> </c:if>>
								바벨
								<input type="radio" name="equipment" value="덤벨"
								 <c:if test="${equipment.equals('덤벨')}"> <c:out value="checked" /> </c:if>>
								덤벨
								<input type="radio" name="equipment" value="머신" 
								<c:if test="${equipment.equals('머신')}"> <c:out value="checked" /> </c:if>>
								머신
								<input type="radio" name="equipment" value="맨몸" 
								<c:if test="${equipment.equals('맨몸')}"> <c:out value="checked" /> </c:if>>
								머신
								
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3">주요 근육</label>
							<div class="col-sm-5">
								<input type="text" id="majorMuscle" name="majorMuscle" class="form-control"
								value="${row.w_majorMuscle}">
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3">지지 근육</label>
							<div class="col-sm-5">
								<input type="text" id="supportMuscle" name="supportMuscle" class="form-control"
								value="${row.w_supportMuscle}">
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3">운동 설명</label>
							<div class="col-sm-5">
								<textarea name="description" rows="2" cols="50" class="form-control">${row.w_description}</textarea>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3">이미지</label>
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
			</div>
		</div>
		</c:forEach>
		<jsp:include page="./footer.jsp"/>
	</body>
</html>