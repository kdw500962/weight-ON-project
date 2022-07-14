<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.inBodyDTO"%>
<%@ page import="dao.inBodyDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sessionId = (String) session.getAttribute("sessionId");
	if(sessionId == null){
		response.sendRedirect("./connect.jsp");
	}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new Timestamp(System.currentTimeMillis()));
	//page에 표시 할 목록 개수 
	int pageSize = 5;
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
    
    ArrayList<inBodyDTO> inbodyList = null;
    inBodyDAO dao = inBodyDAO.getInstance();
    count = dao.getAllCount();  
	System.out.println(count);
	inbodyList= dao.getInBodyData(startRow, pageSize);
    
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>체성분 기록</title>
		<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
		<script type="text/javascript">
		function addToinbody(){
				if(confirm("체성분 기록을 추가 하시겠습니까?")){
					document.addinbody.submit();
				}else{
					document.addinbody.reset();
				}
			}
		</script>
	</head>
	<body>
		<jsp:include page="./menu.jsp"/>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">체성분 기록</h1>
			</div>
		</div>
		<div class="container">
		<form name="addinbody" action="addInBody.jsp" method="post">
		<div class="row">
			<table width="100%" class="table table-hover">
				<colgroup>
					<col style="width:20%;">
					<col style="width:20%;">
					<col style="width:20%;">
					<col style="width:20%;">
					<col style="width:20%;">
				</colgroup>	
				<tr align="center">
					<th>저장 일</th>
					<th>체중</th>
					<th>체지방률</th>
					<th>골격근량</th>
					<th></th>
				</tr>
				<tr align="center">
					<td><input name="save_day" type="text" style = "text-align:center; vertical-align : middle;" value="<%=date%>"></td>
					<td><input name="weight" type="text" size="1" style = "text-align:center; vertical-align : middle;"> kg</td>
					<td><input name="bodyFat" type="text" size="1" style = "text-align:center; vertical-align : middle;"> %</td>
					<td><input name="muscleMass" type="text" size="1" style = "text-align:center; vertical-align : middle;"> kg</td>
					<td align="left"><a href="#" class="btn btn-success" onclick="addToinbody()">저장 &raquo;</a></td>
				</tr>
			</table>
		</div>
		</form>
		<%
			if(count == 0){
		%>
			<div class="container">
				<h2 class="alert alert-danger" align="center">저장 된 체성분 기록이 없습니다.</h2>			
			</div>
		<%
			}else{
		%>		
		<div style="padding-top: 50px; overflow: auto;">
		<table class="table table-hover">
			<colgroup>
				<col style="width:20%;">
				<col style="width:20%;">
				<col style="width:20%;">
				<col style="width:20%;">
				<col style="width:20%;">
			</colgroup>
			<tr align="center">
				<th>저장 일</th>
				<th>체중</th>
				<th>체지방률</th>
				<th>골격근량</th>
				<th></th>
			</tr>
<%			
				for(int i=0; i<inbodyList.size(); i++){
					//운동 리스트 하나씩 출력하기
					inBodyDTO inbody = inbodyList.get(i);
%>
			<tr align="center">
				<th style = "vertical-align : middle;"><%=inbody.getSave_day()%></th>
				<th style = "vertical-align : middle;"><%=inbody.getWeight()%> kg</th>
				<th style = "vertical-align : middle;"><%=inbody.getBodyFat()%> %</th>				
				<th style = "vertical-align : middle;"><%=inbody.getMuscleMass()%> kg</th>
				<td align="left"><a href="./deleteInBody.jsp?num=<%=inbody.getNum()%>" class="btn btn-danger">기록 삭제하기</a></td>
			</tr>
<%
				}
%>
		</table>
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
				<a class="page-link" href="./inBody.jsp?pageNum=<%=startPage-10%>" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
				<span class="sr-only">Previous</span>
				</a>
			<%		}
					
					for (int i = startPage ; i <= endPage ; i++){ 
			%>
			<li class="page-item">
				<a class="page-link" href="./inBody.jsp?pageNum=<%=i%>"><%=i%></a>
			</li>
			<%
					}
					if (endPage < pageCount) {
			%>
			<li class="page-item">
				 <a class="page-link" href="./inBody.jsp?pageNum=<%=startPage+10%>" aria-label="Next">
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