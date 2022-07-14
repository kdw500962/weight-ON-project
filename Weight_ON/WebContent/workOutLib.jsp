<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="dto.WorkOutDTO"%>
<%@ page import="dao.WorkOutLibDAO"%>

<%
	request.setCharacterEncoding("UTF-8");
	String sessionId = (String) session.getAttribute("sessionId");
	if(sessionId == null){
		response.sendRedirect("./connect.jsp");
	}
	//page에 표시 할 목록 개수 
	int pageSize = 5;
	//라이브러리 종류를 결정하는 카테고리 변수
	String Cat = request.getParameter("Cat");
	// 카테고리 분류 기준 변수
	String All = "전체";
	//표시 할 페이지 번호
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
    
    List<WorkOutDTO> workOutList = null;
    WorkOutLibDAO dao = WorkOutLibDAO.getInstance();
    if(Cat.equals(All)){
    	count = dao.getAllCount();	
    }else{
    	count = dao.getCatCount(Cat);	
    }
	System.out.println(count);
    if(count > 0){
    	if(Cat.equals(All)){
    		workOutList= dao.getAllWorkOut(startRow, pageSize);
    	}else{
    		workOutList= dao.getCatWorkOut(Cat, startRow, pageSize);
    	}
    }
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>운동라이브러리</title>
		<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
		<script type="text/javascript">
		function addToPlan(){
				if(confirm("운동을 추가 하시겠습니까?")){
					$("#addForm").submit(); 
				}else{
					document.addForm.reset();
				}
			}
		</script>
	</head>
	<body>
		<jsp:include page="/menu.jsp"/>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">운동 목록</h1>
			</div>
		</div>
		<%
			if(count == 0){
		%>
			<div class="container">			
					<h1 class="display-3">저장된 운동목록이 없습니다.</h1>
			</div>
		<%
			}else{
		%>
		<div class="container">
			<div class="row justify-content-md-center">
				<%
					System.out.println(workOutList.size());
					for(int i = 0; i<workOutList.size(); i++){
								WorkOutDTO workOut = workOutList.get(i);
				%>
				<div class="border row" style="width: 70%;">				
					<div class="col col-lg-3 align-self-center" align="left">
						<img src="/upload/<%=workOut.getFilename()%>" style="width:100%;">
					</div>
					<div class="col col-lg-6 align-self-center">
						<h3><%=workOut.getName()%></h3>
						<p><%=workOut.getCategory()%></p>
					</div>
					<div class="col col-lg-3 align-self-center" align="right">
						<p></p>
						<a href= "./workOut.jsp?Cat=<%=Cat%>&&workoutNum=<%=workOut.getWorkoutNum()%>"
						class="btn btn-secondary" role="button">상세 정보 &raquo;</a>
						<p></p>
						<form name="addForm" action="./addPlan.jsp?workoutNum=<%=workOut.getWorkoutNum()%>" method="post">
						<a href="./addPlan.jsp?workoutNum=<%=workOut.getWorkoutNum()%>&&Cat=<%=Cat%>&&Num=0" class="btn btn-primary" onclick="addToPlan()">운동추가 &raquo;</a>
						</form>
						<p></p>
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
				<a class="page-link" href="./workOutLib.jsp?Cat=<%=Cat%>&&pageNum=<%=startPage-10%>" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
				<span class="sr-only">Previous</span>
				</a>
			</li>
			<%		}
					
					for (int i = startPage ; i <= endPage ; i++){ 
			%>
			<li class="page-item">
				<a class="page-link" href="./workOutLib.jsp?Cat=<%=Cat%>&&pageNum=<%=i%>"><%=i%></a>
			</li>			
			<%
					}
					if (endPage < pageCount) {
			%>
			<li class="page-item">
				 <a class="page-link" href="./workOutLib.jsp?Cat=<%=Cat%>&&pageNum=<%=startPage+10%>" aria-label="Next">
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