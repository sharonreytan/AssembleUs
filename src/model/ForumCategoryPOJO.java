package model;

import java.sql.ResultSet;

public class ForumCategoryPOJO {
	private ResultSet cat_rs;
	
	ForumCategoryPOJO(ResultSet cat_rs){
		this.cat_rs = cat_rs;
	}

	public ResultSet getCat_rs() {
		return cat_rs;
	}
}
