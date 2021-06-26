package com.olive.olive.mission;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.olive.common.FileManager;
import com.olive.olive.common.dao.CommonDAO;

@Service("mission.missionService")
public class MissionServiceImpl implements MissionService{

	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public int insertMission(Mission dto) throws Exception {
		int result = 0;
		try {
			dao.insertData("mission.insertMission", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		result = dto.getNum();
		return result;
	}
	
	@Override
	public int updateMission(Mission dto) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("mission.updateMission", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int deleteMission(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.deleteData("mission.deleteMission", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int insertMissionImage(Mission dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteMissionImage(int imageNum, String pathname) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Mission> listMission() {
		List<Mission> list = null;
		try {
			list=dao.selectList("mission.listMission");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public int countMission() {
		int result = 0;
		try {
			result=dao.selectOne("mission.countMission");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Mission> listCurrentNotMyMission(String userId) {
		List<Mission> list = null;
		try {
			list=dao.selectList("mission.listCurrentNotMyMission", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int countCurrentNotMyMission(String userId) {
		int result = 0;
		try {
			result=dao.selectOne("mission.countCurrentNotMyMission", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int insertLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int countLike(int num) {
		int result = 0;
		try {
			result=dao.selectOne("mission.countLike", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int insertMissionAttend(Mission dto) throws Exception {
		int result = 0;
		try {
			result = dao.insertData("mission.insertMissionAttend", dto);
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	@Override
	public int deleteMissionAttend(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public int countAttend(int missionNum) {
		int result = 0;
		try {
			result=dao.selectOne("mission.countAttend", missionNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Mission> listMyAttend(String userId) {
		List<Mission> list = null;
		try {
			list=dao.selectList("mission.listMyAttend", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int countMyCompleteAttend(String userId) {
		int result = 0;
		try {
			result=dao.selectOne("mission.countMyCompleteAttend", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Mission> listMyCurrentAttend(String userId) {
		List<Mission> list = null;
		try {
			list=dao.selectList("mission.listMyCurrentAttend", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int countMyCurrentAttend(String userId) {
		int result = 0;
		try {
			result=dao.selectOne("mission.countMyCurrentAttend", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int insertMissionContent(Content dto) throws Exception {
		int result = 0;
		try {
			result = dao.insertData("mission.insertMissionContent", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public int updateMissionContent(Content dto) throws Exception {
		int result = 0;
		try {
			result = dao.updateData("mission.updateMissionContent", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int deleteMissionContent(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.deleteData("mission.deleteMissionContent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Content> listMissionContent(int missionNum) {
		List<Content> list = null;
		try {
			list=dao.selectList("mission.listMissionContent", missionNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int insertMissionContentAttend(Content dto, String pathname) throws Exception {
		int result = 0;
		try {
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename!=null) {
				dto.setImageFileName(saveFilename);
				result = dao.insertData("mission.insertMissionContentAttend", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public int updateMissionContentAttend(Content dto) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteMissionContentAttend(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int countContentAttend(int contentNum) {
		int result = 0;
		try {
			result=dao.selectOne("mission.countContentAttend", contentNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Content getMyContentAttend(Map<String, Object> map) {
		Content dto = null;
		try {
			dto=dao.selectOne("mission.getMyContentAttend", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int checkMyContentAttendAccept(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
