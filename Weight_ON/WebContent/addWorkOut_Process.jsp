<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.WorkOutDTO" %>
<%@ page import="dao.WorkOutLibDAO"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>

<%
	request.setCharacterEncoding("UTF-8");

	String filename = "";
	String realFolder = "D:\\upload";	//웹 애플리케이션상의 절대 경로
	int maxSize = 5*1024*1024;			//업로드 될 파일의 최대크기 5MB
	String encType = "utf-8";			//인코팅 유형
		
	MultipartRequest multi = new MultipartRequest(request, realFolder,
	maxSize, encType, new DefaultFileRenamePolicy());
		
	Enumeration files = multi.getFileNames();
	String fname = (String) files.nextElement();
	String fileName = multi.getFilesystemName(fname);

	WorkOutDTO workOut = new WorkOutDTO();
	workOut.setWorkoutNum(multi.getParameter("workoutNum"));
	workOut.setName(multi.getParameter("name"));
	workOut.setDescription(multi.getParameter("description"));
	workOut.setCategory(multi.getParameter("category"));
	workOut.setMajorMuscle(multi.getParameter("majorMuscle"));
	workOut.setSupportMuscle(multi.getParameter("supportMuscle"));
	workOut.setEquipment(multi.getParameter("equipment"));
	workOut.setFilename(fileName);
	WorkOutLibDAO addWorkOut = WorkOutLibDAO.getInstance();
	int msg = addWorkOut.addWorkOut(workOut);

	if(msg>=1){
	response.sendRedirect("./workOutLib.jsp?Cat=전체");
	}
	if(msg==-1){
%>
	<script>
	  alert("중복 된 운동코드 입니다. ");
	  history.go(-1);
	</script>
<%
	}
%>