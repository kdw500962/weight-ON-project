<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.LinkedList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	request.setCharacterEncoding("utf-8");

	String sessionId = (String) session.getAttribute("sessionId");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	
    String[] setWeight = request.getParameterValues("setWeight");
    
    WorkOutLibDAO dao = WorkOutLibDAO.getInstance();
    LinkedList<WorkOutDTO> planlist = dao.getPlanList();
    PlanRecordDAO saveList = PlanRecordDAO.getInstance();
    String date = sdf.format(new Timestamp(System.currentTimeMillis()));
    int msg = -1;
    for(int i=1; i<planlist.size(); i++){
    	PlanDTO plan = new PlanDTO();
    	plan.setId(sessionId);
    	plan.setWorkoutNum(planlist.get(i).getWorkoutNum());
    	plan.setName(planlist.get(i).getName());
    	plan.setCategory(planlist.get(i).getCategory());
    	plan.setSetCount(planlist.get(i).getSetCount());
    	plan.setSetWeight(Integer.parseInt(setWeight[i-1]));
    	plan.setSave_day(date);
    	msg = saveList.addPlanRecode(plan);
    }
    
    if(msg>=1){
		response.sendRedirect("./deletePlan.jsp?sessionId="+sessionId);
	}else{
		response.sendRedirect("plan.jsp");
	}
%>
