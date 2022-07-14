<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.WorkOutLibDAO"%>
<%
	request.setCharacterEncoding("UTF-8");
	String workoutNum = request.getParameter("workoutNum");
	WorkOutLibDAO deleteWorkOut = WorkOutLibDAO.getInstance();
	int msg = deleteWorkOut.deleteWorkOut(workoutNum);
	
	if(msg>=1){
		response.sendRedirect("editWorkOut.jsp?edit=delete");
	}
%>
