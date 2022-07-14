package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.sun.org.apache.regexp.internal.recompile;

import dto.SignDTO;
import dto.WorkOutDTO;
public class SignDAO {	
	
	private Connection conn = null;
	private PreparedStatement pstmt =null;
	private ResultSet rs =null;
	
	// id로 SignDAO검색 할 SignDAOArrayList 객체
	private ArrayList<SignDTO> SignList = new ArrayList<SignDTO>();
	
	private static SignDAO instance = new SignDAO();
	
	public static SignDAO getInstance() {
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
	
	//DB에 User정보 등록
	public int addUser(SignDTO user) {
		String sql = "INSERT INTO userTBL VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		int msg = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getBirth());
			pstmt.setString(6, user.getMail());
			pstmt.setString(7, user.getPhone());
			pstmt.setString(8, user.getAddress());
			pstmt.setString(9, user.getId_group());
			pstmt.setTimestamp(10, user.getRegist_day());
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

	//DB에 User정보 확인
	public SignDTO userCheck(String id, String password) {
		SignDTO userSign = new SignDTO();
		String sql = "SELECT * FROM userTBL WHERE ID=? and password=?";
		System.out.println(id);
		System.out.println(password);
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				userSign.setId(rs.getNString("id"));
				userSign.setId_group(rs.getString("id_group"));				
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
		return userSign;
	}

	//DB에 User정보 삭제
	public int deleteUser(String id) {
		String sql = "DELETE FROM userTBL WHERE id = ?";
		int msg = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
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
		
	//DB에 User정보 수정
	public int updateUser(SignDTO user) {
		String sql = "UPDATE userTBL SET PASSWORD=?, NAME=?, GENDER=?, BIRTH=?, MAIL=?, PHONE=?, ADDRESS=? WHERE ID=?";
		int msg = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getPassword());
			pstmt.setString(2, user.getName());
			pstmt.setString(3, user.getGender());
			pstmt.setString(4, user.getBirth());
			pstmt.setString(5, user.getMail());
			pstmt.setString(6, user.getPhone());
			pstmt.setString(7, user.getAddress());
			pstmt.setString(8, user.getId());
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
		//0:해당 아이디 없음, 1:수정 성공
	}
	
	//DB에 있는 모든 User목록을 가져와 SignList에 저장
	public ArrayList<SignDTO> getSignList(){
		String sql = "SELECT * FROM userTBL";
		try {
				//커넥션 얻기
				conn = getConnection();				
				pstmt = conn.prepareStatement(sql);
				//DB에 저장되어 있는 User정보  모두 가져와  ResultSet객체에 저장
				rs = pstmt.executeQuery();			
				SignList.clear();
				while (rs.next()){
					//빈 객체인 user에 DB에서 가져온 값을 각각 저장
					SignDTO user = new SignDTO();			
					user.setId(rs.getString("id"));
					user.setPassword(rs.getString("password"));
					user.setName(rs.getString("name"));
					user.setGender(rs.getString("gender"));
					user.setBirth(rs.getString("birth"));
					user.setMail(rs.getString("mail"));
					user.setPhone(rs.getString("phone"));
					user.setAddress(rs.getString("adress"));
					//ArrayList컬렉션에 user객체 추가
					SignList.add(user);				
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
		return SignList;					
	}
	
	//SignList에 저장된 User정보를 조회해서 id와 일치하는 User정보객체를 리턴하는 메서드
	public SignDTO getUserById(String id) {
		SignDTO userById = null;		
		for(int i=0; i<SignList.size(); i++) {
			SignDTO signDTO = SignList.get(i);
			if(signDTO != null && signDTO.getId() != null &&
					signDTO.getId().equals(id)) {
				userById = signDTO;
				break;
			}
		}
		return userById;
	}
	
	//ID찾기
	public String findId(String name, String birth) {
		String id = null;
		String sql = "SELECT id FROM userTBL WHERE name=? and birth=?";
		System.out.println(name);
		System.out.println(birth);
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, birth);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString("id");				
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
		return id;
	}
	
	//PW찾기
	public String findPassword(String id, String birth) {
		String password = null;
		String sql = "SELECT password FROM userTBL WHERE id=? and birth=?";
		System.out.println(id);
		System.out.println(birth);
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, birth);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				password = rs.getString("password");				
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
		return password;
	}
	
	//DB에서 sql문에 해당되어 가져 올 회원목록의 번호 및  전체 레코드 수를 표시할 때 사용된다.
	public int getAllCount() {
		String sql = "SELECT count(*) FROM userTBL";
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
	public ArrayList<SignDTO> getAllUser(int start,int end){
		String sql = "SELECT * FROM userTBL order by id asc limit ?,?";

		ArrayList<SignDTO> signList=null;
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
					signList = new ArrayList<SignDTO>(end);
					do {
						//빈 객체인 workOut에 DB에서 가져온 값을 각각 저장
						SignDTO user = new SignDTO();
						user.setId(rs.getString("id"));
						user.setPassword(rs.getString("password"));
						user.setName(rs.getString("name"));
						user.setGender(rs.getString("gender"));
						user.setBirth(rs.getString("birth"));
						user.setMail(rs.getString("mail"));
						user.setPhone(rs.getString("phone"));
						user.setAddress(rs.getString("address"));
						user.setId_group(rs.getString("id_group"));
						//ArrayList컬렉션에 workOut객체 추가
						signList.add(user);
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
		return signList;				
	}
}
