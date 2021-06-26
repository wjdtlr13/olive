package com.olive.olive.free;

import java.util.List;
import java.util.Map;

public interface FreeService {
	public void insertFree(Free dto, String pathname) throws Exception;
	public List<Category> listCategory();
	public List<Free> listFree(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Free readFree(int num);
	public void updateHitCount(int num) throws Exception;
	public Free preReadFree(Map<String, Object> map);
	public Free nextReadFree(Map<String, Object> map);
	public void updateFree(Free dto, String pathname) throws Exception;
	public void deleteFree(int num, String pathname, String userId) throws Exception;
	
	public void insertFreeLike(Map<String, Object> map) throws Exception;
	public int freeLikeCount(int num);
	
	public void insertReply(Reply dto) throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;
	
	public List<Reply> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);
	
	public void insertReplyLike(Map<String, Object> map) throws Exception;
	public Map<String, Object> replyLikeCount(Map<String, Object> map);
	
	public int updatePoint(Map<String, Object> map) throws Exception;
	
	
	
}


