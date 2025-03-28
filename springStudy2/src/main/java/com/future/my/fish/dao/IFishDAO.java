package com.future.my.fish.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.future.my.fish.vo.FishVO;

@Mapper
public interface IFishDAO {
	// 내용 출력
	public ArrayList<FishVO> getInfo();
	
}