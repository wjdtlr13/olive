package com.olive.olive.junggo;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.olive.common.dao.CommonDAO;
 
@Service("junggo.junggoService")
public class JunggoServiceImpl implements JunggoService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertJunggo(Junggo dto, String pathname) throws Exception {
		try {
			dao.insertData("junggo.insertJunggo", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Junggo> listJunggo(Map<String, Object> map) {
		List<Junggo> list = null;
		try {
			list = dao.selectList("junggo.listJunggo", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("junggo.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Junggo readJunggo(int num) {
		Junggo dto = null;
		try {
			dto=dao.selectOne("junggo.readJunggo", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("junggo.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Junggo preReadJunggo(Map<String, Object> map) {
		Junggo dto = null;
		try {
			dto=dao.selectOne("junggo.preReadJunggo", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Junggo nextReadJunggo(Map<String, Object> map) {
		Junggo dto=null;
		try {
			dto=dao.selectOne("junggo.nextReadJunggo", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateJunggo(Junggo dto, String pathname) throws Exception {
		try {
			dao.updateData("junggo.updateJunggo", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteJunggo(int num, String pathname, String userId) throws Exception {
		try {
			Junggo dto = readJunggo(num);
			if(dto==null || (! userId.equals("admin") && ! userId.equals(dto.getUserId())))
				return;
			
			dao.deleteData("junggo.deleteJunggo", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertJunggoLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("junggo.insertJunggoLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int junggoLikeCount(int num) {
		int result=0;
		try {
			result=dao.selectOne("junggo.junggoLikeCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


	@Override
	public boolean isJunggoLikeUser(Map<String, Object> map) {
		boolean result=true;
		try {
			int cnt=dao.selectOne("junggo.junggoLikeUserCount", map);
			if(cnt>0) {
				result=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int junggoLikeDelete(Map<String, Object> map) throws Exception {
		int result=0;
		
		try {
			result=dao.deleteData("junggo.junggoLikeDelete", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("junggo.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		try {
			list = dao.selectList("junggo.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("junggo.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("junggo.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list = null;
		try {
			list = dao.selectList("junggo.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result = 0;
		try {
			result = dao.selectOne("junggo.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	
	@Override
	public List<Junggo> listCategory() {
		
		List<Junggo> list = null;
		
		try {
			list=dao.selectList("junggo.listCategory");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
