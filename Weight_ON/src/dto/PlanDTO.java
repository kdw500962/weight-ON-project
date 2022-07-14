package dto;

public class PlanDTO{
	
	private Integer num;				//DB_index
	private String id;					//userID
	private String workoutNum;			//운동 번호
	private String name;				//운동명
	private String category;			//운동부위
	private Integer setWeight;			//세팅 무게
	private Integer setCount;			//추가한 세트 수
	private String memo;				//운동 설명
	private String complete;			//완료여부
	private String save_day;			//저장날짜
	private String done_day;			//완료날짜
	
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getWorkoutNum() {
		return workoutNum;
	}
	public void setWorkoutNum(String workoutNum) {
		this.workoutNum = workoutNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Integer getSetWeight() {
		return setWeight;
	}
	public void setSetWeight(Integer setWeight) {
		this.setWeight = setWeight;
	}
	public Integer getSetCount() {
		return setCount;
	}
	public void setSetCount(Integer setCount) {
		this.setCount = setCount;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getComplete() {
		return complete;
	}
	public void setComplete(String complete) {
		this.complete = complete;
	}
	public String getSave_day() {
		return save_day;
	}
	public void setSave_day(String save_day) {
		this.save_day = save_day;
	}
	public String getDone_day() {
		return done_day;
	}
	public void setDone_day(String done_day) {
		this.done_day = done_day;
	}

}
