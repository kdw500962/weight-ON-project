<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.SignDAO" %>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String id = request.getParameter("id");
	String findId = null;
	String findPassword = null;
	SignDAO sign_find = SignDAO.getInstance();
	if(name !=null){
		findId = sign_find.findId(name, birth);	
	}
	if(id !=null){
		findPassword = sign_find.findPassword(id, birth);
	}
	
	if(findId != null){
%>
	<script>
	  alert("아이디는 [<%=findId%>] 입니다.");
	  history.go(-1);
	</script>
<%
	}
	if(findPassword != null){
%>
	<script>
	  alert("비밀번호는 [<%=findPassword%>] 입니다.");
	  history.go(-1);
	</script>
<%
	}
	if(findId ==null || findPassword == null){
%>
	<script>
	  alert("가입된 정보가 없습니다.");
	  history.go(-1);
	</script>
<%		
	}
%>