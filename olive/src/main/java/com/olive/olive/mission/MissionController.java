package com.olive.olive.mission;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	
	@RequestMapping(value="List")
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
	
	@RequestMapping(value="ListContent")
	@ResponseBody
	public Map<String, Object> ListContent(
			@RequestParam int num,
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
		
		return model;
	}
	
	@PostMapping("update")
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
	}
	
	@PostMapping("delete")
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
	}
	
	
}
