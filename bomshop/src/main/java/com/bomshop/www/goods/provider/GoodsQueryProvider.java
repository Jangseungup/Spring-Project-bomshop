package com.bomshop.www.goods.provider;

import org.apache.ibatis.jdbc.SQL;

import com.bomshop.www.common.util.SearchCriteria;

public class GoodsQueryProvider {
	
	public String searchSelectSql(SearchCriteria cri) {
		SQL sql = new SQL() {
			{
				SELECT("*");
				FROM("goods");
				
				//getSearchWhere(cri, this);
				
				ORDER_BY("gno DESC");
				LIMIT(cri.getPageStart()+","+cri.getPerPageNum());
			}
		};
		
		String query = sql.toString();
		
		return query;
	}
	
	public String searchSelectCount(SearchCriteria cri) {
		return new SQL() {
			{
				SELECT("count(*)");
				FROM("goods");
				//getSearchWhere(cri,this);
			}
		}.toString();
	}
	
	public void getSearchWhere(SearchCriteria cri, SQL sql) {
		
		String gname_ko_query = "gname_ko LIKE CONCAT('%','"+cri.getKeyword()+"','&')";
		String gname_en_query = "gname_en LIKE CONCAT('%','"+cri.getKeyword()+"','&')";
		String tag1_query = "tag1 LIKE CONCAT('%','"+cri.getKeyword()+"','&')";
		String tag2_query = "tag2 LIKE CONCAT('%','"+cri.getKeyword()+"','&')";
		String tag3_query = "tag3 LIKE CONCAT('%','"+cri.getKeyword()+"','&')";
		
		
		//sql.WHERE(gname_ko_query).OR().WHERE(gname_en_query).OR().WHERE(tag1_query).OR().WHERE(tag2_query).OR().WHERE(tag3_query);
	
	}

}
