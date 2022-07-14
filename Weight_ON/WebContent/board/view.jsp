<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.adviceDTO"%>
<%@ page import="mvc.model.replyDTO"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sessionId = (String) session.getAttribute("sessionId");
	adviceDTO notice = (adviceDTO) request.getAttribute("advice");
	int num = ((Integer) request.getAttribute("num")).intValue();
	int nowpage = ((Integer) request.getAttribute("page")).intValue();
	//reply관련 request
	List replyList = (List) request.getAttribute("replylist");
	int total_record = ((Integer) request.getAttribute("total_record")).intValue();
	int r_pageNum = ((Integer) request.getAttribute("r_pageNum")).intValue();
	int total_page = ((Integer) request.getAttribute("total_page")).intValue();
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<meta charset="UTF-8">
<title>운동 조언 받기</title>
</head>
<body>
	<jsp:include page="../menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">운동 조언 받기</h1>
		</div>
	</div>

	<div class="container">
		<form name="newUpdate"
			action="adviceUpdateAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>"
			class="form-horizontal" method="post">
			<div class="form-group row">
				<label class="col-sm-2 control-label" >성명</label>
				<div class="col-sm-3">
					<input name="name" class="form-control"	value=" <%=notice.getName()%>">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label" >제목</label>
				<div class="col-sm-5">
					<input name="subject" class="form-control"	value=" <%=notice.getSubject()%>" >
				</div>
			</div>
			<c:set var="fileName" value="<%=notice.getFilename()%>" />
			<c:if test="${fileName != null}">
			<div class="form-group row">
			<label class="col-sm-2 control-label" >이미지</label>
				<div class="col col-lg-3 align-self-center" align="center">
					<img src="/upload/<%=notice.getFilename()%>" style="width:100%;">
				</div>
			</div>
			</c:if>
			<div class="form-group row">
				<label class="col-sm-2 control-label" >내용</label>
				<div class="col-sm-8" style="word-break: break-all;">
					<textarea name="content" class="form-control" cols="50" rows="5" style="resize: none;"> <%=notice.getContent()%></textarea>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<c:set var="userId" value="<%=notice.getId()%>" />
					<c:if test="${sessionId==userId}">
						<p>
							<a	href="./adviceDeleteAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>" class="btn btn-danger"> 삭제</a> 
							<input type="submit" class="btn btn-success" value="수정 ">
					</c:if>
					<a href="./adviceListAction.do?pageNum=<%=nowpage%>" class="btn btn-primary"> 목록</a>
				</div>
			</div>
		</form>
		<hr>
	</div>
	<div class="container">
		<form action="<c:url value="./replyWriteAction.do"/>" method="post">
			<div>
				<div>
					<div class="text-right">
						<span class="badge badge-success" >전체 <%=total_record%>건</span>
					</div>
				</div>
				<table class="table table-hover">
					<tr align="center">
						<th width="10%">
							<input name="num" type="hidden" class="form-control" value="<%=num%>">
							<input name="pageNum" type="hidden" class="form-control" value="<%=nowpage%>">
							<input name="r_pageNum" type="hidden" class="form-control" value="<%=r_pageNum%>">
							<input name="id" type="hidden" class="form-control" value="${sessionId}">
						</th>
						<th width="70%">
							<textarea name="comment" cols="30" rows="1" class="form-control"
							placeholder="답글을 작성해주세요" style="resize: none;"></textarea>
						</th>
						<th width="20%" colspan="2"><input type="submit" class="btn btn-primary " value="등록 "></th>
					</tr>
					<%
						for (int j = 0; j < replyList.size(); j++) {
							replyDTO comment = (replyDTO) replyList.get(j);
					%>
					<tr>
						<td width="10%" align="center"><%=comment.getId()%></td>
						<td width="50%" align="left"><%=comment.getComment()%></td>
						<td width="20%" align="center"><%=comment.getRegist_day()%></td>
						<td width="20%" align="center">
							<c:set var="userId" value="<%=comment.getId()%>" />
							<c:if test="${sessionId==userId}">
								<a	href="./replyDeleteAction.do?num=<%=comment.getNum()%>&pageNum=<%=nowpage
								%>&r_num=<%=comment.getR_num()%>&r_pageNum<%=r_pageNum%>"
								 class="btn btn-danger">삭제</a> 
							</c:if>
						</td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			<div align="center">
				<c:set var="pageNum" value="<%=r_pageNum%>" />
				<c:forEach var="i" begin="1" end="<%=total_page%>">
					<a href="<c:url value="./adviceViewAction.do?pageNum=${i}" /> ">
						<c:choose>
							<c:when test="${r_pageNum==i}">
								<font color='4C5317'><b> [${i}]</b></font>
							</c:when>
							<c:otherwise>
								<font color='4C5317'> [${i}]</font>
							</c:otherwise>
						</c:choose>
					</a>
				</c:forEach>
			</div>			
		</form>
	</div>
	<jsp:include page="../footer.jsp" />
</body>
</html>