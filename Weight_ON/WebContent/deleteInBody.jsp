<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.inBodyDTO"%>
<%@ page import="dao.inBodyDAO"%>

<%
	request.setCharacterEncoding("UTF-8");
	String sessionId = (String) session.getAttribute("sessionId");
	int num =   Integer.parseInt(request.getParameter("num"));
		
	inBodyDAO dao = inBodyDAO.getInstance();
	int msg = dao.deleteInBody(sessionId, num);
	
	if(msg>=1){
		response.sendRedirect("./inBody.jsp");
	}else{
%>
	<script>
	  history.go(-1);
	</script>
<%
	}
%>