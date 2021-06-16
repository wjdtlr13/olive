package com.olive.olive.notice;

import java.util.List;
import java.util.Map;

public interface NoticeService {
	
	public void insertNotice(Notice dto, String mode) throws Exception;
	public int dataCount(Map<String, Object> map);
	 
	public List<Notice> listNotice(Map<String, Object> map);
	
	public void updateHitCount(int num) throws Exception;
	
	public Notice readNotice(int num);
	
	public void updateNotice(Notice dto) throws Exception;
	public void deleteNotice(int num, String userId) throws Exception;
	
	

}
