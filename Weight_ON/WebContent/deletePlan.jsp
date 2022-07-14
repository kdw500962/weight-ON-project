<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.LinkedList"%>
<%@ page import="dto.WorkOutDTO"%>
<%@ page import="dao.WorkOutLibDAO" %>

<%
	String sessionId = request.getParameter("sessionId");
	String workoutNum = request.getParameter("workoutNum");
	String Num =request.getParameter("Num");
	if(Num != null){
		int listNum = Integer.parseInt(Num);
	}	
	
	WorkOutLibDAO dao = WorkOutLibDAO.getInstance();
	if(workoutNum != null){
		dao.deletePlan(workoutNum);
	}
		
	
	if(sessionId != null){
		dao.resetPlan(sessionId);
	}
	response.sendRedirect("plan.jsp");
%>