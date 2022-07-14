package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import dto.inBodyDTO;
public class inBodyDAO {	
	
	private Connection conn = null;
	private PreparedStatement pstmt =null;
	private ResultSet rs =null;
		
	private static inBodyDAO instance = new inBodyDAO();
	
	public static inBodyDAO getInstance() {
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
	
	//DB에 inbody정보 등록
	public int addInBody(inBodyDTO inbody) {
		String sql = "INSERT INTO inbodyTBL(id,weight,bodyFat,muscleMass,save_day) VALUES (?, ?, ?, ?, ?)";
		int msg = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, inbody.getId());
			pstmt.setString(2, inbody.getWeight());
			pstmt.setString(3, inbody.getBodyFat());
			pstmt.setString(4, inbody.getMuscleMass());
			pstmt.setString(5, inbody.getSave_day());
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

	//DB에 inBody정보 삭제
	public int deleteInBody(String id, int num) {
		String sql = "DELETE FROM inbodyTBL WHERE id = ? and num = ?";
		int msg = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, num);
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
		//0:해당 아이디 없음, 1:삭제 성공
	}

	//DB에서 sql문에 해당되어 가져 올 운동목록의 번호 및  전체 레코드 수를 표시할 때 사용된다.
	public int getAllCount() {
		String sql = "SELECT count(*) FROM inbodyTBL";
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

	//DB에서 정보를 페이징 처리하기 위하여 특정 범위의 레코드를 가져온다 가져온다
	public ArrayList<inBodyDTO> getInBodyData(int start,int end){
		String sql = "SELECT * FROM inbodyTBL order by num asc limit ?,?";

		ArrayList<inBodyDTO> inbodyList=null;
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
					inbodyList = new ArrayList<inBodyDTO>(end);
					do {
						//빈 객체인 workOut에 DB에서 가져온 값을 각각 저장
						inBodyDTO inbody = new inBodyDTO();
						inbody.setNum(rs.getInt("num"));
						inbody.setId(rs.getString("id"));
						inbody.setWeight(rs.getString("weight"));
						inbody.setBodyFat(rs.getString("bodyFat"));
						inbody.setMuscleMass(rs.getString("muscleMass"));
						inbody.setSave_day(rs.getString("save_day"));
						//ArrayList컬렉션에 workOut객체 추가
						inbodyList.add(inbody);
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
		return inbodyList;					
	}
}
