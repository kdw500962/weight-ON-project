<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.SignDAO" %>
<%@ page import="java.sql.*"%>


<%
	request.setCharacterEncoding("UTF-8");

	String year = request.getParameter("birthyy");
	String month = request.getParameterValues("birthmm")[0];
	String day = request.getParameter("birthdd");
	String birth = year + "/" + month + "/" + day;
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameterValues("mail2")[0];
	String mail = mail1 + "@" + mail2;
	String phone1 = request.getParameterValues("phone1")[0];
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String phone = phone1 + "-" + phone2 + "-" + phone3;
%>
 <jsp:useBean id="user" class="dto.SignDTO">
     <jsp:setProperty name="user" property="id"/>
     <jsp:setProperty name="user" property="password"/>
     <jsp:setProperty name="user" property="name"/>
     <jsp:setProperty name="user" property="gender"/>
     <jsp:setProperty name="user" property="address"/>
     <jsp:setProperty name="user" property="id_group"/>    
 </jsp:useBean>
<%
	user.setBirth(birth);
	user.setMail(mail);
	user.setPhone(phone);
	SignDAO sign_up = SignDAO.getInstance();
	int msg = sign_up.updateUser(user);
	
	if(msg>=1){
		response.sendRedirect("./resultMember.jsp?msg=0");
	}
%>

