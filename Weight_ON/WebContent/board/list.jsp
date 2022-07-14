<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.adviceDTO"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sessionId = (String) session.getAttribute("sessionId");
	List adviceList = (List) request.getAttribute("advicelist");
	int total_record = ((Integer) request.getAttribute("total_record")).intValue();
	int pageNum = ((Integer) request.getAttribute("pageNum")).intValue();
	int total_page = ((Integer) request.getAttribute("total_page")).intValue();
	int r_pageNum = 1;
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<meta charset="UTF-8">
<title>운동 조언 받기</title>
<script type="text/javascript">
	function checkForm(){
		if(${sessionId == null}){
			alert("로그인 해주세요");
			return false;
		}
		location.href = "./adviceWriteForm.do?id=<%=sessionId%>"
	}
</script>
</head>
<body>
	<jsp:include page="../menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">운동 조언 받기</h1>
		</div>
	</div>
	<div class="container">
		<form action="<c:url value="./adviceListAction.do"/>" method="post">
			<div>
				<div class="text-right">
					<span class="badge badge-success">전체 <%=total_record%>건	</span>
				</div>
			</div>
			<div style="padding-top: 50px">
				<table class="table table-hover">
					<tr align="center">
						<th width="10%">번호</th>
						<th width="40%">제목</th>
						<th width="20%">작성일</th>
						<th width="10%">조회</th>
						<th width="20%">글쓴이</th>
					</tr>
					<%
						for (int j = 0; j < adviceList.size(); j++) {
							adviceDTO notice = (adviceDTO) adviceList.get(j);
					%>
					<tr>
						<td width="10%" align="center"><%=notice.getNum()%></td>
						<td width="40%"align="left"><a href="./adviceViewAction.do?num=<%=notice.getNum()%>&pageNum=<%=pageNum%>&r_pageNum=<%=r_pageNum%>"><%=notice.getSubject()%></a></td>
						<td width="20%" align="center"><%=notice.getRegist_day()%></td>
						<td width="10%" align="center"><%=notice.getHit()%></td>
						<td width="20%" align="center"><%=notice.getName()%></td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			<div align="center">
				<c:set var="pageNum" value="<%=pageNum%>" />
				<c:forEach var="i" begin="1" end="<%=total_page%>">
					<a href="<c:url value="./adviceListAction.do?pageNum=${i}" /> ">
						<c:choose>
							<c:when test="${pageNum==i}">
								<font color='4C5317'><b> [${i}]</b></font>
							</c:when>
							<c:otherwise>
								<font color='4C5317'> [${i}]</font>

							</c:otherwise>
						</c:choose>
					</a>
				</c:forEach>
			</div>
			<div align="left">
				<table>
					<tr>
						<td width="100%" align="left">&nbsp;&nbsp; 
						<select name="items" class="txt">
								<option value="subject">제목에서</option>
								<option value="content">본문에서</option>
								<option value="name">글쓴이에서</option>
						</select> <input name="text" type="text" /> <input type="submit" id="btnAdd" class="btn btn-primary " value="검색 " />
						</td>
						<td width="100%" align="right">
							<a href="#" onClick="checkForm(); return false;" class="btn btn-primary">&laquo;글쓰기</a>
						</td>
					</tr>
				</table>
			</div>			
		</form>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>