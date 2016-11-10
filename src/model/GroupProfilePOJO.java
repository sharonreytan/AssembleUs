package model;

public class GroupProfilePOJO {
	String group_id;
	String group_name;
	String group_desc;
	boolean isMember;
	
	GroupProfilePOJO(String group_id, String group_name, String group_desc){
		this.group_id = group_id;
		this.group_name = group_name;
		this.group_desc = group_desc;
	}

	public String getGroup_id() {
		return group_id;
	}

	public String getGroup_name() {
		return group_name;
	}

	public String getGroup_desc() {
		return group_desc;
	}

	public boolean isMember() {
		return isMember;
	}

	public void setMember(boolean isMember) {
		this.isMember = isMember;
	}
	
}
