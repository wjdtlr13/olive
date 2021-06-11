package com.olive.olive.presence;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.olive.common.dao.CommonDAO;

@Service("olive.presenceService")
public class PresenceServiceImpl implements PresenceService{
	@Autowired
	private CommonDAO dao;
	
	@Override
	public int findContinuous(String userId) {
		int result = 0;
		try {
			result = dao.selectOne("presence.findContinuous", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public int myDataCount(String userId) {
		int result = 0;
		try {
			result = dao.selectOne("presence.myDataCount", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	

	@Override
	public int findMyTodayData(String userId) {
		int result = 0;
		try {
			result = dao.selectOne("presence.findMyTodayData", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public String findMyLatest(String userId) {
		List<Presence> list = null;
		String created = "";
		try {
			list = dao.selectList("presence.findMyLatest", userId);
			created = list.get(0).getCreated();
		} catch (Exception e) {
			e.printStackTrace();
			return created;
		}
		return created;
	}

	
	@Override
	public List<Presence> listPresence(Map<String, Object> map) {
		List<Presence> list = null;
		
		try {
			list = dao.selectList("presence.listPresence", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public int insertPresence(Presence dto) throws Exception {
		int result = 0;
		try {
			result = dao.insertData("presence.insertPresence", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	
	@Override
	public int updatePresence(Presence dto) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("presence.updatePresence", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;	
	}

	@Override
	public int dataCount(String userId) {
		int result = 0;
		try {
			result = dao.selectOne("presence.dataCount", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	


}
