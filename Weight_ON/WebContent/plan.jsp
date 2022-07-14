<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.WorkOutDTO"%>
<%@ page import="dao.WorkOutLibDAO"%>
<%@ page import="java.util.LinkedList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css"/>
<%
	String sessionId = (String) session.getAttribute("sessionId");

	if(sessionId == null){
		response.sendRedirect("./connect.jsp");
	}
%>
<title>운동계획</title>
<script type="text/javascript">
	function addToPlanList(){
		if(confirm("운동을 추가 하시겠습니까?")){
			document.savePlan.submit();
		}else{
			document.savePlan.reset();
		}
	}

</script>
</head>
<body>
<jsp:include page="./menu.jsp"/>
<div class="jumbotron">
	<div class="container">
		<h1 class="display-3">운동계획 세우기</h1>
	</div>
</div>
<div class="container">
<form name="savePlan" action="./savePlan.jsp"method="post">
	<div class="row">
		<table width="100%">
			<tr>
				<td align="left"><a href="./deletePlan.jsp?sessionId=<%=sessionId%>" class="btn btn-danger">전체 삭제하기</a></td>
				<td align="right"><a href="#" class="btn btn-success" onclick="addToPlanList()">계획 저장 &raquo;</a></td>
			</tr>
		</table>
	</div>
	<div style="padding-top: 50px">
		<table class="table table-hover">
			<tr>
				<th>운동명</th><th>세트수</th><th>중량</th><th>추가</th><th>감소</th>
			</tr>
<%
				WorkOutLibDAO dao = WorkOutLibDAO.getInstance();
				LinkedList<WorkOutDTO> planList = dao.getPlanList();
				if(planList == null){
					planList = new LinkedList<WorkOutDTO>();
				}
					
				for(int i=1; i<planList.size(); i++){
				//운동 리스트 하나씩 출력하기
					WorkOutDTO workOut = planList.get(i);
%>
			<tr>
<%
					if(workOut.getSetCount()==1){
%>
				<td><%=workOut.getWorkoutNum()%>-<%=workOut.getName()%></td>
				<td><%=workOut.getSetCount()%> Set</td>
				<td><input name="setWeight" type="text" style = "text-align:center;" maxlength="3" size="1" value="0"> kg</td>
				<td><a href="./addPlan.jsp?workoutNum=<%=workOut.getWorkoutNum()%>&&Num=<%=i%>"
				class="badge badge-success">세트 추가</a></td>
				<td><a href="./deletePlan.jsp?workoutNum=<%=workOut.getWorkoutNum()%>&&Num=<%=i%>"
				class="badge badge-danger">SET감소</a></td>	
<%
					}else{
%>
				<td></td>
				<td><%=workOut.getSetCount()%>Set</td>
				<td><input name="setWeight" type="text" style = "text-align:center;" maxlength="3" size="1" value="0"> kg</td>
				<td></td>
				<td></td>	
<%
					}
				}
%>
			</tr>
			<tr>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
			</tr>	
		</table>	
	</div>
	<hr>
</form>
</div>
<jsp:include page="./footer.jsp"/>
</body>
</html>