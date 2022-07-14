package mvc.controller;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.*;
import com.oreilly.servlet.multipart.*;

import mvc.model.adviceDAO;
import mvc.model.adviceDTO;
import mvc.model.replyDTO;
import mvc.model.replyDAO;

public class adviceController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final int LISTCOUNT =5;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
				
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		if(command.equals("/adviceListAction.do")){
			//등록된 글 목록 페이지 출력하기
			requestAdviceList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./board/list.jsp");
			rd.forward(request, response);			
		}else if (command.equals("/adviceWriteForm.do")){
			//글 등록 페이지 출력하기
			requestLoginName(request);
			RequestDispatcher rd = request.getRequestDispatcher("./board/writeForm.jsp");
			rd.forward(request, response);
		}else if (command.equals("/adviceWriteAction.do")) {
			//새로운 글 등록하기
			requestAdviceWrite(request);
			RequestDispatcher rd = request.getRequestDispatcher("/adviceListAction.do");
			rd.forward(request, response);
		}else if (command.equals("/adviceViewAction.do")) {
			//선택된 글 상세 페이지 가져오기
			requestAdviceView(request);
			RequestDispatcher rd = request.getRequestDispatcher("/adviceView.do");
			rd.forward(request, response);
		}else if (command.equals("/adviceView.do")) {
			//글 상세 페이지 출력하기
			RequestDispatcher rd = request.getRequestDispatcher("./board/view.jsp");
			rd.forward(request, response);
		}else if (command.equals("/adviceUpdateAction.do")) {
			//선택된 글 조회수 증가하기
			requestAdviceUpdate(request);
			RequestDispatcher rd = request.getRequestDispatcher("/adviceListAction.do");
			rd.forward(request, response);
		}else if (command.equals("/adviceDeleteAction.do")) {
			//선택된 글 삭제하기
			requestAdviceDelete(request);
			RequestDispatcher rd = request.getRequestDispatcher("/adviceListAction.do");
			rd.forward(request, response);
		}else if (command.equals("/replyWriteAction.do")) {
			//선택된 글 답글 작성
			requestReplyWrite(request);
			RequestDispatcher rd = request.getRequestDispatcher("/adviceViewAction.do");
			rd.forward(request, response);
		}else if (command.equals("/replyDeleteAction.do")) {
			//선택된 글 삭제하기
			requestreplyDelete(request);
			RequestDispatcher rd = request.getRequestDispatcher("/adviceViewAction.do");
			rd.forward(request, response);
		}
	
	}

	//등록된 글 목록 가져오기
	private void requestAdviceList(HttpServletRequest request) {
		// TODO Auto-generated method stub
		adviceDAO dao = adviceDAO.getInstance();
		List<adviceDTO> advicelist = new ArrayList<adviceDTO>();
		
		int pageNum = 1;
		int limit = LISTCOUNT;
		
		if(request.getParameter("pageNum")!=null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
		String items = request.getParameter("items");
		String text = request.getParameter("text");
		
		int total_record = dao.getListCount(items, text);
		advicelist = dao.getBoardList(pageNum, limit, items, text);
		
		int total_page;
		
		if(total_record % limit == 0) {
			total_page = total_record/limit;
			Math.floor(total_page);
		}else {
			total_page = total_record/limit;
			Math.floor(total_page);
			total_page = total_page + 1;
		}
		
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total_page", total_page);
		request.setAttribute("total_record", total_record);
		request.setAttribute("advicelist", advicelist);
		
	}
	
	//인증된 사용자명 가져오기
	private void requestLoginName(HttpServletRequest request) {
		// TODO Auto-generated method stub
		
		String id = request.getParameter("id");
		
		adviceDAO dao = adviceDAO.getInstance();
		
		String name = dao.getLoginNameById(id);
		
		request.setAttribute("name", name);
	
	}
	
	//새로운 글 등록하기
	private void requestAdviceWrite(HttpServletRequest request) throws IOException {
		// TODO Auto-generated method stub
		

		String realFolder = "D:\\upload";	//웹 애플리케이션상의 절대 경로
		int maxSize = 5*1024*1024;			//업로드 될 파일의 최대크기 5MB
		String encType = "utf-8";			//인코팅 유형
		
		MultipartRequest multi = new MultipartRequest(request, realFolder,
				maxSize, encType, new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		String fname = (String) files.nextElement();
		String fileName = multi.getFilesystemName(fname);
	
		adviceDAO dao = adviceDAO.getInstance();
		
		adviceDTO advice = new adviceDTO();
		advice.setId(multi.getParameter("id"));
		advice.setName(multi.getParameter("name"));
		advice.setSubject(multi.getParameter("subject"));
		advice.setContent(multi.getParameter("content"));
		advice.setFilename(fileName);
		
		System.out.println(multi.getParameter("name"));
		System.out.println(multi.getParameter("subject"));
		System.out.println(multi.getParameter("content"));
		java.text.SimpleDateFormat formatter = new
		java.text.SimpleDateFormat("yyyy/mm/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date());
		
		advice.setHit(0);
		advice.setRegist_day(regist_day);
		
		dao.insertBoard(advice);
	}
	
	//선택된 글 상세 페이지 가져오기
	private void requestAdviceView(HttpServletRequest request) {
		// TODO Auto-generated method stub
		int limit = LISTCOUNT;
		
		adviceDAO dao = adviceDAO.getInstance();
		replyDAO r_dao = replyDAO.getInstance();
		
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = 1;
		int r_pageNum = 1;
		if(request.getParameter("pageNum")!=null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		if(request.getParameter("r_pageNum")!=null) {
			r_pageNum = Integer.parseInt(request.getParameter("r_pageNum"));
		}
		
		adviceDTO advice = new adviceDTO();
		advice = dao.getBoardByNum(num, pageNum);
		
		List<replyDTO> replylist = new ArrayList<replyDTO>();
		int total_record = r_dao.getR_ListCount(num);
		replylist = r_dao.getR_BoardList( r_pageNum, limit, num);
		
		int total_page;
		
		if(total_record % limit == 0) {
			total_page = total_record/limit;
			Math.floor(total_page);
		}else {
			total_page = total_record/limit;
			Math.floor(total_page);
			total_page = total_page + 1;
		}
		
		request.setAttribute("num", num);
		request.setAttribute("page", pageNum);
		request.setAttribute("advice", advice);
		request.setAttribute("r_pageNum", r_pageNum);
		request.setAttribute("total_page", total_page);
		request.setAttribute("total_record", total_record);
		request.setAttribute("replylist", replylist);
	
	}
	
	//선택된 글 내용 수정하기
	private void requestAdviceUpdate(HttpServletRequest request) {
		// TODO Auto-generated method stub
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		adviceDAO dao = adviceDAO.getInstance();
		
		adviceDTO advice = new adviceDTO();
		advice.setNum(num);
		advice.setName(request.getParameter("name"));
		advice.setSubject(request.getParameter("subject"));
		advice.setContent(request.getParameter("content"));
		
		java.text.SimpleDateFormat formatter = new
		java.text.SimpleDateFormat("yyyy/mm/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date());
		
		advice.setHit(0);
		advice.setRegist_day(regist_day);
		
		dao.updateBoard(advice);		
	}
	//선택된 글 삭제 
	private void requestAdviceDelete(HttpServletRequest request) {
		// TODO Auto-generated method stub
		
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		adviceDAO dao = adviceDAO.getInstance();
		dao.deleteBoard(num);
	
	}
	
	//선택 글 답글 등록
	private void requestReplyWrite(HttpServletRequest request) {
		// TODO Auto-generated method stub
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = 1;
		int r_pageNum = 1;
		if(request.getParameter("pageNum")!=null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		if(request.getParameter("r_pageNum")!=null) {
			r_pageNum = Integer.parseInt(request.getParameter("r_pageNum"));
		}
		
		replyDAO r_dao = replyDAO.getInstance();
		int total_record = r_dao.getR_ListCount(num);
		
		String id = request.getParameter("id");
		String name = r_dao.getLoginNameById(id);
		
		replyDTO reply = new replyDTO();
		reply.setNum(num);
		reply.setR_num(total_record + 1);
		reply.setId(id);
		reply.setName(name);
		reply.setComment(request.getParameter("comment"));
		java.text.SimpleDateFormat formatter = new
		java.text.SimpleDateFormat("yyyy/mm/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date());
		reply.setRegist_day(regist_day);
				
		r_dao.insertBoard(reply);
		
		request.setAttribute("num", num);
		request.setAttribute("page", pageNum);
		request.setAttribute("r_pageNum", r_pageNum);
	}
	
	////선택 글 답글 삭제
	private void requestreplyDelete(HttpServletRequest request) {
		// TODO Auto-generated method stub
		int num = Integer.parseInt(request.getParameter("num"));
		int r_num = Integer.parseInt(request.getParameter("r_num"));
		int pageNum = 1;
		int r_pageNum = 1;
		if(request.getParameter("pageNum")!=null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		if(request.getParameter("r_pageNum")!=null) {
			r_pageNum = Integer.parseInt(request.getParameter("r_pageNum"));
		}
		
		replyDAO r_dao = replyDAO.getInstance();
		r_dao.deleteR_Board(num, r_num);
		
		request.setAttribute("num", num);
		request.setAttribute("page", pageNum);
		request.setAttribute("r_pageNum", r_pageNum);		
	}

}
