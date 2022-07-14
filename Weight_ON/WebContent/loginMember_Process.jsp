<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.SignDTO"%>
<%@ page import="dao.SignDAO"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	SignDAO sign =SignDAO.getInstance();
	SignDTO userSign = new SignDTO();
	userSign= sign.userCheck(id, password);
	String id_group = userSign.getId_group();
	if(userSign.getId() != null){
		session.setAttribute("sessionId", id);
		session.setAttribute("sessionId_group", id_group);
		response.sendRedirect("resultMember.jsp?msg=2");		
	}else{
		response.sendRedirect("connect.jsp?error=1");
	}
%>


