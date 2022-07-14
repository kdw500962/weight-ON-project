<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.PlanDTO"%>
<%@ page import="dao.PlanRecordDAO" %>

<%
	String sessionId = request.getParameter("sessionId");
	String date = request.getParameter("date");
	
	PlanRecordDAO dao = PlanRecordDAO.getInstance();
	int msg = dao.deletePlanProgress(sessionId, date);
	
		
	
	if(msg >= 1){
		response.sendRedirect("planCalendar.jsp");
	}else{
%>
	<script>
	  history.go(-1);
	</script>
<%
	}
%>