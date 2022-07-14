<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
		<meta charset="UTF-8">
		<title>ID/PW 찾기</title>
	</head>
	<body>
		<jsp:include page="./menu.jsp"/>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">ID/PW 찾기</h1>
			</div>
		</div>
		<div class="container" align="center">
			<div class="col-md-4 col-md-offset-4">
			<form name="findMember" class="form-horizontal" action="findMember_Process.jsp" method="post" onsubmit="return checkForm()">
				<h2 class="alert alert-primary" align="center">ID찾기</h2>
				<div class="form-group  row">
					<label class="col-sm-5">성명</label>
					<div class="col-sm-5">
						<input name="name" type="text" class="form-control" placeholder="name" >
					</div>
				</div>
				<div class="form-group  row">
					<label class="col-sm-5">생년월일</label>
					<div class="col-sm-5">
						<input name="birth" type="text" class="form-control" placeholder="yyyy/mm/dd" >
					</div>
				</div>		
				<div class="form-group  row" align="center">
					<div class="col-sm-offset-2 col-sm-10 ">
						<input type="submit" class="btn btn-primary " value="찿기 " > 
						<input type="reset" class="btn btn-primary " value="취소 " onclick="reset()" >
					</div>
				</div>
			</form>
			<form name="findMember" class="form-horizontal" action="findMember_Process.jsp" method="post" onsubmit="return checkForm()">
				<h2 class="alert alert-primary" align="center">PW찾기</h2>
				<div class="form-group row">
					<label class="col-sm-5">아이디</label>
					<div class="col-sm-5">
						<input name="id" type="text" class="form-control" placeholder="id" >
					</div>
				</div>
				<div class="form-group  row">
					<label class="col-sm-5">생년월일</label>
					<div class="col-sm-5">
						<input name="birth" type="text" class="form-control" placeholder="yyyy/mm/dd" >
					</div>
				</div>		
				<div class="form-group  row" align="center">
					<div class="col-sm-offset-2 col-sm-10 ">
						<input type="submit" class="btn btn-primary " value="찿기 " > 
						<input type="reset" class="btn btn-primary " value="취소 " onclick="reset()" >
					</div>
				</div>
			</form>
			</div>
		</div>
		<jsp:include page="./footer.jsp"/>
	</body>
</html>