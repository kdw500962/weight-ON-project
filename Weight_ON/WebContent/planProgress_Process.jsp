<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.PlanDTO"%>
<%@ page import="dao.PlanRecordDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	request.setCharacterEncoding("utf-8");

	String sessionId = (String) session.getAttribute("sessionId");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new Timestamp(System.currentTimeMillis()));
    String[] setWeight = request.getParameterValues("setWeight");
    String[] complete = request.getParameterValues("complete");
    String[] memo = request.getParameterValues("memo");
    
    PlanRecordDAO dao = PlanRecordDAO.getInstance();
    ArrayList<PlanDTO> planList = new ArrayList<PlanDTO>();
    planList = dao.searchPlanList(sessionId, date);
    int msg = -1;
    for(int i=0; i<planList.size(); i++){
    	PlanDTO plan = new PlanDTO();
    	plan.setNum(planList.get(i).getNum());
    	plan.setSetWeight(Integer.parseInt(setWeight[i]));
    	plan.setComplete(complete[i]);
    	plan.setMemo(memo[i]);
    	plan.setDone_day(date);
    	msg = dao.donePlanRecode(plan);
    }
    
    if(msg>=1){
		response.sendRedirect("./planCalendar.jsp");
	}else{
		response.sendRedirect("./planProgress.jsp");
	}
%>