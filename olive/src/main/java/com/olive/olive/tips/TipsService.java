package com.olive.olive.tips;

import java.util.List;
import java.util.Map;

public interface TipsService {
	public void insertTips(Tips dto, String pathname) throws Exception;
	public List<Tips> listTips(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Tips readTips(int num);
	public void updateHitCount(int num) throws Exception;
	public Tips preReadTips(Map<String, Object> map);
	public Tips nextReadTips(Map<String, Object> map);
	public void updateTips(Tips dto, String pathname) throws Exception;
	public void deleteTips(int num, String pathname, String userId) throws Exception;
	
	public void insertTipsLike(Map<String, Object> map) throws Exception;
	public int tipsLikeCount(int num);
	 
	public String getAddress(String userId);
}
