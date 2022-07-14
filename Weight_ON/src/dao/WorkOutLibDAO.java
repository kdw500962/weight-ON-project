package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedList;

import dto.WorkOutDTO;
public class WorkOutLibDAO {	
	private Connection conn = null;
	private PreparedStatement pstmt =null;
	private ResultSet rs =null;
	
	// workoutNum으로 WorkOut검색 할 WorkOutArrayList 객체
	private static ArrayList<WorkOutDTO> WorkOutLibrary = new ArrayList<WorkOutDTO>();
	
	private static LinkedList<WorkOutDTO> planlist = new LinkedList<WorkOutDTO>();
		
	private static WorkOutLibDAO instance = new WorkOutLibDAO();
	
	public static WorkOutLibDAO getInstance() {
		return instance;
	}
	//DB 접속 (Connection 객체 리턴 메서드)
	private Connection getConnection()throws Exception{
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
	
	//DB에서 Cat 분류한 정보를 페이징 처리하기 위하여 특정 범위의 레코드를 가져온다 가져온다
	public ArrayList<WorkOutDTO> getCatWorkOut(String Cat,int start,int end){
		String sql = "SELECT * FROM workoutlib WHERE w_category=? order by w_num asc limit ?,?";

		ArrayList<WorkOutDTO> libraryList=null;
		try {
				//커넥션 얻기
				conn = getConnection();				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, Cat);
				pstmt.setInt(2,start-1);
				pstmt.setInt(3, end);
				//DB에서 sql문에 해당되는 저장되어 있는 운동정보  모두 가져와  ResultSet객체에 저장
				rs = pstmt.executeQuery();			
				if(rs.next()) {
					libraryList = new ArrayList<WorkOutDTO>(end);
					do {
						//빈 객체인 workOut에 DB에서 가져온 값을 각각 저장
						WorkOutDTO workOut = new WorkOutDTO();
						workOut.setWorkoutNum(rs.getString("w_num"));
						workOut.setName(rs.getString("w_name"));
						workOut.setCategory(rs.getString("w_category"));
						workOut.setEquipment(rs.getString("w_equipment"));
						workOut.setMajorMuscle(rs.getString("w_majorMuscle"));
						workOut.setSupportMuscle(rs.getString("w_supportMuscle"));
						workOut.setDescription(rs.getString("w_description"));
						workOut.setFilename(rs.getString("w_fileName"));
						//ArrayList컬렉션에 workOut객체 추가
						libraryList.add(workOut);
					}while (rs.next());		
				}			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
					if(rs!= null){rs.close();}
					if(pstmt!= null){pstmt.close();}
					if(conn!= null){conn.close();}
					System.out.println("DB연동 해제");
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		//각 workOut객체가 저장된 ArrayList 리턴
		return libraryList;					
	}
	
	//DB에서 정보를 페이징 처리하기 위하여 특정 범위의 레코드를 가져온다 가져온다
	public ArrayList<WorkOutDTO> getAllWorkOut(int start,int end){
		String sql = "SELECT * FROM workoutlib order by w_num asc limit ?,?";

		ArrayList<WorkOutDTO> libraryList=null;
		try {
				//커넥션 얻기
				conn = getConnection();				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,start-1);
				pstmt.setInt(2, end);
				//DB에서 sql문에 해당되는 저장되어 있는  모두 가져와  ResultSet객체에 저장
				rs = pstmt.executeQuery();			
				
				if(rs.next()) {
					//빈 객체인 workOut에 DB에서 가져온 값을 각각 저장
					libraryList = new ArrayList<WorkOutDTO>(end);
					do {
						//빈 객체인 workOut에 DB에서 가져온 값을 각각 저장
						WorkOutDTO workOut = new WorkOutDTO();
						workOut.setWorkoutNum(rs.getString("w_num"));
						workOut.setName(rs.getString("w_name"));
						workOut.setCategory(rs.getString("w_category"));
						workOut.setEquipment(rs.getString("w_equipment"));
						workOut.setMajorMuscle(rs.getString("w_majorMuscle"));
						workOut.setSupportMuscle(rs.getString("w_supportMuscle"));
						workOut.setDescription(rs.getString("w_description"));
						workOut.setFilename(rs.getString("w_fileName"));
						//ArrayList컬렉션에 workOut객체 추가
						libraryList.add(workOut);
					}while (rs.next());		
				}			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
					if(rs!= null){rs.close();}
					if(pstmt!= null){pstmt.close();}
					if(conn!= null){conn.close();}
					System.out.println("DB연동 해제");
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		//각 객체가 저장되어 ArrayList 리턴
		return libraryList;					
	}

	//DB에 WorkOut정보 등록
	public int addWorkOut(WorkOutDTO workOut) {
		String sql = "INSERT INTO workoutlib VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
		int msg = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, workOut.getWorkoutNum());
			pstmt.setString(2, workOut.getName());
			pstmt.setString(3, workOut.getCategory());
			pstmt.setString(4, workOut.getEquipment());
			pstmt.setString(5, workOut.getMajorMuscle());
			pstmt.setString(6, workOut.getSupportMuscle());
			pstmt.setString(7, workOut.getDescription());
			pstmt.setString(8, workOut.getFilename());
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
	public int updateWorkOut(WorkOutDTO workOut) {
		String sql = "SELECT * FROM workoutlib WHERE w_num = ?";
		int msg = -1;
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, workOut.getWorkoutNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(workOut.getFilename() != null){
					sql = "UPDATE workoutlib SET w_name=?,w_category=?, w_equipment=?, w_majorMuscle=?, w_supportMuscle=?, w_description=?, w_fileName=? WHERE w_num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, workOut.getName());
					pstmt.setString(2, workOut.getCategory());
					pstmt.setString(3, workOut.getEquipment());
					pstmt.setString(4, workOut.getMajorMuscle());
					pstmt.setString(5, workOut.getSupportMuscle());
					pstmt.setString(6, workOut.getDescription());
					pstmt.setString(7, workOut.getFilename());
					pstmt.setString(8, workOut.getWorkoutNum());
					msg = pstmt.executeUpdate();			
				}else{
					sql =  "UPDATE workoutlib SET w_name=?,w_category=?, w_equipment=?, w_majorMuscle=?, w_supportMuscle=?, w_description=? WHERE w_num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, workOut.getName());
					pstmt.setString(2, workOut.getCategory());
					pstmt.setString(3, workOut.getEquipment());
					pstmt.setString(4, workOut.getMajorMuscle());
					pstmt.setString(5, workOut.getSupportMuscle());
					pstmt.setString(6, workOut.getDescription());
					pstmt.setString(7, workOut.getWorkoutNum());
					msg = pstmt.executeUpdate();	
				}
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
		return msg;
	}
	
	//DB에 WorkOut정보 삭제
	public int deleteWorkOut(String workoutNum) {
		String sql = "DELETE FROM workoutlib WHERE w_num = ?";
		int msg = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, workoutNum);
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
		//0:해당 WorkOut정보 없음, 1:삭제 성공
	}
	
