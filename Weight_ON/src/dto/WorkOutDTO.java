package dto;

public class WorkOutDTO{
	
	private String workoutNum;			//운동 번호
	private String name;				//운동명
	private String description;			//운동 설명
	private String category;			//운동부위
	private String majorMuscle;			//주요근욱
	private String supportMuscle;		//지지근욱
	private String equipment;			//운동장비
	private String filename;			//이미지 파일명
	private Integer setWeight;			//세팅 무게
	private Integer setCount;			//추가한 세트 수 
	
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getMajorMuscle() {
		return majorMuscle;
	}
	public void setMajorMuscle(String majorMuscle) {
		this.majorMuscle = majorMuscle;
	}
	public String getSupportMuscle() {
		return supportMuscle;
	}
	public void setSupportMuscle(String supportMuscle) {
		this.supportMuscle = supportMuscle;
	}
	public String getEquipment() {
		return equipment;
	}
	public void setEquipment(String equipment) {
		this.equipment = equipment;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
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

}
