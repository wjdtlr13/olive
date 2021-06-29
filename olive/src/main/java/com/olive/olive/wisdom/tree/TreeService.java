package com.olive.olive.wisdom.tree;

import java.util.List;
import java.util.Map;



public interface TreeService {
	
	public void insertWisdom(Tree dto, String pathname) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Tree> listWisdom(Map<String, Object> map);
	public Tree readWisdom(int num);
	 
	public void updateHitCount(int num) throws Exception;
	public void updateWisdom(Tree dto, String pathname) throws Exception;
	
	public void deleteWisdom(int num, String pathname) throws Exception;
	
	public void insertImg(Tree dto) throws Exception;
	public List<Tree> listImg(int num);
	public Tree readImg(int imageNum);
	public void deleteImg(Map<String, Object> map) throws Exception;
	 
	//selected 업데이트
	public void updateSelect(int num) throws Exception;
	 
	public Tree preReadWisdom(Map<String, Object> map);
	public Tree nextReadWisdom(Map<String, Object> map);
	
	
	public void deleteWisdom(int num, String pathname, String userId) throws Exception;
	
	//좋아요
	public void insertWisdomLike(Map<String, Object> map) throws Exception;
	public int wisdomLikeCount(int num);
	
	//댓글
	public void insertReply(Reply dto) throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;

	//댓글 좋아요
	public void insertReplyLike(Map<String, Object> map) throws Exception;
	public int replyLikeCount(int replyNum);
		
	//카테고리 리스트
	public List<Tree> listCategory();

}
