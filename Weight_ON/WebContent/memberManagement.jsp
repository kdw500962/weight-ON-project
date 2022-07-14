<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="dto.SignDTO"%>
<%@ page import="dao.SignDAO"%>

<%
	request.setCharacterEncoding("UTF-8");
	String sessionId = (String) session.getAttribute("sessionId");
	String sessionId_group  = (String) session.getAttribute("sessionId_group");
	if(sessionId == null){
		response.sendRedirect("./connect.jsp");
	}
	if(!sessionId_group.equals("관리자")){
		response.sendRedirect("./Weight-ON_home.jsp");
	}
	//page에 표시 할 목록 개수 
	int pageSize = 10;
	
	String pageNum = request.getParameter("pageNum");
	
	if (pageNum == null) {
        pageNum = "1";
    }	
	//현재페이지 String타입으로 넘어온 pageNum의 값을 int타입으로 저장
	int currentPage = Integer.parseInt(pageNum);
	//DB에서 가져오는 Row의 범위 시작 번호
    int startRow = (currentPage - 1) * pageSize + 1;
  	//DB에서 가져오는 Row의 범위 끝 번호 
  	int endRow = currentPage * pageSize;
    int count = 0;
    
    List<SignDTO> SignList = null;
    SignDAO dao = SignDAO.getInstance();
    count =dao.getAllCount();
	System.out.println(count);
	if(count > 0){
		SignList= dao.getAllUser(startRow, pageSize);
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원관리</title>
		<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
		<script type="text/javascript">
		function deletlToMember(){
			if(confirm("회원정보를 삭제 하시겠습니까?")){
				$("#deleteForm").submit(); 
			}else{
				document.deleteForm.reset();
			}
		}
		</script>
	</head>
	<body>
		<jsp:include page="/menu.jsp"/>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">회원 관리</h1>
			</div>
		</div>
		<%
			if(count == 0){
		%>
			<div class="container">			
					<h1 class="display-3">가입된 회원이 없습니다.</h1>
			</div>
		<%
			}else{
		%>
		<div class="container">
			<div class="row justify-content-md-center">
				<div class="border row" style="width: 100%;">				
					<div class="col col-lg-2 align-self-center" align="left">
						<h4>회원 아이디</h4>
					</div>
					<div class="col col-lg-2 align-self-center">
						<h3>계정그룹</h3>
					</div>
					<div class="col col-lg-2 align-self-center">
						<h3>이름</h3>
					</div>
					<div class="col col-lg-2 align-self-center">
						<h3>생년원일</h3>
					</div>
					<div class="col col-lg-2 align-self-center">
						<h3>성별</h3>
					</div>
					<div class="col col-lg-2 align-self-center" align="center">
						<h3>삭제</h3>
					</div>
				</div>
				<%
					System.out.println(SignList.size());
					for(int i = 0; i<SignList.size(); i++){
								SignDTO user = SignList.get(i);
				%>
				<div class="border row" style="width: 100%;">				
					<div class="col col-lg-2 align-self-center" align="left">
						<h3><%=user.getId()%></h3>
					</div>
					<div class="col col-lg-2 align-self-center">
						<h3><%=user.getId_group()%></h3>
					</div>
					<div class="col col-lg-2 align-self-center">
						<h3><%=user.getName()%></h3>
					</div>
					<div class="col col-lg-2 align-self-center">
						<h3><%=user.getBirth()%></h3>
					</div>
					<div class="col col-lg-2 align-self-center">
						<h3><%=user.getGender()%></h3>
					</div>
					<div class="col col-lg-2 align-self-center" align="right">
						<form name="deleteForm" action="./deleteMember.jsp?id=<%=user.getId()%>" method="post">
							<a href="./deleteMember.jsp?id=<%=user.getId()%>" class="btn btn-danger" onclick="deletlToMember()">삭제 &raquo;</a>
						</form>
					</div>
				</div>
				<%
					}
				%>				
			</div>	
		</div>
		
	<nav aria-label="Page navigation example" >
		<ul class="pagination justify-content-center">
			<%
				if(count > 0){
					//페이지 총 수
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
					int startPage = 1;
					
					if(currentPage % 10 != 0){
						startPage = (int)(currentPage/10)*10 + 1;
					}else{
						startPage = ((int)(currentPage/10)-1)*10 + 1;
					}
					
					int pageBlock = 10;
					int endPage = startPage + pageBlock - 1;
					if (endPage > pageCount) endPage = pageCount;
					
					if (startPage > 10) {				
			%>
		 	<li class="page-item">			
				<a class="page-link" href="./memberManagement.jsp?pageNum=<%=startPage-10%>" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
				<span class="sr-only">Previous</span>
				</a>
			</li>
			<%		}
					
					for (int i = startPage ; i <= endPage ; i++){ 
			%>
			<li class="page-item">
				<a class="page-link" href="./memberManagement.jsp?pageNum=<%=i%>"><%=i%></a>
			</li>			
			<%
					}
					if (endPage < pageCount) {
			%>
			<li class="page-item">
				 <a class="page-link" href="./memberManagement.jsp?pageNum=<%=startPage+10%>" aria-label="Next">
				 <span aria-hidden="true">&raquo;</span>
				 <span class="sr-only">Next</span>
				 </a>
			</li>			
		<%
					}
				}
			}			
		%>
		</ul>
	</nav>
	<jsp:include page="/footer.jsp"/>
	</body>
</html>