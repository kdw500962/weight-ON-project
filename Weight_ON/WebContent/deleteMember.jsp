<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.SignDAO"%>
<%
	request.setCharacterEncoding("UTF-8");

	String sessionId = (String) session.getAttribute("sessionId");
	String id = request.getParameter("id");	

	SignDAO sign = SignDAO.getInstance();
	
	int msg = 0;
	if(id != null){
		msg= sign.deleteUser(id);
	}else{
		msg= sign.deleteUser(sessionId);
	}
	if(id != null){
		if(msg>=1){
			response.sendRedirect("memberManagement.jsp");
		}
	}else{
		if(msg>=1){
			session.invalidate();
			response.sendRedirect("resultMember.jsp");
		}
	}
%>


