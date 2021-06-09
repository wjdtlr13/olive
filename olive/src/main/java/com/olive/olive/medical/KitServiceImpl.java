package com.olive.olive.medical;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.olive.common.dao.CommonDAO;

@Service("kit.kitService")
public class KitServiceImpl implements KitService{
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertKit(Kit dto) throws Exception {
		try {
			int seq =dao.selectOne("kit.seq");
			dto.setNum(seq);
			
			dao.insertData("kit.insertKit", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("kit.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Kit> listKit(Map<String, Object> map) {
		List<Kit> list = null;
		
		try {
			list = dao.selectList("kit.listKit", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public Kit readKit(int num) {
		Kit dto = null;
		
		try {
			dto = dao.selectOne("kit.readKit", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateKit(Kit dto) throws Exception {
		try {
			dao.updateData("kit.updateKit", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteKit(int num, String userId) throws Exception {
		try {
			Kit dto = readKit(num);
			if(dto==null || (!userId.equals("admin")&& ! userId.equals(dto.getUserId())))
				return;
			dao.deleteData("kit.deleteKit", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
}
