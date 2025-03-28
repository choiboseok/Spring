package com.future.my.fish.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.future.my.fish.dao.IFishDAO;
import com.future.my.fish.vo.FishVO;

@Service
public class FishService {
	@Autowired
	IFishDAO dao;
	
	public ArrayList<FishVO> getInfo(){
		
		return dao.getInfo();
	}
}
