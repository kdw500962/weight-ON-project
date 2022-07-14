<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.inBodyDTO"%>
<%@ page import="dao.inBodyDAO"%>

<%
	request.setCharacterEncoding("UTF-8");
	String sessionId = (String) session.getAttribute("sessionId");
	String save_day = request.getParameter("save_day");
	System.out.println(save_day);
	String weight = request.getParameter("weight");
	System.out.println(weight);
	String bodyFat =request.getParameter("bodyFat");
	System.out.println(bodyFat);
	String muscleMass =request.getParameter("muscleMass");
	System.out.println(muscleMass);
	
	inBodyDTO inbody = new inBodyDTO();
	inbody.setId(sessionId);
	inbody.setWeight(weight);
	inbody.setBodyFat(bodyFat);
	inbody.setMuscleMass(muscleMass);
	inbody.setSave_day(save_day);
	
	inBodyDAO dao = inBodyDAO.getInstance();
	int msg = dao.addInBody(inbody);
	
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