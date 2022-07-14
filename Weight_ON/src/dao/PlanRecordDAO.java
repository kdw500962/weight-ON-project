package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import dto.PlanDTO;
public class PlanRecordDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt =null;
	private ResultSet rs =null;

	private static ArrayList<PlanDTO> RecordList = new ArrayList<PlanDTO>();
	
	private static PlanRecordDAO instance = new PlanRecordDAO();
	
	public static  PlanRecordDAO getInstance() {
		return instance;
	}
	
	//DB 접속 (Connection 객체 리턴 메서드)
	private Connection getConnection(){
		String jdbcUrl = "jdbc:mysql://localhost:3306/Weight_OnDB";
		String user = "root";
		String password = "1234";
		try {
			Class.forName("com.mysql.jdbc.Driver");	//드라이버명
			conn = DriverManager.getConnection(jdbcUrl, user, password);
			System.out.println("DB연동 완료");
		} catch (Exception e) {
			System.out.println("DB연동 실패");
			e.printStackTrace();
		}
		return conn;
	}

	//DB에 plan정보 등록
	public int addPlanRecode(PlanDTO plan) {
		int msg = -1;
		String sql = "INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,save_day)";
				sql+=" VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, plan.getId());
			pstmt.setString(2, plan.getWorkoutNum());
			pstmt.setString(3, plan.getName());
			pstmt.setString(4, plan.getCategory());
			pstmt.setInt(5, plan.getSetCount());
			pstmt.setInt(6, plan.getSetWeight());
			pstmt.setString(7, plan.getSave_day());
			msg = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!= null){pstmt.close();}
				if(conn!= null){conn.close();}
				System.out.println("DB연동 해제");
			}catch (Exception e2) {
				e2.printStackTrace();
			}			
		}
		return msg;		
	}
	
	//DB에 완료 되지 않은 planList정보 불러오기
	public ArrayList<PlanDTO> searchPlanList (String sessionId, String date) {
		ArrayList<PlanDTO> planList = new ArrayList<PlanDTO>();
		String sql = "SELECT * FROM planTBL WHERE id = ? and save_day= ? and complete is null ORDER BY num ASC";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sessionId);
			pstmt.setString(2, date);
			rs= pstmt.executeQuery();
			
			while(rs.next()){
				PlanDTO plan = new PlanDTO();
				plan.setNum(rs.getInt("num"));
				plan.setId(rs.getString("id"));
				plan.setWorkoutNum(rs.getString("workoutNum"));
				plan.setName(rs.getString("name"));
				plan.setCategory(rs.getString("category"));
				plan.setSetCount(rs.getInt("setCount"));
				plan.setSetWeight(rs.getInt("setWeight"));
				plan.setMemo(rs.getString("memo"));
				plan.setSave_day(rs.getString("save_day"));
				planList.add(plan);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!= null){rs.close();}
				if(pstmt!= null){pstmt.close();}
				if(conn!= null){conn.close();}
				System.out.println("DB연동 해제");
			}catch (Exception e2) {
				e2.printStackTrace();
			}			
		}
		return planList;
	}
	
	//DB에 plan정보 등록
	public int donePlanRecode(PlanDTO plan) {
		int msg = -1;
		String sql = "UPDATE planTBL SET setWeight=?, memo=?, complete=?, done_day=? WHERE num=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, plan.getSetWeight());
			pstmt.setString(2, plan.getMemo());
			pstmt.setString(3, plan.getComplete());
			pstmt.setString(4, plan.getDone_day());
			pstmt.setInt(5, plan.getNum());
			msg = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!= null){pstmt.close();}
				if(conn!= null){conn.close();}
				System.out.println("DB연동 해제");
			}catch (Exception e2) {
				e2.printStackTrace();
			}			
		}
		return msg;		
	}

	//DB에 완료 된 plan 날짜정보 불러오기
	public ArrayList<String> getDone_dayList (String sessionId) {
		ArrayList<String>Done_dayList = new ArrayList<String>();
		String sql = "SELECT DISTINCT done_day FROM planTBL where id = ? ORDER BY done_day ASC";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sessionId);
			rs= pstmt.executeQuery();
			
				while(rs.next()){
					String Done_day = rs.getNString("done_day");
					System.out.println(Done_day);
					Done_dayList.add(Done_day);
				}
				String Done_day = "0000-00-00";
				Done_dayList.add(Done_day);
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!= null){rs.close();}
				if(pstmt!= null){pstmt.close();}
				if(conn!= null){conn.close();}
				System.out.println("DB연동 해제");
			}catch (Exception e2) {
				e2.printStackTrace();
			}			
		}
		return Done_dayList;
	}
	//DB에 완료 되지 않은 planList정보 불러오기
	public ArrayList<PlanDTO> PlanRecordList (String sessionId, String date) {
		ArrayList<PlanDTO> planList = new ArrayList<PlanDTO>();
		String sql = "SELECT * FROM planTBL WHERE id = ? and done_day= ? ORDER BY num ASC";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sessionId);
			pstmt.setString(2, date);
			rs= pstmt.executeQuery();
			
			while(rs.next()){
				PlanDTO plan = new PlanDTO();
				plan.setNum(rs.getInt("num"));
				plan.setId(rs.getString("id"));
				plan.setWorkoutNum(rs.getString("workoutNum"));
				plan.setName(rs.getString("name"));
				plan.setCategory(rs.getString("category"));
				plan.setSetCount(rs.getInt("setCount"));
				plan.setSetWeight(rs.getInt("setWeight"));
				plan.setMemo(rs.getString("memo"));
				plan.setSave_day(rs.getString("save_day"));
				planList.add(plan);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!= null){rs.close();}
				if(pstmt!= null){pstmt.close();}
				if(conn!= null){conn.close();}
				System.out.println("DB연동 해제");
			}catch (Exception e2) {
				e2.printStackTrace();
			}			
		}
		return planList;
	}
	
	//DB에 plan정보 등록
	public int deletePlanRecode(String sessionId, String date) {
		int msg = -1;
		String sql = "DELETE FROM planTBL WHERE id = ? and done_day= ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sessionId);
			pstmt.setString(2, date);
			msg = pstmt.executeUpdate();
			System.out.println(msg);
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!= null){pstmt.close();}
				if(conn!= null){conn.close();}
				System.out.println("DB연동 해제");
			}catch (Exception e2) {
				e2.printStackTrace();
			}			
		}
		return msg;		
	}
	
	//DB에 plan정보 등록
	public int deletePlanProgress(String sessionId, String date) {
		int msg = -1;
		String sql = "DELETE FROM planTBL WHERE id = ? and save_day= ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sessionId);
			pstmt.setString(2, date);
			msg = pstmt.executeUpdate();
			System.out.println(msg);
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!= null){pstmt.close();}
				if(conn!= null){conn.close();}
				System.out.println("DB연동 해제");
			}catch (Exception e2) {
				e2.printStackTrace();
			}			
		}
		return msg;		
	}
}
