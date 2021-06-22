package com.olive.olive.junggo;

import java.util.List;
import java.util.Map;

public interface JunggoService {
	public void insertJunggo(Junggo dto, String pathname) throws Exception;
	public List<Junggo> listJunggo(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Junggo readJunggo(int num);
	public void updateHitCount(int num) throws Exception;
	public Junggo preReadJunggo(Map<String, Object> map);
	public Junggo nextReadJunggo(Map<String, Object> map);
	public void updateJunggo(Junggo dto, String pathname) throws Exception;
	public void deleteJunggo(int num, String pathname, String userId) throws Exception;
	
	public List<Junggo> listCategory();
	
	public void insertJunggoLike(Map<String, Object> map) throws Exception;
	public int junggoLikeCount(int num);
	public boolean isJunggoLikeUser(Map<String, Object> map);
	public int junggoLikeDelete(Map<String, Object> map) throws Exception;
	
	public void insertReply(Reply dto) throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;
	
	public List<Reply> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);
	
}
