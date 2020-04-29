package com.bomshop.www.common.dao;
import java.util.List;

import org.apache.ibatis.annotations.Select;

public interface HeaderDAO {

	@Select("SELECT shopname FROM member WHERE mtype=2")
	List<String> getBrandList() throws Exception;

	
}
