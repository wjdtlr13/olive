package com.olive.olive.presence;

import java.util.List;
import java.util.Map;

public interface PresenceService {
	public int findContinuous(String userId);
	public int myDataCount(String userId);
	public int findMyTodayData(String userId);
	public String findMyLatest(String userId);
	
	public int insertPresence(Presence dto) throws Exception;
	public int updatePresence(Presence dto) throws Exception;
	
	public int dataCount(String userId);
	public List<Presence> listPresence(Map<String, Object> map);
	
	
}
