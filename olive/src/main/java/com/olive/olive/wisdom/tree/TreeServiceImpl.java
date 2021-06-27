package com.olive.olive.wisdom.tree;

import java.util.List;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.olive.olive.common.FileManager;
import com.olive.olive.common.dao.CommonDAO;


@Service("wisdom.wisdomServiceImpl")
public class TreeServiceImpl implements TreeService{

	@Autowired
	private CommonDAO dao;
	
	@Autowired 
	private FileManager filManager;
	
	@Override
	public void insertWisdom(Tree dto, String pathname) throws Exception {
		try {
			int seq=dao.selectOne("wisdom.seq");
			dto.setNum(seq);
			
			dao.insertData("wisdom.insertImage", dto);
			
			//파일 업로드
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					String saveFilename=filManager.doFileUpload(mf, pathname);
					if(saveFilename==null) continue;
					
					dto.setImageFileName(saveFilename);
					insertImg(dto);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;

		}
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result=dao.selectOne("wisdom.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();

		}
		return result;
	}

	@Override
	public List<Tree> listWisdom(Map<String, Object> map) {
		List<Tree> list = null;
		try {
			list = dao.selectList("wisdom.listWisdom", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Tree readWisdom(int num) {
		Tree dto = null;
		try {
			dto=dao.selectOne("wisdom.readWisdom", num);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateWisdom(Tree dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteWisdom(int num, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertImg(Tree dto) throws Exception {
		
		
		try {
			dao.selectList("wisdom.listImg" ,dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;

		}
		
	}

	@Override
	public List<Tree> listImg(int num) {
		List<Tree> listImg=null;
		
		try {
			listImg=dao.selectList("wisdom.listImg",num);
		} catch (Exception e) {
			e.printStackTrace();

		}
		
		return listImg;
	}
	@Override
	public Tree readImg(int imageNum) {
		Tree dto = null;
		
		try {
			dto=dao.selectOne("wisdom.readImg",imageNum);
		} catch (Exception e) {
			e.printStackTrace();

		}
		
		return dto;
	}
	
	@Override
	public void deleteImg(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("wisdom.deleteImg", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;

		}
		
	}

	@Override
	public void insertWisdomLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("wisdom.insertWisdomLike", map);
			
			int num = (Integer)map.get("num");
			int count = wisdomLikeCount(num);
			
			if(count>=2) {
				updateSelect(num);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	

	@Override
	public int wisdomLikeCount(int num) {
		int result=0;
		try {
			result=dao.selectOne("wisdom.wisdomLikeCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("wisdom.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}	
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list=null;
		try {
			list=dao.selectList("wisdom.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("wisdom.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertReplyLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("wisdom.insertReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int replyLikeCount(int replyNum) {
		int result=0;
		try {
			result=dao.selectOne("wisdom.replyLikeCount", replyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	
	//게시물 옮기기 위한 selected 없데이트하기
	@Override
	public void updateSelect(int num) throws Exception {
		
		try {
			dao.updateData("wisdom.updateSelected", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}

	@Override
	public List<Category> listCategory() {
		List<Category> list = null;
		try {
			list = dao.selectList("wisdom.listCategory");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	
	
	

}
