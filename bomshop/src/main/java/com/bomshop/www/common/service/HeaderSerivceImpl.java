package com.bomshop.www.common.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bomshop.www.common.dao.HeaderDAO;

@Service
public class HeaderSerivceImpl implements HeaderService{

	@Inject
	HeaderDAO dao;
	
	@Override
	public List<String> getBrandList() throws Exception {
		return dao.getBrandList();
	}
	
	
}
