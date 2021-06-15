package com.olive.olive.mission;

import java.util.List;
import java.util.Map;

public interface MissionService {
	public int insertMission(Mission dto) throws Exception;
	public int updateMission(Mission dto) throws Exception;
	public int deleteMission(Map<String, Object> map) throws Exception;
	
	public int insertMissionImage(Mission dto, String pathname) throws Exception;
	public int deleteMissionImage(int imageNum, String pathname) throws Exception;
	
	public List<Mission> listMission();
	public List<Mission> listCurrentNotMyMission(String userId);//
	public int countCurrentNotMyMission(String userId);//
	
	public int insertLike(Map<String, Object> map) throws Exception;
	public int deleteLike(Map<String, Object> map) throws Exception;
	public int countLike(int num);//
	
	public int insertMissionAttend(Mission dto) throws Exception;
	public int deleteMissionAttend(Map<String, Object> map) throws Exception;
	public int countAttend(int missionNum);//
	
	
	public List<Mission> listMyAttend(String userId);
	public int countMyCompleteAttend(String userId);//
	public List<Mission> listMyCurrentAttend(String userId);//
	public int countMyCurrentAttend(String userId);//
	
	public int insertMissionContent(Content dto) throws Exception;
	public int updateMissionContent(Content dto) throws Exception;
	public int deleteMissionContent(Map<String, Object> map) throws Exception;
	
	public List<Content> listMissionContent(int missionNum);//
	
	public int insertMissionContentAttend(Content dto) throws Exception;
	public int updateMissionContentAttend(Content dto) throws Exception;
	public int deleteMissionContentAttend(Map<String, Object> map) throws Exception;
	
	public int countContentAttend(int contentNum);
	public Content getMyContentAttend(Map<String, Object> map);//
	public int checkMyContentAttendAccept(Map<String, Object> map);
	

}
