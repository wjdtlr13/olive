package com.olive.olive.presence;

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

@Controller("presence.presenceController")
@RequestMapping("/presence/*")
public class PresenceController {
	@Autowired
	private PresenceService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("main")
	public String list(
			HttpSession session,
			Model model) throws Exception{
	
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		int myCount = service.myDataCount(userId);
		int continuous = service.findContinuous(userId);
		int myToday = service.findMyTodayData(userId);
		String myLatest = service.findMyLatest(userId);
        
        model.addAttribute("userId", userId);
        model.addAttribute("myCount", myCount);
        model.addAttribute("continuous", continuous);
        model.addAttribute("myToday", myToday);
        model.addAttribute("myLatest", myLatest);
        
		return ".presence.main";
	}
	
	@RequestMapping(value="list")
	@ResponseBody
	public Map<String, Object> list(
			 @RequestParam(value="pageNo", defaultValue="1") int current_page,
			 HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		int dataCount = service.dataCount(userId);
		int rows = 8;
		int total_page = myUtil.pageCount(rows,  dataCount);
		
		if(total_page < current_page)
			current_page = total_page;
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("offset", offset);
        map.put("rows", rows);
        map.put("userId", userId);
        
        List<Presence> list = service.listPresence(map);
        
        int listNum, n = 0;
        for(Presence dto : list) {
        	dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
        	 listNum = dataCount - (offset + n);
             dto.setListNum(listNum);
             n++;
        }
        
        String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
        
        Map<String, Object> model = new HashMap<>();
        model.put("list", list);
        model.put("pageNo", current_page);
        model.put("dataCount", dataCount);
        model.put("total_page", total_page);
        model.put("paging", paging);
		
		
		return model;
		
	}
	
	
	@PostMapping("insert")
	public String insertSubmit(
			Presence dto) throws Exception{
		
		int num = dto.getPointed();
		String userId = dto.getUserId();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("userId", userId);
		try {
			service.insertPresence(dto);
			service.updatePoint(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/presence/main";
	}
	
	@PostMapping("update")
	@ResponseBody
	public Map<String, Object> updateSubmit(
			Presence dto) throws Exception{
		Map<String, Object> model = new HashMap<>();
		
		try {
			service.updatePresence(dto);
			model.put("status", "true");
		} catch (Exception e) {
			e.printStackTrace();
			model.put("status", "false");
		}
		
		return model;
	}
}
