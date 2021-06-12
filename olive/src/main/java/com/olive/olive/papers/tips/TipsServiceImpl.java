package com.olive.olive.papers.tips;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.olive.olive.common.dao.CommonDAO;

public class TipsServiceImpl implements TipsService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertTips(Tips dto) throws Exception {
		try {
			dao.insertData("papers.tips.insertTips", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Tips> listTips(Map<String, Object> map) {
		List<Tips> list = null;
		
		try {
			list=dao.selectList("papers.tips.listTips", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result=dao.selectOne("papers.tips.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public Tips readTips(int num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Tips preReadTips(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Tips nextReadTips(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateTips(Tips dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteTips(int num, String userId) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertTipsLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int tipsLikeCount(int num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean isTipsLikeUser(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int tipsLikeDelete(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	

}
