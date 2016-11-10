package model;

import java.sql.ResultSet;

public class GroupsPOJO {
	private ResultSet groups_rs;
	
	GroupsPOJO(ResultSet groups_rs){
		this.groups_rs = groups_rs;
	}

	public ResultSet getGroups_rs() {
		return groups_rs;
	}
}
