package com.olive.olive;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.olive.common.dao.CommonDAO;
import com.olive.olive.junggo.Junggo;

@Service("olive.homeService")
public class HomeServiceImpl implements HomeService{
	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Junggo> listJunggo() {
		List<Junggo> list = null;
		try {
			list = dao.selectList("home.listJunggo");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
