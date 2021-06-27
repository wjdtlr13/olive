package com.olive.olive.admin.manage;

import java.util.List;
import java.util.Map;
 
public interface MemberSerivce {
	 
	public int dataCount(Map<String, Object> map);
	
	public List<Member> listMember(Map<String, Object> map) throws Exception;

	public Member readMember(String userId) throws Exception;
	
	//신고하기
	public void insertBlock(Block dto) throws Exception;
	
	//신고된 회원 warn_cnt 증가
	public void updateWarncnt(String blockedId) throws Exception;
	
	//신고회원리스트
	public List<Block> blockList(Map<String, Object> map) throws Exception;
	
	//신고회원조치
	public void updateBlockMember(String userId) throws Exception;
	
}
