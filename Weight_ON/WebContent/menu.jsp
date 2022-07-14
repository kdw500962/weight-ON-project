<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String sessionId = (String) session.getAttribute("sessionId");
	String sessionId_group  = (String) session.getAttribute("sessionId_group");
	
	if(sessionId == null){
		response.sendRedirect("./connect.jsp");
	}
%>
<h1 class="display-3 text-dark font-weight-bold" align="center">Weight-ON</h1>
<nav class = "navbar navbar-expand navbar-dark bg-secondary">
	<div class = "container">
		<div class = "navbar-header">
			<a class = "navbar-brand" href="./Weight-ON_home.jsp">Home</a>
		</div>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class = "navbar-nav mr-auto">
				<li class="nav-item">
				<div class="dropdown">
				  <a class="nav-link dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-expanded="false">
				    운동 라이브러리
				  </a>				
				  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
				  	<a class="dropdown-item" href="./workOutLib.jsp?Cat=전체">전체 운동 목록</a>
				    <a class="dropdown-item" href="./workOutLib.jsp?Cat=가슴">가슴 운동</a>
				    <a class="dropdown-item" href="./workOutLib.jsp?Cat=등">등 운동</a>
				    <a class="dropdown-item" href="./workOutLib.jsp?Cat=하체">하체 운동</a>
				    <a class="dropdown-item" href="./workOutLib.jsp?Cat=어깨">어깨 운동</a>
				    <a class="dropdown-item" href="./workOutLib.jsp?Cat=팔">팔 운동</a>
				    <a class="dropdown-item" href="./workOutLib.jsp?Cat=복근">코어 운동</a>
				    <c:choose>
				    	<c:when test="${sessionId_group != '일반회원'}">
				    	<a class="dropdown-item" href="./addWorkOut.jsp">운동 등록</a>
					    <a class="dropdown-item" href="./editWorkOut.jsp?edit=update">운동 수정</a>
					    <a class="dropdown-item" href="./editWorkOut.jsp?edit=delete">운동 삭제</a>
				    	</c:when>
				    </c:choose>
				  </div>
				</div>
				</li>
				<li class="nav-item">
					<div class="dropdown">
						<a class="nav-link dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-expanded="false">
						   운동계획
						</a>				
						<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
						    <a class="dropdown-item" href="./plan.jsp">운동계획 세우기</a>
						    <a class="dropdown-item" href="./planProgress.jsp">운동진행</a>
						</div>
					</div>
				</li>
				<li class="nav-item">
					<div class="dropdown">
						<a class="nav-link dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-expanded="false">
						   My데이터
						</a>				
						<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
						    <a class="dropdown-item" href="./planCalendar.jsp">월별 운동 현황</a>
						    <a class="dropdown-item" href="./inBody.jsp">체성분 기록</a>
						</div>
					</div>
				</li>
				<li class="nav-item"><a class=" nav-link" href="<c:url
						value="/adviceListAction.do?pageNum=1"/>">운동 조언 받기</a></li>
			</ul>
			<ul class="navbar-nav justify-content-end">	
				<c:choose>
				    <c:when test="${empty sessionId}">
						<li class="nav-item"><a class=" nav-link" href="<c:url
						value="./connect.jsp"/>">로그인</a></li>
						<li class="nav-item"><a class=" nav-link" href="<c:url
						value="./addMember.jsp"/>">회원가입</a></li>
				    </c:when>
					 <c:otherwise>
					 	<li class="nav-item"><a class="nav-link text-light">[<%=sessionId%>님]</a></li>
						<li class="nav-item"><a class=" nav-link" href="<c:url
						value="./logoutMember.jsp"/>">로그아웃</a></li>
						<li class="nav-item"><a class=" nav-link" href="<c:url
						value="./updateMember.jsp"/>">회원 수정</a></li>
					</c:otherwise>
				</c:choose>
				<c:choose>
				    	<c:when test="${sessionId_group == '관리자'}">
				    	<li class="nav-item"><a class=" nav-link" href="<c:url
						value="./memberManagement.jsp"/>">회원관리</a></li>			    
				    	</c:when>
				</c:choose>
			</ul>			
		</div>
	</div>
</nav>
