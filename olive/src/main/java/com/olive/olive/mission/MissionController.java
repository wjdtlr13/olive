package com.olive.olive.mission;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.olive.olive.common.MyUtil;
import com.olive.olive.member.SessionInfo;

@Controller("mission.missionController")
@RequestMapping("/mission/*")
public class MissionController {
	@Autowired
	private MissionService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("main")
	public String main(
			HttpSession session,
			Model model) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String nickName = info.getNickName();
		String userId = info.getUserId();
		int myComplete = service.countMyCompleteAttend(userId);
		model.addAttribute("myComplete", myComplete);
		model.addAttribute("nickName", nickName);
		
		return ".mission.main";
	}
	
	
	@RequestMapping(value="list")
	@ResponseBody
	public Map<String, Object> List(
			 @RequestParam(value="pageNo", defaultValue="1") int current_page,
			 @RequestParam String mode,
			 HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		List<Mission> list = null; int dataCount=0;
		if(mode.equals("notmy")) {
			dataCount = service.countCurrentNotMyMission(userId);
			list = service.listCurrentNotMyMission(userId);
		} else if(mode.equals("admin")) {
			dataCount = service.countMission();
			list = service.listMission();
		}
		else{
			dataCount = service.countMyCurrentAttend(userId);
			list = service.listMyCurrentAttend(userId);
		}
		
		for(Mission dto:list) {
			int attendCount = service.countAttend(dto.getNum());
			int likeCount = service.countLike(dto.getNum());
			dto.setAttendee(attendCount);
			dto.setLikeCount(likeCount);
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("mode", mode);
		model.put("list", list);
		model.put("pageNo", current_page);
		
		return model;
	}
	
	@RequestMapping(value="listcontent")
	@ResponseBody
	public Map<String, Object> ListContent(
			@RequestParam int num,
			@RequestParam String mode,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		List<Content> list = service.listMissionContent(num);
		
		for(Content dto:list) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			int contentNum = dto.getContentNum();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("contentNum", contentNum);
			map.put("userId", userId);
			try {
				Content mine = service.getMyContentAttend(map);
				dto.setAttendDate(mine.getAttendDate());
				dto.setAccept(mine.getAccept());
			} catch (Exception e) {
				e.printStackTrace();
				dto.setAttendDate("");
				dto.setAccept(0);
			}
		}
		Map<String, Object> model = new HashMap<>();
		model.put("list", list);
		model.put("mode", mode);
		
		return model;
	}
	
	
	@RequestMapping(value="insertmission", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertMission(
		Mission dto) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		int num = 0;
		
		try {
			num = service.insertMission(dto);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "false");
			throw e;
		}
		
		result.put("status", "true");
		result.put("num", num);
		return result;
	};
	
	@PostMapping("updatemission")
	@ResponseBody
	public Map<String, Object> updateMission(
			Mission dto) throws Exception{
		Map<String, Object> model = new HashMap<>();
		
		try {
			service.updateMission(dto);
			model.put("status", "true");
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "false");
		}
		
		return model;
	};
	
	@PostMapping("deletemission")
	@ResponseBody
	public Map<String, Object> deleteMission(
			@RequestParam int num,
			@RequestParam String userId) throws Exception{
		Map<String, Object> model = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		map.put("num", num);
		map.put("userId", userId);
		try {
			
			service.deleteMission(map);
			model.put("status", "true");
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "false");
		}
		
		return model;
	};
	
	@RequestMapping("insertcontent")
	@ResponseBody
	public Map<String, Object> insertContent(
			@RequestParam int missionNum,
			@RequestParam(name="subject") List<String> listSubject,
			@RequestParam(name="content") List<String> listContent,
			@RequestParam(name="startDate") List<String> listStartDate,
			@RequestParam(name="endDate") List<String> listEndDate,
			@RequestParam String userId) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			for(int i=0; i<listContent.size(); i++) {
				Content dto = new Content();
				
				dto.setMissionNum(missionNum);
				dto.setContent(listContent.get(i));
				dto.setStartDate(listStartDate.get(i));
				dto.setEndDate(listEndDate.get(i));
				dto.setSubject(listSubject.get(i));
				dto.setUserId(userId);
				
				service.insertMissionContent(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "false");
			throw e;
		}
		
		result.put("status", "true");
		return result;
	};
	@PostMapping("updatecontent")
	@ResponseBody
	public Map<String, Object> updateContent(
			Content dto) throws Exception{
		Map<String, Object> model = new HashMap<>();
		
		try {
			service.updateMissionContent(dto);
			model.put("status", "true");
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "false");
		}
		
		return model;
	}
	
	@PostMapping("deletecontent")
	@ResponseBody
	public Map<String, Object> deleteContent(
			@RequestParam int contentNum,
			@RequestParam String userId) throws Exception{
		Map<String, Object> model = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		map.put("contentNum", contentNum);
		map.put("userId", userId);
		try {
			
			service.deleteMissionContent(map);
			model.put("status", "true");
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "false");
		}
		
		return model;
	}
	
	@PostMapping("insertattend")
	@ResponseBody
	public Map<String, Object> insertMissionAttend(
			Mission dto) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			service.insertMissionAttend(dto);
			map.put("status", "true");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("status", "false");
			throw e;
		}
		
		return map;
	}
	
	@PostMapping("insertcontentattend")
	@ResponseBody
	public Map<String, Object> insertContentAttend(
			Content dto,
			HttpSession session) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String path=root+"uploads"+File.separator+"photo";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String state = "true";
		try {
			dto.setUserId(info.getUserId());
			service.insertMissionContentAttend(dto, path);
		} catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	
	
	
}