	//DB에서 sql문에 해당되어 가져 올 운동목록의 번호 및  전체 레코드 수를 표시할 때 사용된다.
	public int getCatCount(String Cat) {
		String sql = "SELECT count(*) FROM workoutlib WHERE w_category=?";
		int count=0;
		try {
			//커넥션 얻기
			conn = getConnection();				
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Cat);
			//DB에서 sql문에 해당되는 저장되어 있는  운동정보 개수를  ResultSet객체에 저장
			rs = pstmt.executeQuery();			
						
			if (rs.next()) {
				count= rs.getInt(1);
				}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
				try {
						if(rs!= null){rs.close();}
						if(pstmt!= null){pstmt.close();}
						if(conn!= null){conn.close();}
						System.out.println("DB연동 해제");
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return count;
	}
	
	//DB에서 sql문에 해당되어 가져 올 운동목록의 번호 및  전체 레코드 수를 표시할 때 사용된다.
	public int getAllCount() {
		String sql = "SELECT count(*) FROM workoutlib";
		int count=0;
		try {
			conn = getConnection();				//커넥션 얻기
			pstmt = conn.prepareStatement(sql);
			//DB에서 sql문에 해당하는 저장되어 있는  운동정보 개수를  ResultSet객체에 저장
			rs = pstmt.executeQuery();			
						
			if (rs.next()) {
				count= rs.getInt(1);
				}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
				try {
						if(rs!= null){rs.close();}
						if(pstmt!= null){pstmt.close();}
						if(conn!= null){conn.close();}
						System.out.println("DB연동 해제");
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return count;
	}
	
	//DB에 있는 모든 운동목록을 가져와 listOfWorkOuts에 저장
	public ArrayList<WorkOutDTO> getWorkOutLibrary(){
		String sql = "SELECT * FROM workoutlib";
		
		try {
				//커넥션 얻기
				conn = getConnection();				
				pstmt = conn.prepareStatement(sql);
				//DB에 저장되어 있는 운동정보  모두 가져와  ResultSet객체에 저장
				rs = pstmt.executeQuery();			
				WorkOutLibrary.clear();
				while (rs.next()){
					//빈 객체인 workOut에 DB에서 가져온 값을 각각 저장
					WorkOutDTO workOut = new WorkOutDTO();			
					workOut.setWorkoutNum(rs.getString("w_num"));
					workOut.setName(rs.getString("w_name"));
					workOut.setCategory(rs.getString("w_category"));
					workOut.setEquipment(rs.getString("w_equipment"));
					workOut.setMajorMuscle(rs.getString("w_majorMuscle"));
					workOut.setSupportMuscle(rs.getString("w_supportMuscle"));
					workOut.setDescription(rs.getString("w_description"));
					workOut.setFilename(rs.getString("w_fileName"));
					//ArrayList컬렉션에 workOut객체 추가
					WorkOutLibrary.add(workOut);				
				}			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
					if(rs!= null){rs.close();}
					if(pstmt!= null){pstmt.close();}
					if(conn!= null){conn.close();}
					System.out.println("DB연동 해제");
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		//각 객체가 저장되어 ArrayList 리턴
		return WorkOutLibrary;					
	}
		
	//WorkOutLibrary에 저장된 운동 목록을 조회해서 운동코드와 일치하는 운동객체를 리턴하는 메서드
	public WorkOutDTO getWorkOutByNum(String workoutNum) {
		WorkOutDTO workOutByNum = null;
		
		for(int i = 0; i < WorkOutLibrary.size(); i++) {
			WorkOutDTO workOut = WorkOutLibrary.get(i);
			if(workOut != null && workOut.getWorkoutNum() != null &&
					workOut.getWorkoutNum().equals(workoutNum)) {
				workOutByNum = workOut;
				break;
			}
		}		
		return workOutByNum;
	}
	
	//planlist 가져오기
	public LinkedList<WorkOutDTO> getPlanList(){
		return planlist;		
	}
	
	//
	public void addWorkOut(String workoutNum) {
		
		getWorkOutLibrary();
		WorkOutDTO addWork = getWorkOutByNum(workoutNum);
		
		//planlist가 비어있지 않으면 실행
		if(planlist != null && !planlist.isEmpty()){
			int num = 0;
			WorkOutDTO planWork = null;
			for(int i=0; i<planlist.size(); i++){
				WorkOutDTO checkWork = planlist.get(i);
				if(checkWork.getWorkoutNum().equals(workoutNum)){
					planWork = checkWork;
					num = i;
				}
			}
			if(planWork != null){
				int Set = planWork.getSetCount()+1;
				addWork.setSetCount(Set);
				int addNum = ++num;
				if(addNum == planlist.size()){
					planlist.add(addWork);
				}else{
					planlist.add(addNum, addWork);
				}
			}else{
				addWork.setSetCount(1);
				planlist.add(addWork);
			}
		}
		////planlist에 추가 된 운동객체가 없을 경우 객체의 SetCount를 1로 설정하여 list마지막에 추가한다
		if(planlist.isEmpty()){
			WorkOutDTO nullWork = new WorkOutDTO();
			nullWork.setWorkoutNum("000");
			planlist.add(nullWork);
			addWork.setSetCount(1);
			planlist.add(addWork);		
		}
	}
	
	public void deletePlan(String workoutNum) {
		//세트 삭제
		int num = 0;
		for(int i=0; i<planlist.size(); i++){
			WorkOutDTO checkWork = planlist.get(i);
			if(checkWork.getWorkoutNum().equals(workoutNum)){
				num = i;
			}
		}
		planlist.remove(num);
	}
	
	public void resetPlan(String sessionId) {
		planlist.clear();
	}
}
