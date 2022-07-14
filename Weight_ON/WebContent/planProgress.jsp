<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.PlanDTO"%>
<%@ page import="dao.PlanRecordDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css"/>
<%
	request.setCharacterEncoding("UTF-8");
	String sessionId = (String) session.getAttribute("sessionId");
	if(sessionId == null){
		response.sendRedirect("./connect.jsp");
	}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new Timestamp(System.currentTimeMillis()));
	ArrayList<PlanDTO> planList = new ArrayList<PlanDTO>();
	PlanRecordDAO dao = PlanRecordDAO.getInstance();
	System.out.println(date);
	planList = dao.searchPlanList(sessionId, date);
%>
<title>운동계획 진행하기</title>
<script type="text/javascript">
	var time = -1;	//기준시간 작성
	var min = "";	//분
	var sec = "";	//초
	var count = 0;
	
	function doneToPlanList(){
		if(confirm("운동진행을 저장 하시겠습니까?")){
			document.donePlan.submit();
		}
	}
	
	function checkToComplete(){
		time = prompt("휴식시간을 초단위로 입력해주세요","60");
		//setInterval(함수,시간) : 주기적인 실행
		var setTime = setInterval(function(){
			//parseInt() : 정수로 변환 
			min = parseInt(time/60);	
			sec = time%60;		

			document.getElementById("timer").innerHTML = min+"분"+sec+"초";
			time--;
			//타임아웃 시
			if(time < 0){
				clearInterval(setTime);	//setInterval() 실행 종료
				document.getElementById("timer").innerHTML = "휴식종료";
			}		
		},1000);
	}
</script>
</head>
<body>
<jsp:include page="./menu.jsp"/>
<div class="jumbotron">
	<div class="container">
		<h1 class="display-3">운동계획  진행하기</h1>
	</div>
</div>
<div class="container">
	<form name="donePlan" action="./planProgress_Process.jsp" method="post">
	<div class="row">
		<table width="100%">
			<tr>
				<td align="left"><a href="./deletePlanProgress.jsp?sessionId=<%=sessionId%>&&date=<%=date%>" class="btn btn-danger">전체 삭제하기</a></td>
				<td align="right"><a href="#" class="btn btn-success" onclick="doneToPlanList()">운동 완료 &raquo;</a></td>
			</tr>
		</table>
	</div>		
	<div style="padding-top: 50px; overflow: auto;">
		<div id="timer" style="margin: 5px 0 10px 0; font-size: 16px; color: #1a5490; border: 1px solid #dcdcdc; text-align: center; padding: 10px; font-weight: bold;">휴식대기</div>
		<table class="table table-hover">
			<colgroup>
				<col style="width:25%;">
				<col style="width:15%;">
				<col style="width:20%;">
				<col style="width:15%;">
				<col style="width:25%;">
			</colgroup>
			<tr align="center">
				<th>운동 명</th>
				<th>세트 수</th>
				<th>중량</th>
				<th>완료 체크</th>
				<th>운동 메모</th>
			</tr>
<%			
				for(int i=0; i<planList.size(); i++){
					//운동 리스트 하나씩 출력하기
					PlanDTO plan = planList.get(i);
					System.out.println(plan.getComplete());
%>
			<tr>
				<th align="left" style = "vertical-align : middle;"><%=plan.getName()%></th>
				<th align="center" style = "vertical-align : middle;"><%=plan.getSetCount()%> Set</th>
				<td align="center" style = "vertical-align : middle;">
					<input name="setWeight" type="text" style = "text-align:center; vertical-align : middle;"
					 maxlength="3" size="1" value="<%=plan.getSetWeight()%>"> kg
				</td>
<%
					if(plan.getComplete() != null){
%>				
				<td align="center" style = "vertical-align : middle;">
					<input name="complete" id="checkBoxId" type="checkbox" value="Done" style="width:25px;height:25px;" onclick="checkToComplete()" checked="checked">
				</td>
<%
					}else{
%>
				<td align="center" style = "vertical-align : middle;">
					<input name="complete" id="checkBoxId" type="checkbox" value="Done" style="width:25px;height:25px;" onclick="checkToComplete()">
				</td>
<%
					}
					
					if(plan.getMemo() != null){
%>				
				<td><textarea name="memo" rows="2" cols="30" style="resize: none;"><%=plan.getMemo()%></textarea></td>
<%
					}else{
%>
				<td><textarea name="memo" rows="2" cols="30" style="resize: none;"></textarea></td>
<%
					}
%>
			</tr>
<%
				}
%>
			<tr>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
			</tr>
		</table>
	</div>
	</form>
</div>
<jsp:include page="./footer.jsp"/>	
</body>
</html>