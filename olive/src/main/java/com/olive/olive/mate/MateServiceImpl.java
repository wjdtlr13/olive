package com.olive.olive.mate;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.olive.common.dao.CommonDAO;

@Service("olive.mateService")
public class MateServiceImpl implements MateService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public String getAddress(String userId) {
		String result = "";
		
		try {
			result = dao.selectOne("mate.getAddress", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public int insertMate(Mate dto) throws Exception {
		int result = 0;
		
		try {
			dao.insertData("mate.insertMate", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		result = dto.getNum();
		return result;
	}

	@Override
	public int updateMate(Mate dto) throws Exception {
		int result = 0;
		
		try {
			result = dao.updateData("mate.updateMate", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public int deleteMate(int num) throws Exception {
		int result = 0;
		
		try {
			result = dao.deleteData("mate.deleteMate", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("mate.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public List<Category> listCategory() {
		List<Category> list = null;
		
		try {
			list = dao.selectList("mate.listCategory");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return list;
	}
	
	@Override
	public int insertMate_Register(Register dto) throws Exception {
		int result = 0;
		
		try {
			result = dao.insertData("mate.insertMate_Register", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public int deleteMate_Register(Map<String, Object> map) throws Exception {
		int result = 0;
		int num = Integer.parseInt(map.get("mate_regi_num").toString());
		
		try {
			result = dao.deleteData("mate.deleteMate_Register", map);
			result += dao.deleteData("mate.deleteMateinRequest", map);
			result += dao.deleteData("mate.deleteRequestinRegister", map);
			result += deleteMate(num);
		} catch (Exception e) {
			throw e;
		}
		
		return result;
	}

	@Override
	public List<Register> listMyRegister(Map<String, Object> map) {
		String mode = (String) map.get("mode");
		String query = "";
		if(mode.equals("upcoming"))
			query = "mate.listRegister_upcoming";
		else if(mode.equals("past"))
			query = "mate.listRegister_past";
		else if(mode.equals("matched"))
			query = "mate.listRegister_matched";
		else return null;
		List<Register> list = null;
		
		try {
			list = dao.selectList(query, map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Register readMate_Register(int num) {
		Register dto = null;
		try {
			dto = dao.selectOne("mate.readMate_Register", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int updateMate_RegisterAccept(Map<String, Object> map) throws Exception {
		int result = 0;
		
		try {
			result = dao.updateData("mate.updateMate_RegisterAccept", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public int insertMate_Request(Request dto) throws Exception {
		int result = 0;
		
		try {
			result = dao.insertData("mate.insertMate_Request", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

	@Override
	public int deleteMate_Request(int num) throws Exception {
		int result = 0;
		
		try {
			result = dao.insertData("mate.deleteMate_Request", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return result;
	}

}
