<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.PlanDTO"%>
<%@ page import="dao.PlanRecordDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css"/>
<%
	request.setCharacterEncoding("UTF-8");
	String sessionId = (String) session.getAttribute("sessionId");
	if(sessionId == null){
		response.sendRedirect("./connect.jsp");
	}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = request.getParameter("date");
	ArrayList<PlanDTO> planList = new ArrayList<PlanDTO>();
	PlanRecordDAO dao = PlanRecordDAO.getInstance();
	System.out.println(date);
	planList = dao.PlanRecordList(sessionId, date);
%>
<title>운동기록 내용확인</title>
</head>
<body>
<jsp:include page="./menu.jsp"/>
<div class="jumbotron">
	<div class="container">
		<h1 class="display-3">운동기록 내용확인</h1>
	</div>
</div>
<div class="container">
	<form name="Plan" action="./planProgress_Process.jsp" method="post">
	<div class="row">
		<table width="100%">
			<tr>
				<td align="left"><a href="./deletePlanRecord.jsp?date=<%=date%>&&sessionId=<%=sessionId%>" class="btn btn-danger">기록 삭제하기</a></td>
				<td align="right"><a href="./planCalendar.jsp" class="btn btn-secondary">뒤로가기&raquo;</a></td>
			</tr>
		</table>
	</div>		
	<div style="padding-top: 50px; overflow: auto;">
		<table class="table table-hover">
			<colgroup>
				<col style="width:30%;">
				<col style="width:15%;">
				<col style="width:20%;">
				<col style="width:35%;">
			</colgroup>
			<tr align="center">
				<th>운동 명</th>
				<th>세트 수</th>
				<th>중량</th>
				<th>운동 메모</th>
			</tr>
<%			
				for(int i=0; i<planList.size(); i++){
					//운동 리스트 하나씩 출력하기
					PlanDTO plan = planList.get(i);
%>
			<tr align="center">
				<th style = "vertical-align : middle;"><%=plan.getName()%></th>
				<th style = "vertical-align : middle;"><%=plan.getSetCount()%> Set</th>
				<th style = "vertical-align : middle;"><%=plan.getSetWeight()%> kg</th>				
				<td style = "vertical-align : middle;"><%=plan.getMemo()%></td>
			</tr>
<%
				}
%>
			<tr>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
			</tr>
		</table>
	</div>
	</form>
</div>
<jsp:include page="./footer.jsp"/>	
</body>
</html>