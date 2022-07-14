<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="dto.WorkOutDTO"%>
<%@ page import="dao.WorkOutLibDAO"%>

<%
	request.setCharacterEncoding("UTF-8");
	String sessionId = (String) session.getAttribute("sessionId");
	String sessionId_group  = (String) session.getAttribute("sessionId_group");
	
	if(sessionId == null){
		response.sendRedirect("./connect.jsp");
	}
	if(sessionId_group.equals("일반회원")){
		response.sendRedirect("./Weight-ON_home.jsp");
	}
	//page에 표시 할 목록 개수 
	int pageSize = 10;
	//표시 할 페이지 번호
	String pageNum = request.getParameter("pageNum");
	
	String edit = request.getParameter("edit");
	
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
    
    List<WorkOutDTO> workOutList = null;
    WorkOutLibDAO dao = WorkOutLibDAO.getInstance();
    count = dao.getAllCount();
    if(count > 0){
    	workOutList= dao.getAllWorkOut(startRow, endRow);		
    }
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>운동라이브러리</title>
		<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
		<script type="text/javascript">
			function deleteConfirm(workoutNum){
				if(confirm("운동정보를 삭제합니다!!") == true){
					location.href = "./deleteWorkOut.jsp?workoutNum="+workoutNum;
				}else{
					return;
				}
			}
		</script>
	</head>
	<body>
		<jsp:include page="./menu.jsp"/>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">운동 목록</h1>
			</div>
		</div>
		<%
			if(count == 0){
		%>
			<h1 class="display-3">저장된 운동목록이 없습니다.</h1>
		<%
			}else{
		%>
		<div class="container">
			<div class="row justify-content-md-center">
				<%
					for(int i=0; i<workOutList.size(); i++){
								WorkOutDTO workOut = workOutList.get(i);
				%>
				<div class="border row" style="width: 70%;">				
					<div class="col col-lg-3 align-self-center" align="left">
						<img src="/upload/<%=workOut.getFilename()%>" style="width: 100%;">
					</div>
					<div class="col col-lg-6 align-self-center">
						<h3><%=workOut.getName()%></h3>
						<p><%=workOut.getCategory()%></p>
					</div>
					<div class="col col-lg-3 align-self-center" align="right">
						<%
							if(edit.equals("update")){
							%>
							<a href="./updateWorkOut.jsp?workoutNum=<%=workOut.getWorkoutNum()%>"
							class="btn btn-success" role="button">수정 &raquo;</a>
							<%
								}else if(edit.equals("delete")){
							%>
							<a href="#" onclick="deleteConfirm('<%=workOut.getWorkoutNum()%>')" 
							class="btn btn-danger" role="button">삭제 &raquo;</a>
						<%
							}
						%>
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
				<a class="page-link" href="./workOutLib.jsp?pageNum=<%=startPage-10%>" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
				<span class="sr-only">Previous</span>
				</a>
			</li>
			<%		}
					
					for (int i = startPage ; i <= endPage ; i++){ 
			%>
			<li class="page-item">
				<a class="page-link" href="./workOutLib.jsp?pageNum=<%=i%>"><%=i%></a>
			</li>			
			<%
					}
					if (endPage < pageCount) {
			%>
			<li class="page-item">
				 <a class="page-link" href="./workOutLib.jsp?pageNum=<%=startPage+10%>" aria-label="Next">
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
		<jsp:include page="./footer.jsp"/>
	</body>
</html>