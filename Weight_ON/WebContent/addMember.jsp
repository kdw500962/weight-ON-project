<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
		<meta charset="UTF-8">
		<title>회원 가입</title>
		<script type="text/javascript">
			function checkForm() {
				if (!document.newMember.id.value) {
					alert("아이디를 입력하세요.");
					return false;
				}
		
				if (!document.newMember.password.value) {
					alert("비밀번호를 입력하세요.");
					return false;
				}
		
				if (document.newMember.password.value != document.newMember.password_confirm.value) {
					alert("비밀번호를 동일하게 입력하세요.");
					return false;
				}
				if(document.newMember.id_group.value == "트레이너"){
					var code = prompt("가입승인코트를 입력하세요.","");
					if(code != 500){
						alert("가입승인코트를 확인하세요.");
						return false;
					}
				}
			}
		</script>
	</head>
	<body>
		<jsp:include page="./menu.jsp"/>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">회원 가입</h1>
			</div>
		</div>
		<div class="container">
			<form name="newMember" class="form-horizontal" action="addMember_Process.jsp" method="post" onsubmit="return checkForm()">
				<div class="form-group row">
				<label class="col-sm-2">아이디</label>
					<div class="col-sm-3">
						<input name="id" type="text" class="form-control" placeholder="id" >
					</div>
				</div>
				<div class="form-group  row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<input name="password" type="text" class="form-control" placeholder="password" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호확인</label>
				<div class="col-sm-3">
					<input name="password_confirm" type="text" class="form-control" placeholder="password 확인" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">성명</label>
				<div class="col-sm-3">
					<input name="name" type="text" class="form-control" placeholder="name" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">성별</label>
				<div class="col-sm-10">
					<input name="gender" type="radio" value="남"/> 남 
					<input name="gender" type="radio" value="여"/> 여
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">생일</label>
				<div class="col-sm-4  ">
					<input type="text" name="birthyy" maxlength="4" placeholder="년(yyyy)" size="6"> 
					<select name="birthmm">
						<option value="">월</option>
						<option value="01">01</option>
						<option value="02">02</option>
						<option value="03">03</option>
						<option value="04">04</option>
						<option value="05">05</option>
						<option value="06">06</option>
						<option value="07">07</option>
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
					</select> <input type="text" name="birthdd" maxlength="2" placeholder="일(dd)" size="4">
				</div>
			</div>
			<div class="form-group  row ">
				<label class="col-sm-2">이메일</label>
				<div class="col-sm-10">
					<input type="text" name="mail1" maxlength="50">@ 
					<select name="mail2">
						<option>naver.com</option>
						<option>daum.net</option>
						<option>gmail.com</option>
						<option>nate.com</option>
					</select>
				</div>				
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">전화번호</label>
				<div class="col-sm-6">
					<select name="phone1">
					<option value="">선택</option>
					<option value="010">010</option>
					<option value="011">011</option>
					<option value="016">016</option>
					<option value="017">017</option>
					<option value="019">019</option>						
					</select> - <input type="text" maxlength="4" size="4" name="phone2"> - <input type="text" maxlength="4" size="4" name="phone3">
				</div>
			</div>			
			<div class="form-group  row">
				<label class="col-sm-2 ">주소</label>
				<div class="col-sm-5">
					<input name="address" type="text" class="form-control" placeholder="address">
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">사용자 구분</label>
				<div class="col-sm-10">
					<input name="id_group" type="radio" value="일반회원" checked="checked"/> 일반회원 
					<input name="id_group" type="radio" value="트레이너" /> 트레이너
				</div>
			</div>
			<div class="form-group  row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-primary " value="등록 " > 
					<input type="reset" class="btn btn-primary " value="취소 " onclick="reset()" >
				</div>
			</div>
			</form>
		</div>
		<jsp:include page="./footer.jsp"/>
	</body>
</html>