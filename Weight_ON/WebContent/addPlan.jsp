<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.LinkedList"%>
<%@ page import="dto.WorkOutDTO"%>
<%@ page import="dao.WorkOutLibDAO"%>

<%
	//라이브러리 종류를 결정하는 카테고리 변수
	String Cat = request.getParameter("Cat");
	String workoutNum = request.getParameter("workoutNum");
	String Num =request.getParameter("Num");
	int listNum = Integer.parseInt(Num);
	System.out.println(workoutNum);
	System.out.println(listNum);
	
	//workoutNum String변수에 운동 코드가 없다면 운동목록 페이지로 돌아가기
	if(workoutNum == null || workoutNum.trim().equals("")){
		response.sendRedirect("workOutLib.jsp");
		return;
	}
	
	WorkOutLibDAO dao = WorkOutLibDAO.getInstance();
	dao.addWorkOut(workoutNum);

	//처리 후 넘어 갈 페이지
	if(listNum == 0){
%>
	<script>
	  history.go(-1);
	</script>
<%
	}else{
		response.sendRedirect("plan.jsp");
	}
%>