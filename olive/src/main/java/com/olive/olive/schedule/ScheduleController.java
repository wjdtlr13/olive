package com.olive.olive.schedule;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.olive.olive.member.SessionInfo;

@RestController("sch.scheduleController")
@RequestMapping("/schedule/*")
public class ScheduleController {
	@Autowired
	private ScheduleService service;
	
	@RequestMapping(value = "main")
	public ModelAndView main(Model model) throws Exception {
		ModelAndView mav = new ModelAndView(".schedule.main");
		model.addAttribute("menuIndex", 5);
		return mav;
	}
	
	@RequestMapping(value="month")
	public Map<String, Object> month(
			@RequestParam String start,
			@RequestParam String end,
			@RequestParam(defaultValue="all") String group,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("group", group);
		map.put("start", start);
		map.put("end", end);
		map.put("userId", info.getUserId());
		
		List<Schedule> list=service.listMonth(map);
		for(Schedule dto:list) {
	    	if(dto.getStime()==null) {
	    		dto.setAllDay(true);
	    	} else {
	    		dto.setAllDay(false);
	    	}
	    	
	    	if(dto.getStime()!=null && dto.getStime().length()!=0) {
	    		dto.setStart(dto.getSday()+"T" + dto.getStime());
	    	} else {
	    		dto.setStart(dto.getSday());
	    	}
	    	
	    	if(dto.getEtime()!=null && dto.getEtime().length()!=0) {
	    		dto.setEnd(dto.getEday()+"T" + dto.getEtime());
	    	} else {
	    		dto.setEnd(dto.getEday());
	    	}
	    	
	    	if(dto.getRepeat()!=0) { // 반복 일정인 경우
	    		if( dto.getStart().substring(0,4).compareTo(start.substring(0,4)) != 0 ) {
	    			dto.setStart(start.substring(0,4)+dto.getStart().substring(5));
	    			System.out.println("::::"+dto.getStart());
	    		}
	    	}	    	
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("list", list);
		return model;
	}

	
	@PostMapping("insert")
	public Map<String, Object> insertSubmit(Schedule dto,
			HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String state="true";
		try {
			dto.setUserId(info.getUserId());
			service.insertSchedule(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@PostMapping("update")
	public Map<String, Object> updateSubmit(Schedule dto,
			HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String state="true";
		try {
			dto.setUserId(info.getUserId());
			service.updateSchedule(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@PostMapping("delete")
	public Map<String, Object> delete(
			@RequestParam int num,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");

		String state = "true";
		try {
			Map<String, Object> map=new HashMap<>();
			map.put("userId", info.getUserId());
			map.put("num", num);
			service.deleteSchedule(map);
		}catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		
		return model;
	}
}
