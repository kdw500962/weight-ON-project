package mvc.model;

public class adviceDTO {
	private int num;
	private String id;
	private String name;
	private String subject;
	private String content;
	private String filename;
	private String regist_day;
	private int hit;
	
	public adviceDTO() {
		super();		
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getRegist_day() {
		return regist_day;
	}

	public void setRegist_day(String regist_day) {
		this.regist_day = regist_day;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

}
