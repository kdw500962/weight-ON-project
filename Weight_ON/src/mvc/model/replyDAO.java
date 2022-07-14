package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mvc.database.DBConnection;

public class replyDAO {
	
	private static replyDAO instance;
	
	private replyDAO() {
		
	}

	public static replyDAO getInstance() {
		if (instance == null)
			instance = new replyDAO();
		return instance;
	}
	
	//테이블의 레코드 개수 
	public int getR_ListCount(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		String sql= "SELECT count(*) from replyTBL where num = ?";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num);		
			rs = pstmt.executeQuery();

			if (rs.next()) 
				x = rs.getInt(1);
			
		} catch (Exception ex) {
			System.out.println("getListCount() 예러: " + ex);
		} finally {			
			try {				
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();												
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}		
		return x;
	}
	
	//테이블의 레코드 가져오기
	public ArrayList<replyDTO> getR_BoardList(int page, int limit, int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int total_record = getR_ListCount(num);
		int start = (page - 1) * limit;
		int index = start + 1;

		String sql = "SELECT  * FROM replyTBL ORDER BY r_num DESC";

		ArrayList<replyDTO> list = new ArrayList<replyDTO>();

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.absolute(index)) {
				replyDTO reply = new replyDTO();
				reply.setNum(rs.getInt("num"));
				reply.setR_num(rs.getInt("r_num"));
				reply.setId(rs.getString("id"));
				reply.setName(rs.getString("name"));
				reply.setComment(rs.getString("comment"));
				reply.setRegist_day(rs.getString("regist_day"));
				list.add(reply);

				if (index < (start + limit) && index <= total_record)
					index++;
				else
					break;
			}
			return list;
		} catch (Exception ex) {
			System.out.println("getBoardList() 에러 : " + ex);
		} finally {
			try {
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}			
		}
		return null;
	}
	
	//테이블에서 인증 된 id의 사용자명 가져오기
	public String getLoginNameById(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;	

		String name=null;
		String sql = "SELECT  * FROM userTBL WHERE id = ? ";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) 
				name = rs.getString("name");	
			
			return name;
		} catch (Exception ex) {
			System.out.println("getBoardByNum() 에러 : " + ex);
		} finally {
			try {				
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
		return null;
	}

	//테이블에 새로운 글 삽입하기
	public void insertBoard(replyDTO reply)  {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.getConnection();		

			String sql = "insert into replyTBL values(?, ?, ?, ?, ?, ?)";
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reply.getNum());
			pstmt.setInt(2, reply.getR_num());
			pstmt.setString(3, reply.getId());
			pstmt.setString(4, reply.getName());			
			pstmt.setString(5, reply.getComment());
			pstmt.setString(6, reply.getRegist_day());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("insertBoard() 에러 : " + ex);
		} finally {
			try {									
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}		
	}

	//선택된 글내용 수정하기
	public void updateBoard(replyDTO reply) {

		Connection conn = null;
		PreparedStatement pstmt = null;
	
		try {
			String sql = "update replyTBL set comment=? where r_num=?";

			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			conn.setAutoCommit(false);			
			pstmt.setString(1, reply.getComment());
			pstmt.setInt(2, reply.getR_num());

			pstmt.executeUpdate();			
			conn.commit();

		} catch (Exception ex) {
			System.out.println("updateBoard() 에러 : " + ex);
		} finally {
			try {										
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
	}
	
	//선택된 글 삭제하기
	public void deleteR_Board(int num, int r_num) {
		Connection conn = null;
		PreparedStatement pstmt = null;		

		String sql = "delete from replyTBL where num =? and r_num= ?";	

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, r_num);
			pstmt.executeUpdate();

		} catch (Exception ex) {
			System.out.println("deleteBoard() 에러 : " + ex);
		} finally {
			try {										
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
	}	
}
