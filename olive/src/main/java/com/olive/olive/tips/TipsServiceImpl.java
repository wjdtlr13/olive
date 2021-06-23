package com.olive.olive.tips;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.olive.common.FileManager;
import com.olive.olive.common.dao.CommonDAO;

@Service("tips.tipsService")
public class TipsServiceImpl implements TipsService{
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;

	@Override
	public void insertTips(Tips dto, String pathname) throws Exception {
		try {
			
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename!=null) {
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			}
			dao.insertData("tips.insertTips", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Tips> listTips(Map<String, Object> map) {
		List<Tips> list = null;
		try {
			list=dao.selectList("tips.listTips", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("tips.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Tips readTips(int num) {
		Tips dto = null;
		try {
			dto=dao.selectOne("tips.readTips", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("tips.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Tips preReadTips(Map<String, Object> map) {
		Tips dto = null;
		try {
			dto=dao.selectOne("tips.preReadTips", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Tips nextReadTips(Map<String, Object> map) {
		Tips dto= null;
		try {
			dto=dao.selectOne("tips.nextReadTips", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateTips(Tips dto, String pathname) throws Exception {
		try {
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename!=null) {
				if(dto.getSaveFilename()!=null&&dto.getSaveFilename().length()!=0)
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			}
			dao.updateData("tips.updateTips", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteTips(int num, String pathname, String userId) throws Exception {
		try {
			Tips dto = readTips(num);
			if(dto==null||( ! userId.equals("admin")&& ! userId.equals(dto.getUserId())))
				return;
			
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
			
			dao.deleteData("tips.deleteTips", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertTipsLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("tips.insertTipsLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int tipsLikeCount(int num) {
		int result=0;
		try {
			result=dao.selectOne("tips.tipsLikeCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public String getAddress(String userId) {
		String result = "";
		try {
			result = dao.selectOne("tips.getAddress", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
}
