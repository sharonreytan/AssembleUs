package model;

import java.sql.ResultSet;

public class ForumPostsPOJO {
	private ResultSet posts_rs;
	private int topic;
	
	ForumPostsPOJO(ResultSet posts_rs , int topic){
		this.posts_rs = posts_rs;
		this.topic = topic;
	}

	public ResultSet getPosts_rs() {
		return posts_rs;
	}

	public int getTopic() {
		return topic;
	}
}
