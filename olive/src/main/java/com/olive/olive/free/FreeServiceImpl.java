package com.olive.olive.free;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.olive.common.FileManager;
import com.olive.olive.common.dao.CommonDAO;

@Service("olive.freeService")
public class FreeServiceImpl implements FreeService{
	@Autowired
	private CommonDAO  dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertFree(Free dto, String pathname) throws Exception{
		try{
			
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename!=null) {
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			}
			
			dao.insertData("free.insertFree", dto);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Category> listCategory(){
		List<Category> list = null;
		try {
			list = dao.selectList("free.listCategory");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<Free> listFree(Map<String, Object> map) {
		List<Free> list=null;
		
		try{
			list=dao.selectList("free.listFree", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try{
			result=dao.selectOne("free.dataCount", map);			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public Free readFree(int num) {
		Free dto=null;
		
		try{
			// 게시물 가져오기
			dto=dao.selectOne("free.readFree", num);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try{
			// 조회수 증가
			dao.updateData("free.updateHitCount", num);
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public Free preReadFree(Map<String, Object> map) {
		Free dto=null;
		
		try{
			dto=dao.selectOne("free.preReadFree", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;

	}

	@Override
	public Free nextReadFree(Map<String, Object> map) {
		Free dto=null;
		
		try{
			dto=dao.selectOne("free.nextReadFree", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public void updateFree(Free dto, String pathname) throws Exception{
		try{
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename != null) {
				if(dto.getSaveFilename()!=null && dto.getSaveFilename().length()!=0)
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			}
			
			dao.updateData("free.updateFree", dto);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteFree(int num, String pathname, String userId) throws Exception{
		try{
			Free dto=readFree(num);
			if(dto==null || (! userId.equals("admin") && ! userId.equals(dto.getUserId())))
				return;
			
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
			
			
			dao.deleteData("free.deleteFree", num);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("free.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list=null;
		try {
			list=dao.selectList("free.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("free.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception{
		try {
			dao.deleteData("free.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list=null;
		try {
			list=dao.selectList("free.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result=0;
		try {
			result=dao.selectOne("free.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertReplyLike(Map<String, Object> map) throws Exception{
		try {
			dao.insertData("free.insertReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Map<String, Object> replyLikeCount(Map<String, Object> map) {
		Map<String, Object> countMap=null;
		try {
			countMap=dao.selectOne("free.replyLikeCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return countMap;
	}

	@Override
	public void insertFreeLike(Map<String, Object> map) throws Exception{
		try {
			dao.insertData("free.insertFreeLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int freeLikeCount(int num) {
		int result=0;
		try {
			result=dao.selectOne("free.freeLikeCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int updatePoint(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("member.updatePoint", map);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}
}
