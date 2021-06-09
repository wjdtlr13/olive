package com.olive.olive.medical;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.olive.olive.common.MyUtil;
import com.olive.olive.member.SessionInfo;

@Controller("medical.kitController")
@RequestMapping("/medical/*")
public class KitController {
	@Autowired
	private KitService service; 
	@Autowired
	private MyUtil myUtil; 

	@RequestMapping(value = "list")
	public String list(@RequestParam(value="page", defaultValue = "1")int current_page, @RequestParam(defaultValue = "all")String condition, @RequestParam(defaultValue = "")String keyword, HttpServletRequest req, Model model ) throws Exception{
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		if(dataCount!=0) {
			total_page= myUtil.pageCount(rows, dataCount);
		}
		
		if(total_page < current_page)
			current_page = total_page;
		
		int offset = (current_page - 1) * rows;
		if(offset<0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Kit> list = service.listKit(map);
		
		int listNum, n = 0;
		for(Kit dto : list) {
			listNum = dataCount - (offset+n);
			dto.setListNum(listNum);
			
			dto.setCreated(dto.getCreated().substring(0,10));
			n++;
		}
			
		String cp = req.getContextPath();
		String query="";
		
		String listUrl = cp+"/medical/list";
		if(keyword.length()!=0) {
			query ="condtion="+condition+"&keyword="+URLEncoder.encode(keyword,"utf-8");
			
		}
		
		if(query.length()!=0) {
			listUrl = cp+"/medical/list?"+query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);

		return ".medical.list";		
	}
	
	@RequestMapping(value = "created", method = RequestMethod.GET)
	public String createdForm(Model model, HttpSession session) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(! info.getUserId().equals("admin"))
			return "redirect:/medical/list";
		
		model.addAttribute("mode","created");
		model.addAttribute("page", "1");
		return ".medical.created";
	
	}
	
	@RequestMapping(value = "created", method = RequestMethod.POST)
	public String createdSubmit(Kit dto, HttpSession session) throws Exception {
	
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return "redirect:/medical/list";
		}
		
		try {			
			dto.setUserId(info.getUserId());
			service.insertKit(dto);
			
		} catch (Exception e) {
		}
		
		return "redirect:/medical/list?page=1";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(@RequestParam int num, @RequestParam String page, HttpSession session, Model model) throws Exception{

		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return "redirect:/medical/list?page="+page;
		}
		
		Kit dto = service.readKit(num);
		if(dto==null) {
			return "redirect:/medical/list?page="+page;
		}
		
		model.addAttribute("mode", "update");
		model.addAttribute("page",page);
		model.addAttribute("dto", dto);

		return ".medical.created";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit(Kit dto, @RequestParam String page, HttpSession session) throws Exception {
	
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(!info.getUserId().equals("admin"))
			return "redirect:/medical/list?page="+page;
		
		try {
			dto.setUserId(info.getUserId());
			service.updateKit(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/medical/list?page="+page;
	}
	
	@RequestMapping(value = "delete")
	public String delete(@RequestParam int num, @RequestParam String page,@RequestParam(defaultValue = "all")String condition, @RequestParam(defaultValue = "")String keyword, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		keyword = URLDecoder.decode(keyword,"utf-8");
		String query = "page="+page;
		if(keyword.length()!=0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		if(! info.getUserId().equals("admin")) {
			return "redirect:/medical/list?"+query;
		}
		
		try {
			service.deleteKit(num, info.getUserId());
		} catch (Exception e) {
		}
		
		return "redirect:/medical/list?"+query;
	}
	
	@RequestMapping(value = "medicalMap", method = RequestMethod.GET)
	public String medicalMap() throws Exception{
		
		return ".medical.medicalMap";
	}
	
	
}
