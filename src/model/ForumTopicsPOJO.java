package model;

import java.sql.ResultSet;

public class ForumTopicsPOJO {
	private ResultSet topic_rs;
	private int category;
	
	ForumTopicsPOJO(ResultSet topic_rs , int category){
		this.topic_rs = topic_rs;
		this.category = category;
	}

	public ResultSet getTopic_rs() {
		return topic_rs;
	}

	public int getCategory() {
		return category;
	}
}
